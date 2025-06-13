; Combined hardware include

        ifnd    _HW_I
_HW_I   set     1

custom = $dff000
ciaa = $bfe001
ciab = $bfd000
execbase = $4


********************************************************************************
* Custom regs
********************************************************************************

bltddat = $000          ; Blitter dest. early read (dummy address)
dmaconr = $002          ; Dma control (and blitter status) read
vposr = $004            ; Read vertical most sig. bits (and frame flop)
vhposr = $006           ; Read vert and horiz position of beam
dskdatr = $008          ; Disk data early read (dummy address)
joy0dat = $00a          ; Joystick-mouse 0 data (vert, horiz)
joy1dat = $00c          ; Joystick-mouse 1 data (vert, horiz)
clxdat = $00e           ; Collision data reg. (read and clear)
adkconr = $010          ; Audio,disk control register read
pot0dat = $012          ; Pot counter data left pair (vert, horiz)
pot1dat = $014          ; Pot counter data right pair (vert, horiz)
potinp = $016           ; Pot pin data read
serdatr = $018          ; Serial port data and status read
dskbytr = $01a          ; Disk data byte and status read
intenar = $01c          ; Interrupt enable bits read
intreqr = $01e          ; Interrupt request bits read
dskpt = $020            ; Disk pointer
dskpth = $020           ; Disk pointer (high 5 bits, was 3 bits)
dskptl = $022           ; Disk pointer (low 15 bits)
dsklen = $024           ; Disk length
dskdat = $026           ; Disk DMA data write
refptr = $028           ; Refresh pointer
vposw = $02a            ; Write vert most sig. bits (and frame flop)
vhposw = $02c           ; Write vert and horiz pos of beam
copcon = $02e           ; Coprocessor control
serdat = $030           ; Serial port data and stop bits write
serper = $032           ; Serial port period and control
potgo = $034            ; Pot count start,pot pin drive enable data
joytest = $036          ; Write to all 4 joystick-mouse counters at once
strequ = $038           ; Strobe for horiz sync with VB and EQU
strvbl = $03a           ; Strobe for horiz sync with VB (vert blank)
strhor = $03c           ; Strobe for horiz sync
strlong = $03e          ; Strobe for identification of long horiz line
bltcon0 = $040          ; Blitter control register 0
bltcon1 = $042          ; Blitter control register 1
bltafwm = $044          ; Blitter first word mask for source A
bltalwm = $046          ; Blitter last word mask for source A
bltcpt = $048           ; Blitter pointer to source C
bltcpth = $048          ; Blitter pointer to source C (high 5 bits, was 3 bits)
bltcptl = $04a          ; Blitter pointer to source C (low 15 bits)
bltbpt = $04c           ; Blitter pointer to source B
bltbpth = $04c          ; Blitter pointer to source B (high 5 bits, was 3 bits)
bltbptl = $04e          ; Blitter pointer to source B (low 15 bits)
bltapt = $050           ; Blitter pointer to source A
bltapth = $050          ; Blitter pointer to source A (high 5 bits, was 3 bits)
bltaptl = $052          ; Blitter pointer to source A (low 15 bits)
bltdpt = $054           ; Blitter pointer to dest D
bltdpth = $054          ; Blitter pointer to dest D (high 5 bits, was 3 bits)
bltdptl = $056          ; Blitter pointer to dest D (low 15 bits)
bltsize = $058          ; Blitter start and size (win/width,height)
bltcon0l = $05a         ; control 0, lower 8 bits (minterms)
bltsizv = $05c          ; V size (for 15 bit vertical size)
bltsizh = $05e          ; H size and start (for 11 bit H size)
bltcmod = $060          ; Blitter modulo for source C
bltbmod = $062          ; Blitter modulo for source B
bltamod = $064          ; Blitter modulo for source A
bltdmod = $066          ; Blitter modulo for dest D
bltcdat = $070          ; Blitter source C data register
bltbdat = $072          ; Blitter source B data register
bltadat = $074          ; Blitter source A data register
sprhdat = $078          ; . logic UHRES sprite pointer and data identifier
bplhdat = $07a          ; . logic UHRES bit plane identifier
deniseid = $07c         ; revision level for Denise/Lisa (video out chip)
dsksync = $07e          ; Disk sync pattern reg for disk read
cop1lc = $080           ; Coprocessor 1st location
cop1lch = $080          ; Coprocessor 1st location (high 5 bits,was 3 bits)
cop1lcl = $082          ; Coprocessor 1st location (low 15 bits)
cop2lc = $084           ; Coprocessor 2nd locatio
cop2lch = $084          ; Coprocessor 2nd location(high 5 bits,was 3 bits)
cop2lcl = $086          ; Coprocessor 2nd location (low 15 bits)
copjmp1 = $088          ; Coprocessor restart at 1st location
copjmp2 = $08a          ; Coprocessor restart at 2nd location
copins = $08c           ; Coprocessor inst fetch identify
diwstrt = $08e          ; Display window start (upper left vert,horiz pos)
diwstop = $090          ; Display window stop (lower right vert,horiz pos)
ddfstrt = $092          ; Display bit plane data fetch start,horiz pos
ddfstop = $094          ; Display bit plane data fetch stop,horiz pos
dmacon = $096           ; DMA control write (clear or set)
clxcon = $098           ; Collision control
intena = $09a           ; Interrupt enable bits (clear or set bits)
intreq = $09c           ; Interrupt request bits (clear or set bits)
adkcon = $09e           ; Audio,disk,UART control
aud0lc = $0a0           ; Audio channel 0 location
aud0lch = $0a0          ; Audio channel 0 location (high 5 bits was 3 bits)
aud0lcl = $0a2          ; Audio channel 0 location (low 15 bits)
aud0len = $0a4          ; Audio channel 0 length
aud0per = $0a6          ; Audio channel 0 period
aud0vol = $0a8          ; Audio channel 0 volume
aud0dat = $0aa          ; Audio channel 0 data
aud1lc = $0b0           ; Audio channel 1 location
aud1lch = $0b0          ; Audio channel 1 location (high 5 bits was 3 bits)
aud1lcl = $0b2          ; Audio channel 1 location (low 15 bits)
aud1len = $0b4          ; Audio channel 1 length
aud1per = $0b6          ; Audio channel 1 period
aud1vol = $0b8          ; Audio channel 1 volume
aud1dat = $0ba          ; Audio channel 1 data
aud2lc = $0c0           ; Audio channel 2 location
aud2lch = $0c0          ; Audio channel 2 location (high 5 bits was 3 bits)
aud2lcl = $0c2          ; Audio channel 2 location (low 15 bits)
aud2len = $0c4          ; Audio channel 2 length
aud2per = $0c6          ; Audio channel 2 period
aud2vol = $0c8          ; Audio channel 2 volume
aud2dat = $0ca          ; Audio channel 2 data
aud3lc = $0d0           ; Audio channel 3 location
aud3lch = $0d0          ; Audio channel 3 location (high 5 bits was 3 bits)
aud3lcl = $0d2          ; Audio channel 3 location (low 15 bits)
aud3len = $0d4          ; Audio channel 3 length
aud3per = $0d6          ; Audio channel 3 period
aud3vol = $0d8          ; Audio channel 3 volume
aud3dat = $0da          ; Audio channel 3 data
bplpt = $0e0            ; Bitplane pointers
bpl1pt = $0e0           ; Bitplane pointer 1
bpl1pth = $0e0          ; Bitplane pointer 1 (high 5 bits was 3 bits)
bpl1ptl = $0e2          ; Bitplane pointer 1 (low 15 bits)
bpl2pt = $0e4           ; Bitplane pointer 2
bpl2pth = $0e4          ; Bitplane pointer 2 (high 5 bits was 3 bits)
bpl2ptl = $0e6          ; Bitplane pointer 2 (low 15 bits)
bpl3pt = $0e8           ; Bitplane pointer 3
bpl3pth = $0e8          ; Bitplane pointer 3 (high 5 bits was 3 bits)
bpl3ptl = $0ea          ; Bitplane pointer 3 (low 15 bits)
bpl4pt = $0ec           ; Bitplane pointer 4
bpl4pth = $0ec          ; Bitplane pointer 4 (high 5 bits was 3 bits)
bpl4ptl = $0ee          ; Bitplane pointer 4 (low 15 bits)
bpl5pt = $0f0           ; Bitplane pointer 5
bpl5pth = $0f0          ; Bitplane pointer 5 (high 5 bits was 3 bits)
bpl5ptl = $0f2          ; Bitplane pointer 5 (low 15 bits)
bpl6pt = $0f4           ; Bitplane pointer 6
bpl6pth = $0f4          ; Bitplane pointer 6 (high 5 bits was 3 bits)
bpl6ptl = $0f6          ; Bitplane pointer 6 (low 15 bits)
bpl7pt = $0f8           ; 7
bpl7pth = $0f8          ; 7 (high 5 bits was 3 bits)
bpl7ptl = $0fa          ; 7 (low 15 bits)
bpl8pt = $0fc           ; 8
bpl8pth = $0fc          ; 8 (high 5 bits was 3 bits)
bpl8ptl = $0fe          ; 8 (low 15 bits)
bplcon0 = $100          ; Bitplane control (miscellaneous control bits)
bplcon1 = $102          ; Bitplane control (scroll value)
bplcon2 = $104          ; Bitplane control (video priority control)
bplcon3 = $106          ; Bitplane control (enhanced features)
bpl1mod = $108          ; Bitplane modulo (odd planes)
bpl2mod = $10a          ; Bitplane modulo (even planes)
bplcon4 = $10c          ; (bitplane and sprite-masks)
clxcon2 = $10e          ; control
bpl1dat = $110          ; Bitplane 1 data (parallel to serial convert)
bpl2dat = $112          ; Bitplane 2 data (parallel to serial convert)
bpl3dat = $114          ; Bitplane 3 data (parallel to serial convert)
bpl4dat = $116          ; Bitplane 4 data (parallel to serial convert)
bpl5dat = $118          ; Bitplane 5 data (parallel to serial convert)
bpl6dat = $11a          ; Bitplane 6 data (parallel to serial convert)
bpl7dat = $11c          ; data (parallel to serial convert)
bpl8dat = $11e          ; data (parallel to serial convert)
sprpt = $120            ; Sprite pointers
spr0pt = $120           ; Sprite 0 pointer
spr0pth = $120          ; Sprite 0 pointer (high 5 bits was 3 bits)
spr0ptl = $122          ; Sprite 0 pointer (low 15 bits)
spr1pt = $124           ; Sprite 1 pointer
spr1pth = $124          ; Sprite 1 pointer (high 5 bits was 3 bits)
spr1ptl = $126          ; Sprite 1 pointer (low 15 bits)
spr2pt = $128           ; Sprite 2 pointer
spr2pth = $128          ; Sprite 2 pointer (high 5 bits was 3 bits)
spr2ptl = $12a          ; Sprite 2 pointer (low 15 bits)
spr3pt = $12c           ; Sprite 3 pointer
spr3pth = $12c          ; Sprite 3 pointer (high 5 bits was 3 bits)
spr3ptl = $12e          ; Sprite 3 pointer (low 15 bits)
spr4pt = $130           ; Sprite 4 pointer
spr4pth = $130          ; Sprite 4 pointer (high 5 bits was 3 bits)
spr4ptl = $132          ; Sprite 4 pointer (low 15 bits)
spr5pt = $134           ; Sprite 5 pointer
spr5pth = $134          ; Sprite 5 pointer (high 5 bits was 3 bits)
spr5ptl = $136          ; Sprite 5 pointer (low 15 bits)
spr6pt = $138           ; Sprite 6 pointer
spr6pth = $138          ; Sprite 6 pointer (high 5 bits was 3 bits)
spr6ptl = $13a          ; Sprite 6 pointer (low 15 bits)
spr7pt = $13c           ; Sprite 7 pointer
spr7pth = $13c          ; Sprite 7 pointer (high 5 bits was 3 bits)
spr7ptl = $13e          ; Sprite 7 pointer (low 15 bits)
spr0pos = $140          ; Sprite 0 vert,horiz start pos data
spr0ctl = $142          ; Sprite 0 position and control data
spr0data = $144         ; Sprite 0 image data register A
spr0datb = $146         ; Sprite 0 image data register B
spr1pos = $148          ; Sprite 1 vert,horiz start pos data
spr1ctl = $14a          ; Sprite 1 position and control data
spr1data = $14c         ; Sprite 1 image data register A
spr1datb = $14e         ; Sprite 1 image data register B
spr2pos = $150          ; Sprite 2 vert,horiz start pos data
spr2ctl = $152          ; Sprite 2 position and control data
spr2data = $154         ; Sprite 2 image data register A
spr2datb = $156         ; Sprite 2 image data register B
spr3pos = $158          ; Sprite 3 vert,horiz start pos data
spr3ctl = $15a          ; Sprite 3 position and control data
spr3data = $15c         ; Sprite 3 image data register A
spr3datb = $15e         ; Sprite 3 image data register B
spr4pos = $160          ; Sprite 4 vert,horiz start pos data
spr4ctl = $162          ; Sprite 4 position and control data
spr4data = $164         ; Sprite 4 image data register A
spr4datb = $166         ; Sprite 4 image data register B
spr5pos = $168          ; Sprite 5 vert,horiz start pos data
spr5ctl = $16a          ; Sprite 5 position and control data
spr5data = $16c         ; Sprite 5 image data register A
spr5datb = $16e         ; Sprite 5 image data register B
spr6pos = $170          ; Sprite 6 vert,horiz start pos data
spr6ctl = $172          ; Sprite 6 position and control data
spr6data = $174         ; Sprite 6 image data register A
spr6datb = $176         ; Sprite 6 image data register B
spr7pos = $178          ; Sprite 7 vert,horiz start pos data
spr7ctl = $17a          ; Sprite 7 position and control data
spr7data = $17c         ; Sprite 7 image data register A
spr7datb = $17e         ; Sprite 7 image data register B
color00 = $180          ; Color table 0
color01 = $182          ; Color table 1
color02 = $184          ; Color table 2
color03 = $186          ; Color table 3
color04 = $188          ; Color table 4
color05 = $18a          ; Color table 5
color06 = $18c          ; Color table 6
color07 = $18e          ; Color table 7
color08 = $190          ; Color table 8
color09 = $192          ; Color table 9
color10 = $194          ; Color table 10
color11 = $196          ; Color table 11
color12 = $198          ; Color table 12
color13 = $19a          ; Color table 13
color14 = $19c          ; Color table 14
color15 = $19e          ; Color table 15
color16 = $1a0          ; Color table 16
color17 = $1a2          ; Color table 17
color18 = $1a4          ; Color table 18
color19 = $1a6          ; Color table 19
color20 = $1a8          ; Color table 20
color21 = $1aa          ; Color table 21
color22 = $1ac          ; Color table 22
color23 = $1ae          ; Color table 23
color24 = $1b0          ; Color table 24
color25 = $1b2          ; Color table 25
color26 = $1b4          ; Color table 26
color27 = $1b6          ; Color table 27
color28 = $1b8          ; Color table 28
color29 = $1ba          ; Color table 29
color30 = $1bc          ; Color table 30
color31 = $1be          ; Color table 31
htotal = $1c0           ; number count, horiz line (VARBEAMEN=1)
hsstop = $1c2           ; line position for HSYNC stop
hbstrt = $1c4           ; line position for HBLANK start
hbstop = $1c6           ; line position for HBLANK stop
vtotal = $1c8           ; numbered vertical line (VARBEAMEN=1)
vsstop = $1ca           ; line position for VSYNC stop
vbstrt = $1cc           ; line for VBLANK start
vbstop = $1ce           ; line for VBLANK stop
sprhstrt = $1d0         ; sprite vertical start
sprhstop = $1d2         ; sprite vertical stop
bplhstrt = $1d4         ; bit plane vertical start
bplhstop = $1d6         ; bit plane vertical stop
hhposw = $1d8           ; mode hires H beam counter write
hhposr = $1da           ; mode hires H beam counter read
beamcon0 = $1dc         ; Beam counter control register (SHRES,UHRES,PAL)
hsstrt = $1de           ; sync start (VARHSY)
vsstrt = $1e0           ; sync start (VARVSY)
hcenter = $1e2          ; position for Vsync on interlace
diwhigh = $1e4          ; window - upper bits for start/stop
bplhmod = $1e6          ; bit plane modulo
sprhpt = $1e8           ; sprite pointer
sprhpth = $1e8          ; sprite pointer (high 5 bits)
sprhptl = $1ea          ; sprite pointer (low 15 bits)
bplhpt = $1ec           ;
bplhpth = $1ec          ; (UHRES) bitplane pointer (hi 5 bits)
bplhptl = $1ee          ; (UHRES) bitplane pointer (lo 15 bits)
fmode = $1fc            ; register

