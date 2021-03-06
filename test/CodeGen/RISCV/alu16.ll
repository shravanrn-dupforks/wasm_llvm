; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

; These tests are identical to those in alu32.ll but operate on i16. They check
; that legalisation of these non-native types doesn't introduce unnecessary
; inefficiencies.

; TODO: it's unnecessary to mask (zero-extend) the shift amount.

define i16 @addi(i16 %a) nounwind {
; RV32I-LABEL: addi:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, 1
; RV32I-NEXT:    ret
  %1 = add i16 %a, 1
  ret i16 %1
}

define i16 @slti(i16 %a) nounwind {
; RV32I-LABEL: slti:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    slti a0, a0, 2
; RV32I-NEXT:    ret
  %1 = icmp slt i16 %a, 2
  %2 = zext i1 %1 to i16
  ret i16 %2
}

define i16 @sltiu(i16 %a) nounwind {
; RV32I-LABEL: sltiu:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    sltiu a0, a0, 3
; RV32I-NEXT:    ret
  %1 = icmp ult i16 %a, 3
  %2 = zext i1 %1 to i16
  ret i16 %2
}

define i16 @xori(i16 %a) nounwind {
; RV32I-LABEL: xori:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a0, a0, 4
; RV32I-NEXT:    ret
  %1 = xor i16 %a, 4
  ret i16 %1
}

define i16 @ori(i16 %a) nounwind {
; RV32I-LABEL: ori:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ori a0, a0, 5
; RV32I-NEXT:    ret
  %1 = or i16 %a, 5
  ret i16 %1
}

define i16 @andi(i16 %a) nounwind {
; RV32I-LABEL: andi:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 6
; RV32I-NEXT:    ret
  %1 = and i16 %a, 6
  ret i16 %1
}

define i16 @slli(i16 %a) nounwind {
; RV32I-LABEL: slli:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 7
; RV32I-NEXT:    ret
  %1 = shl i16 %a, 7
  ret i16 %1
}

define i16 @srli(i16 %a) nounwind {
; RV32I-LABEL: srli:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, -64
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 6
; RV32I-NEXT:    ret
  %1 = lshr i16 %a, 6
  ret i16 %1
}

define i16 @srai(i16 %a) nounwind {
; RV32I-LABEL: srai:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 25
; RV32I-NEXT:    ret
  %1 = ashr i16 %a, 9
  ret i16 %1
}


define i16 @add(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: add:
; RV32I:       # %bb.0:
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    ret
  %1 = add i16 %a, %b
  ret i16 %1
}

define i16 @sub(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: sub:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    ret
  %1 = sub i16 %a, %b
  ret i16 %1
}

define i16 @sll(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: sll:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a2, 16
; RV32I-NEXT:    addi a2, a2, -1
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sll a0, a0, a1
; RV32I-NEXT:    ret
  %1 = shl i16 %a, %b
  ret i16 %1
}

define i16 @slt(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: slt:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a1, 16
; RV32I-NEXT:    srai a1, a1, 16
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    slt a0, a0, a1
; RV32I-NEXT:    ret
  %1 = icmp slt i16 %a, %b
  %2 = zext i1 %1 to i16
  ret i16 %2
}

define i16 @sltu(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: sltu:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a2, 16
; RV32I-NEXT:    addi a2, a2, -1
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    sltu a0, a0, a1
; RV32I-NEXT:    ret
  %1 = icmp ult i16 %a, %b
  %2 = zext i1 %1 to i16
  ret i16 %2
}

define i16 @xor(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: xor:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
  %1 = xor i16 %a, %b
  ret i16 %1
}

define i16 @srl(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: srl:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a2, 16
; RV32I-NEXT:    addi a2, a2, -1
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    srl a0, a0, a1
; RV32I-NEXT:    ret
  %1 = lshr i16 %a, %b
  ret i16 %1
}

define i16 @sra(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: sra:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lui a2, 16
; RV32I-NEXT:    addi a2, a2, -1
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    sra a0, a0, a1
; RV32I-NEXT:    ret
  %1 = ashr i16 %a, %b
  ret i16 %1
}

define i16 @or(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: or:
; RV32I:       # %bb.0:
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
  %1 = or i16 %a, %b
  ret i16 %1
}

define i16 @and(i16 %a, i16 %b) nounwind {
; RV32I-LABEL: and:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    ret
  %1 = and i16 %a, %b
  ret i16 %1
}
