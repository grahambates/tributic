        incdir  "includes"
        include "hw.i"
        include "macros.i"

********************************************************************************

C = bltsize

STEPS = 12
DIST = 500
FACE_W = 96
Y_SPEED = 7
Z_SPEED = 17
Y_OFFSET = 30

DIV_RANGE = 3072

VERT_COUNT = 8
DOT_COUNT = (STEPS+1)*(STEPS+1)*(STEPS+1)

; Display setup:
BPLS = 4                ; Bitplane count
DIW_W = 256             ; Display window width
DIW_H = 256             ; Display window height
INTERLEAVED = 0         ; Interleaved bitplanes?
SCROLL = 0              ; Enable playfield scroll (add additional word of data fetch)
DPF = 0                 ; Enable dual playfield
HAM = 0                 ; Enable HAM
HIRES = 0               ; Enable hi-res mode
LACE = 0                ; Enable interlace
PF1P = 0                ; Playfield 1 priority code (with respect to sprites)
PF2P = 0                ; Playfield 2 priority code (with respect to sprites)
PF2PRI = 0              ; Playfield 2 (even planes) has priority over (appears in front of) playfield 1 (odd planes).

SCREEN_W = DIW_W        ; Screen buffer width
SCREEN_H = DIW_H        ; Screen buffer height

; Initial DMA/Interrupt bits:
DMASET = DMAF_SETCLR!DMAF_MASTER!DMAF_RASTER!DMAF_COPPER!DMAF_BLITTER
INTSET = INTF_SETCLR!INTF_INTEN!INTF_BLIT

;-------------------------------------------------------------------------------

COLORS = 1<<BPLS        ; Number of palette colours
SCREEN_BW = SCREEN_W/16*2 ; byte-width of 1 bitplane line
        ifne    INTERLEAVED
SCREEN_MOD = SCREEN_BW*(BPLS-1) ; modulo (interleaved)
SCREEN_BPL = SCREEN_BW  ; bitplane offset (interleaved)
        else
SCREEN_MOD = 0          ; modulo (non-interleaved)
SCREEN_BPL = SCREEN_BW*SCREEN_H ; bitplane offset (non-interleaved)
        endc
SCREEN_SIZE = SCREEN_BW*SCREEN_H*BPLS ; byte size of screen buffer
DIW_BW = DIW_W/16*2     ; Display window bit width
DIW_MOD = SCREEN_BW-DIW_BW+SCREEN_MOD-SCROLL*2
DIW_SIZE = DIW_BW*DIW_H*BPLS ; Display window byte size
DIW_LW = DIW_W/(HIRES+1) ; low res width

; Display windows bounds for centered PAL display:
DIW_XSTRT = $81+(320-DIW_LW)/2
DIW_YSTRT = $2c+(256-DIW_H)/2
DIW_XSTOP = DIW_XSTRT+DIW_LW
DIW_YSTOP = DIW_YSTRT+DIW_H

********************************************************************************

; Named Vertex offsets Front/Back Left/Right Top/Bottom
        rsreset
V_FLT   rs.l    1
V_FLB   rs.l    1
V_FRT   rs.l    1
V_FRB   rs.l    1
V_BLT   rs.l    1
V_BLB   rs.l    1
V_BRT   rs.l    1
V_BRB   rs.l    1


********************************************************************************
Entrypoint:
********************************************************************************
        lea     Vars(pc),a5
        lea     custom+C,a6

        ; sys backup
        move.w  intenar-C(a6),-(sp)
        move.l  $6c.w,-(sp)

        move.w  #$7fff,intena-C(a6)

********************************************************************************
InitBuffers:
        lea     Buffers(pc),a0
        move.l  a5,a1
        rept    6
        move.l  a0,(a1)+ ; Screen
        adda.w  #SCREEN_BPL,a0
        endr
        rept    2
        move.l  a0,(a1)+ ; Points
        adda.w  #DOT_COUNT*4,a0
        endr
        move.l  a0,(a1)+ ; SMC
        adda.w  #Smc2-Smc1,a0
        move.l  a0,(a1)+ ; SMC