;-------------------------------------------------------------------------------
; structs

* AudChannel
ac_ptr = $00            ; ptr to start of waveform data
ac_len = $04            ; length of waveform in words
ac_per = $06            ; sample period
ac_vol = $08            ; volume
ac_dat = $0a            ; sample pair
ac_SIZEOF = $10

* SpriteDef
sd_pos = $00
sd_ctl = $02
sd_dataa = $04
sd_dataB = $06
sd_SIZEOF = $08


********************************************************************************
* DMA Bits
********************************************************************************

DMAB_SETCLR = 15
DMAB_AUD0 = 0
DMAB_AUD1 = 1
DMAB_AUD2 = 2
DMAB_AUD3 = 3
DMAB_DISK = 4
DMAB_SPRITE = 5
DMAB_BLITTER = 6
DMAB_COPPER = 7
DMAB_RASTER = 8
DMAB_MASTER = 9
DMAB_BLITHOG = 10
DMAB_BLTDONE = 14
DMAB_BLTNZERO = 13

DMAF_SETCLR = $8000
DMAF_AUDIO = $000f
DMAF_AUD0 = $0001
DMAF_AUD1 = $0002
DMAF_AUD2 = $0004
DMAF_AUD3 = $0008
DMAF_DISK = $0010
DMAF_SPRITE = $0020
DMAF_BLITTER = $0040
DMAF_COPPER = $0080
DMAF_RASTER = $0100
DMAF_MASTER = $0200
DMAF_BLITHOG = $0400
DMAF_ALL = $01ff
DMAF_BLTDONE = $4000
DMAF_BLTNZERO = $2000


