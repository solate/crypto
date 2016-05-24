// Use of this source code is governed by a license
// that can be found in the LICENSE file.

// +build amd64,!gccgo,!appengine

// func chachaCore(dst *[64]byte, state *[16]uint32, rounds int)
TEXT ·chachaCore(SB),4,$0-24
	MOVQ state+8(FP), AX
	MOVQ dst+0(FP), BX
	MOVQ rounds+16(FP), CX
	MOVO 0(AX), X0
	MOVO 16(AX), X1
	MOVO 32(AX), X2
	MOVO 48(AX), X3
	MOVO X0, X4
	MOVO X1, X5
	MOVO X2, X6
	MOVO X3, X7
	loop:
		PADDL X5, X4
		PXOR X4, X7
		MOVO X7, X8
		PSLLL $16, X8
		PSRLL $16, X7
		PXOR X8, X7
		PADDL X7, X6
		PXOR X6, X5
		MOVO X5, X8
		PSLLL $12, X8
		PSRLL $20, X5
		PXOR X8, X5
		PADDL X5, X4
		PXOR X4, X7
		MOVO X7, X8
		PSLLL $8, X8
		PSRLL $24, X7
		PXOR X8, X7
		PADDL X7, X6
		PXOR X6, X5
		MOVO X5, X8
		PSLLL $7, X8
		PSRLL $25, X5
		PXOR X8, X5
		PSHUFL $57, X5, X5
		PSHUFL $78, X6, X6
		PSHUFL $147, X7, X7
		PADDL X5, X4
		PXOR X4, X7
		MOVO X7, X8
		PSLLL $16, X8
		PSRLL $16, X7
		PXOR X8, X7
		PADDL X7, X6
		PXOR X6, X5
		MOVO X5, X8
		PSLLL $12, X8
		PSRLL $20, X5
		PXOR X8, X5
		PADDL X5, X4
		PXOR X4, X7
		MOVO X7, X8
		PSLLL $8, X8
		PSRLL $24, X7
		PXOR X8, X7
		PADDL X7, X6
		PXOR X6, X5
		MOVO X5, X8
		PSLLL $7, X8
		PSRLL $25, X5
		PXOR X8, X5
		PSHUFL $147, X5, X5
		PSHUFL $78, X6, X6
		PSHUFL $57, X7, X7
		SUBQ $2, CX
		JNE loop
	PADDL X4, X0
	PADDL X5, X1
	PADDL X6, X2
	PADDL X7, X3
	MOVO X0, 0(BX)
	MOVO X1, 16(BX)
	MOVO X2, 32(BX)
	MOVO X3, 48(BX)
	RET

// func chachaCoreXOR(dst *byte, src *byte, state *[16]uint32, rounds uint)
TEXT ·chachaCoreXOR(SB),4,$0-32
	MOVQ dst+0(FP), AX
	MOVQ src+8(FP), BX
	MOVQ state+16(FP), CX
	MOVQ rounds+24(FP), DX
	MOVO 0(CX), X0
	MOVO 16(CX), X1
	MOVO 32(CX), X2
	MOVO 48(CX), X3
	MOVO X0, X4
	MOVO X1, X5
	MOVO X2, X6
	MOVO X3, X7
chacha_loop_begin:
		PADDL X5, X4
		PXOR X4, X7
		MOVO X7, X8
		PSLLL $16, X8
		PSRLL $16, X7
		PXOR X8, X7
		PADDL X7, X6
		PXOR X6, X5
		MOVO X5, X8
		PSLLL $12, X8
		PSRLL $20, X5
		PXOR X8, X5
		PADDL X5, X4
		PXOR X4, X7
		MOVO X7, X8
		PSLLL $8, X8
		PSRLL $24, X7
		PXOR X8, X7
		PADDL X7, X6
		PXOR X6, X5
		MOVO X5, X8
		PSLLL $7, X8
		PSRLL $25, X5
		PXOR X8, X5
		PSHUFL $57, X5, X5
		PSHUFL $78, X6, X6
		PSHUFL $147, X7, X7
		PADDL X5, X4
		PXOR X4, X7
		MOVO X7, X8
		PSLLL $16, X8
		PSRLL $16, X7
		PXOR X8, X7
		PADDL X7, X6
		PXOR X6, X5
		MOVO X5, X8
		PSLLL $12, X8
		PSRLL $20, X5
		PXOR X8, X5
		PADDL X5, X4
		PXOR X4, X7
		MOVO X7, X8
		PSLLL $8, X8
		PSRLL $24, X7
		PXOR X8, X7
		PADDL X7, X6
		PXOR X6, X5
		MOVO X5, X8
		PSLLL $7, X8
		PSRLL $25, X5
		PXOR X8, X5
		PSHUFL $147, X5, X5
		PSHUFL $78, X6, X6
		PSHUFL $57, X7, X7
		SUBQ $2, DX
		JNE chacha_loop_begin
	PADDL X0, X4
	PADDL X1, X5
	PADDL X2, X6
	PADDL X3, X7
	MOVOU 0(BX), X8
	PXOR X4, X8
	MOVOU X8, 0(AX)
	MOVOU 16(BX), X8
	PXOR X5, X8
	MOVOU X8, 16(AX)
	MOVOU 32(BX), X8
	PXOR X6, X8
	MOVOU X8, 32(AX)
	MOVOU 48(BX), X8
	PXOR X7, X8
	MOVOU X8, 48(AX)
	RET