********************************************************************************
InitDivs:
        lea     DivLut+DIV_RANGE*2-Vars(a5),a0
        move.l  a0,a1
        clr.w   (a0)+
        moveq   #2,d0
        move.w  #DIV_RANGE-1,d7
.l:
        move.l  d0,d1
        divu    #STEPS,d1
        move.w  d1,(a0)+
        neg.w   d1
        move.w  d1,-(a1)
        addq    #2,d0
        dbf     d7,.l

********************************************************************************
; https://eab.abime.net/showpost.php?p=1471651&postcount=24
; maxError = 26.86567%
; averageError = 8.483626%
;-------------------------------------------------------------------------------
InitSin:
        ; lea     Sin,a0
        moveq   #0,d0   ; amp=16384, len=1024
        move.w  #511+2,a1
.l:     subq.l  #2,a1
        move.l  d0,d1
        asr.l   #2,d1
        move.w  d1,1024*2(a0)
        move.w  d1,(a0)+
        neg.w   d1
        move.w  d1,1024-2(a0)
        add.l   a1,d0
        bne.b   .l

********************************************************************************
; Install interrupt and copper
        lea     BlitInt(pc),a0
        move.l  a0,$6c.w
        move.w  #INTSET,intena-C(a6)
        lea     Cop(pc),a0
        move.l  a0,cop1lc-C(a6)
        move.w  #DMASET,dmacon-C(a6)

********************************************************************************
; Init palette
        lea     Colors(pc),a2
        lea     color01-C(a6),a0
        rept    8
        move.l  (a2)+,(a0)+
        endr

********************************************************************************
MainLoop:
********************************************************************************
        ; move.w  #$f00,color00-C(a6)
.sync:  cmp.b   #DIW_YSTOP&$ff,vhposr-C(a6)
        bne.s   .sync

        ; swap buffers
        lea     ScreenBuffers(pc),a2
        movem.l (a2),d0-a1
        exg     d0,d1
        exg     d1,d2
        exg     d2,d3
        exg     d3,d4
        exg     d4,d5
        exg     d6,d7
        exg     a0,a1
        movem.l d0-a1,(a2)

        ; set bpl ptrs
        lea     bplpt-C(a6),a0
        rept    BPLS
        move.l  (a2)+,(a0)+
        endr

        ; reset blit 'queue'
        clr.w   BlitOffset-Vars(a5)

        ; clear screen
        clr.w   bltdmod-C(a6)
        move.l  #$01000000,bltcon0-C(a6)
        move.l  ClearScreen(pc),bltdpt-C(a6)
        move.w  #SCREEN_H*64+SCREEN_BW/2,bltsize-C(a6)

        move.l  #$7fe07fe,d7 ; sin mask

        ; Increment angles
        move.l  Angles(pc),d3
        add.l   #Y_SPEED<<16!Z_SPEED,d3
        and.l   d7,d3
        move.l  d3,Angles-Vars(a5)
        
        ; sin distance
        lea     Sin(pc),a0
        move.w  Frame(pc),d0
        and.w   d7,d0
        move.w  (a0,d0),d1
        asr.w   #8,d1
        add.w   #DIST,d1
        move.w  d1,Dist-Vars(a5)

        ; twist angle
        add.w   d0,d0
        and.w   d7,d0
        move.w  (a0,d0),d1
        asr.w   #6,d1
        add.w   d1,d3
        and.l   d7,d3
        move.w  d3,Angle2-Vars(a5)

********************************************************************************
Rotate:
        movem.w Angles(pc),a1/a4

        lea     512(a0),a5
        lea     Verts(pc),a2
        lea     Transformed(pc),a3

        moveq   #VERT_COUNT-1,d7
.RotLoop:
        movem.w (a2)+,d0-d2

