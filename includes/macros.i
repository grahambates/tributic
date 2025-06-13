        ifnd    MACROS_I
MACROS_I set    1

********************************************************************************
* SIN/COS lookup
********************************************************************************

SIN_LEN = $400
SIN_AMP = $4000
SIN_MASK = (SIN_LEN-1)*2

********************************************************************************
; Sin lookup (signed)
;-------------------------------------------------------------------------------
; \1 - table offset (masked to word offset, so lower bit ignored)
; \2 - dest
; \3 - amplitude (optional)
; a0 - sin tbl
;-------------------------------------------------------------------------------
SIN     macro
        ifnc    "\1","\2"
        move.w  \1,\2
        endc
        and.w   #SIN_MASK,\2
        move.w  (a0,\2),\2
        ifnc    "\3",""
        _SIN_SHIFT \3,\2
        endc
        endm

********************************************************************************
; Cos lookup (signed)
;-------------------------------------------------------------------------------
; \1 - table offset (masked to word offset, so lower bit ignored)
; \2 - dest
; \3 - amplitude (optional)
; a1 - cos tbl
;-------------------------------------------------------------------------------
COS     macro
        ifnc    "\1","\2"
        move.w  \1,\2
        endc
        and.w   #SIN_MASK,\2
        move.w  (a1,\2),\2
        ifnc    "\3",""
        _SIN_SHIFT \3,\2
        endc
        endm

********************************************************************************
; Sin lookup (usigned)
;-------------------------------------------------------------------------------
; \1 - table offset (masked to word offset, so lower bit ignored)
; \2 - dest
; \3 - amplitude (optional)
; a0 - sin tbl
;-------------------------------------------------------------------------------
SINU    macro
        ifnc    "\1","\2"
        move.w  \1,\2
        endc
        and.w   #SIN_MASK,\2
        move.w  (a0,\2),\2
        add.w   #SIN_AMP,\2
        ifnc    "\3",""
        _SIN_SHIFTU \3,\2
        endc
        endm

********************************************************************************
; Cos lookup (unsigned)
;-------------------------------------------------------------------------------
; \1 - table offset (masked to word offset, so lower bit ignored)
; \2 - dest
; \3 - amplitude (optional)
; a1 - cos tbl
;-------------------------------------------------------------------------------
COSU    macro
        ifnc    "\1","\2"
        move.w  \1,\2
        endc
        and.w   #SIN_MASK,\2
        move.w  (a1,\2),\2
        add.w   #SIN_AMP,\2
        ifnc    "\3",""
        _SIN_SHIFTU \3,\2
        endc
        endm

; Shift to range (used in SIN/COS)
_SIN_SHIFT macro
        rept    8
; shift left and swap for >8
        if      (\1)<SIN_AMP>>8
        ifeq    (SIN_AMP>>(9+REPTN))-(\1)
        ext.l   \2
        lsl.l   #7-REPTN,\2
        add.l   #$8000,\2 ; round
        swap    \2
        endc
; shift right
        else
        ifeq    (SIN_AMP>>(REPTN+1))-(\1)
        add.w   #1<<REPTN,\2 ; round
        asr.w   #(REPTN+1),\2
        endc
        endc            ; shift size
        endr
        endm

; Shift to range (used in SINU/COSU)
_SIN_SHIFTU macro
        rept    8
; shift left and swap for >8
        if      (\1)<SIN_AMP>>8
        ifeq    (SIN_AMP>>(9+REPTN))-(\1)
        swap    \2
        clr.w   \2
        swap    \2
        lsl.l   #7-REPTN,\2
        add.l   #$8000,\2 ; round
        swap    \2
        endc
; shift right
        else
        ifeq    (SIN_AMP>>(REPTN+1))-(\1)
        add.w   #1<<REPTN,\2 ; round
        lsr.w   #(REPTN+1),\2
        endc
        endc            ; shift size
        endr
        endm

********************************************************************************
* Blitter
********************************************************************************