********************************************************************************
* Int Bits
********************************************************************************

INTB_SETCLR = 15        ;Set/Clear control bit. Determines if bits
INTB_INTEN = 14         ;Master interrupt enable only 
INTB_EXTER = 13         ;External interrupt
INTB_DSKSYNC = 12       ;Disk re-SYNChronized
INTB_RBF = 11           ;serial port Receive Buffer Full
INTB_AUD3 = 10          ;Audio channel 3 block finished
INTB_AUD2 = 9           ;Audio channel 2 block finished
INTB_AUD1 = 8           ;Audio channel 1 block finished
INTB_AUD0 = 7           ;Audio channel 0 block finished
INTB_BLIT = 6           ;Blitter finished
INTB_VERTB = 5          ;start of Vertical Blank
INTB_COPER = 4          ;Coprocessor
INTB_PORTS = 3          ;I/O Ports and timers
INTB_SOFTINT = 2        ;software interrupt request
INTB_DSKBLK = 1         ;Disk Block done
INTB_TBE = 0            ;serial port Transmit Buffer Empty

INTF_SETCLR = 1<<15
INTF_INTEN = 1<<14
INTF_EXTER = 1<<13
INTF_DSKSYNC = 1<<12
INTF_RBF = 1<<11
INTF_AUD3 = 1<<10
INTF_AUD2 = 1<<9
INTF_AUD1 = 1<<8
INTF_AUD0 = 1<<7
INTF_BLIT = 1<<6
INTF_VERTB = 1<<5
INTF_COPER = 1<<4
INTF_PORTS = 1<<3
INTF_SOFTINT = 1<<2
INTF_DSKBLK = 1<<1
INTF_TBE = 1<<0