;	NX=X*COS(Z)-Y*SIN(Z)
;	NY=X*SIN(Z)+Y*COS(Z)
        move.w  (a5,a4),d4 ; SIN(z)
        move.w  (a0,a4),d3 ; COS(z)
        move.w  d1,d5   ; y
        move.w  d0,d6   ; x
        muls    d4,d5   ; d5 = y*SIN(z)
        muls    d4,d6   ; d6 = x*SIN(z)
        muls    d3,d1   ; d1 = y*COS(z)
        muls    d0,d3   ; d3 = x*COS(z)
        sub.l   d5,d3   ; d3 = x*COS(z)-y*SIN(z)
        add.l   d6,d1   ; d1 = x*SIN(z)+y*COS(z)
        FP2I14  d3      ; d3 = nx
        ; FP2I14  d1      ; d1 = ny
        lsl.l   #16-9,d1 ; 11:5
        swap    d1
        ; ext.l   d1

;	NX=X*COS(Y)-Z*SIN(Y)
;	NZ=X*SIN(Y)+Z*COS(Y)
        move.w  (a5,a1),d4 ; SIN(Y)
        move.w  (a0,a1),d0 ; COS(Y)
        move.w  d3,d5   ; x
        move.w  d2,d6   ; z
        muls    d4,d5   ; d5 = X*SIN(Y)
        muls    d4,d6   ; d6 = z*SIN(Y)
        muls    d0,d3   ; d3 = x*COS(Y)
        muls    d2,d0   ; d0 = z*COS(Y)
        sub.l   d5,d0   ; X*COS(Y)-Z*SIN(Y)
        add.l   d6,d3   ; X*SIN(Y)+Z*COS(Y)
        ; FP2I14  d0      ; d0 = nx
        lsl.l   #16-9,d0 ; 11:5
        swap    d0
        ; ext.l   d0
        FP2I14  d3      ; d3 = nz

; Perspective
        ext.l   d1
        asl.l   #8,d1
        ext.l   d0
        asl.l   #8,d0
        add.w   Dist(pc),d3
        divs    d3,d1
        divs    d3,d0

; center and write coords
        add.w   #(SCREEN_W<<5)/2,d0
        add.w   #((SCREEN_H-Y_OFFSET)<<5)/2,d1
        move.w  d0,(a3)+
        move.w  d1,(a3)+

        ; switch angle half way
        cmp.w   #VERT_COUNT/2-1,d7
        bne     .ok
        move.w  Angle2(pc),a4
.ok:

        dbf     d7,.RotLoop

********************************************************************************
LerpPoints:
        lea     Transformed(pc),a0 ; in
        move.l  DrawPoints(pc),a1 ; out
        lea     DivLut+DIV_RANGE*2(pc),a4
        lea     Vars(pc),a5
        move.l  #$fffefffe,d7

        macro   DELTA_PAIR_LUT
        sub.l   \1,\2
        and.l   d7,\2
        move.w  (a4,\2),\2
        swap    \2
        move.w  (a4,\2),\2
        swap    \2
        endm

        ; Deltas for outer lerp - front to back
        lea     V_BLT(a0),a2
        rept    4
        move.l  (a0)+,d0
        move.l  (a2),d2
        DELTA_PAIR_LUT d0,d2
        move.l  d2,(a2)+
        endr

        ;-------------------------------------------------------------------------------
        lea     Transformed,a0
        moveq   #STEPS,d7
        bra     .zStart
.z:
        ; apply deltas (z)
        lea     V_FLT(a0),a2
        movem.l V_BLT(a0),d0-d3
        add.l   d0,(a2)+
        add.l   d1,(a2)+
        add.l   d2,(a2)+
        add.l   d3,(a2)+
.zStart:
        move.w  d7,a3
        move.l  #$fffefffe,d7
        movem.l V_FLT(a0),d2/d3
        DELTA_PAIR_LUT d2,d3

        movem.l V_FRT(a0),d4/d5
        DELTA_PAIR_LUT d4,d5

        ;-------------------------------------------------------------------------------
        moveq   #STEPS,d6
        bra     .yStart