BLIT_WAIT macro
; tst.w	(a6)					;for compatibility with A1000
.\@:    btst    #DMAB_BLTDONE,dmaconr-C(a6)
        bne.s   .\@
        endm

BLIT_HOG macro
        move.w  #DMAF_SETCLR!DMAF_BLITHOG,dmacon-C(a6)
        endm

BLIT_UNHOG macro
        move.w  #DMAF_BLITHOG,dmacon-C(a6)
        endm

BLTCON  macro
        ifnc    "\3",""
        move.w  #BLTEN_\1!(\2)&$ff!(\3<<12),bltcon0-C(a6)
        else
        move.w  #BLTEN_\1!(\2)&$ff,bltcon0-C(a6)
        endc
        endm

BLTCONL macro
        ifnc    "\3",""
        ifnc    "\4",""
        move.l  #(BLTEN_\1!(\2)&$ff!(\3<<12))<<16!(\4),bltcon0-C(a6)
        else
        move.l  #(BLTEN_\1!(\2)&$ff!(\3<<12))<<16,bltcon0-C(a6)
        endc
        else
        move.l  #(BLTEN_\1!(\2)&$ff)<<16,bltcon0-C(a6)
        endc
        endm


********************************************************************************
* Fixed point
********************************************************************************

;-------------------------------------------------------------------------------
; Convert fixed point to regular integer
;-------------------------------------------------------------------------------

FP2I16  macro
        swap    \1
        endm

FP2I15  macro
        add.l   \1,\1
        swap    \1
        endm

FP2I14  macro
        lsl.l   #2,\1
        swap    \1
        endm

FP2I8   macro
        lsr.l   #8,\2
        endm

; Rounded for more accuracy

FP2I16R macro
        add.l   #$8000,\1
        swap    \1
        endm

FP2I15R macro
        add.l   \1,\1
        add.l   #$8000,\1
        swap    \1
        endm

FP2I14R macro
        lsl.l   #2,\1
        add.l   #$8000,\1
        swap    \1
        endm

FP2I8R  macro
        add.l   #$80,\2
        lsr.l   #8,\2
        endm

;-------------------------------------------------------------------------------
; Mulitply
;-------------------------------------------------------------------------------

FPMULU16 macro
        mulu    \1,\2
        swap    \2
        endm

FPMULS16 macro
        muls    \1,\2
        swap    \2
        endm

FPMULS15 macro
        muls.w  \1,\2
        FP2I15  \2
        endm

FPMULU15 macro
        mulu.w  \1,\2
        FP2I15  \2
        endm

FPMULS14 macro
        muls.w  \1,\2
        FP2I14  \2
        endm

FPMULU14 macro
        mulu.w  \1,\2
        FP2I14  \2
        endm

FPMULS8 macro
        muls    \1,\2
        lsr.l   #8,\2
        endm

FPMULU8 macro
        mulu    \1,\2
        lsr.l   #8,\2
        endm

        endc

********************************************************************************
; Copper
********************************************************************************

COP_MOVE: macro
        dc.w    (\2)&$1fe,\1
        endm

COP_WAIT: macro
        dc.w    (((\1)&$ff)<<8)+((\2)&$fe)+1,$fffe
        endm

COP_WAITV: macro
        COP_WAIT \1&$ff,4
        endm

COP_WAITH: macro
        dc.w    ((\1&$80)<<8)+(\2&$fe)+1,$80fe
        endm

COP_WAITBLIT: macro
        dc.l    $10000
        endm

COP_SKIP: macro
        dc.w    (((\1)&$ff)<<8)+((\2)&$fe)+1,$ffff
        endm

COP_SKIPV: macro
        COP_SKIP \1,4
        endm

COP_SKIPH: macro
        dc.w    (((\1)&$80)<<8)+((\2)&$fe)+1,$80ff
        endm

COP_NOP: macro
        COP_MOVE 0,$1fe
        endm

COP_END: macro
        dc.l    $fffffffe
        endm