********************************************************************************
* Blitter
********************************************************************************

;-------------------------------------------------------------------------------
; BLTCON0

; NDK

ABC = $80
ABNC = $40
ANBC = $20
ANBNC = $10
NABC = $8
NABNC = $4
NANBC = $2
NANBNC = $1

BC0B_DEST = 8
BC0B_SRCC = 9
BC0B_SRCB = 10
BC0B_SRCA = 11
BC0F_DEST = $100
BC0F_SRCC = $200
BC0F_SRCB = $400
BC0F_SRCA = $800

DEST = $100
SRCC = $200
SRCB = $400
SRCA = $800

ASHIFTSHIFT = 12        /* bits to right align ashift value */
BSHIFTSHIFT = 12        /* bits to right align bshift value */

; Kalms additional

BLTCON0B_ASH3 = 15
BLTCON0B_ASH2 = 14
BLTCON0B_ASH1 = 13
BLTCON0B_ASH0 = 12
BLTCON0B_USEA = 11
BLTCON0B_USEB = 10
BLTCON0B_USEC = 9
BLTCON0B_USED = 8
BLTCON0B_LF7 = 7
BLTCON0B_LF6 = 6
BLTCON0B_LF5 = 5
BLTCON0B_LF4 = 4
BLTCON0B_LF3 = 3
BLTCON0B_LF2 = 2
BLTCON0B_LF1 = 1
BLTCON0B_LF0 = 0