// func chachaCoreXOR128(dst *byte, src *byte, n128 int, state *[16]uint32, rounds int)
TEXT ·chachaCoreXOR128(SB),4,$0-40
	MOVQ dst+0(FP), AX
	MOVQ src+8(FP), BX
	MOVQ n64+16(FP), CX
	MOVQ state+24(FP), DX
	MOVQ rounds+32(FP), DI
	MOVO 0(DX), X0
	MOVO 16(DX), X1
	MOVO 32(DX), X2
	MOVO 48(DX), X3
	PXOR X4, X4
	MOVO X4, 48(DX)
	MOVL $1, SI
	MOVL SI, 48(DX)
	MOVO 48(DX), X4
xor_loop_begin:
		MOVO X0, X5
		MOVO X1, X6
		MOVO X2, X7
		MOVO X3, X8
		MOVO X0, X9
		MOVO X1, X10
		MOVO X2, X11
		MOVO X3, X12
		PADDQ X4, X12
		MOVQ DI, SI
chacha_loop_begin:
			PADDL X6, X5
			PADDL X10, X9
			PXOR X5, X8
			PXOR X9, X12
			MOVO X8, X13
			PSLLL $16, X13
			PSRLL $16, X8
			PXOR X13, X8
			MOVO X12, X13
			PSLLL $16, X13
			PSRLL $16, X12
			PXOR X13, X12
			PADDL X8, X7
			PADDL X12, X11
			PXOR X7, X6
			PXOR X11, X10
			MOVO X6, X13
			PSLLL $12, X13
			PSRLL $20, X6
			PXOR X13, X6
			MOVO X10, X13
			PSLLL $12, X13
			PSRLL $20, X10
			PXOR X13, X10
			PADDL X6, X5
			PADDL X10, X9
			PXOR X5, X8
			PXOR X9, X12
			MOVO X8, X13
			PSLLL $8, X13
			PSRLL $24, X8
			PXOR X13, X8
			MOVO X12, X13
			PSLLL $8, X13
			PSRLL $24, X12
			PXOR X13, X12
			PADDL X8, X7
			PADDL X12, X11
			PXOR X7, X6
			PXOR X11, X10
			MOVO X6, X13
			PSLLL $7, X13
			PSRLL $25, X6
			PXOR X13, X6
			MOVO X10, X13
			PSLLL $7, X13
			PSRLL $25, X10
			PXOR X13, X10
			PSHUFL $57, X6, X6
			PSHUFL $57, X10, X10
			PSHUFL $78, X7, X7
			PSHUFL $78, X11, X11
			PSHUFL $147, X8, X8
			PSHUFL $147, X12, X12
			PADDL X6, X5
			PADDL X10, X9
			PXOR X5, X8
			PXOR X9, X12
			MOVO X8, X13
			PSLLL $16, X13
			PSRLL $16, X8
			PXOR X13, X8
			MOVO X12, X13
			PSLLL $16, X13
			PSRLL $16, X12
			PXOR X13, X12
			PADDL X8, X7
			PADDL X12, X11
			PXOR X7, X6
			PXOR X11, X10
			MOVO X6, X13
			PSLLL $12, X13
			PSRLL $20, X6
			PXOR X13, X6
			MOVO X10, X13
			PSLLL $12, X13
			PSRLL $20, X10
			PXOR X13, X10
			PADDL X6, X5
			PADDL X10, X9
			PXOR X5, X8
			PXOR X9, X12
			MOVO X8, X13
			PSLLL $8, X13
			PSRLL $24, X8
			PXOR X13, X8
			MOVO X12, X13
			PSLLL $8, X13
			PSRLL $24, X12
			PXOR X13, X12
			PADDL X8, X7
			PADDL X12, X11
			PXOR X7, X6
			PXOR X11, X10
			MOVO X6, X13
			PSLLL $7, X13
			PSRLL $25, X6
			PXOR X13, X6
			MOVO X10, X13
			PSLLL $7, X13
			PSRLL $25, X10
			PXOR X13, X10
			PSHUFL $147, X6, X6
			PSHUFL $147, X10, X10
			PSHUFL $78, X7, X7
			PSHUFL $78, X11, X11
			PSHUFL $57, X8, X8
			PSHUFL $57, X12, X12
			SUBQ $2, SI
			JNE chacha_loop_begin
		PADDL X0, X5
		PADDL X1, X6
		PADDL X2, X7
		PADDL X3, X8
		MOVOU 0(BX), X13
		PXOR X5, X13
		MOVOU X13, 0(AX)
		MOVOU 16(BX), X13
		PXOR X6, X13
		MOVOU X13, 16(AX)
		MOVOU 32(BX), X13
		PXOR X7, X13
		MOVOU X13, 32(AX)
		MOVOU 48(BX), X13
		PXOR X8, X13
		MOVOU X13, 48(AX)
		PADDQ X4, X3
		ADDQ $64, AX
		ADDQ $64, BX
		PADDL X0, X9
		PADDL X1, X10
		PADDL X2, X11
		PADDL X3, X12
		MOVOU 0(BX), X13
		PXOR X5, X13
		MOVOU X13, 0(AX)
		MOVOU 16(BX), X13
		PXOR X6, X13
		MOVOU X13, 16(AX)
		MOVOU 32(BX), X13
		PXOR X7, X13
		MOVOU X13, 32(AX)
		MOVOU 48(BX), X13
		PXOR X8, X13
		MOVOU X13, 48(AX)
		PADDQ X4, X3
		ADDQ $64, AX
		ADDQ $64, BX
		SUBQ $128, CX
		JNE xor_loop_begin
	MOVO X0, 0(DX)
	MOVO X1, 16(DX)
	MOVO X2, 32(DX)
	MOVO X3, 48(DX)
	RET