.y:
        ; apply deltas (y)
        add.l   d3,d2
        add.l   d5,d4
.yStart:
        move.l  d2,d0
        move.l  d4,d1
        DELTA_PAIR_LUT d0,d1

        ;-------------------------------------------------------------------------------
        ; x inner loop
        rept    STEPS
        ; write to buffer
        move.l  d0,(a1)+
        ; apply deltas (x)
        add.l   d1,d0
        endr
        move.l  d0,(a1)+

        dbf     d6,.y
        move.w  a3,d7
        dbf     d7,.z
        ;-------------------------------------------------------------------------------


********************************************************************************
Draw:
        move.l  DrawScreen(pc),a0
        move.l  RunSmc(pc),a1
        ; limit dot count
        move.w  Frame(pc),d0
        cmp.w   #DOT_COUNT,d0
        bls     .noClamp
        move.w  #DOT_COUNT,d0
.noClamp:
        mulu    #6,d0
        move.w  #$4e75,(a1,d0) ; add rts
        jsr     (a1)
        move.w  #$08e8,(a1,d0) ; restore bset
        
        lea     Logo(pc),a2
        adda.w  #SCREEN_BW*160,a0
        rept    4
        move.l  (a2)+,(a0)
        adda.w  #SCREEN_BW,a0
        endr
        move.l  (a2)+,(a0)+

.wait:  cmp.w   #14,BlitOffset-Vars(a5)
        bne     .wait
        addq.w  #8,Frame-Vars(a5) ; always shifted by at least 2
        btst    #CIAB_GAMEPORT0,ciaa ; Left mouse button not pressed?
        bne     MainLoop

********************************************************************************
Exit:
        move.l  (sp)+,$6c.w
        or.w    #$8000,(sp)
        move.w  (sp)+,intena-C(a6)

        move.l  $4.w,a1 ; execbase
        move.l  156(a1),a1 ; graphics.library
        move.l  38(a1),cop1lc-C(a6) ; restore copper pointer
        movem.l (sp)+,d0-a6
        rts


********************************************************************************
BlitInt:
********************************************************************************
        movem.l d0-a6,-(sp)
        lea     custom+C,a6
        move.w  #INTF_BLIT,intreq-C(a6)
        lea     BlitOffset(pc),a0
        move.w  (a0),d0
        addq.w  #2,(a0)+
        move.l  TransformPoints(pc),a1 ; A = x
        move.l  DrawSmc(pc),a2
        jmp     (a0,d0)

BlitOffset: 
        dc.w    0
BlitJmp:
        bra.s   .blitBit
        bra.s   .blitFull
        bra.s   .blitRemainder
        bra.s   .blitOffset
        bra.s   .blitFull
        bra.s   .blitRemainder
        movem.l (sp)+,d0-a6
        rte

; x to source bit
.blitBit:
        addq    #2,a2   ; D
        BLTCONL AD,~BLT_A,5
        move.l  #(2<<16)!4,bltamod-C(a6)
        move.l  d7,bltafwm-C(a6) ; hopefully -1!
        movem.l a1-a2,bltapt-C(a6)
        move.w  #1,bltsize-C(a6)
        movem.l (sp)+,d0-a6
        rte
; x,y to offset
.blitOffset:
        lea     2(a1),a0 ; B = y
        addq    #4,a2   ; D
        BLTCON  ABD,(BLT_B&~BLT_C)!(BLT_A&BLT_C),(5+3)
        move.w  #2,bltbmod-C(a6)
        move.w  #$1f,bltcdat-C(a6)
        movem.l a0-a2,bltbpt-C(a6)
.blitFull:
        move.w  #1,bltsize-C(a6)
        movem.l (sp)+,d0-a6
        rte
.blitRemainder:
        move.w  #(DOT_COUNT-2048)*64+1,bltsize-C(a6)
        movem.l (sp)+,d0-a6
        rte


********************************************************************************
Data:
********************************************************************************

