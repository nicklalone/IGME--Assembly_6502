HITDET:
	LDA	R_BKER	;GET KERNAL WITH BOTTEM OF CURSOR
	LSR		;\2 FOR BIRDKERNAL
	TAX
	BCC	GOODKER	;IF CARRY ITS A NEST
	INX		;SO GO TO THE ASSOCATED BIRD KER
GOODKER:
	STX	TEMP3		;IS BIRD DEAD

	CPX	#2
	bne	NOT2
IS2:	NOP
NOT2:	CPX	#3
	bne	NOT3
IS3:	NOP
NOT3:


	LDA	BIRDCHAR,X
	CMP	#1
	BCS	GO
	RTS

GO:
;	TXA	;FIND KERNAL STARTING Y POSITION BY
;	ASL	;MULTPLYING BY 2 CAUSE NEST KERNALS ARE INCLUDED IN THE TABLE
;	TAY
;	INY	;ADD 1 CAUSE THE FIRST TABLE ENTRY IS ZERO
;	INY	;ADD ANOTHER CAUSE THESE ARE KERNAL TOPS AND WE WANT BOTTEMS
;



;;;;;;;;;;;;;;;;;;;;;;;;;
; FIND OUT IF TOP OF CURSOR IS BELOW BOTTEM OF BIRD
; I.E. IF CURTOP-BRDBOTTEM CAUSES CARYY (CARRY CLEAR) BIRD IS ABOVE CURSOR

	

;	LDA	R_VOFFSET	;GET TOP OF CURSOR
;	SEC			
;	SBC	r_ypos,x	;
;	CLC
;	ADC	#CURSIZE
;	BCC	.exit
;	SBC	@TOPKER(Y)
;	sta	TEMP
;		
;
;
;	BCC	.exit
;FIND OUT IF TOP OF BIRD IS BELOW BOTTEM OF CURSOR
;i.e. BRDTOP-CURBOTTEM CAUSE CARRY (CARRY CLEAR) BIRD IS BELOW CURSOR
;	LDA	BIRDCHAR,X
;	TAY
;	LDA	CHARSIZE,Y
;	SEC
;	SBC	TEMP
;	CMP	R_VOFFSET
;	BCC	.exit

HCHK:
	LDA	HOFFSET		;CURSOR X POSITION
	sec
	SBC	X,r_xpos	;BIRD X POSITION
	CMP	#4
	BCC	HHIT
	LDA	X,r_xpos
	sec
	SBC	HOFFSET
	CMP	#4
	BCC	HHIT
	jmp	Hexit
;
;	Bird is Hit .!!!!!!!!!!^%$*^$!@%$)_+)+??????
;
HHIT:	
	jsr	PLAY_DING
	jsr 	INC_SCORE
	ldx	TEMP3
	txa
	asl
	tay
EGGSCORE:
	lda	R_SCREEN
	cmp	#INPIPESCREEN
	bne	SETREE

	lda	x,w_got_egg		;drop egg
	bne	PTWO_SCORE
PONE_SCORE:
	lda	#(PONEIMG & $FF)
	sta	BIRDDATA,y
	lda	#(PONEIMG & $FF00)/$0100
	sta	BIRDDATA+1,y
	jmp	exit_score

PTWO_SCORE:
	lda	#(PTWOIMG & $FF)
	sta	BIRDDATA,y
	lda	#(PTWOIMG & $FF00)/$0100
	sta	BIRDDATA+1,y
	LDA	#1		;TELL INITDROP BIRD IS DROPPING THE EGG
	jsr	INITDROP	; start egg dropping
	jmp	exit_score

SETREE:
	lda	x,w_got_egg		;drop egg
	bne	TTWO_SCORE
TONE_SCORE:
	lda	#(TONEIMG & $FF)
	sta	BIRDDATA,y
	lda	#(TONEIMG & $FF00)/$0100
	sta	BIRDDATA+1,y
	jmp	exit_score

TTWO_SCORE:
	lda	#(TTWOIMG & $FF)
	sta	BIRDDATA,y
	lda	#(TTWOIMG & $FF00)/$0100
	sta	BIRDDATA+1,y
	LDA	#1		;TELL INITDROP BIRD IS DROPPING THE EGG
	jsr	INITDROP	; start egg dropping

exit_score:
;
;
;
;
	ldx	TEMP3
	lda	#0
	sta	BIRDCOLOR,x
	sta	BIRDCHAR,x
	sta	w_got_egg,x		;drop egg
	lda	#SCOREHOLD
	sta	w_hold,x
	lda	#REFLEFT
	sta	W_BRD1REF,x
Hexit:	rts

			
	