BLTCON0F_ASH3 = 1<<BLTCON0B_ASH3
BLTCON0F_ASH2 = 1<<BLTCON0B_ASH2
BLTCON0F_ASH1 = 1<<BLTCON0B_ASH1
BLTCON0F_ASH0 = 1<<BLTCON0B_ASH0
BLTCON0F_USEA = 1<<BLTCON0B_USEA
BLTCON0F_USEB = 1<<BLTCON0B_USEB
BLTCON0F_USEC = 1<<BLTCON0B_USEC
BLTCON0F_USED = 1<<BLTCON0B_USED
BLTCON0F_LF7 = 1<<BLTCON0B_LF7
BLTCON0F_LF6 = 1<<BLTCON0B_LF6
BLTCON0F_LF5 = 1<<BLTCON0B_LF5
BLTCON0F_LF4 = 1<<BLTCON0B_LF4
BLTCON0F_LF3 = 1<<BLTCON0B_LF3
BLTCON0F_LF2 = 1<<BLTCON0B_LF2
BLTCON0F_LF1 = 1<<BLTCON0B_LF1
BLTCON0F_LF0 = 1<<BLTCON0B_LF0


;-------------------------------------------------------------------------------
; BLTCON1

; NDK

BC1F_DESC = 2

LINEMODE = $1
FILL_OR = $8
FILL_XOR = $10
FILL_CARRYIN = $4
ONEDOT = $2
OVFLAG = $20
SIGNFLAG = $40
BLITREVERSE = $2

