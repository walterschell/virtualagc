### FILE="Main.annotation"
# Copyright:	Public domain.
# Filename:	???.agc
# Purpose:	Part of the source code for Solarium build 55. This
#		is for the Command Module's (CM) Apollo Guidance
#		Computer (AGC), for Apollo 4.
# Assembler:	yaYUL --block1
# Contact:	Jim Lawton <jim DOT lawton AT gmail DOT com>
# Website:	www.ibiblio.org/apollo/index.html
# Page scans:	www.ibiblio.org/apollo/ScansForConversion/Solarium055/
# Mod history:	2009-09-22 JL	Created.
#		2009-09-22 JL	Fixed typo.

## Page 326

		SETLOC	60000

AVETOMD1	AXC,1	2
		ITA	SXA,1
		ITC
			1
			MIDEXIT
			MEASMODE
			AVETOMID

AVETOMD2	AXC,1	1
		ITA	SXA,1
			2
			MIDEXIT
			MEASMODE

AVETOMID	VMOVE	6
		AXT,1	SXA,1
		AXT,1	SXA,1
		AXT,1	SXA,1
		AXT,1	SXA,1
		AXT,1	SXA,1
		AXT,1	SXA,1
			ZEROVEC
			0
			WMATFLAG	# TURN OFF WMATRIX INTEGRATION.
			RSCALE
			SCALER		# SET SCALE OF POSITION.
			4
			SCALDELT	# ALSO DEVIATION.
			18D
			SCALEDT		# AND TIME STEP.
			EARTHTAB
			PBODY
			TESTTET
			STEPEXIT
		STORE	TDELTAV		# ZERO POSITION DEVIATION.

		NOLOD	0
		STORE	TNUV		# ALSO VELOCITY.

		NOLOD	0		# AND TIME SINCE RECTIFICATION, TIME, 
		STORE	TC		# AND KEPLER X.
## Page 327
		AXT,1	1
		AST,1
			12D
			6

RVTOMID		VXSC*	1		# TRANSFORM POSITION AND VELOCTY TO
		VXM	VSLT
			RRECT +12D,1
			SCLRAVMD +12D,1
			REFSMMAT
			2
		STORE	RRECT +12D,1

		NOLOD	0
		STORE	RCV +12D,1

		TIX,1	0
			RVTOMID

		DMOVE	0
			TAVEGON
		STORE	TDEC

## Page 328

TESTTET		EXIT	0		# FOR DUMP ONLY
		TC	INTPRET
		LXC,1	1
		AST,1	TIX,1
			MEASMODE
			1
			+3

		ITC	0
			+4

		TEST	0
			UPDATFLG
			NOSTATE

		STZ	0
			OVFIND

		DSU	2
		RTB	TSLT
		DDV
			TDEC
			TET
			SGNAGREE
			11D
			EARTHTAB
		STORE	DT/2

		BOV	3
		ABS	DSU
		BMN	DAD
		DSU	BMN
			USEMAXDT
			DT/2
			DT/2MIN
			DODCSION
			DT/2MIN
			DT/2MAX
			TIMESTEP

USEMAXDT	DMOVE	1
		SIGN
			DT/2MAX
			DT/2
		STORE	DT/2

		ITC	0
			TIMESTEP

## Page 329

DODCSION	ITC	0		# RECTIFY TO OBTAIN FULL POSITION
			RECTIFY		# AND VELOCUTY VECTORS.

		SMOVE	1
		BMN	BZE
			MEASMODE	# TEST MEASMODE.
			AVEGON		# MEASMODE = -1.
			IGN-4SEC	# MEASMODE = 0.

		AXT,1	1		# MEASMODE = +1.
		AST,1
			12D
			6

RVTOAVE		VXSC*	1		# TRANSFORM POSITION AND VELOCITY VECTORS
		MXV	VSLT
			RRECT +12D,1
			SCLRMDAV +12D,1
			REFSMMAT
			1
		STORE	RIGNTION +12D,1

		VXSC*	1
		MXV	VSLT
			RAVEGON +12D,1
			SCLRMDAV +12D,1
			REFSMMAT
			1
		STORE	RAVEGON +12D,1

		TIX,1	0
			RVTOAVE

		ITCI	0
			MIDEXIT		# RETURN. 

## Page 330

AVEGON		VMOVE	0		# SAVE POSITION AND VELOCTY AT
			RRECT		# AVERAGE G ON TIME.
		STORE	RAVEGON

		VMOVE	0
			VRECT
		STORE	VAVEGON

		LXC,1	1
		AST,1	TIX,1
			MEASMODE
			1
			RVTOAVE -4

		DAD	1
		AXT,1	SXA,1
			TDEC
			12M56S		# 12 MINUTES, 56 SECS
			0
			MEASMODE	# MAKE MEASMODE 0.
		STORE	TDEC

		ITC	0
			TESTTET		# CONTINUE INTEGRATION.



IGN-4SEC	VXSC	1		# TRANSFORM AND SAVE POSITION ONLY
		MXV	VSLT
			RRECT
			SCLRMDAV
			REFSMMAT
			1
		STORE	RIG-4SEC

		DAD	1
		AXT,1	SXA,1
			TDEC
			4SECONDS	# ADD 4 SECONDS TO DECISION TIME.
			1
			MEASMODE	# MAKE MEASMODE +1.
		STORE	TDEC

		ITC	0
			TESTTET		# DO LAST INTEGRATION STEP.

## Page 331
12M56S		2DEC	77600		# 12 MINUTES, 56 SECS
4SECONDS	2DEC	400
DT/2MIN		2DEC	.000024
DT/2MAX		2DEC	.65027077 B-1	# .075 HOUR MAXIMUM TIME STEP
INITMSK		OCT	30000