Verts:
        dc.w    -FACE_W,-FACE_W,-FACE_W ; front left top
        dc.w    -FACE_W, FACE_W,-FACE_W ; front left bottom
        dc.w    FACE_W,-FACE_W,-FACE_W ; front right top
        dc.w    FACE_W, FACE_W,-FACE_W ; front right bottom
        dc.w    -FACE_W,-FACE_W, FACE_W ; back left top
        dc.w    -FACE_W, FACE_W, FACE_W ; back left bottom
        dc.w    FACE_W,-FACE_W, FACE_W ; back right top
        dc.w    FACE_W, FACE_W, FACE_W ; back right bottom

*******************************************************************************

Cop:
        dc.w    diwstrt,DIW_YSTRT<<8!DIW_XSTRT
        dc.w    diwstop,(DIW_YSTOP&$ff)<<8!(DIW_XSTOP&$ff)
        dc.w    ddfstrt,(DIW_XSTRT-17)>>1&$fc+HIRES*4
        dc.w    ddfstop,(DIW_XSTRT-17+(DIW_LW>>4-1)<<4)>>1&$fc-SCROLL*8
        dc.w    bpl1mod,DIW_MOD
        ; dc.w    bpl2mod,DIW_MOD
        dc.w    bplcon0,(HIRES<<15)!(BPLS<<12)!(HAM<<11)!(DPF<<10)!(1<<9)!(LACE<<1)
        ; dc.w    bplcon1,0
        ; COP_WAITV $ac-40
        dc.w    color00,COLOR_BG2
        COP_WAITV $ac+40
        dc.w    color00,COLOR_BG
        COP_WAITV $ff
        dc.w    bpl1mod,-SCREEN_BW*2
        ; dc.w    bpl2mod,-SCREEN_BW*2
        dc.w    bplcon0,2<<12
        dc.l    -2
CopE:

; COLOR_BG = $013
; COLOR_BG2 = $002
; COLOR_1 = $235
; COLOR_2 = $568
; COLOR_3 = $88b
; COLOR_4 = $bbe

COLOR_BG2 = $200
COLOR_BG = $300
COLOR_1 = $800
COLOR_2 = $c00
COLOR_3 = $f72
COLOR_4 = $fb8

Colors:
        dc.w    COLOR_1
        dc.w    COLOR_2
        dc.w    COLOR_3
        dc.w    COLOR_3
        dc.w    COLOR_3
        dc.w    COLOR_3
        dc.w    COLOR_3
        dc.w    COLOR_3
        dc.w    COLOR_4
        dc.w    COLOR_4
        dc.w    COLOR_4
        dc.w    COLOR_4
        dc.w    COLOR_4
        dc.w    COLOR_4
        dc.w    COLOR_4
        
Logo:
        incbin  data/logo.BPL

********************************************************************************
Vars:
********************************************************************************

ScreenBuffers:
ViewScreen1: dc.l 0
ViewScreen2: dc.l 0
ViewScreen3: dc.l 0
ViewScreen4: dc.l 0
DrawScreen: dc.l 0
ClearScreen: dc.l 0

DblBuffers:
DrawPoints: dc.l 0
TransformPoints: dc.l 0
DrawSmc: dc.l   0
RunSmc: dc.l    0

Frame:  ds.w    1
Angles: ds.w    2
Angle2: ds.w    1
Dist:   ds.w    1


Transformed:
        ds.w    VERT_COUNT*2

DivLut:
        ds.w    DIV_RANGE*2+1

Sin:    ds.b    3072


********************************************************************************
Buffers:
********************************************************************************

Points: ds.l    DOT_COUNT*2
Screen: ds.b    SCREEN_BPL*6

Smc1:
        rept    DOT_COUNT+1
        dc.w    $08e8   ; bset #0,0(a0) 
        dc.l    0
        endr
Smc2:
        rept    DOT_COUNT+1
        dc.w    $08e8   ; bset #0,0(a0) 
        dc.l    0
        endr