SUD = $10
SUL = $8
AUL = $4

OCTANT8 = 24
OCTANT7 = 4
OCTANT6 = 12
OCTANT5 = 28
OCTANT4 = 20
OCTANT3 = 8
OCTANT2 = 0
OCTANT1 = 16

; Kalms additional

BLTCON1B_BSH3 = 15
BLTCON1B_BSH2 = 14
BLTCON1B_BSH1 = 13
BLTCON1B_BSH0 = 12
; in Area mode
BLTCON1B_DOFF = 7
BLTCON1B_EFE = 4
BLTCON1B_IFE = 3
BLTCON1B_FCI = 2
BLTCON1B_DESC = 1
BLTCON1B_LINE = 0
; in Fill mode
BLTCON1B_DPFF = 7
BLTCON1B_SIGN = 6
BLTCON1B_OVF = 5
BLTCON1B_SUD = 4
BLTCON1B_SUL = 3
BLTCON1B_AUL = 2
BLTCON1B_SING = 1
;BLTCON1B_LINE	=	0

BLTCON1F_BSH3 = 1<<BLTCON1B_BSH3
BLTCON1F_BSH2 = 1<<BLTCON1B_BSH2
BLTCON1F_BSH1 = 1<<BLTCON1B_BSH1
BLTCON1F_BSH0 = 1<<BLTCON1B_BSH0
; in Area mode
BLTCON1F_DOFF = 1<<BLTCON1B_DOFF
BLTCON1F_EFE = 1<<BLTCON1B_EFE
BLTCON1F_IFE = 1<<BLTCON1B_IFE
BLTCON1F_FCI = 1<<BLTCON1B_FCI
BLTCON1F_DESC = 1<<BLTCON1B_DESC
BLTCON1F_LINE = 1<<BLTCON1B_LINE
; in Fill mode
BLTCON1F_DPFF = 1<<BLTCON1B_DPFF
BLTCON1F_SIGN = 1<<BLTCON1B_SIGN
BLTCON1F_OVF = 1<<BLTCON1B_OVF
BLTCON1F_SUD = 1<<BLTCON1B_SUD
BLTCON1F_SUL = 1<<BLTCON1B_SUL
BLTCON1F_AUL = 1<<BLTCON1B_AUL
BLTCON1F_SING = 1<<BLTCON1B_SING
;BLTCON1F_LINE	=	1<<BLTCON1B_LINE

;-------------------------------------------------------------------------------
; Minterm bits
; http://eab.abime.net/showthread.php?t=76068
;
; Example use for A XOR B
; move.w	#$0d3c,bltcon0(a6)
; move.w	#BLTEN_ABD+(BLT_A^BLT_B),bltcon0(a6)

BLTEN_AD = (SRCA|DEST)
BLTEN_ABD = (SRCA|SRCB|DEST)
BLTEN_ACD = (SRCA|SRCC|DEST)
BLTEN_ABCD = (SRCA|SRCB|SRCC|DEST)

BLT_A = %11110000
BLT_B = %11001100
BLT_C = %10101010


********************************************************************************
* ADK
********************************************************************************

; bit definitions for adkcon register

ADKB_SETCLR = 15        ; standard set/clear bit
ADKB_PRECOMP1 = 14      ; two bits of precompensation
ADKB_PRECOMP0 = 13
ADKB_MFMPREC = 12       ; use mfm style precompensation
ADKB_UARTBRK = 11       ; force uart output to zero
ADKB_WORDSYNC = 10      ; enable DSKSYNC register matching
ADKB_MSBSYNC = 9        ; (Apple GCR Only) sync on MSB for reading
ADKB_FAST = 8           ; 1 -> 2 us/bit (mfm), 2 -> 4 us/bit (gcr)
ADKB_USE3PN = 7         ; use aud chan 3 to modulate period of ??
ADKB_USE2P3 = 6         ; use aud chan 2 to modulate period of 3
ADKB_USE1P2 = 5         ; use aud chan 1 to modulate period of 2
ADKB_USE0P1 = 4         ; use aud chan 0 to modulate period of 1
ADKB_USE3VN = 3         ; use aud chan 3 to modulate volume of ??
ADKB_USE2V3 = 2         ; use aud chan 2 to modulate volume of 3
ADKB_USE1V2 = 1         ; use aud chan 1 to modulate volume of 2
ADKB_USE0V1 = 0         ; use aud chan 0 to modulate volume of 1

ADKF_SETCLR = (1<<15)
ADKF_PRECOMP1 = (1<<14)
ADKF_PRECOMP0 = (1<<13)
ADKF_MFMPREC = (1<<12)
ADKF_UARTBRK = (1<<11)
ADKF_WORDSYNC = (1<<10)
ADKF_MSBSYNC = (1<<9)
ADKF_FAST = (1<<8)
ADKF_USE3PN = (1<<7)
ADKF_USE2P3 = (1<<6)
ADKF_USE1P2 = (1<<5)
ADKF_USE0P1 = (1<<4)
ADKF_USE3VN = (1<<3)
ADKF_USE2V3 = (1<<2)
ADKF_USE1V2 = (1<<1)
ADKF_USE0V1 = (1<<0)

ADKF_PRE000NS = 0       ; 000 ns of precomp
ADKF_PRE140NS = (ADKF_PRECOMP0) ; 140 ns of precomp
ADKF_PRE280NS = (ADKF_PRECOMP1) ; 280 ns of precomp
ADKF_PRE560NS = (ADKF_PRECOMP0!ADKF_PRECOMP1) ; 560 ns of precomp


********************************************************************************
* CIA
********************************************************************************

* cia register offsets
ciapra = $0000
ciaprb = $0100
ciaddra = $0200
ciaddrb = $0300
ciatalo = $0400
ciatahi = $0500
ciatblo = $0600
ciatbhi = $0700
ciatodlow = $0800
ciatodmid = $0900
ciatodhi = $0a00
ciasdr = $0c00
ciaicr = $0d00
ciacra = $0e00
ciacrb = $0f00

* interrupt control register bit numbers
CIAICRB_TA = 0
CIAICRB_TB = 1
CIAICRB_ALRM = 2
CIAICRB_SP = 3
CIAICRB_FLG = 4
CIAICRB_IR = 7
CIAICRB_SETCLR = 7

* control register A bit numbers
CIACRAB_START = 0
CIACRAB_PBON = 1
CIACRAB_OUTMODE = 2
CIACRAB_RUNMODE = 3
CIACRAB_LOAD = 4
CIACRAB_INMODE = 5
CIACRAB_SPMODE = 6
CIACRAB_TODIN = 7

* control register B bit numbers
CIACRBB_START = 0
CIACRBB_PBON = 1
CIACRBB_OUTMODE = 2
CIACRBB_RUNMODE = 3
CIACRBB_LOAD = 4
CIACRBB_INMODE0 = 5
CIACRBB_INMODE1 = 6
CIACRBB_ALARM = 7

* interrupt control register bit masks
CIAICRF_TA = (1<<0)
CIAICRF_TB = (1<<1)
CIAICRF_ALRM = (1<<2)
CIAICRF_SP = (1<<3)
CIAICRF_FLG = (1<<4)
CIAICRF_IR = (1<<7)
CIAICRF_SETCLR = (1<<7)

* control register A bit masks
CIACRAF_START = (1<<0)
CIACRAF_PBON = (1<<1)
CIACRAF_OUTMODE = (1<<2)
CIACRAF_RUNMODE = (1<<3)
CIACRAF_LOAD = (1<<4)
CIACRAF_INMODE = (1<<5)
CIACRAF_SPMODE = (1<<6)
CIACRAF_TODIN = (1<<7)

* control register B bit masks
CIACRBF_START = (1<<0)
CIACRBF_PBON = (1<<1)
CIACRBF_OUTMODE = (1<<2)
CIACRBF_RUNMODE = (1<<3)
CIACRBF_LOAD = (1<<4)
CIACRBF_INMODE0 = (1<<5)
CIACRBF_INMODE1 = (1<<6)
CIACRBF_ALARM = (1<<7)

* control register B INMODE masks
CIACRBF_IN_PHI2 = 0
CIACRBF_IN_CNT = (CIACRBF_INMODE0)
CIACRBF_IN_TA = (CIACRBF_INMODE1)
CIACRBF_IN_CNT_TA = (CIACRBF_INMODE0!CIACRBF_INMODE1)

*:
* Port definitions -- what each bit in a cia peripheral register is tied to
*:

* ciaa port A (0xbfe001)
CIAB_GAMEPORT1 = (7)    * gameport 1, pin 6 (fire button*)
CIAB_GAMEPORT0 = (6)    * gameport 0, pin 6 (fire button*)
CIAB_DSKRDY = (5)       * disk ready*
CIAB_DSKTRACK0 = (4)    * disk on track 00*
CIAB_DSKPROT = (3)      * disk write protect*
CIAB_DSKCHANGE = (2)    * disk change*
CIAB_LED = (1)          * led light control (0==>bright)
CIAB_OVERLAY = (0)      * memory overlay bit

* ciaa port B (0xbfe101) -- parallel port

* ciab port A (0xbfd000) -- serial and printer control
CIAB_COMDTR = (7)       * serial Data Terminal Ready*
CIAB_COMRTS = (6)       * serial Request to Send*
CIAB_COMCD = (5)        * serial Carrier Detect*
CIAB_COMCTS = (4)       * serial Clear to Send*
CIAB_COMDSR = (3)       * serial Data Set Ready*
CIAB_PRTRSEL = (2)      * printer SELECT
CIAB_PRTRPOUT = (1)     * printer paper out
CIAB_PRTRBUSY = (0)     * printer busy

* ciab port B (0xbfd100) -- disk control
CIAB_DSKMOTOR = (7)     * disk motorr*
CIAB_DSKSEL3 = (6)      * disk select unit 3*
CIAB_DSKSEL2 = (5)      * disk select unit 2*
CIAB_DSKSEL1 = (4)      * disk select unit 1*
CIAB_DSKSEL0 = (3)      * disk select unit 0*
CIAB_DSKSIDE = (2)      * disk side select*
CIAB_DSKDIREC = (1)     * disk direction of seek*
CIAB_DSKSTEP = (0)      * disk step heads*

* ciaa port A (0xbfe001)
CIAF_GAMEPORT1 = (1<<7)
CIAF_GAMEPORT0 = (1<<6)
CIAF_DSKRDY = (1<<5)
CIAF_DSKTRACK0 = (1<<4)
CIAF_DSKPROT = (1<<3)
CIAF_DSKCHANGE = (1<<2)
CIAF_LED = (1<<1)
CIAF_OVERLAY = (1<<0)

* ciaa port B (0xbfe101) -- parallel port

* ciab port A (0xbfd000) -- serial and printer control
CIAF_COMDTR = (1<<7)
CIAF_COMRTS = (1<<6)
CIAF_COMCD = (1<<5)
CIAF_COMCTS = (1<<4)
CIAF_COMDSR = (1<<3)
CIAF_PRTRSEL = (1<<2)
CIAF_PRTRPOUT = (1<<1)
CIAF_PRTRBUSY = (1<<0)

* ciab port B (0xbfd100) -- disk control
CIAF_DSKMOTOR = (1<<7)
CIAF_DSKSEL3 = (1<<6)
CIAF_DSKSEL2 = (1<<5)
CIAF_DSKSEL1 = (1<<4)
CIAF_DSKSEL0 = (1<<3)
CIAF_DSKSIDE = (1<<2)
CIAF_DSKDIREC = (1<<1)
CIAF_DSKSTEP = (1<<0)

        endc