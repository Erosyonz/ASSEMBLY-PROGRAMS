; System Name: Library Management System
; Discription: A simple library management system with user registration and login that is capable of managing books and users (Add book, Update Book, Delete Book, View Book).
; Programmer: Alleah Dela Pena
; Date Started: November 22, 2025
; Date Completed: December 7, 2025


putc MACRO char
    mov ah, 02h
    mov dl, char
    int 21h
ENDM
renderc MACRO char, page, color, write
    mov ah, 09h 
    mov al, char
    mov bh, page
    mov bl, color
    mov cx, write
    int 10h
ENDM
setcursor MACRO row, col
    mov ah, 02h
    mov bh, 00h
    mov dh, row
    mov dl, col
    int 10h
ENDM
colorz MACRO color, write
    mov ah, 09h 
    mov bl, color
    mov cx, write
    int 10h
ENDM
.model small
.data

	MAX_USERS EQU 10
	USER_COUNT DB 0

	USERS DB 400 dup(0) 
	; First Screen Data - Title Screen
	title_0_R0_C0 db "                                                                                ",'$'
	title_1_R1_C0 db "                                                                                ",'$'
	title_2_R2_C0 db "                 ",'$'
	title_3_R2_C17 db "                                               ",'$'
	title_4_R2_C64 db "                ",'$'
	title_5_R3_C0 db "                 ",'$'
	title_6_R3_C17 db "  ",'$'
	title_7_R3_C19 db "                                           ",'$'
	title_8_R3_C62 db "  ",'$'
	title_9_R3_C64 db "                ",'$'
	title_10_R4_C0 db "                 ",'$'
	title_11_R4_C17 db "  ",'$'
	title_12_R4_C19 db "     -------------------------------       ",'$'
	title_13_R4_C62 db "  ",'$'
	title_14_R4_C64 db "                ",'$'
	title_15_R5_C0 db "                 ",'$'
	title_16_R5_C17 db "  ",'$'
	title_17_R5_C19 db "        LIBRARY MANAGEMENT SYSTEM          ",'$'
	title_18_R5_C62 db "  ",'$'
	title_19_R5_C64 db "                ",'$'
	title_20_R6_C0 db "                 ",'$'
	title_21_R6_C17 db "  ",'$'
	title_22_R6_C19 db "     -------------------------------       ",'$'
	title_23_R6_C62 db "  ",'$'
	title_24_R6_C64 db "                ",'$'
	title_25_R7_C0 db "                 ",'$'
	title_26_R7_C17 db "  ",'$'
	title_27_R7_C19 db "                                           ",'$'
	title_28_R7_C62 db "  ",'$'
	title_29_R7_C64 db "                ",'$'
	title_30_R8_C0 db "                 ",'$'
	title_31_R8_C17 db "  ",'$'
	title_32_R8_C19 db "  PROGRAMMER: ALLEAH DELA PENA             ",'$'
	title_33_R8_C62 db "  ",'$'
	title_34_R8_C64 db "                ",'$'
	title_35_R9_C0 db "                 ",'$'
	title_36_R9_C17 db "  ",'$'
	title_37_R9_C19 db "  DATE: NOVEMBER 22, 2025                  ",'$'
	title_38_R9_C62 db "  ",'$'
	title_39_R9_C64 db "                ",'$'
	title_40_R10_C0 db "                 ",'$'
	title_41_R10_C17 db "  ",'$'
	title_42_R10_C19 db "                                           ",'$'
	title_43_R10_C62 db "  ",'$'
	title_44_R10_C64 db "                ",'$'
	title_45_R11_C0 db "                 ",'$'
	title_46_R11_C17 db "  ",'$'
	title_47_R11_C19 db "                                           ",'$'
	title_48_R11_C62 db "  ",'$'
	title_49_R11_C64 db "                ",'$'
	title_50_R12_C0 db "                 ",'$'
	title_51_R12_C17 db "  ",'$'
	title_52_R12_C19 db "  PRESS ENTER TO CONTINUE....              ",'$'
	title_53_R12_C62 db "  ",'$'
	title_54_R12_C64 db "                ",'$'
	title_55_R13_C0 db "                 ",'$'
	title_56_R13_C17 db "  ",'$'
	title_57_R13_C19 db "                                           ",'$'
	title_58_R13_C62 db "  ",'$'
	title_59_R13_C64 db "                ",'$'
	title_60_R14_C0 db "                 ",'$'
	title_61_R14_C17 db "  ",'$'
	title_62_R14_C19 db "                                           ",'$'
	title_63_R14_C62 db "  ",'$'
	title_64_R14_C64 db "                ",'$'
	title_65_R15_C0 db "                 ",'$'
	title_66_R15_C17 db "                                               ",'$'
	title_67_R15_C64 db "                ",'$'
	title_68_R16_C0 db "                                                                                ",'$'
	title_69_R17_C0 db "                                                                                ",'$'
	title_70_R18_C0 db "                                                                                ",'$'
	title_71_R19_C0 db "                                                                                ",'$'

	; Second Screen Data - Navigation Bar
	nav_0_R0_C0 db "                                                                                ",'$'
	nav_1_R1_C0 db "                                                                                ",'$'
	nav_2_R2_C0 db "                 ",'$'
	nav_3_R2_C17 db "                                               ",'$'
	nav_4_R2_C64 db "                ",'$'
	nav_5_R3_C0 db "                 ",'$'
	nav_6_R3_C17 db "  ",'$'
	nav_7_R3_C19 db "                                           ",'$'
	nav_8_R3_C62 db "  ",'$'
	nav_9_R3_C64 db "                ",'$'
	nav_10_R4_C0 db "                 ",'$'
	nav_11_R4_C17 db "  ",'$'
	nav_12_R4_C19 db "     -------------------------------       ",'$'
	nav_13_R4_C62 db "  ",'$'
	nav_14_R4_C64 db "                ",'$'
	nav_15_R5_C0 db "                 ",'$'
	nav_16_R5_C17 db "  ",'$'
	nav_17_R5_C19 db "             NAVIGATION BAR                ",'$'
	nav_18_R5_C62 db "  ",'$'
	nav_19_R5_C64 db "                ",'$'
	nav_20_R6_C0 db "                 ",'$'
	nav_21_R6_C17 db "  ",'$'
	nav_22_R6_C19 db "     -------------------------------       ",'$'
	nav_23_R6_C62 db "  ",'$'
	nav_24_R6_C64 db "                ",'$'
	nav_25_R7_C0 db "                 ",'$'
	nav_26_R7_C17 db "  ",'$'
	nav_27_R7_C19 db "                                           ",'$'
	nav_28_R7_C62 db "  ",'$'
	nav_29_R7_C64 db "                ",'$'
	nav_30_R8_C0 db "                 ",'$'
	nav_31_R8_C17 db "  ",'$'
	nav_32_R8_C19 db "  1.Register                               ",'$'
	nav_33_R8_C62 db "  ",'$'
	nav_34_R8_C64 db "                ",'$'
	nav_35_R9_C0 db "                 ",'$'
	nav_36_R9_C17 db "  ",'$'
	nav_37_R9_C19 db "  2.Log-in                                 ",'$'
	nav_38_R9_C62 db "  ",'$'
	nav_39_R9_C64 db "                ",'$'
	nav_40_R10_C0 db "                 ",'$'
	nav_41_R10_C17 db "  ",'$'
	nav_42_R10_C19 db "  3.Exit                                   ",'$'
	nav_43_R10_C62 db "  ",'$'
	nav_44_R10_C64 db "                ",'$'
	nav_45_R11_C0 db "                 ",'$'
	nav_46_R11_C17 db "  ",'$'
	nav_47_R11_C19 db "                                           ",'$'
	nav_48_R11_C62 db "  ",'$'
	nav_49_R11_C64 db "                ",'$'
	nav_50_R12_C0 db "                 ",'$'
	nav_51_R12_C17 db "  ",'$'
	nav_52_R12_C19 db "  Please input your choice:                ",'$'
	nav_53_R12_C62 db "  ",'$'
	nav_54_R12_C64 db "                ",'$'
	nav_55_R13_C0 db "                 ",'$'
	nav_56_R13_C17 db "  ",'$'
	nav_57_R13_C19 db "                                           ",'$'
	nav_58_R13_C62 db "  ",'$'
	nav_59_R13_C64 db "                ",'$'
	nav_60_R14_C0 db "                 ",'$'
	nav_61_R14_C17 db "  ",'$'
	nav_62_R14_C19 db "                                           ",'$'
	nav_63_R14_C62 db "  ",'$'
	nav_64_R14_C64 db "                ",'$'
	nav_65_R15_C0 db "                 ",'$'
	nav_66_R15_C17 db "                                               ",'$'
	nav_67_R15_C64 db "                ",'$'
	nav_68_R16_C0 db "                                                                                ",'$'
	nav_69_R17_C0 db "                                                                                ",'$'
	nav_70_R18_C0 db "                                                                                ",'$'
	nav_71_R19_C0 db "                                                                                ",'$'

	; Third Screen Data - Registration Screen
	reg_0_R0_C0 db "                                                                                ",'$'
	reg_1_R1_C0 db "                                                                                ",'$'
	reg_2_R2_C0 db "                 ",'$'
	reg_3_R2_C17 db "                                               ",'$'
	reg_4_R2_C64 db "                ",'$'
	reg_5_R3_C0 db "                 ",'$'
	reg_6_R3_C17 db "  ",'$'
	reg_7_R3_C19 db "                                           ",'$'
	reg_8_R3_C62 db "  ",'$'
	reg_9_R3_C64 db "                ",'$'
	reg_10_R4_C0 db "                 ",'$'
	reg_11_R4_C17 db "  ",'$'
	reg_12_R4_C19 db "     -------------------------------       ",'$'
	reg_13_R4_C62 db "  ",'$'
	reg_14_R4_C64 db "                ",'$'
	reg_15_R5_C0 db "                 ",'$'
	reg_16_R5_C17 db "  ",'$'
	reg_17_R5_C19 db "               REGISTRATION                ",'$'
	reg_18_R5_C62 db "  ",'$'
	reg_19_R5_C64 db "                ",'$'
	reg_20_R6_C0 db "                 ",'$'
	reg_21_R6_C17 db "  ",'$'
	reg_22_R6_C19 db "     -------------------------------       ",'$'
	reg_23_R6_C62 db "  ",'$'
	reg_24_R6_C64 db "                ",'$'
	reg_25_R7_C0 db "                 ",'$'
	reg_26_R7_C17 db "  ",'$'
	reg_27_R7_C19 db "                                           ",'$'
	reg_28_R7_C62 db "  ",'$'
	reg_29_R7_C64 db "                ",'$'
	reg_30_R8_C0 db "                 ",'$'
	reg_31_R8_C17 db "  ",'$'
	reg_32_R8_C19 db "  User-Name:                               ",'$'
	reg_33_R8_C62 db "  ",'$'
	reg_34_R8_C64 db "                ",'$'
	reg_35_R9_C0 db "                 ",'$'
	reg_36_R9_C17 db "  ",'$'
	reg_37_R9_C19 db "                                           ",'$'
	reg_38_R9_C62 db "  ",'$'
	reg_39_R9_C64 db "                ",'$'
	reg_40_R10_C0 db "                 ",'$'
	reg_41_R10_C17 db "  ",'$'
	reg_42_R10_C19 db "  Password:                                ",'$'
	reg_43_R10_C62 db "  ",'$'
	reg_44_R10_C64 db "                ",'$'
	reg_45_R11_C0 db "                 ",'$'
	reg_46_R11_C17 db "  ",'$'
	reg_47_R11_C19 db "                                           ",'$'
	reg_48_R11_C62 db "  ",'$'
	reg_49_R11_C64 db "                ",'$'
	reg_50_R12_C0 db "                 ",'$'
	reg_51_R12_C17 db "  ",'$'
	reg_52_R12_C19 db "                                           ",'$'
	reg_53_R12_C62 db "  ",'$'
	reg_54_R12_C64 db "                ",'$'
	reg_55_R13_C0 db "                 ",'$'
	reg_56_R13_C17 db "  ",'$'
	reg_57_R13_C19 db "  ",'$'
	reg_58_R13_C62 db "  ",'$'
	reg_59_R13_C64 db "                ",'$'
	reg_60_R14_C0 db "                 ",'$'
	reg_61_R14_C17 db "  ",'$'
	reg_62_R14_C19 db "                                           ",'$'
	reg_63_R14_C62 db "  ",'$'
	reg_64_R14_C64 db "                ",'$'
	reg_65_R15_C0 db "                 ",'$'
	reg_66_R15_C17 db "                                               ",'$'
	reg_67_R15_C64 db "                ",'$'
	reg_68_R16_C0 db "                                                                                ",'$'
	reg_69_R17_C0 db "                                                                                ",'$'
	reg_70_R18_C0 db "                                                                                ",'$'
	reg_71_R19_C0 db "                                                                                ",'$'

	; Fourth Screen Data - Login Screen
	login_0_R0_C0 db "                                                                                ",'$'
	login_1_R1_C0 db "                                                                                ",'$'
	login_2_R2_C0 db "                 ",'$'
	login_3_R2_C17 db "                                             ",'$'
	login_4_R2_C62 db "                  ",'$'
	login_5_R3_C0 db "                 ",'$'
	login_6_R3_C17 db "  ",'$'
	login_7_R3_C19 db "                                         ",'$'
	login_8_R3_C60 db "  ",'$'
	login_9_R3_C62 db "                  ",'$'
	login_10_R4_C0 db "                 ",'$'
	login_11_R4_C17 db "  ",'$'
	login_12_R4_C19 db "     -------------------------------     ",'$'
	login_13_R4_C60 db "  ",'$'
	login_14_R4_C62 db "                  ",'$'
	login_15_R5_C0 db "                 ",'$'
	login_16_R5_C17 db "  ",'$'
	login_17_R5_C19 db "                 LOG-IN                  ",'$'
	login_18_R5_C60 db "  ",'$'
	login_19_R5_C62 db "                  ",'$'
	login_20_R6_C0 db "                 ",'$'
	login_21_R6_C17 db "  ",'$'
	login_22_R6_C19 db "     -------------------------------     ",'$'
	login_23_R6_C60 db "  ",'$'
	login_24_R6_C62 db "                  ",'$'
	login_25_R7_C0 db "                 ",'$'
	login_26_R7_C17 db "  ",'$'
	login_27_R7_C19 db "                                         ",'$'
	login_28_R7_C60 db "  ",'$'
	login_29_R7_C62 db "                  ",'$'
	login_30_R8_C0 db "                 ",'$'
	login_31_R8_C17 db "  ",'$'
	login_32_R8_C19 db "  User-Name:                             ",'$'
	login_33_R8_C60 db "  ",'$'
	login_34_R8_C62 db "                  ",'$'
	login_35_R9_C0 db "                 ",'$'
	login_36_R9_C17 db "  ",'$'
	login_37_R9_C19 db "                                         ",'$'
	login_38_R9_C60 db "  ",'$'
	login_39_R9_C62 db "                  ",'$'
	login_40_R10_C0 db "                 ",'$'
	login_41_R10_C17 db "  ",'$'
	login_42_R10_C19 db "  Password:                              ",'$'
	login_43_R10_C60 db "  ",'$'
	login_44_R10_C62 db "                  ",'$'
	login_45_R11_C0 db "                 ",'$'
	login_46_R11_C17 db "  ",'$'
	login_47_R11_C19 db "                                         ",'$'
	login_48_R11_C60 db "  ",'$'
	login_49_R11_C62 db "                  ",'$'
	login_50_R12_C0 db "                 ",'$'
	login_51_R12_C17 db "  ",'$'
	login_52_R12_C19 db "                                           ",'$'  ; Blank by default
	login_53_R12_C60 db "  ",'$'
	login_54_R12_C62 db "                  ",'$'
	login_55_R13_C0 db "                 ",'$'
	login_56_R13_C17 db "  ",'$'
	login_57_R13_C19 db "                                         ",'$'
	login_58_R13_C60 db "  ",'$'
	login_59_R13_C62 db "                  ",'$'
	login_60_R14_C0 db "                 ",'$'
	login_61_R14_C17 db "  ",'$'
	login_62_R14_C19 db "                                         ",'$'
	login_63_R14_C60 db "  ",'$'
	login_64_R14_C62 db "                  ",'$'
	login_65_R15_C0 db "                 ",'$'
	login_66_R15_C17 db "                                             ",'$'
	login_67_R15_C62 db "                  ",'$'
	login_68_R16_C0 db "                                                                                ",'$'
	login_69_R17_C0 db "                                                                                ",'$'
	login_70_R18_C0 db "                                                                                ",'$'
	login_71_R19_C0 db "                                                                                ",'$'

	; Menu Screen Data
	menu_0_R0_C0 db "                                                                                ",'$'
	menu_1_R1_C0 db "                                                                                ",'$'
	menu_2_R2_C0 db "                 ",'$'
	menu_3_R2_C17 db "                                             ",'$'
	menu_4_R2_C62 db "                  ",'$'
	menu_5_R3_C0 db "                 ",'$'
	menu_6_R3_C17 db "  ",'$'
	menu_7_R3_C19 db "                                         ",'$'
	menu_8_R3_C60 db "  ",'$'
	menu_9_R3_C62 db "                  ",'$'
	menu_10_R4_C0 db "                 ",'$'
	menu_11_R4_C17 db "  ",'$'
	menu_12_R4_C19 db "     -------------------------------     ",'$'
	menu_13_R4_C60 db "  ",'$'
	menu_14_R4_C62 db "                  ",'$'
	menu_15_R5_C0 db "                 ",'$'
	menu_16_R5_C17 db "  ",'$'
	menu_17_R5_C19 db "                  MENU                   ",'$'
	menu_18_R5_C60 db "  ",'$'
	menu_19_R5_C62 db "                  ",'$'
	menu_20_R6_C0 db "                 ",'$'
	menu_21_R6_C17 db "  ",'$'
	menu_22_R6_C19 db "     -------------------------------     ",'$'
	menu_23_R6_C60 db "  ",'$'
	menu_24_R6_C62 db "                  ",'$'
	menu_25_R7_C0 db "                 ",'$'
	menu_26_R7_C17 db "  ",'$'
	menu_27_R7_C19 db "  1.Add Book                             ",'$'
	menu_28_R7_C60 db "  ",'$'
	menu_29_R7_C62 db "                  ",'$'
	menu_30_R8_C0 db "                 ",'$'
	menu_31_R8_C17 db "  ",'$'
	menu_32_R8_C19 db "  2.View Books                           ",'$'
	menu_33_R8_C60 db "  ",'$'
	menu_34_R8_C62 db "                  ",'$'
	menu_35_R9_C0 db "                 ",'$'
	menu_36_R9_C17 db "  ",'$'
	menu_37_R9_C19 db "  3.Update Book                          ",'$'
	menu_38_R9_C60 db "  ",'$'
	menu_39_R9_C62 db "                  ",'$'
	menu_40_R10_C0 db "                 ",'$'
	menu_41_R10_C17 db "  ",'$'
	menu_42_R10_C19 db "  4.Delete Book                          ",'$'
	menu_43_R10_C60 db "  ",'$'
	menu_44_R10_C62 db "                  ",'$'
	menu_45_R11_C0 db "                 ",'$'
	menu_46_R11_C17 db "  ",'$'
	menu_47_R11_C19 db "  5.Log-Out                              ",'$'
	menu_48_R11_C60 db "  ",'$'
	menu_49_R11_C62 db "                  ",'$'
	menu_50_R12_C0 db "                 ",'$'
	menu_51_R12_C17 db "  ",'$'
	menu_52_R12_C19 db "  ",'$'
	menu_53_R12_C21 db "             ",'$'
	menu_54_R12_C34 db "                          ",'$'
	menu_55_R12_C60 db "  ",'$'
	menu_56_R12_C62 db "                  ",'$'
	menu_57_R13_C0 db "                 ",'$'
	menu_58_R13_C17 db "  ",'$'
	menu_59_R13_C19 db "  Enter choice:                          ",'$'
	menu_60_R13_C60 db "  ",'$'
	menu_61_R13_C62 db "                  ",'$'
	menu_62_R14_C0 db "                 ",'$'
	menu_63_R14_C17 db "  ",'$'
	menu_64_R14_C19 db "                                         ",'$'
	menu_65_R14_C60 db "  ",'$'
	menu_66_R14_C62 db "                  ",'$'
	menu_67_R15_C0 db "                 ",'$'
	menu_68_R15_C17 db "  ",'$'
	menu_69_R15_C19 db "  ",'$'
	menu_70_R15_C21 db "                                ",'$'
	menu_71_R15_C48 db "            ",'$'
	menu_72_R15_C60 db "  ",'$'
	menu_73_R15_C62 db "                  ",'$'
	menu_74_R16_C0 db "                 ",'$'
	menu_75_R16_C17 db "  ",'$'
	menu_76_R16_C19 db "                                         ",'$'
	menu_77_R16_C60 db "  ",'$'
	menu_78_R16_C62 db "                  ",'$'
	menu_79_R17_C0 db "                 ",'$'
	menu_80_R17_C17 db "                                             ",'$'
	menu_81_R17_C62 db "                  ",'$'
	menu_82_R18_C0 db "                                                                                ",'$'
	menu_83_R19_C0 db "                                                                                ",'$'
	menu_84_R20_C0 db "                                                                                ",'$'

	; Add Book Screen Data
	add_book_0_R0_C0 db "                                                                                ",'$'
	add_book_1_R1_C0 db "                                                                                ",'$'
	add_book_2_R2_C0 db "                 ",'$'
	add_book_3_R2_C17 db "                                             ",'$'
	add_book_4_R2_C62 db "                  ",'$'
	add_book_5_R3_C0 db "                 ",'$'
	add_book_6_R3_C17 db "  ",'$'
	add_book_7_R3_C19 db "                                         ",'$'
	add_book_8_R3_C60 db "  ",'$'
	add_book_9_R3_C62 db "                  ",'$'
	add_book_10_R4_C0 db "                 ",'$'
	add_book_11_R4_C17 db "  ",'$'
	add_book_12_R4_C19 db "     -------------------------------     ",'$'
	add_book_13_R4_C60 db "  ",'$'
	add_book_14_R4_C62 db "                  ",'$'
	add_book_15_R5_C0 db "                 ",'$'
	add_book_16_R5_C17 db "  ",'$'
	add_book_17_R5_C19 db "               ADD-BOOK                  ",'$'
	add_book_18_R5_C60 db "  ",'$'
	add_book_19_R5_C62 db "                  ",'$'
	add_book_20_R6_C0 db "                 ",'$'
	add_book_21_R6_C17 db "  ",'$'
	add_book_22_R6_C19 db "     -------------------------------     ",'$'
	add_book_23_R6_C60 db "  ",'$'
	add_book_24_R6_C62 db "                  ",'$'
	add_book_25_R7_C0 db "                 ",'$'
	add_book_26_R7_C17 db "  ",'$'
	add_book_27_R7_C19 db "                                         ",'$'
	add_book_28_R7_C60 db "  ",'$'
	add_book_29_R7_C62 db "                  ",'$'
	add_book_30_R8_C0 db "                 ",'$'
	add_book_31_R8_C17 db "  ",'$'
	add_book_32_R8_C19 db "  Title:",'$'
	add_book_33_R8_C60 db "  ",'$'
	add_book_34_R8_C62 db "                  ",'$'
	add_book_35_R9_C0 db "                 ",'$'
	add_book_36_R9_C17 db "  ",'$'
	add_book_37_R9_C19 db "                                         ",'$'
	add_book_38_R9_C60 db "  ",'$'
	add_book_39_R9_C62 db "                  ",'$'
	add_book_40_R10_C0 db "                 ",'$'
	add_book_41_R10_C17 db "  ",'$'
	add_book_42_R10_C19 db "  Author:                                ",'$'
	add_book_43_R10_C60 db "  ",'$'
	add_book_44_R10_C62 db "                  ",'$'
	add_book_45_R11_C0 db "                 ",'$'
	add_book_46_R11_C17 db "  ",'$'
	add_book_47_R11_C19 db "                                         ",'$'
	add_book_48_R11_C60 db "  ",'$'
	add_book_49_R11_C62 db "                  ",'$'
	add_book_50_R12_C0 db "                 ",'$'
	add_book_51_R12_C17 db "  ",'$'
	add_book_52_R12_C19 db "  ISBN:",'$'
	add_book_53_R12_C26 db "        ",'$'
	add_book_54_R12_C34 db "                          ",'$'
	add_book_55_R12_C60 db "  ",'$'
	add_book_56_R12_C62 db "                  ",'$'
	add_book_57_R13_C0 db "                 ",'$'
	add_book_58_R13_C17 db "  ",'$'
	add_book_59_R13_C19 db "                                         ",'$'
	add_book_60_R13_C60 db "  ",'$'
	add_book_61_R13_C62 db "                  ",'$'
	add_book_62_R14_C0 db "                 ",'$'
	add_book_63_R14_C17 db "  ",'$'
	add_book_64_R14_C19 db "                                         ",'$'
	add_book_65_R14_C60 db "  ",'$'
	add_book_66_R14_C62 db "                  ",'$'
	add_book_67_R15_C0 db "                 ",'$'
	add_book_68_R15_C17 db "  ",'$'
	add_book_69_R15_C19 db "  ",'$'
	add_book_70_R15_C21 db "                           ",'$'
	add_book_71_R15_C48 db "            ",'$'
	add_book_72_R15_C60 db "  ",'$'
	add_book_73_R15_C62 db "                  ",'$'
	add_book_74_R16_C0 db "                 ",'$'
	add_book_75_R16_C17 db "  ",'$'
	add_book_76_R16_C19 db "                                         ",'$'
	add_book_77_R16_C60 db "  ",'$'
	add_book_78_R16_C62 db "                  ",'$'
	add_book_79_R17_C0 db "                 ",'$'
	add_book_80_R17_C17 db "                                             ",'$'
	add_book_81_R17_C62 db "                  ",'$'
	add_book_82_R18_C0 db "                                                                                ",'$'
	add_book_83_R19_C0 db "                                                                                ",'$'
	add_book_84_R20_C0 db "                                                                                ",'$'

	; View Books Screen Data
		txt_0_R0_C0 db "                                                                                ",'$'
	txt_1_R1_C0 db "                                                                                ",'$'
	txt_2_R2_C0 db "    ",'$'
	txt_3_R2_C4 db "                                                                        ",'$'
	txt_4_R2_C76 db "    ",'$'
	txt_5_R3_C0 db "    ",'$'
	txt_6_R3_C4 db "  ",'$'
	txt_7_R3_C6 db "   ",'$'
	txt_8_R3_C9 db "          ",'$'
	txt_9_R3_C19 db "                                         ",'$'
	txt_10_R3_C60 db "  ",'$'
	txt_11_R3_C62 db "            ",'$'
	txt_12_R3_C74 db "  ",'$'
	txt_13_R3_C76 db "    ",'$'
	txt_14_R4_C0 db "    ",'$'
	txt_15_R4_C4 db "  ",'$'
	txt_16_R4_C6 db "           ",'$'
	txt_17_R4_C17 db "  ",'$'
	txt_18_R4_C19 db "     -------------------------------     ",'$'
	txt_19_R4_C60 db "  ",'$'
	txt_20_R4_C62 db "            ",'$'
	txt_21_R4_C74 db "  ",'$'
	txt_22_R4_C76 db "    ",'$'
	txt_23_R5_C0 db "    ",'$'
	txt_24_R5_C4 db "  ",'$'
	txt_25_R5_C6 db "           ",'$'
	txt_26_R5_C17 db "  ",'$'
	txt_27_R5_C19 db "              VIEW-BOOK                  ",'$'
	txt_28_R5_C60 db "  ",'$'
	txt_29_R5_C62 db "            ",'$'
	txt_30_R5_C74 db "  ",'$'
	txt_31_R5_C76 db "    ",'$'
	txt_32_R6_C0 db "    ",'$'
	txt_33_R6_C4 db "  ",'$'
	txt_34_R6_C6 db "           ",'$'
	txt_35_R6_C17 db "  ",'$'
	txt_36_R6_C19 db "     -------------------------------     ",'$'
	txt_37_R6_C60 db "  ",'$'
	txt_38_R6_C62 db "            ",'$'
	txt_39_R6_C74 db "  ",'$'
	txt_40_R6_C76 db "    ",'$'
	txt_41_R7_C0 db "    ",'$'
	txt_42_R7_C4 db "  ",'$'
	txt_43_R7_C6 db "    ",'$'
	txt_44_R7_C10 db "ID:",'$'
	txt_45_R7_C13 db "    ",'$'
	txt_46_R7_C17 db "  ",'$'
	txt_47_R7_C19 db " ",'$'
	txt_48_R7_C20 db "TITLE:",'$'
	txt_49_R7_C26 db "             ",'$'
	txt_50_R7_C39 db "AUTHOR:",'$'
	txt_51_R7_C46 db " ",'$'
	txt_52_R7_C54 db "      ",'$'
	txt_53_R7_C60 db "ISBN:",'$'
	txt_54_R7_C65 db "         ",'$'
	txt_55_R7_C74 db "  ",'$'
	txt_56_R7_C76 db "    ",'$'
	txt_57_R8_C0 db "    ",'$'
	txt_58_R8_C4 db "  ",'$'
	txt_59_R8_C6 db "           ",'$'
	txt_60_R8_C17 db "  ",'$'
	txt_61_R8_C19 db "  ",'$'
	txt_62_R8_C60 db "  ",'$'
	txt_63_R8_C62 db "            ",'$'
	txt_64_R8_C74 db "  ",'$'
	txt_65_R8_C76 db "    ",'$'
	txt_66_R9_C0 db "    ",'$'
	txt_67_R9_C4 db "  ",'$'
	txt_68_R9_C6 db "           ",'$'
	txt_69_R9_C17 db "  ",'$'
	txt_70_R9_C19 db "                                         ",'$'
	txt_71_R9_C60 db "  ",'$'
	txt_72_R9_C62 db "            ",'$'
	txt_73_R9_C74 db "  ",'$'
	txt_74_R9_C76 db "    ",'$'
	txt_75_R10_C0 db "    ",'$'
	txt_76_R10_C4 db "  ",'$'
	txt_77_R10_C6 db "           ",'$'
	txt_78_R10_C17 db "  ",'$'
	txt_79_R10_C19 db "                                         ",'$'
	txt_80_R10_C60 db "  ",'$'
	txt_81_R10_C62 db "            ",'$'
	txt_82_R10_C74 db "  ",'$'
	txt_83_R10_C76 db "    ",'$'
	txt_84_R11_C0 db "    ",'$'
	txt_85_R11_C4 db "  ",'$'
	txt_86_R11_C6 db "           ",'$'
	txt_87_R11_C17 db "  ",'$'
	txt_88_R11_C19 db "                                         ",'$'
	txt_89_R11_C60 db "  ",'$'
	txt_90_R11_C62 db "            ",'$'
	txt_91_R11_C74 db "  ",'$'
	txt_92_R11_C76 db "    ",'$'
	txt_93_R12_C0 db "    ",'$'
	txt_94_R12_C4 db "  ",'$'
	txt_95_R12_C6 db "           ",'$'
	txt_96_R12_C17 db "  ",'$'
	txt_97_R12_C19 db "           ",'$'
	txt_98_R12_C30 db "    ",'$'
	txt_99_R12_C34 db "                          ",'$'
	txt_100_R12_C60 db "  ",'$'
	txt_101_R12_C62 db "            ",'$'
	txt_102_R12_C74 db "  ",'$'
	txt_103_R12_C76 db "    ",'$'
	txt_104_R13_C0 db "    ",'$'
	txt_105_R13_C4 db "  ",'$'
	txt_106_R13_C6 db "           ",'$'
	txt_107_R13_C17 db "  ",'$'
	txt_108_R13_C19 db "                                         ",'$'
	txt_109_R13_C60 db "  ",'$'
	txt_110_R13_C62 db "            ",'$'
	txt_111_R13_C74 db "  ",'$'
	txt_112_R13_C76 db "    ",'$'
	txt_113_R14_C0 db "    ",'$'
	txt_114_R14_C4 db "  ",'$'
	txt_115_R14_C6 db "           ",'$'
	txt_116_R14_C17 db "  ",'$'
	txt_117_R14_C19 db "                                  .      ",'$'
	txt_118_R14_C60 db "   ",'$'
	txt_119_R14_C63 db "           ",'$'
	txt_120_R14_C74 db "  ",'$'
	txt_121_R14_C76 db "    ",'$'
	txt_122_R15_C0 db "    ",'$'
	txt_123_R15_C4 db "  ",'$'
	txt_124_R15_C6 db "   Press Enter...                         ",'$'
	txt_125_R15_C48 db "            ",'$'
	txt_126_R15_C60 db "  ",'$'
	txt_127_R15_C62 db "           ",'$'
	txt_128_R15_C73 db " ",'$'
	txt_129_R15_C74 db "  ",'$'
	txt_130_R15_C76 db "  ",'$'
	txt_131_R15_C78 db " ",'$'
	txt_132_R15_C79 db " ",'$'
	txt_133_R16_C0 db "    ",'$'
	txt_134_R16_C4 db "  ",'$'
	txt_135_R16_C6 db "           ",'$'
	txt_136_R16_C17 db "                                                ",'$'
	txt_137_R16_C65 db "         ",'$'
	txt_138_R16_C74 db "  ",'$'
	txt_139_R16_C76 db "    ",'$'
	txt_140_R17_C0 db "    ",'$'
	txt_141_R17_C4 db "             ",'$'
	txt_142_R17_C17 db "                                             ",'$'
	txt_143_R17_C62 db "              ",'$'
	txt_144_R17_C76 db "    ",'$'
	txt_145_R18_C0 db "                                                                                ",'$'
	txt_146_R19_C0 db "                                                                                ",'$'
	txt_147_R20_C0 db "                                                                                ",'$'
	
	; Update Book Screen Data
	update_book_0_R0_C0 db "                                                                                ",'$'
	update_book_1_R1_C0 db "                                                                                ",'$'
	update_book_2_R2_C0 db "                 ",'$'
	update_book_3_R2_C17 db "                                             ",'$'
	update_book_4_R2_C62 db "                  ",'$'
	update_book_5_R3_C0 db "                 ",'$'
	update_book_6_R3_C17 db "  ",'$'
	update_book_7_R3_C19 db "                                         ",'$'
	update_book_8_R3_C60 db "  ",'$'
	update_book_9_R3_C62 db "                  ",'$'
	update_book_10_R4_C0 db "                 ",'$'
	update_book_11_R4_C17 db "  ",'$'
	update_book_12_R4_C19 db "     -------------------------------     ",'$'
	update_book_13_R4_C60 db "  ",'$'
	update_book_14_R4_C62 db "                  ",'$'
	update_book_15_R5_C0 db "                 ",'$'
	update_book_16_R5_C17 db "  ",'$'
	update_book_17_R5_C19 db "              UPDATE BOOK                ",'$'
	update_book_18_R5_C60 db "  ",'$'
	update_book_19_R5_C62 db "                  ",'$'
	update_book_20_R6_C0 db "                 ",'$'
	update_book_21_R6_C17 db "  ",'$'
	update_book_22_R6_C19 db "     -------------------------------     ",'$'
	update_book_23_R6_C60 db "  ",'$'
	update_book_24_R6_C62 db "                  ",'$'
	update_book_25_R7_C0 db "                 ",'$'
	update_book_26_R7_C17 db "  ",'$'
	update_book_27_R7_C19 db "                                         ",'$'
	update_book_28_R7_C60 db "  ",'$'
	update_book_29_R7_C62 db "                  ",'$'
	update_book_30_R8_C0 db "                 ",'$'
	update_book_31_R8_C17 db "  ",'$'
	update_book_32_R8_C19 db "  Book ID to update:                     ",'$'
	update_book_33_R8_C60 db "  ",'$'
	update_book_34_R8_C62 db "                  ",'$'
	update_book_35_R9_C0 db "                 ",'$'
	update_book_36_R9_C17 db "  ",'$'
	update_book_37_R9_C19 db "                                         ",'$'
	update_book_38_R9_C60 db "  ",'$'
	update_book_39_R9_C62 db "                  ",'$'
	update_book_40_R10_C0 db "                 ",'$'
	update_book_41_R10_C17 db "  ",'$'
	update_book_42_R10_C19 db "  New Title:                            ",'$'
	update_book_43_R10_C60 db "  ",'$'
	update_book_44_R10_C62 db "                  ",'$'
	update_book_45_R11_C0 db "                 ",'$'
	update_book_46_R11_C17 db "  ",'$'
	update_book_47_R11_C19 db "                                         ",'$'
	update_book_48_R11_C60 db "  ",'$'
	update_book_49_R11_C62 db "                  ",'$'
	update_book_50_R12_C0 db "                 ",'$'
	update_book_51_R12_C17 db "  ",'$'
	update_book_52_R12_C19 db "  New Author:                           ",'$'
	update_book_53_R12_C60 db "  ",'$'
	update_book_54_R12_C62 db "                  ",'$'
	update_book_55_R13_C0 db "                 ",'$'
	update_book_56_R13_C17 db "  ",'$'
	update_book_57_R13_C19 db "                                         ",'$'
	update_book_58_R13_C60 db "  ",'$'
	update_book_59_R13_C62 db "                  ",'$'
	update_book_60_R14_C0 db "                 ",'$'
	update_book_61_R14_C17 db "  ",'$'
	update_book_62_R14_C19 db "  New ISBN:                              ",'$'
	update_book_63_R14_C60 db "  ",'$'
	update_book_64_R14_C62 db "                  ",'$'
	update_book_65_R15_C0 db "                 ",'$'
	update_book_66_R15_C17 db "  ",'$'
	update_book_67_R15_C19 db "                                         ",'$'
	update_book_68_R15_C60 db "  ",'$'
	update_book_69_R15_C62 db "                  ",'$'
	update_book_70_R16_C0 db "                 ",'$'
	update_book_71_R16_C17 db "  ",'$'
	update_book_72_R16_C19 db "                                         ",'$'
	update_book_73_R16_C60 db "  ",'$'
	update_book_74_R16_C62 db "                  ",'$'
	update_book_75_R17_C0 db "                 ",'$'
	update_book_76_R17_C17 db "                                             ",'$'
	update_book_77_R17_C62 db "                  ",'$'
	update_book_78_R18_C0 db "                                                                                ",'$'
	update_book_79_R19_C0 db "                                                                                ",'$'
	update_book_80_R20_C0 db "                                                                                ",'$'

	; Delete Book Screen Data
	delete_book_0_R0_C0 db "                                                                                ",'$'
	delete_book_1_R1_C0 db "                                                                                ",'$'
	delete_book_2_R2_C0 db "                 ",'$'
	delete_book_3_R2_C17 db "                                             ",'$'
	delete_book_4_R2_C62 db "                  ",'$'
	delete_book_5_R3_C0 db "                 ",'$'
	delete_book_6_R3_C17 db "  ",'$'
	delete_book_7_R3_C19 db "                                         ",'$'
	delete_book_8_R3_C60 db "  ",'$'
	delete_book_9_R3_C62 db "                  ",'$'
	delete_book_10_R4_C0 db "                 ",'$'
	delete_book_11_R4_C17 db "  ",'$'
	delete_book_12_R4_C19 db "     -------------------------------     ",'$'
	delete_book_13_R4_C60 db "  ",'$'
	delete_book_14_R4_C62 db "                  ",'$'
	delete_book_15_R5_C0 db "                 ",'$'
	delete_book_16_R5_C17 db "  ",'$'
	delete_book_17_R5_C19 db "              DELETE BOOK                ",'$'
	delete_book_18_R5_C60 db "  ",'$'
	delete_book_19_R5_C62 db "                  ",'$'
	delete_book_20_R6_C0 db "                 ",'$'
	delete_book_21_R6_C17 db "  ",'$'
	delete_book_22_R6_C19 db "     -------------------------------     ",'$'
	delete_book_23_R6_C60 db "  ",'$'
	delete_book_24_R6_C62 db "                  ",'$'
	delete_book_25_R7_C0 db "                 ",'$'
	delete_book_26_R7_C17 db "  ",'$'
	delete_book_27_R7_C19 db "                                         ",'$'
	delete_book_28_R7_C60 db "  ",'$'
	delete_book_29_R7_C62 db "                  ",'$'
	delete_book_30_R8_C0 db "                 ",'$'
	delete_book_31_R8_C17 db "  ",'$'
	delete_book_32_R8_C19 db "  Book ID to delete:                     ",'$'
	delete_book_33_R8_C60 db "  ",'$'
	delete_book_34_R8_C62 db "                  ",'$'
	delete_book_35_R9_C0 db "                 ",'$'
	delete_book_36_R9_C17 db "  ",'$'
	delete_book_37_R9_C19 db "                                         ",'$'
	delete_book_38_R9_C60 db "  ",'$'
	delete_book_39_R9_C62 db "                  ",'$'
	delete_book_40_R10_C0 db "                 ",'$'
	delete_book_41_R10_C17 db "  ",'$'
	delete_book_42_R10_C19 db "                                         ",'$'
	delete_book_43_R10_C60 db "  ",'$'
	delete_book_44_R10_C62 db "                  ",'$'
	delete_book_45_R11_C0 db "                 ",'$'
	delete_book_46_R11_C17 db "  ",'$'
	delete_book_47_R11_C19 db "                                         ",'$'
	delete_book_48_R11_C60 db "  ",'$'
	delete_book_49_R11_C62 db "                  ",'$'
	delete_book_50_R12_C0 db "                 ",'$'
	delete_book_51_R12_C17 db "  ",'$'
	delete_book_52_R12_C19 db "                                         ",'$'
	delete_book_53_R12_C60 db "  ",'$'
	delete_book_54_R12_C62 db "                  ",'$'
	delete_book_55_R13_C0 db "                 ",'$'
	delete_book_56_R13_C17 db "  ",'$'
	delete_book_57_R13_C19 db "                                         ",'$'
	delete_book_58_R13_C60 db "  ",'$'
	delete_book_59_R13_C62 db "                  ",'$'
	delete_book_60_R14_C0 db "                 ",'$'
	delete_book_61_R14_C17 db "  ",'$'
	delete_book_62_R14_C19 db "                                         ",'$'
	delete_book_63_R14_C60 db "  ",'$'
	delete_book_64_R14_C62 db "                  ",'$'
	delete_book_65_R15_C0 db "                 ",'$'
	delete_book_66_R15_C17 db "  ",'$'
	delete_book_67_R15_C19 db "                                         ",'$'
	delete_book_68_R15_C60 db "  ",'$'
	delete_book_69_R15_C62 db "                  ",'$'
	delete_book_70_R16_C0 db "                 ",'$'
	delete_book_71_R16_C17 db "  ",'$'
	delete_book_72_R16_C19 db "                                         ",'$'
	delete_book_73_R16_C60 db "  ",'$'
	delete_book_74_R16_C62 db "                  ",'$'
	delete_book_75_R17_C0 db "                 ",'$'
	delete_book_76_R17_C17 db "                                             ",'$'
	delete_book_77_R17_C62 db "                  ",'$'
	delete_book_78_R18_C0 db "                                                                                ",'$'
	delete_book_79_R19_C0 db "                                                                                ",'$'
	delete_book_80_R20_C0 db "                                                                                ",'$'

	; Input and Messages
	invalid_msg db "INVALID INPUT! Please enter 1, 2, or 3.",'$'
	success_msg db "  Successfully registered! Press Enter...",'$'
	invalid_account_msg db "  Invalid Account! Press Enter....        ",'$'
	no_account_msg db "  No account registered! Press Enter..       ",'$'
	valid_account_msg db "  Valid Account!Press Enter....          ",'$'
	invalid_menu_msg db "  Invalid choice! Please enter 1-5.        ",'$'
	valid_menu_msg db "Valid Number!Press Enter...              ",'$'
	
	; Input buffers
	username_buffer db 20 dup(0)    ; Array to store username
	password_buffer db 20 dup(0)    ; Array to store password
	username_length db 0
	password_length db 0
	
	; Login input buffers
	login_username_buffer db 20 dup(0)
	login_password_buffer db 20 dup(0)
	login_username_length db 0
	login_password_length db 0

	; ============ BOOK MANAGEMENT SYSTEM DATA ============
	MAX_BOOKS       EQU 10
	BOOK_COUNT      DB 0
	CURRENT_USER    DB 20 dup(0) ; Currently logged in user

	; Book structure: [Title 33B][Author 32B][ISBN 8B][Owner 20B] = 93 bytes
	BOOKS           DB 930 dup(0)  ; 10 books * 93 bytes

	; Temporary book input buffers
	TEMP_TITLE      DB 33 dup(0)
	TEMP_AUTHOR     DB 32 dup(0)  
	TEMP_ISBN       DB 8 dup(0)
	TEMP_ID         DB 0

	; Messages
	success_add_msg db "  Book added successfully! Press Enter.  ",'$'
	success_upd_msg db "  Book updated successfully! Press Enter.  ",'$'
	success_del_msg db "  Book deleted successfully! Press Enter.  ",'$'
	library_full_msg db "  Library full! Max 10 books reached.",'$'
	book_not_found_msg db "  Book not found! Press Enter...         ",'$'
	no_books_msg db "  No books found in your library!          ",'$'
	confirm_del_msg db "  Are you sure? (Y/N): ",'$'
	db_full_msg db "  User database full! Max 10 users.",'$'
	user_exists_msg db "  Username already exists! Press Enter...",'$'

.code
.stack 100h

; ============================================================
; SCREEN DISPLAY PROCEDURES
; ============================================================

; Procedure to display title screen
display_title_screen PROC
	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset title_0_R0_C0
	int 21h
	
	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset title_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_2_R2_C0
	int 21h

	setcursor 2, 17
	colorz 64, 47
	mov ah, 09h
	mov dx, offset title_3_R2_C17
	int 21h

	setcursor 2, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_4_R2_C64
	int 21h

	setcursor 3, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_5_R3_C0
	int 21h

	setcursor 3, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_6_R3_C17
	int 21h

	setcursor 3, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_7_R3_C19
	int 21h

	setcursor 3, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_8_R3_C62
	int 21h

	setcursor 3, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_9_R3_C64
	int 21h

	setcursor 4, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_10_R4_C0
	int 21h

	setcursor 4, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_11_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_12_R4_C19
	int 21h

	setcursor 4, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_13_R4_C62
	int 21h

	setcursor 4, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_14_R4_C64
	int 21h

	setcursor 5, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_15_R5_C0
	int 21h

	setcursor 5, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_16_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_17_R5_C19
	int 21h

	setcursor 5, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_18_R5_C62
	int 21h

	setcursor 5, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_19_R5_C64
	int 21h

	setcursor 6, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_20_R6_C0
	int 21h

	setcursor 6, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_21_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_22_R6_C19
	int 21h

	setcursor 6, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_23_R6_C62
	int 21h

	setcursor 6, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_24_R6_C64
	int 21h

	setcursor 7, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_25_R7_C0
	int 21h

	setcursor 7, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_26_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_27_R7_C19
	int 21h

	setcursor 7, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_28_R7_C62
	int 21h

	setcursor 7, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_29_R7_C64
	int 21h

	setcursor 8, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_30_R8_C0
	int 21h

	setcursor 8, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_31_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_32_R8_C19
	int 21h

	setcursor 8, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_33_R8_C62
	int 21h

	setcursor 8, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_34_R8_C64
	int 21h

	setcursor 9, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_35_R9_C0
	int 21h

	setcursor 9, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_36_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_37_R9_C19
	int 21h

	setcursor 9, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_38_R9_C62
	int 21h

	setcursor 9, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_39_R9_C64
	int 21h

	setcursor 10, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_40_R10_C0
	int 21h

	setcursor 10, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_41_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_42_R10_C19
	int 21h

	setcursor 10, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_43_R10_C62
	int 21h

	setcursor 10, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_44_R10_C64
	int 21h

	setcursor 11, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_45_R11_C0
	int 21h

	setcursor 11, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_46_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_47_R11_C19
	int 21h

	setcursor 11, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_48_R11_C62
	int 21h

	setcursor 11, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_49_R11_C64
	int 21h

	setcursor 12, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_50_R12_C0
	int 21h

	setcursor 12, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_51_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_52_R12_C19
	int 21h

	setcursor 12, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_53_R12_C62
	int 21h

	setcursor 12, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_54_R12_C64
	int 21h

	setcursor 13, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_55_R13_C0
	int 21h

	setcursor 13, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_56_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_57_R13_C19
	int 21h

	setcursor 13, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_58_R13_C62
	int 21h

	setcursor 13, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_59_R13_C64
	int 21h

	setcursor 14, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_60_R14_C0
	int 21h

	setcursor 14, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_61_R14_C17
	int 21h

	setcursor 14, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset title_62_R14_C19
	int 21h

	setcursor 14, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset title_63_R14_C62
	int 21h

	setcursor 14, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_64_R14_C64
	int 21h

	setcursor 15, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset title_65_R15_C0
	int 21h

	setcursor 15, 17
	colorz 64, 47
	mov ah, 09h
	mov dx, offset title_66_R15_C17
	int 21h

	setcursor 15, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset title_67_R15_C64
	int 21h

	setcursor 16, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset title_68_R16_C0
	int 21h

	setcursor 17, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset title_69_R17_C0
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset title_70_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset title_71_R19_C0
	int 21h
	ret
display_title_screen ENDP

; Procedure to display navigation screen
display_nav_screen PROC
	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset nav_0_R0_C0
	int 21h

	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset nav_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_2_R2_C0
	int 21h

	setcursor 2, 17
	colorz 64, 47
	mov ah, 09h
	mov dx, offset nav_3_R2_C17
	int 21h

	setcursor 2, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_4_R2_C64
	int 21h

	setcursor 3, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_5_R3_C0
	int 21h

	setcursor 3, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_6_R3_C17
	int 21h

	setcursor 3, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_7_R3_C19
	int 21h

	setcursor 3, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_8_R3_C62
	int 21h

	setcursor 3, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_9_R3_C64
	int 21h

	setcursor 4, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_10_R4_C0
	int 21h

	setcursor 4, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_11_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_12_R4_C19
	int 21h

	setcursor 4, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_13_R4_C62
	int 21h

	setcursor 4, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_14_R4_C64
	int 21h

	setcursor 5, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_15_R5_C0
	int 21h

	setcursor 5, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_16_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_17_R5_C19
	int 21h

	setcursor 5, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_18_R5_C62
	int 21h

	setcursor 5, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_19_R5_C64
	int 21h

	setcursor 6, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_20_R6_C0
	int 21h

	setcursor 6, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_21_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_22_R6_C19
	int 21h

	setcursor 6, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_23_R6_C62
	int 21h

	setcursor 6, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_24_R6_C64
	int 21h

	setcursor 7, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_25_R7_C0
	int 21h

	setcursor 7, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_26_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_27_R7_C19
	int 21h

	setcursor 7, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_28_R7_C62
	int 21h

	setcursor 7, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_29_R7_C64
	int 21h

	setcursor 8, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_30_R8_C0
	int 21h

	setcursor 8, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_31_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_32_R8_C19
	int 21h

	setcursor 8, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_33_R8_C62
	int 21h

	setcursor 8, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_34_R8_C64
	int 21h

	setcursor 9, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_35_R9_C0
	int 21h

	setcursor 9, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_36_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_37_R9_C19
	int 21h

	setcursor 9, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_38_R9_C62
	int 21h

	setcursor 9, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_39_R9_C64
	int 21h

	setcursor 10, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_40_R10_C0
	int 21h

	setcursor 10, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_41_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_42_R10_C19
	int 21h

	setcursor 10, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_43_R10_C62
	int 21h

	setcursor 10, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_44_R10_C64
	int 21h

	setcursor 11, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_45_R11_C0
	int 21h

	setcursor 11, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_46_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_47_R11_C19
	int 21h

	setcursor 11, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_48_R11_C62
	int 21h

	setcursor 11, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_49_R11_C64
	int 21h

	setcursor 12, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_50_R12_C0
	int 21h

	setcursor 12, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_51_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_52_R12_C19
	int 21h

	setcursor 12, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_53_R12_C62
	int 21h

	setcursor 12, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_54_R12_C64
	int 21h

	setcursor 13, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_55_R13_C0
	int 21h

	setcursor 13, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_56_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_57_R13_C19
	int 21h

	setcursor 13, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_58_R13_C62
	int 21h

	setcursor 13, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_59_R13_C64
	int 21h

	setcursor 14, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_60_R14_C0
	int 21h

	setcursor 14, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_61_R14_C17
	int 21h

	setcursor 14, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset nav_62_R14_C19
	int 21h

	setcursor 14, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset nav_63_R14_C62
	int 21h

	setcursor 14, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_64_R14_C64
	int 21h

	setcursor 15, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset nav_65_R15_C0
	int 21h

	setcursor 15, 17
	colorz 64, 47
	mov ah, 09h
	mov dx, offset nav_66_R15_C17
	int 21h

	setcursor 15, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset nav_67_R15_C64
	int 21h

	setcursor 16, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset nav_68_R16_C0
	int 21h

	setcursor 17, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset nav_69_R17_C0
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset nav_70_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset nav_71_R19_C0
	int 21h
	ret
display_nav_screen ENDP

; Procedure to display registration screen
display_reg_screen PROC
	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset reg_0_R0_C0
	int 21h

	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset reg_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_2_R2_C0
	int 21h

	setcursor 2, 17
	colorz 64, 47
	mov ah, 09h
	mov dx, offset reg_3_R2_C17
	int 21h

	setcursor 2, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_4_R2_C64
	int 21h

	setcursor 3, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_5_R3_C0
	int 21h

	setcursor 3, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_6_R3_C17
	int 21h

	setcursor 3, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_7_R3_C19
	int 21h

	setcursor 3, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_8_R3_C62
	int 21h

	setcursor 3, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_9_R3_C64
	int 21h

	setcursor 4, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_10_R4_C0
	int 21h

	setcursor 4, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_11_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_12_R4_C19
	int 21h

	setcursor 4, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_13_R4_C62
	int 21h

	setcursor 4, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_14_R4_C64
	int 21h

	setcursor 5, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_15_R5_C0
	int 21h

	setcursor 5, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_16_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_17_R5_C19
	int 21h

	setcursor 5, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_18_R5_C62
	int 21h

	setcursor 5, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_19_R5_C64
	int 21h

	setcursor 6, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_20_R6_C0
	int 21h

	setcursor 6, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_21_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_22_R6_C19
	int 21h

	setcursor 6, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_23_R6_C62
	int 21h

	setcursor 6, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_24_R6_C64
	int 21h

	setcursor 7, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_25_R7_C0
	int 21h

	setcursor 7, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_26_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_27_R7_C19
	int 21h

	setcursor 7, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_28_R7_C62
	int 21h

	setcursor 7, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_29_R7_C64
	int 21h

	setcursor 8, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_30_R8_C0
	int 21h

	setcursor 8, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_31_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_32_R8_C19
	int 21h

	setcursor 8, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_33_R8_C62
	int 21h

	setcursor 8, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_34_R8_C64
	int 21h

	setcursor 9, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_35_R9_C0
	int 21h

	setcursor 9, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_36_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_37_R9_C19
	int 21h

	setcursor 9, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_38_R9_C62
	int 21h

	setcursor 9, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_39_R9_C64
	int 21h

	setcursor 10, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_40_R10_C0
	int 21h

	setcursor 10, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_41_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_42_R10_C19
	int 21h

	setcursor 10, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_43_R10_C62
	int 21h

	setcursor 10, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_44_R10_C64
	int 21h

	setcursor 11, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_45_R11_C0
	int 21h

	setcursor 11, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_46_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_47_R11_C19
	int 21h

	setcursor 11, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_48_R11_C62
	int 21h

	setcursor 11, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_49_R11_C64
	int 21h

	setcursor 12, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_50_R12_C0
	int 21h

	setcursor 12, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_51_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_52_R12_C19
	int 21h

	setcursor 12, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_53_R12_C62
	int 21h

	setcursor 12, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_54_R12_C64
	int 21h

	setcursor 13, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_55_R13_C0
	int 21h

	setcursor 13, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_56_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 2
	mov ah, 09h
	mov dx, offset reg_57_R13_C19
	int 21h

	setcursor 13, 21
	renderc 32, 0, 70h, 41

	setcursor 13, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_58_R13_C62
	int 21h

	setcursor 13, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_59_R13_C64
	int 21h

	setcursor 14, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_60_R14_C0
	int 21h

	setcursor 14, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_61_R14_C17
	int 21h

	setcursor 14, 19
	colorz 112, 43
	mov ah, 09h
	mov dx, offset reg_62_R14_C19
	int 21h

	setcursor 14, 62
	colorz 64, 2
	mov ah, 09h
	mov dx, offset reg_63_R14_C62
	int 21h

	setcursor 14, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_64_R14_C64
	int 21h

	setcursor 15, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset reg_65_R15_C0
	int 21h

	setcursor 15, 17
	colorz 64, 47
	mov ah, 09h
	mov dx, offset reg_66_R15_C17
	int 21h

	setcursor 15, 64
	colorz 112, 16
	mov ah, 09h
	mov dx, offset reg_67_R15_C64
	int 21h

	setcursor 16, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset reg_68_R16_C0
	int 21h

	setcursor 17, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset reg_69_R17_C0
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset reg_70_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset reg_71_R19_C0
	int 21h
	ret
display_reg_screen ENDP

; Procedure to display login screen
display_login_screen PROC
	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset login_0_R0_C0
	int 21h

	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset login_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_2_R2_C0
	int 21h

	setcursor 2, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset login_3_R2_C17
	int 21h

	setcursor 2, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_4_R2_C62
	int 21h

	setcursor 3, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_5_R3_C0
	int 21h

	setcursor 3, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_6_R3_C17
	int 21h

	setcursor 3, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_7_R3_C19
	int 21h

	setcursor 3, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_8_R3_C60
	int 21h

	setcursor 3, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_9_R3_C62
	int 21h

	setcursor 4, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_10_R4_C0
	int 21h

	setcursor 4, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_11_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_12_R4_C19
	int 21h

	setcursor 4, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_13_R4_C60
	int 21h

	setcursor 4, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_14_R4_C62
	int 21h

	setcursor 5, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_15_R5_C0
	int 21h

	setcursor 5, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_16_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_17_R5_C19
	int 21h

	setcursor 5, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_18_R5_C60
	int 21h

	setcursor 5, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_19_R5_C62
	int 21h

	setcursor 6, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_20_R6_C0
	int 21h

	setcursor 6, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_21_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_22_R6_C19
	int 21h

	setcursor 6, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_23_R6_C60
	int 21h

	setcursor 6, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_24_R6_C62
	int 21h

	setcursor 7, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_25_R7_C0
	int 21h

	setcursor 7, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_26_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_27_R7_C19
	int 21h

	setcursor 7, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_28_R7_C60
	int 21h

	setcursor 7, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_29_R7_C62
	int 21h

	setcursor 8, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_30_R8_C0
	int 21h

	setcursor 8, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_31_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_32_R8_C19
	int 21h

	setcursor 8, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_33_R8_C60
	int 21h

	setcursor 8, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_34_R8_C62
	int 21h

	setcursor 9, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_35_R9_C0
	int 21h

	setcursor 9, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_36_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_37_R9_C19
	int 21h

	setcursor 9, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_38_R9_C60
	int 21h

	setcursor 9, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_39_R9_C62
	int 21h

	setcursor 10, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_40_R10_C0
	int 21h

	setcursor 10, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_41_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_42_R10_C19
	int 21h

	setcursor 10, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_43_R10_C60
	int 21h

	setcursor 10, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_44_R10_C62
	int 21h

	setcursor 11, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_45_R11_C0
	int 21h

	setcursor 11, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_46_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_47_R11_C19
	int 21h

	setcursor 11, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_48_R11_C60
	int 21h

	setcursor 11, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_49_R11_C62
	int 21h

	setcursor 12, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_50_R12_C0
	int 21h

	setcursor 12, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_51_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_52_R12_C19
	int 21h

	setcursor 12, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_53_R12_C60
	int 21h

	setcursor 12, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_54_R12_C62
	int 21h

	setcursor 13, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_55_R13_C0
	int 21h

	setcursor 13, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_56_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_57_R13_C19
	int 21h

	setcursor 13, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_58_R13_C60
	int 21h

	setcursor 13, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_59_R13_C62
	int 21h

	setcursor 14, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_60_R14_C0
	int 21h

	setcursor 14, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_61_R14_C17
	int 21h

	setcursor 14, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset login_62_R14_C19
	int 21h

	setcursor 14, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset login_63_R14_C60
	int 21h

	setcursor 14, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_64_R14_C62
	int 21h

	setcursor 15, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset login_65_R15_C0
	int 21h

	setcursor 15, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset login_66_R15_C17
	int 21h

	setcursor 15, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset login_67_R15_C62
	int 21h

	setcursor 16, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset login_68_R16_C0
	int 21h

	setcursor 17, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset login_69_R17_C0
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset login_70_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset login_71_R19_C0
	int 21h
	ret
display_login_screen ENDP

; Procedure to display menu screen
display_menu_screen PROC
    ; Clear screen
    mov ah, 00h
    mov al, 03h
    int 10h

	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset menu_0_R0_C0
	int 21h

	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset menu_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_2_R2_C0
	int 21h

	setcursor 2, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset menu_3_R2_C17
	int 21h

	setcursor 2, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_4_R2_C62
	int 21h

	setcursor 3, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_5_R3_C0
	int 21h

	setcursor 3, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_6_R3_C17
	int 21h

	setcursor 3, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_7_R3_C19
	int 21h

	setcursor 3, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_8_R3_C60
	int 21h

	setcursor 3, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_9_R3_C62
	int 21h

	setcursor 4, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_10_R4_C0
	int 21h

	setcursor 4, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_11_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_12_R4_C19
	int 21h

	setcursor 4, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_13_R4_C60
	int 21h

	setcursor 4, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_14_R4_C62
	int 21h

	setcursor 5, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_15_R5_C0
	int 21h

	setcursor 5, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_16_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_17_R5_C19
	int 21h

	setcursor 5, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_18_R5_C60
	int 21h

	setcursor 5, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_19_R5_C62
	int 21h

	setcursor 6, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_20_R6_C0
	int 21h

	setcursor 6, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_21_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_22_R6_C19
	int 21h

	setcursor 6, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_23_R6_C60
	int 21h

	setcursor 6, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_24_R6_C62
	int 21h

	setcursor 7, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_25_R7_C0
	int 21h

	setcursor 7, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_26_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_27_R7_C19
	int 21h

	setcursor 7, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_28_R7_C60
	int 21h

	setcursor 7, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_29_R7_C62
	int 21h

	setcursor 8, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_30_R8_C0
	int 21h

	setcursor 8, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_31_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_32_R8_C19
	int 21h

	setcursor 8, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_33_R8_C60
	int 21h

	setcursor 8, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_34_R8_C62
	int 21h

	setcursor 9, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_35_R9_C0
	int 21h

	setcursor 9, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_36_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_37_R9_C19
	int 21h

	setcursor 9, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_38_R9_C60
	int 21h

	setcursor 9, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_39_R9_C62
	int 21h

	setcursor 10, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_40_R10_C0
	int 21h

	setcursor 10, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_41_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_42_R10_C19
	int 21h

	setcursor 10, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_43_R10_C60
	int 21h

	setcursor 10, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_44_R10_C62
	int 21h

	setcursor 11, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_45_R11_C0
	int 21h

	setcursor 11, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_46_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_47_R11_C19
	int 21h

	setcursor 11, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_48_R11_C60
	int 21h

	setcursor 11, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_49_R11_C62
	int 21h

	setcursor 12, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_50_R12_C0
	int 21h

	setcursor 12, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_51_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 2
	mov ah, 09h
	mov dx, offset menu_52_R12_C19
	int 21h

	setcursor 12, 21
	colorz 119, 13
	mov ah, 09h
	mov dx, offset menu_53_R12_C21
	int 21h

	setcursor 12, 34
	colorz 112, 26
	mov ah, 09h
	mov dx, offset menu_54_R12_C34
	int 21h

	setcursor 12, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_55_R12_C60
	int 21h

	setcursor 12, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_56_R12_C62
	int 21h

	setcursor 13, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_57_R13_C0
	int 21h

	setcursor 13, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_58_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_59_R13_C19
	int 21h

	setcursor 13, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_60_R13_C60
	int 21h

	setcursor 13, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_61_R13_C62
	int 21h

	setcursor 14, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_62_R14_C0
	int 21h

	setcursor 14, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_63_R14_C17
	int 21h

	setcursor 14, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_64_R14_C19
	int 21h

	setcursor 14, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_65_R14_C60
	int 21h

	setcursor 14, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_66_R14_C62
	int 21h

	setcursor 15, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_67_R15_C0
	int 21h

	setcursor 15, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_68_R15_C17
	int 21h

	setcursor 15, 19
	colorz 119, 2
	mov ah, 09h
	mov dx, offset menu_69_R15_C19
	int 21h

	; Display blank spaces instead of the valid message by default
	setcursor 15, 21
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_70_R15_C21
	int 21h

	setcursor 15, 48
	colorz 119, 12
	mov ah, 09h
	mov dx, offset menu_71_R15_C48
	int 21h

	setcursor 15, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_72_R15_C60
	int 21h

	setcursor 15, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_73_R15_C62
	int 21h

	setcursor 16, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_74_R16_C0
	int 21h

	setcursor 16, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_75_R16_C17
	int 21h

	setcursor 16, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset menu_76_R16_C19
	int 21h

	setcursor 16, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset menu_77_R16_C60
	int 21h

	setcursor 16, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_78_R16_C62
	int 21h

	setcursor 17, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset menu_79_R17_C0
	int 21h

	setcursor 17, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset menu_80_R17_C17
	int 21h

	setcursor 17, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset menu_81_R17_C62
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset menu_82_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset menu_83_R19_C0
	int 21h

	setcursor 20, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset menu_84_R20_C0
	int 21h
	ret
display_menu_screen ENDP

; Procedure to display add book screen
display_add_book_screen PROC
    ; Clear screen
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Display the add book screen
	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset add_book_0_R0_C0
	int 21h

	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset add_book_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_2_R2_C0
	int 21h

	setcursor 2, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset add_book_3_R2_C17
	int 21h

	setcursor 2, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_4_R2_C62
	int 21h

	setcursor 3, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_5_R3_C0
	int 21h

	setcursor 3, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_6_R3_C17
	int 21h

	setcursor 3, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_7_R3_C19
	int 21h

	setcursor 3, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_8_R3_C60
	int 21h

	setcursor 3, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_9_R3_C62
	int 21h

	setcursor 4, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_10_R4_C0
	int 21h

	setcursor 4, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_11_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_12_R4_C19
	int 21h

	setcursor 4, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_13_R4_C60
	int 21h

	setcursor 4, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_14_R4_C62
	int 21h

	setcursor 5, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_15_R5_C0
	int 21h

	setcursor 5, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_16_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_17_R5_C19
	int 21h

	setcursor 5, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_18_R5_C60
	int 21h

	setcursor 5, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_19_R5_C62
	int 21h

	setcursor 6, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_20_R6_C0
	int 21h

	setcursor 6, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_21_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_22_R6_C19
	int 21h

	setcursor 6, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_23_R6_C60
	int 21h

	setcursor 6, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_24_R6_C62
	int 21h

	setcursor 7, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_25_R7_C0
	int 21h

	setcursor 7, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_26_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_27_R7_C19
	int 21h

	setcursor 7, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_28_R7_C60
	int 21h

	setcursor 7, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_29_R7_C62
	int 21h

	setcursor 8, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_30_R8_C0
	int 21h

	setcursor 8, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_31_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 8
	mov ah, 09h
	mov dx, offset add_book_32_R8_C19
	int 21h

	; Clear the input area for Title
	setcursor 8, 27
	renderc 32, 0, 70h, 33

	setcursor 8, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_33_R8_C60
	int 21h

	setcursor 8, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_34_R8_C62
	int 21h

	setcursor 9, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_35_R9_C0
	int 21h

	setcursor 9, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_36_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_37_R9_C19
	int 21h

	setcursor 9, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_38_R9_C60
	int 21h

	setcursor 9, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_39_R9_C62
	int 21h

	setcursor 10, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_40_R10_C0
	int 21h

	setcursor 10, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_41_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_42_R10_C19
	int 21h

	; Clear the input area for Author
	setcursor 10, 28
	renderc 32, 0, 70h, 32

	setcursor 10, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_43_R10_C60
	int 21h

	setcursor 10, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_44_R10_C62
	int 21h

	setcursor 11, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_45_R11_C0
	int 21h

	setcursor 11, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_46_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_47_R11_C19
	int 21h

	setcursor 11, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_48_R11_C60
	int 21h

	setcursor 11, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_49_R11_C62
	int 21h

	setcursor 12, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_50_R12_C0
	int 21h

	setcursor 12, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_51_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 7
	mov ah, 09h
	mov dx, offset add_book_52_R12_C19
	int 21h

	; Clear the input area for ISBN
	setcursor 12, 26
	renderc 32, 0, 70h, 8

	setcursor 12, 34
	colorz 112, 26
	mov ah, 09h
	mov dx, offset add_book_54_R12_C34
	int 21h

	setcursor 12, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_55_R12_C60
	int 21h

	setcursor 12, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_56_R12_C62
	int 21h

	setcursor 13, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_57_R13_C0
	int 21h

	setcursor 13, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_58_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_59_R13_C19
	int 21h

	setcursor 13, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_60_R13_C60
	int 21h

	setcursor 13, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_61_R13_C62
	int 21h

	setcursor 14, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_62_R14_C0
	int 21h

	setcursor 14, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_63_R14_C17
	int 21h

	; Display blank area initially instead of success message
	setcursor 14, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_64_R14_C19
	int 21h

	setcursor 14, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_65_R14_C60
	int 21h

	setcursor 14, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_66_R14_C62
	int 21h

	setcursor 15, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_67_R15_C0
	int 21h

	setcursor 15, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_68_R15_C17
	int 21h

	setcursor 15, 19
	colorz 119, 2
	mov ah, 09h
	mov dx, offset add_book_69_R15_C19
	int 21h

	setcursor 15, 21
	colorz 112, 27
	mov ah, 09h
	mov dx, offset add_book_70_R15_C21
	int 21h

	setcursor 15, 48
	colorz 119, 12
	mov ah, 09h
	mov dx, offset add_book_71_R15_C48
	int 21h

	setcursor 15, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_72_R15_C60
	int 21h

	setcursor 15, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_73_R15_C62
	int 21h

	setcursor 16, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_74_R16_C0
	int 21h

	setcursor 16, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_75_R16_C17
	int 21h

	setcursor 16, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset add_book_76_R16_C19
	int 21h

	setcursor 16, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset add_book_77_R16_C60
	int 21h

	setcursor 16, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_78_R16_C62
	int 21h

	setcursor 17, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset add_book_79_R17_C0
	int 21h

	setcursor 17, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset add_book_80_R17_C17
	int 21h

	setcursor 17, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset add_book_81_R17_C62
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset add_book_82_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset add_book_83_R19_C0
	int 21h

	setcursor 20, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset add_book_84_R20_C0
	int 21h

    ; Now collect book information using our new ADD_BOOK procedure
    CALL ADD_BOOK

    ; Wait for Enter to return to menu
    wait_for_enter_add:
        mov ah, 00h
        int 16h
        cmp al, 13
        jne wait_for_enter_add
    
    ret
display_add_book_screen ENDP

; Procedure to display view books screen
display_view_books_screen PROC
     ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h


	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset txt_0_R0_C0
	int 21h

	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset txt_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_2_R2_C0
	int 21h

	setcursor 2, 4
	colorz 68, 72
	mov ah, 09h
	mov dx, offset txt_3_R2_C4
	int 21h

	setcursor 2, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_4_R2_C76
	int 21h

	setcursor 3, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_5_R3_C0
	int 21h

	setcursor 3, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_6_R3_C4
	int 21h

	setcursor 3, 6
	colorz 112, 3
	mov ah, 09h
	mov dx, offset txt_7_R3_C6
	int 21h

	setcursor 3, 9
	colorz 116, 10
	mov ah, 09h
	mov dx, offset txt_8_R3_C9
	int 21h

	setcursor 3, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_9_R3_C19
	int 21h

	setcursor 3, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_10_R3_C60
	int 21h

	setcursor 3, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_11_R3_C62
	int 21h

	setcursor 3, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_12_R3_C74
	int 21h

	setcursor 3, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_13_R3_C76
	int 21h

	setcursor 4, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_14_R4_C0
	int 21h

	setcursor 4, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_15_R4_C4
	int 21h

	setcursor 4, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_16_R4_C6
	int 21h

	setcursor 4, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_17_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_18_R4_C19
	int 21h

	setcursor 4, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_19_R4_C60
	int 21h

	setcursor 4, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_20_R4_C62
	int 21h

	setcursor 4, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_21_R4_C74
	int 21h

	setcursor 4, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_22_R4_C76
	int 21h

	setcursor 5, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_23_R5_C0
	int 21h

	setcursor 5, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_24_R5_C4
	int 21h

	setcursor 5, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_25_R5_C6
	int 21h

	setcursor 5, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_26_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_27_R5_C19
	int 21h

	setcursor 5, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_28_R5_C60
	int 21h

	setcursor 5, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_29_R5_C62
	int 21h

	setcursor 5, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_30_R5_C74
	int 21h

	setcursor 5, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_31_R5_C76
	int 21h

	setcursor 6, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_32_R6_C0
	int 21h

	setcursor 6, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_33_R6_C4
	int 21h

	setcursor 6, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_34_R6_C6
	int 21h

	setcursor 6, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_35_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_36_R6_C19
	int 21h

	setcursor 6, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_37_R6_C60
	int 21h

	setcursor 6, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_38_R6_C62
	int 21h

	setcursor 6, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_39_R6_C74
	int 21h

	setcursor 6, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_40_R6_C76
	int 21h

	setcursor 7, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_41_R7_C0
	int 21h

	setcursor 7, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_42_R7_C4
	int 21h

	setcursor 7, 6
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_43_R7_C6
	int 21h

	setcursor 7, 10
	colorz 63, 3
	mov ah, 09h
	mov dx, offset txt_44_R7_C10
	int 21h

	setcursor 7, 13
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_45_R7_C13
	int 21h

	setcursor 7, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_46_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 1
	mov ah, 09h
	mov dx, offset txt_47_R7_C19
	int 21h

	setcursor 7, 20
	colorz 63, 6
	mov ah, 09h
	mov dx, offset txt_48_R7_C20
	int 21h

	setcursor 7, 26
	colorz 127, 13
	mov ah, 09h
	mov dx, offset txt_49_R7_C26
	int 21h

	setcursor 7, 39
	colorz 63, 7
	mov ah, 09h
	mov dx, offset txt_50_R7_C39
	int 21h

	setcursor 7, 46
	colorz 127, 1
	mov ah, 09h
	mov dx, offset txt_51_R7_C46
	int 21h

	setcursor 7, 47
	renderc 32, 0, 7fh, 7

	setcursor 7, 54
	colorz 112, 6
	mov ah, 09h
	mov dx, offset txt_52_R7_C54
	int 21h

	setcursor 7, 60
	colorz 63, 5
	mov ah, 09h
	mov dx, offset txt_53_R7_C60
	int 21h

	setcursor 7, 65
	colorz 112, 9
	mov ah, 09h
	mov dx, offset txt_54_R7_C65
	int 21h

	setcursor 7, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_55_R7_C74
	int 21h

	setcursor 7, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_56_R7_C76
	int 21h

	setcursor 8, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_57_R8_C0
	int 21h

	setcursor 8, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_58_R8_C4
	int 21h

	setcursor 8, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_59_R8_C6
	int 21h

	setcursor 8, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_60_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 2
	mov ah, 09h
	mov dx, offset txt_61_R8_C19
	int 21h

	setcursor 8, 21
	renderc 32, 0, 70h, 39

	setcursor 8, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_62_R8_C60
	int 21h

	setcursor 8, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_63_R8_C62
	int 21h

	setcursor 8, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_64_R8_C74
	int 21h

	setcursor 8, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_65_R8_C76
	int 21h

	setcursor 9, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_66_R9_C0
	int 21h

	setcursor 9, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_67_R9_C4
	int 21h

	setcursor 9, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_68_R9_C6
	int 21h

	setcursor 9, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_69_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_70_R9_C19
	int 21h

	setcursor 9, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_71_R9_C60
	int 21h

	setcursor 9, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_72_R9_C62
	int 21h

	setcursor 9, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_73_R9_C74
	int 21h

	setcursor 9, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_74_R9_C76
	int 21h

	setcursor 10, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_75_R10_C0
	int 21h

	setcursor 10, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_76_R10_C4
	int 21h

	setcursor 10, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_77_R10_C6
	int 21h

	setcursor 10, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_78_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_79_R10_C19
	int 21h

	setcursor 10, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_80_R10_C60
	int 21h

	setcursor 10, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_81_R10_C62
	int 21h

	setcursor 10, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_82_R10_C74
	int 21h

	setcursor 10, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_83_R10_C76
	int 21h

	setcursor 11, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_84_R11_C0
	int 21h

	setcursor 11, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_85_R11_C4
	int 21h

	setcursor 11, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_86_R11_C6
	int 21h

	setcursor 11, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_87_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_88_R11_C19
	int 21h

	setcursor 11, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_89_R11_C60
	int 21h

	setcursor 11, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_90_R11_C62
	int 21h

	setcursor 11, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_91_R11_C74
	int 21h

	setcursor 11, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_92_R11_C76
	int 21h

	setcursor 12, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_93_R12_C0
	int 21h

	setcursor 12, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_94_R12_C4
	int 21h

	setcursor 12, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_95_R12_C6
	int 21h

	setcursor 12, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_96_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_97_R12_C19
	int 21h

	setcursor 12, 30
	colorz 119, 4
	mov ah, 09h
	mov dx, offset txt_98_R12_C30
	int 21h

	setcursor 12, 34
	colorz 112, 26
	mov ah, 09h
	mov dx, offset txt_99_R12_C34
	int 21h

	setcursor 12, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_100_R12_C60
	int 21h

	setcursor 12, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_101_R12_C62
	int 21h

	setcursor 12, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_102_R12_C74
	int 21h

	setcursor 12, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_103_R12_C76
	int 21h

	setcursor 13, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_104_R13_C0
	int 21h

	setcursor 13, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_105_R13_C4
	int 21h

	setcursor 13, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_106_R13_C6
	int 21h

	setcursor 13, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_107_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_108_R13_C19
	int 21h

	setcursor 13, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_109_R13_C60
	int 21h

	setcursor 13, 62
	colorz 112, 12
	mov ah, 09h
	mov dx, offset txt_110_R13_C62
	int 21h

	setcursor 13, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_111_R13_C74
	int 21h

	setcursor 13, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_112_R13_C76
	int 21h

	setcursor 14, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_113_R14_C0
	int 21h

	setcursor 14, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_114_R14_C4
	int 21h

	setcursor 14, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_115_R14_C6
	int 21h

	setcursor 14, 17
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_116_R14_C17
	int 21h

	setcursor 14, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset txt_117_R14_C19
	int 21h

	setcursor 14, 60
	colorz 116, 3
	mov ah, 09h
	mov dx, offset txt_118_R14_C60
	int 21h

	setcursor 14, 63
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_119_R14_C63
	int 21h

	setcursor 14, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_120_R14_C74
	int 21h

	setcursor 14, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_121_R14_C76
	int 21h

	setcursor 15, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_122_R15_C0
	int 21h

	setcursor 15, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_123_R15_C4
	int 21h

	setcursor 15, 6
	colorz 112, 42
	mov ah, 09h
	mov dx, offset txt_124_R15_C6
	int 21h

	setcursor 15, 48
	colorz 119, 12
	mov ah, 09h
	mov dx, offset txt_125_R15_C48
	int 21h

	setcursor 15, 60
	colorz 116, 2
	mov ah, 09h
	mov dx, offset txt_126_R15_C60
	int 21h

	setcursor 15, 62
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_127_R15_C62
	int 21h

	setcursor 15, 73
	colorz 116, 1
	mov ah, 09h
	mov dx, offset txt_128_R15_C73
	int 21h

	setcursor 15, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_129_R15_C74
	int 21h

	setcursor 15, 76
	colorz 112, 2
	mov ah, 09h
	mov dx, offset txt_130_R15_C76
	int 21h

	setcursor 15, 78
	colorz 116, 1
	mov ah, 09h
	mov dx, offset txt_131_R15_C78
	int 21h

	setcursor 15, 79
	colorz 112, 1
	mov ah, 09h
	mov dx, offset txt_132_R15_C79
	int 21h

	setcursor 16, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_133_R16_C0
	int 21h

	setcursor 16, 4
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_134_R16_C4
	int 21h

	setcursor 16, 6
	colorz 112, 11
	mov ah, 09h
	mov dx, offset txt_135_R16_C6
	int 21h

	setcursor 16, 17
	colorz 116, 48
	mov ah, 09h
	mov dx, offset txt_136_R16_C17
	int 21h

	setcursor 16, 65
	colorz 112, 9
	mov ah, 09h
	mov dx, offset txt_137_R16_C65
	int 21h

	setcursor 16, 74
	colorz 68, 2
	mov ah, 09h
	mov dx, offset txt_138_R16_C74
	int 21h

	setcursor 16, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_139_R16_C76
	int 21h

	setcursor 17, 0
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_140_R17_C0
	int 21h

	setcursor 17, 4
	colorz 68, 13
	mov ah, 09h
	mov dx, offset txt_141_R17_C4
	int 21h

	setcursor 17, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset txt_142_R17_C17
	int 21h

	setcursor 17, 62
	colorz 68, 14
	mov ah, 09h
	mov dx, offset txt_143_R17_C62
	int 21h

	setcursor 17, 76
	colorz 112, 4
	mov ah, 09h
	mov dx, offset txt_144_R17_C76
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset txt_145_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset txt_146_R19_C0
	int 21h

	setcursor 20, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset txt_147_R20_C0
	int 21h

	; Display books for current user
	call DISPLAY_USER_BOOKS

	; Wait for Enter to return to menu
	wait_for_enter_view:
		mov ah, 00h
		int 16h
		cmp al, 13
		jne wait_for_enter_view

	ret
display_view_books_screen ENDP

; Procedure to display update book screen
display_update_book_screen PROC
    ; Clear screen
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Display the update book screen
	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset update_book_0_R0_C0
	int 21h

	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset update_book_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_2_R2_C0
	int 21h

	setcursor 2, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset update_book_3_R2_C17
	int 21h

	setcursor 2, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_4_R2_C62
	int 21h

	setcursor 3, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_5_R3_C0
	int 21h

	setcursor 3, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_6_R3_C17
	int 21h

	setcursor 3, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_7_R3_C19
	int 21h

	setcursor 3, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_8_R3_C60
	int 21h

	setcursor 3, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_9_R3_C62
	int 21h

	setcursor 4, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_10_R4_C0
	int 21h

	setcursor 4, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_11_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_12_R4_C19
	int 21h

	setcursor 4, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_13_R4_C60
	int 21h

	setcursor 4, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_14_R4_C62
	int 21h

	setcursor 5, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_15_R5_C0
	int 21h

	setcursor 5, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_16_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_17_R5_C19
	int 21h

	setcursor 5, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_18_R5_C60
	int 21h

	setcursor 5, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_19_R5_C62
	int 21h

	setcursor 6, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_20_R6_C0
	int 21h

	setcursor 6, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_21_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_22_R6_C19
	int 21h

	setcursor 6, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_23_R6_C60
	int 21h

	setcursor 6, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_24_R6_C62
	int 21h

	setcursor 7, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_25_R7_C0
	int 21h

	setcursor 7, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_26_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_27_R7_C19
	int 21h

	setcursor 7, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_28_R7_C60
	int 21h

	setcursor 7, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_29_R7_C62
	int 21h

	setcursor 8, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_30_R8_C0
	int 21h

	setcursor 8, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_31_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_32_R8_C19
	int 21h

	; Clear input area for Book ID
	setcursor 8, 40
	renderc 32, 0, 70h, 2

	setcursor 8, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_33_R8_C60
	int 21h

	setcursor 8, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_34_R8_C62
	int 21h

	setcursor 9, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_35_R9_C0
	int 21h

	setcursor 9, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_36_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_37_R9_C19
	int 21h

	setcursor 9, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_38_R9_C60
	int 21h

	setcursor 9, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_39_R9_C62
	int 21h

	setcursor 10, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_40_R10_C0
	int 21h

	setcursor 10, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_41_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_42_R10_C19
	int 21h

	; Clear input area for New Title
	setcursor 10, 32
	renderc 32, 0, 70h, 28

	setcursor 10, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_43_R10_C60
	int 21h

	setcursor 10, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_44_R10_C62
	int 21h

	setcursor 11, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_45_R11_C0
	int 21h

	setcursor 11, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_46_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_47_R11_C19
	int 21h

	setcursor 11, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_48_R11_C60
	int 21h

	setcursor 11, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_49_R11_C62
	int 21h

	setcursor 12, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_50_R12_C0
	int 21h

	setcursor 12, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_51_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_52_R12_C19
	int 21h

	; Clear input area for New Author
	setcursor 12, 32
	renderc 32, 0, 70h, 28

	setcursor 12, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_53_R12_C60
	int 21h

	setcursor 12, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_54_R12_C62
	int 21h

	setcursor 13, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_55_R13_C0
	int 21h

	setcursor 13, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_56_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_57_R13_C19
	int 21h

	setcursor 13, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_58_R13_C60
	int 21h

	setcursor 13, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_59_R13_C62
	int 21h

	setcursor 14, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_60_R14_C0
	int 21h

	setcursor 14, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_61_R14_C17
	int 21h

	setcursor 14, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_62_R14_C19
	int 21h

	; Clear input area for New ISBN
	setcursor 14, 32
	renderc 32, 0, 70h, 8

	setcursor 14, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_63_R14_C60
	int 21h

	setcursor 14, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_64_R14_C62
	int 21h

	setcursor 15, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_65_R15_C0
	int 21h

	setcursor 15, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_66_R15_C17
	int 21h

	setcursor 15, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_67_R15_C19
	int 21h

	setcursor 15, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_68_R15_C60
	int 21h

	setcursor 15, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_69_R15_C62
	int 21h

	setcursor 16, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_70_R16_C0
	int 21h

	setcursor 16, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_71_R16_C17
	int 21h

	setcursor 16, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset update_book_72_R16_C19
	int 21h

	setcursor 16, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset update_book_73_R16_C60
	int 21h

	setcursor 16, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_74_R16_C62
	int 21h

	setcursor 17, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset update_book_75_R17_C0
	int 21h

	setcursor 17, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset update_book_76_R17_C17
	int 21h

	setcursor 17, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset update_book_77_R17_C62
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset update_book_78_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset update_book_79_R19_C0
	int 21h

	setcursor 20, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset update_book_80_R20_C0
	int 21h

    ; Now update book using our new UPDATE_BOOK procedure
    CALL UPDATE_BOOK

    ; Wait for Enter to return to menu
    wait_for_enter_update:
        mov ah, 00h
        int 16h
        cmp al, 13
        jne wait_for_enter_update
    
    ret
display_update_book_screen ENDP

; Procedure to display delete book screen
display_delete_book_screen PROC
    ; Clear screen
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Display the delete book screen
	setcursor 0, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset delete_book_0_R0_C0
	int 21h

	setcursor 1, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset delete_book_1_R1_C0
	int 21h

	setcursor 2, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_2_R2_C0
	int 21h

	setcursor 2, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset delete_book_3_R2_C17
	int 21h

	setcursor 2, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_4_R2_C62
	int 21h

	setcursor 3, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_5_R3_C0
	int 21h

	setcursor 3, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_6_R3_C17
	int 21h

	setcursor 3, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_7_R3_C19
	int 21h

	setcursor 3, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_8_R3_C60
	int 21h

	setcursor 3, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_9_R3_C62
	int 21h

	setcursor 4, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_10_R4_C0
	int 21h

	setcursor 4, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_11_R4_C17
	int 21h

	setcursor 4, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_12_R4_C19
	int 21h

	setcursor 4, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_13_R4_C60
	int 21h

	setcursor 4, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_14_R4_C62
	int 21h

	setcursor 5, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_15_R5_C0
	int 21h

	setcursor 5, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_16_R5_C17
	int 21h

	setcursor 5, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_17_R5_C19
	int 21h

	setcursor 5, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_18_R5_C60
	int 21h

	setcursor 5, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_19_R5_C62
	int 21h

	setcursor 6, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_20_R6_C0
	int 21h

	setcursor 6, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_21_R6_C17
	int 21h

	setcursor 6, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_22_R6_C19
	int 21h

	setcursor 6, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_23_R6_C60
	int 21h

	setcursor 6, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_24_R6_C62
	int 21h

	setcursor 7, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_25_R7_C0
	int 21h

	setcursor 7, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_26_R7_C17
	int 21h

	setcursor 7, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_27_R7_C19
	int 21h

	setcursor 7, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_28_R7_C60
	int 21h

	setcursor 7, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_29_R7_C62
	int 21h

	setcursor 8, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_30_R8_C0
	int 21h

	setcursor 8, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_31_R8_C17
	int 21h

	setcursor 8, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_32_R8_C19
	int 21h

	; Clear input area for Book ID
	setcursor 8, 40
	renderc 32, 0, 70h, 2

	setcursor 8, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_33_R8_C60
	int 21h

	setcursor 8, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_34_R8_C62
	int 21h

	setcursor 9, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_35_R9_C0
	int 21h

	setcursor 9, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_36_R9_C17
	int 21h

	setcursor 9, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_37_R9_C19
	int 21h

	setcursor 9, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_38_R9_C60
	int 21h

	setcursor 9, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_39_R9_C62
	int 21h

	setcursor 10, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_40_R10_C0
	int 21h

	setcursor 10, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_41_R10_C17
	int 21h

	setcursor 10, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_42_R10_C19
	int 21h

	setcursor 10, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_43_R10_C60
	int 21h

	setcursor 10, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_44_R10_C62
	int 21h

	setcursor 11, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_45_R11_C0
	int 21h

	setcursor 11, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_46_R11_C17
	int 21h

	setcursor 11, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_47_R11_C19
	int 21h

	; Clear confirmation area
	setcursor 11, 42
	renderc 32, 0, 70h, 1

	setcursor 11, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_48_R11_C60
	int 21h

	setcursor 11, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_49_R11_C62
	int 21h

	setcursor 12, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_50_R12_C0
	int 21h

	setcursor 12, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_51_R12_C17
	int 21h

	setcursor 12, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_52_R12_C19
	int 21h

	setcursor 12, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_53_R12_C60
	int 21h

	setcursor 12, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_54_R12_C62
	int 21h

	setcursor 13, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_55_R13_C0
	int 21h

	setcursor 13, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_56_R13_C17
	int 21h

	setcursor 13, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_57_R13_C19
	int 21h

	setcursor 13, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_58_R13_C60
	int 21h

	setcursor 13, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_59_R13_C62
	int 21h

	setcursor 14, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_60_R14_C0
	int 21h

	setcursor 14, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_61_R14_C17
	int 21h

	setcursor 14, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_62_R14_C19
	int 21h

	setcursor 14, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_63_R14_C60
	int 21h

	setcursor 14, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_64_R14_C62
	int 21h

	setcursor 15, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_65_R15_C0
	int 21h

	setcursor 15, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_66_R15_C17
	int 21h

	setcursor 15, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_67_R15_C19
	int 21h

	setcursor 15, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_68_R15_C60
	int 21h

	setcursor 15, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_69_R15_C62
	int 21h

	setcursor 16, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_70_R16_C0
	int 21h

	setcursor 16, 17
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_71_R16_C17
	int 21h

	setcursor 16, 19
	colorz 112, 41
	mov ah, 09h
	mov dx, offset delete_book_72_R16_C19
	int 21h

	setcursor 16, 60
	colorz 64, 2
	mov ah, 09h
	mov dx, offset delete_book_73_R16_C60
	int 21h

	setcursor 16, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_74_R16_C62
	int 21h

	setcursor 17, 0
	colorz 112, 17
	mov ah, 09h
	mov dx, offset delete_book_75_R17_C0
	int 21h

	setcursor 17, 17
	colorz 64, 45
	mov ah, 09h
	mov dx, offset delete_book_76_R17_C17
	int 21h

	setcursor 17, 62
	colorz 112, 18
	mov ah, 09h
	mov dx, offset delete_book_77_R17_C62
	int 21h

	setcursor 18, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset delete_book_78_R18_C0
	int 21h

	setcursor 19, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset delete_book_79_R19_C0
	int 21h

	setcursor 20, 0
	colorz 112, 80
	mov ah, 09h
	mov dx, offset delete_book_80_R20_C0
	int 21h

    ; Now delete book using our new DELETE_BOOK procedure
    CALL DELETE_BOOK

    ; Wait for Enter to return to menu
    wait_for_enter_delete:
        mov ah, 00h
        int 16h
        cmp al, 13
        jne wait_for_enter_delete
    
    ret
display_delete_book_screen ENDP

; ============================================================
; UTILITY PROCEDURES
; ============================================================

; Procedure to get navigation input with validation
get_nav_input PROC
input_loop:
    ; Set cursor position for input
    setcursor 12, 47
    
    ; Get single character input
    mov ah, 01h
    int 21h
    
    ; Check if input is valid (1, 2, or 3)
    cmp al, '1'
    je valid_input
    cmp al, '2' 
    je valid_input
    cmp al, '3'
    je valid_input
    
    ; Invalid input - display error message
    setcursor 14, 19
    mov ah, 09h
    mov dx, offset invalid_msg
    int 21h
    
    ; Wait a moment
    mov cx, 0FFFFh
    delay_loop:
        loop delay_loop
    
    ; Clear error message
    setcursor 14, 19
    mov ah, 09h
    mov dx, offset nav_62_R14_C19
    int 21h
    
    jmp input_loop
    
valid_input:
    ret
get_nav_input ENDP

; Procedure to get menu input with validation
get_menu_input PROC
input_loop_menu:
    ; Set cursor position for input
    setcursor 13, 34
    
    ; Get single character input
    mov ah, 01h
    int 21h
    
    ; Check if input is valid (1, 2, 3, 4, or 5)
    cmp al, '1'
    je valid_menu_input
    cmp al, '2' 
    je valid_menu_input
    cmp al, '3'
    je valid_menu_input
    cmp al, '4'
    je valid_menu_input
    cmp al, '5'
    je valid_menu_input
    
    ; Invalid input - display error message
    setcursor 15, 19
    colorz 112, 41
    mov ah, 09h
    mov dx, offset invalid_menu_msg
    int 21h
    
    ; Wait a moment
    mov cx, 0FFFFh
    delay_loop_menu:
    loop delay_loop_menu
    
    ; Clear error message by redrawing the message area
    setcursor 15, 19
    colorz 112, 41
    mov ah, 09h
    mov dx, offset menu_64_R14_C19
    int 21h
    
    jmp input_loop_menu
    
valid_menu_input:
    ; Display valid message
    setcursor 15, 21
    colorz 112, 38
    mov ah, 09h
    mov dx, offset valid_menu_msg
    int 21h
    
    ret
get_menu_input ENDP

; Procedure to get string input
; Input: DI = offset of buffer to store string
;        CX = maximum length
; Output: AL = actual length of input
get_string_input PROC
    push bx
    push cx
    push dx
    push di
    
    mov bx, 0  ; Character counter
    
input_char:
    ; Get character without echo
    mov ah, 07h
    int 21h
    
    ; Check for Enter key (end input)
    cmp al, 13
    je end_input
    
    ; Check for Backspace
    cmp al, 8
    je backspace
    
    ; Check if we reached max length
    cmp bl, cl
    jae input_char  ; If max reached, ignore input
    
    ; Store character in buffer
    mov [di], al
    inc di
    inc bl
    
    ; Display the character
    mov dl, al
    mov ah, 02h
    int 21h
    
    jmp input_char

backspace:
    ; Check if there are characters to delete
    cmp bl, 0
    je input_char
    
    ; Move cursor back
    mov dl, 8
    mov ah, 02h
    int 21h
    
    ; Print space to erase
    mov dl, ' '
    mov ah, 02h
    int 21h
    
    ; Move cursor back again
    mov dl, 8
    mov ah, 02h
    int 21h
    
    ; Remove from buffer
    dec di
    dec bl
    mov byte ptr [di], 0
    
    jmp input_char

end_input:
    ; Null terminate the string
    mov byte ptr [di], 0
    
    ; Return the length in AL
    mov al, bl
    
    pop di
    pop dx
    pop cx
    pop bx
    ret
get_string_input ENDP

; Procedure to clear username and password buffers
clear_credentials PROC
    push cx
    push di
    
    ; Clear username buffer
    mov cx, 20
    mov di, offset username_buffer
    clear_username:
        mov byte ptr [di], 0
        inc di
        loop clear_username
    
    ; Clear password buffer  
    mov cx, 20
    mov di, offset password_buffer
    clear_password:
        mov byte ptr [di], 0
        inc di
        loop clear_password
    
    mov username_length, 0
    mov password_length, 0
    
    pop di
    pop cx
    ret
clear_credentials ENDP

; Procedure to clear login buffers
clear_login_credentials PROC
    push cx
    push di
    
    ; Clear login username buffer
    mov cx, 20
    mov di, offset login_username_buffer
    clear_login_username:
        mov byte ptr [di], 0
        inc di
        loop clear_login_username
    
    ; Clear login password buffer  
    mov cx, 20
    mov di, offset login_password_buffer
    clear_login_password:
        mov byte ptr [di], 0
        inc di
        loop clear_login_password
    
    mov login_username_length, 0
    mov login_password_length, 0
    
    pop di
    pop cx
    ret
clear_login_credentials ENDP

; Procedure to compare strings
; Input: SI = offset of string1, DI = offset of string2, CL = length
; Output: ZF set if equal, ZF clear if not equal
; Fixed compare_strings procedure
compare_strings PROC
    push ax
    push cx
    push si
    push di
    
    mov ch, 0
    jcxz compare_str_equal  ; Changed label name
    
compare_str_loop:  ; Changed label name
    mov al, [si]
    cmp al, [di]
    jne compare_str_not_equal  ; Changed label name
    inc si
    inc di
    loop compare_str_loop
    
compare_str_equal:  ; Changed label name
    cmp al, al  ; Set ZF=1 (strings are equal)
    jmp compare_str_done
    
compare_str_not_equal:  ; Changed label name
    mov al, 1
    cmp al, 2   ; Set ZF=0 (strings are not equal)
    
compare_str_done:  ; Changed label name
    pop di
    pop si
    pop cx
    pop ax
    ret
compare_strings ENDP
; Procedure to copy string
; Input: SI = source, DI = destination, CL = length
copy_string PROC
    push ax
    push cx
    push si
    push di
    
    mov ch, 0
    jcxz copy_done
    
copy_loop:
    mov al, [si]
    mov [di], al
    inc si
    inc di
    loop copy_loop
    
copy_done:
    pop di
    pop si
    pop cx
    pop ax
    ret
copy_string ENDP

; Procedure to clear current user
clear_current_user PROC
    push cx
    push di
    
    mov cx, 20
    mov di, offset current_user
    clear_user:
        mov byte ptr [di], 0
        inc di
        loop clear_user
    
    pop di
    pop cx
    ret
clear_current_user ENDP

; ============================================================
; BOOK MANAGEMENT SYSTEM PROCEDURES
; ============================================================

; Clear temporary book buffers
CLEAR_TEMP_BOOK PROC
    PUSH CX
    PUSH DI
    
    LEA DI, TEMP_TITLE
    MOV CX, 33
    CALL FILL_ZERO
    
    LEA DI, TEMP_AUTHOR
    MOV CX, 32
    CALL FILL_ZERO
    
    LEA DI, TEMP_ISBN
    MOV CX, 8
    CALL FILL_ZERO
    
    POP DI
    POP CX
    RET
CLEAR_TEMP_BOOK ENDP

; Fill memory with zeros
FILL_ZERO PROC
    PUSH AX
    PUSH CX
    PUSH DI
    
    MOV AL, 0
FILL_LOOP:
    MOV [DI], AL
    INC DI
    LOOP FILL_LOOP
    
    POP DI
    POP CX
    POP AX
    RET
FILL_ZERO ENDP

; Copy memory block
; SI = source, DI = destination, CX = count
; Fixed COPY_MEMORY procedure with unique labels
COPY_MEMORY PROC
    PUSH AX
    PUSH CX
    PUSH SI
    PUSH DI
    
COPY_MEM_LOOP:  ; Changed label name
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_MEM_LOOP
    
    POP DI
    POP SI
    POP CX
    POP AX
    RET
COPY_MEMORY ENDP

; Fixed COMPARE_MEMORY procedure with unique labels
COMPARE_MEMORY PROC
    PUSH AX
    PUSH CX
    PUSH SI
    PUSH DI
    
COMPARE_MEM_LOOP:  ; Changed label name
    MOV AL, [SI]
    CMP AL, [DI]
    JNE COMPARE_MEM_NOT_EQUAL  ; Changed label name
    INC SI
    INC DI
    LOOP COMPARE_MEM_LOOP
    
    CMP AL, AL  ; Set ZF=1
    JMP COMPARE_MEM_END
    
COMPARE_MEM_NOT_EQUAL:  ; Changed label name
    MOV AL, 1
    CMP AL, 2   ; Set ZF=0
    
COMPARE_MEM_END:
    POP DI
    POP SI
    POP CX
    POP AX
    RET
COMPARE_MEMORY ENDP

; Print number in AL
PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR AH, AH
    MOV BL, 10
    XOR CX, CX
    
    CMP AL, 0
    JNE PRINT_NUM_LOOP
    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    JMP PRINT_NUM_END
    
PRINT_NUM_LOOP:
    XOR AH, AH
    DIV BL
    PUSH AX
    INC CX
    CMP AL, 0
    JNE PRINT_NUM_LOOP
    
PRINT_NUM_DISPLAY:
    POP AX
    MOV DL, AH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRINT_NUM_DISPLAY
    
PRINT_NUM_END:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

; Get number input, returns in AL
; Get number input, returns in AL
GET_NUMBER PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR BX, BX  ; Store the number
    XOR CX, CX  ; Character counter
    
GET_NUM_LOOP:
    MOV AH, 00h      ; Wait for key press
    INT 16h
    
    CMP AL, 13       ; Enter key
    JE GET_NUM_END
    
    CMP AL, 8        ; Backspace key
    JE HANDLE_BACKSPACE
    
    CMP AL, '0'
    JB GET_NUM_LOOP
    CMP AL, '9'
    JA GET_NUM_LOOP
    
    ; Display the digit
    MOV AH, 02h
    MOV DL, AL
    INT 21h
    
    ; Add to number
    SUB AL, '0'
    MOV CL, AL
    
    MOV AX, BX
    MOV BL, 10
    MUL BL
    MOV BX, AX
    ADD BL, CL
    ADC BH, 0
    JMP GET_NUM_LOOP
    
HANDLE_BACKSPACE:
    ; Check if there are any characters to delete
    CMP BX, 0
    JE GET_NUM_LOOP  ; Nothing to delete
    
    ; Move cursor back
    MOV AH, 02h
    MOV DL, 8        ; Backspace
    INT 21h
    
    ; Print space to erase
    MOV DL, ' '
    INT 21h
    
    ; Move cursor back again
    MOV DL, 8
    INT 21h
    
    ; Remove last digit from number (divide by 10)
    MOV AX, BX
    MOV BL, 10
    DIV BL           ; AX ÷ 10 = AL (quotient), AH (remainder)
    XOR AH, AH       ; Clear remainder
    MOV BX, AX
    
    JMP GET_NUM_LOOP
    
GET_NUM_END:
    MOV AL, BL
    POP DX
    POP CX
    POP BX
    RET
GET_NUMBER ENDP
; Print string - DX points to string
PRINT_STRING PROC
    PUSH AX
    MOV AH, 09H
    INT 21H
    POP AX
    RET
PRINT_STRING ENDP

; Add book procedure
; Add book procedure
; Add book procedure - FIXED VERSION
ADD_BOOK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    ; Check if library is full
    MOV AL, BOOK_COUNT
    CMP AL, MAX_BOOKS
    JB ADD_NOT_FULL
    
    ; Library full
    setcursor 14, 19
    colorz 112, 41
    LEA DX, library_full_msg
    CALL PRINT_STRING
    JMP ADD_END
    
ADD_NOT_FULL:
    ; Clear temp buffers
    CALL CLEAR_TEMP_BOOK
    
    ; Get book title
    setcursor 8, 27
    MOV DI, OFFSET TEMP_TITLE
    MOV CX, 32
    CALL GET_STRING_INPUT
    
    ; Check if title is empty - FIXED JUMP
    CMP AL, 0
    JNE ADD_GET_AUTHOR
    JMP ADD_INVALID
    
ADD_GET_AUTHOR:
    ; Get book author
    setcursor 10, 28
    MOV DI, OFFSET TEMP_AUTHOR
    MOV CX, 31
    CALL GET_STRING_INPUT
    
    ; Check if author is empty - FIXED JUMP
    CMP AL, 0
    JNE ADD_GET_ISBN
    JMP ADD_INVALID
    
ADD_GET_ISBN:
    ; Get book ISBN
    setcursor 12, 26
    MOV DI, OFFSET TEMP_ISBN
    MOV CX, 7
    CALL GET_STRING_INPUT
    
    ; Check if ISBN is empty - FIXED JUMP
    CMP AL, 0
    JNE ADD_VALID_INPUT
    JMP ADD_INVALID
    
ADD_VALID_INPUT:
    ; Calculate book storage location
    MOV AL, BOOK_COUNT
    MOV BL, 93  ; Size of book structure
    MUL BL
    MOV DI, OFFSET BOOKS
    ADD DI, AX
    
    ; Copy data to book record
    ; Copy title (33 bytes)
    MOV SI, OFFSET TEMP_TITLE
    MOV CX, 33
    PUSH DI
COPY_TITLE_ADD:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_TITLE_ADD
    POP DI
    ADD DI, 33
    
    ; Copy author (32 bytes)
    MOV SI, OFFSET TEMP_AUTHOR
    MOV CX, 32
    PUSH DI
COPY_AUTHOR_ADD:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_AUTHOR_ADD
    POP DI
    ADD DI, 32
    
    ; Copy ISBN (8 bytes)
    MOV SI, OFFSET TEMP_ISBN
    MOV CX, 8
    PUSH DI
COPY_ISBN_ADD:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_ISBN_ADD
    POP DI
    ADD DI, 8
    
    ; Copy owner (current user) (20 bytes)
    MOV SI, OFFSET CURRENT_USER
    MOV CX, 20
COPY_OWNER_ADD:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    LOOP COPY_OWNER_ADD
    
    ; Increment book count
    INC BOOK_COUNT
    
    ; Show success message
    setcursor 14, 19
    colorz 112, 41
    LEA DX, success_add_msg
    CALL PRINT_STRING
    JMP ADD_END
    
ADD_INVALID:
    ; If invalid, don't show success message
    
ADD_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
ADD_BOOK ENDP; Find book by ID for current user
; Input: AL = book ID (1-based)
; Output: SI = book address, CF=1 if found, CF=0 if not found
FIND_BOOK_BY_ID PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DI
    
    MOV BL, AL  ; Store target ID
    
    MOV CL, BOOK_COUNT
    CMP CL, 0
    JE FIND_NOT_FOUND
    
    XOR CH, CH
    MOV SI, OFFSET BOOKS
    MOV AL, 1  ; Current ID counter
    
FIND_LOOP:
    ; Check if this book belongs to current user
    PUSH SI
    ADD SI, 73  ; Move to owner field (33+32+8=73)
    MOV DI, OFFSET CURRENT_USER
    MOV CX, 20
    CALL COMPARE_MEMORY
    POP SI
    JNE FIND_NEXT
    
    ; Check ID
    CMP AL, BL
    JE FIND_FOUND
    
FIND_NEXT:
    ADD SI, 93  ; Next book
    INC AL
    CMP AL, BOOK_COUNT
    JBE FIND_LOOP
    
FIND_NOT_FOUND:
    CLC
    JMP FIND_EXIT
    
FIND_FOUND:
    STC
    
FIND_EXIT:
    POP DI
    POP CX
    POP BX
    POP AX
    RET
FIND_BOOK_BY_ID ENDP

; Display all books for current user
; Display all books for current user
; Display all books for current user
DISPLAY_USER_BOOKS PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    ; Check if there are any books
    MOV AL, BOOK_COUNT
    CMP AL, 0
    JE DISPLAY_NO_BOOKS
    
    ; Initialize counters
    MOV SI, OFFSET BOOKS
    XOR BL, BL  ; Book counter (0-based index)
    MOV BH, 1   ; Display ID (1-based)
    
DISPLAY_LOOP:
    ; Check if we've gone through all books
    MOV AL, BOOK_COUNT
    CMP BL, AL
    JAE DISPLAY_CHECK_FOUND
    
    ; Check if book belongs to current user
    ; Point DI to owner field of current book
    MOV DI, SI
    ADD DI, 73  ; Move to owner field (33+32+8=73)
    
    ; Save BX before string comparison
    PUSH BX
    PUSH SI
    
    ; Point to current user
    MOV SI, OFFSET CURRENT_USER
    
    ; Compare owner with current user character by character
    MOV CX, 20
    
DISPLAY_CMP_LOOP:
    MOV AL, [SI]
    MOV AH, [DI]
    CMP AL, AH
    JNE DISPLAY_NOT_MATCH
    
    ; Check if both are null (end of username)
    CMP AL, 0
    JE DISPLAY_MATCH
    
    INC SI
    INC DI
    LOOP DISPLAY_CMP_LOOP
    
DISPLAY_MATCH:
    ; Book belongs to current user
    ; Restore registers
    POP SI
    POP BX
    
    ; Display this book - BH contains the correct display ID
    PUSH BX
    PUSH SI
    CALL DISPLAY_BOOK_ROW
    POP SI
    POP BX
    
    INC BH  ; Next display ID
    JMP DISPLAY_NEXT
    
DISPLAY_NOT_MATCH:
    ; Book doesn't belong to current user
    POP SI
    POP BX
    
DISPLAY_NEXT:
    ADD SI, 93  ; Move to next book
    INC BL      ; Increment book counter
    JMP DISPLAY_LOOP
    
DISPLAY_CHECK_FOUND:
    ; Check if we found any books
    CMP BH, 1
    JE DISPLAY_NO_BOOKS
    JMP DISPLAY_END
    
DISPLAY_NO_BOOKS:
    setcursor 9, 19
    colorz 112, 41
    LEA DX, no_books_msg
    CALL PRINT_STRING
    
DISPLAY_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_USER_BOOKS ENDP
; Display single book row
; Input: SI = book address, BH = display ID
; Display single book row
; Input: SI = book address, BH = display ID
; Display single book row
; Input: SI = book address, BH = display ID
DISPLAY_BOOK_ROW PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    ; Calculate display row (start from row 8)
    MOV AL, BH
    ADD AL, 7  ; Start at row 8 (header is row 7)
    MOV DH, AL
    
    ; Display ID (align with "ID:" header at column 10)
    MOV DL, 10
    MOV AL, BH    ; <-- FIX: Move the correct display ID from BH to AL
    setcursor DH, DL  ; <-- setcursor clears BH, but AL now holds the ID
    CALL PRINT_NUMBER
    
    ; Display Title (align with "TITLE:" header at column 20)
    MOV DL, 20
    setcursor DH, DL
    PUSH SI
    MOV DI, SI  ; Title starts at book address
    MOV CX, 13  ; Reduced to fit better
    CALL DISPLAY_FIELD
    POP SI
    
    ; Display Author (align with "AUTHOR:" header at column 39)
    MOV DL, 39
    setcursor DH, DL
    PUSH SI
    MOV DI, SI
    ADD DI, 33  ; Author field
    MOV CX, 14  ; Adjusted width
    CALL DISPLAY_FIELD
    POP SI
    
    ; Display ISBN (align with "ISBN:" header at column 60)
    MOV DL, 60
    setcursor DH, DL
    PUSH SI
    MOV DI, SI
    ADD DI, 65  ; ISBN field (33+32=65)
    MOV CX, 8
    CALL DISPLAY_FIELD
    POP SI
    
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_BOOK_ROW ENDP

; Display field with fixed width
; Input: DI = field address, CX = field width
DISPLAY_FIELD PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DI
    
    MOV BX, 0  ; Character counter
    
DISPLAY_FIELD_LOOP:
    CMP BX, CX
    JGE DISPLAY_FIELD_DONE
    
    MOV AL, [DI]
    CMP AL, 0
    JE DISPLAY_FIELD_FILL
    
    ; Display character
    MOV AH, 02H
    MOV DL, AL
    INT 21H
    
    INC DI
    INC BX
    JMP DISPLAY_FIELD_LOOP

DISPLAY_FIELD_FILL:
    ; Fill with spaces
    MOV AH, 02H
    MOV DL, ' '
    INT 21H
    INC BX
    JMP DISPLAY_FIELD_LOOP

DISPLAY_FIELD_DONE:
    POP DI
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_FIELD ENDP

; Update book procedure
; Fixed UPDATE_BOOK procedure
; Fixed UPDATE_BOOK procedure with proper jump handling
; Fixed UPDATE_BOOK procedure with intermediate jumps for out-of-range issues
UPDATE_BOOK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    ; Get book ID to update
    setcursor 8, 40
    CALL GET_NUMBER
    MOV TEMP_ID, AL
    
    ; Find the book
    MOV AL, TEMP_ID
    CALL FIND_BOOK_BY_ID
    JNC SHORT_NOT_FOUND
    JMP BOOK_FOUND
    
SHORT_NOT_FOUND:
    JMP UPDATE_NOT_FOUND
    
BOOK_FOUND:
    ; Book found - get new details
    CALL CLEAR_TEMP_BOOK
    
    ; Get new title
    setcursor 10, 32
    MOV DI, OFFSET TEMP_TITLE
    MOV CX, 28
    CALL GET_STRING_INPUT
    CMP AL, 0
    JE SHORT_INVALID
    
    ; Get new author
    setcursor 12, 32
    MOV DI, OFFSET TEMP_AUTHOR
    MOV CX, 28
    CALL GET_STRING_INPUT
    CMP AL, 0
    JE SHORT_INVALID
    
    ; Get new ISBN
    setcursor 14, 32
    MOV DI, OFFSET TEMP_ISBN
    MOV CX, 8
    CALL GET_STRING_INPUT
    CMP AL, 0
    JE SHORT_INVALID
    
    ; ==== FIXED: Update all book fields ====
    ; SI points to the found book structure
    
    ; 1. Update Title (starts at offset 0)
    LEA DI, TEMP_TITLE      ; Source: temp title
    MOV CX, 33              ; 33 bytes for title
    PUSH SI                 ; Save book pointer
COPY_TITLE_UPD:
    MOV AL, [DI]
    MOV [SI], AL
    INC SI
    INC DI
    LOOP COPY_TITLE_UPD
    
    ; 2. Update Author (starts at offset 33)
    POP SI                  ; Restore book pointer
    PUSH SI                 ; Save it again
    ADD SI, 33              ; Move to author field
    LEA DI, TEMP_AUTHOR     ; Source: temp author
    MOV CX, 32              ; 32 bytes for author
COPY_AUTHOR_UPD:
    MOV AL, [DI]
    MOV [SI], AL
    INC SI
    INC DI
    LOOP COPY_AUTHOR_UPD
    
    ; 3. Update ISBN (starts at offset 65 = 33+32)
    POP SI                  ; Restore book pointer
    ADD SI, 65              ; Move to ISBN field
    LEA DI, TEMP_ISBN       ; Source: temp ISBN
    MOV CX, 8               ; 8 bytes for ISBN
COPY_ISBN_UPD:
    MOV AL, [DI]
    MOV [SI], AL
    INC SI
    INC DI
    LOOP COPY_ISBN_UPD
    
    ; Show success
    setcursor 16, 19
    colorz 112, 41
    LEA DX, success_upd_msg
    CALL PRINT_STRING
    JMP UPDATE_END
    
SHORT_INVALID:
    JMP UPDATE_INVALID
    
UPDATE_NOT_FOUND:
    setcursor 16, 19
    colorz 112, 41
    LEA DX, book_not_found_msg
    CALL PRINT_STRING
    JMP UPDATE_END
    
UPDATE_INVALID:
    ; Don't update if invalid input
    ; Could show an error message here if needed
    
UPDATE_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
UPDATE_BOOK ENDP
; Fixed DELETE_BOOK procedure  
DELETE_BOOK PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    ; Get book ID to delete
    setcursor 8, 40
    CALL GET_NUMBER
    MOV TEMP_ID, AL
    
    ; Find the book
    MOV AL, TEMP_ID
    CALL FIND_BOOK_BY_ID
    JNC DELETE_NOT_FOUND_FAR  ; Jump to far label first
    
    JMP DELETE_FOUND
    
DELETE_NOT_FOUND_FAR:
    JMP DELETE_NOT_FOUND
    
DELETE_FOUND:
    ; Confirm deletion
    setcursor 11, 19
    CALL CONFIRM_DELETE
    JNC DELETE_CANCELLED_FAR  ; Jump to far label first
    
    ; Delete by shifting subsequent books
    MOV DI, SI  ; DI points to book to delete
    
    ; Calculate number of books after this one
    MOV AL, BOOK_COUNT
    SUB AL, TEMP_ID
    CMP AL, 0
    JLE DELETE_LAST
    
    ; Calculate bytes to move
    MOV AH, 0
    MOV BL, 93
    MUL BL
    MOV CX, AX
    
    ; Set up source and destination
    MOV SI, DI
    ADD SI, 93  ; SI points to next book
    
    ; Shift books left
DELETE_SHIFT_LOOP:
    CMP CX, 0
    JE DELETE_SHIFT_DONE
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    DEC CX
    JMP DELETE_SHIFT_LOOP
    
DELETE_SHIFT_DONE:
    ; Decrease book count
    DEC BOOK_COUNT
    JMP DELETE_SUCCESS
    
DELETE_LAST:
    ; Just decrease count if it's the last book
    DEC BOOK_COUNT
    JMP DELETE_SUCCESS
    
DELETE_NOT_FOUND:
    setcursor 16, 19
    colorz 112, 41
    LEA DX, book_not_found_msg
    CALL PRINT_STRING
    JMP DELETE_END
    
DELETE_CANCELLED_FAR:
    JMP DELETE_CANCELLED
    
DELETE_CANCELLED:
    ; Do nothing
    JMP DELETE_END
    
DELETE_SUCCESS:
    setcursor 16, 19
    colorz 112, 41
    LEA DX, success_del_msg
    CALL PRINT_STRING
    
DELETE_END:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DELETE_BOOK ENDP
; Confirm deletion
; Returns: CF=1 if confirmed, CF=0 if cancelled
CONFIRM_DELETE PROC
    PUSH AX
    PUSH DX
    
    ; Display confirmation message
    LEA DX, confirm_del_msg
    CALL PRINT_STRING
    
CONFIRM_LOOP:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 'Y'
    JE CONFIRM_YES
    CMP AL, 'y'
    JE CONFIRM_YES
    CMP AL, 'N'
    JE CONFIRM_NO
    CMP AL, 'n'
    JE CONFIRM_NO
    JMP CONFIRM_LOOP
    
CONFIRM_YES:
    STC
    JMP CONFIRM_END
    
CONFIRM_NO:
    CLC
    
CONFIRM_END:
    POP DX
    POP AX
    RET
CONFIRM_DELETE ENDP


; ============================================================
; USER MANAGEMENT PROCEDURES - UPDATED
; ============================================================

; Procedure to find user by username
; Input: SI = username to find, CL = username length
; Output: CF=1 if found, CF=0 if not found
;         DI = user record if found
FIND_USER_BY_NAME PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    
    MOV AL, USER_COUNT
    CMP AL, 0
    JE FIND_USER_NOT_FOUND
    
    XOR CH, CH
    MOV DI, OFFSET USERS
    MOV BL, 0  ; User index
    
FIND_USER_LOOP:
    ; Compare username
    PUSH DI
    PUSH SI
    MOV CX, 20  ; Username field length
    CALL COMPARE_MEMORY
    POP SI
    POP DI
    JE FIND_USER_FOUND
    
    ; Move to next user (40 bytes each)
    ADD DI, 40
    INC BL
    CMP BL, USER_COUNT
    JB FIND_USER_LOOP
    
FIND_USER_NOT_FOUND:
    CLC
    JMP FIND_USER_EXIT
    
FIND_USER_FOUND:
    STC
    
FIND_USER_EXIT:
    POP SI
    POP CX
    POP BX
    POP AX
    RET
FIND_USER_BY_NAME ENDP

; Updated registration process
registration_process PROC
    ; Display registration screen
    CALL display_reg_screen
    
    ; Check if user database is full
    MOV AL, USER_COUNT
    CMP AL, MAX_USERS
    JB REGISTER_NOT_FULL
    
    ; Database full
    setcursor 12, 19
    colorz 112, 41
    MOV AH, 09H
    MOV DX, OFFSET db_full_msg
    INT 21H
    JMP REGISTER_WAIT
    
REGISTER_NOT_FULL:
    ; Get Username
    setcursor 8, 32
    MOV DI, OFFSET TEMP_TITLE  ; Reuse temp buffer
    MOV CX, 19
    CALL GET_STRING_INPUT
    MOV TEMP_ID, AL  ; Store username length
    
    ; Check if username already exists
    MOV SI, OFFSET TEMP_TITLE
    MOV CL, TEMP_ID
    CALL FIND_USER_BY_NAME
    JC USERNAME_EXISTS
    
    ; Get Password  
    setcursor 10, 32
    MOV DI, OFFSET TEMP_AUTHOR  ; Reuse temp buffer
    MOV CX, 19
    CALL GET_STRING_INPUT
    CMP AL, 0
    JE REGISTER_INVALID
    
    ; Store new user in database
    ; Calculate position for new user
    MOV AL, USER_COUNT
    MOV BL, 40  ; Size of user record
    MUL BL
    MOV DI, OFFSET USERS
    ADD DI, AX
    
    ; Store username (copy from TEMP_TITLE)
    MOV SI, OFFSET TEMP_TITLE
    MOV CL, TEMP_ID
    MOV CH, 0
    PUSH DI
COPY_USERNAME:
    CMP CX, 0
    JE COPY_USERNAME_DONE
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    DEC CX
    JMP COPY_USERNAME
COPY_USERNAME_DONE:
    POP DI
    ADD DI, 20  ; Move to password field
    
    ; Store password (copy from TEMP_AUTHOR)
    MOV SI, OFFSET TEMP_AUTHOR
    PUSH DI
COPY_PASSWORD:
    CMP BYTE PTR [SI], 0
    JE COPY_PASSWORD_DONE
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    JMP COPY_PASSWORD
COPY_PASSWORD_DONE:
    POP DI
    
    ; Increment user count
    INC USER_COUNT
    
    ; Display success message
    setcursor 12, 19
    colorz 112, 41
    MOV AH, 09H
    MOV DX, OFFSET success_msg
    INT 21H
    JMP REGISTER_WAIT
    
USERNAME_EXISTS:
    setcursor 12, 19
    colorz 112, 41
    MOV AH, 09H
    MOV DX, OFFSET user_exists_msg
    INT 21H
    JMP REGISTER_WAIT
    
REGISTER_INVALID:
    ; Don't register if invalid input
    
REGISTER_WAIT:
    ; Wait for Enter to continue
    MOV AH, 00H
    INT 16H
    CMP AL, 13
    JNE REGISTER_WAIT
    
    RET
registration_process ENDP

; Updated login process
login_process PROC
    ; Clear login buffers
    CALL clear_login_credentials
    
    ; Display login screen
    CALL display_login_screen
    
    ; Check if any users exist
    MOV AL, USER_COUNT
    CMP AL, 0
    JNE LOGIN_GET_INPUT
    
    ; No users registered
    setcursor 12, 19
    colorz 112, 41
    MOV AH, 09H
    MOV DX, OFFSET no_account_msg
    INT 21H
    JMP LOGIN_WAIT_NO_ACCOUNT

LOGIN_GET_INPUT:
    ; Get Login Username
    setcursor 8, 32
    MOV DI, OFFSET login_username_buffer
    MOV CX, 19
    CALL GET_STRING_INPUT
    MOV login_username_length, AL
    
    ; Get Login Password  
    setcursor 10, 32
    MOV DI, OFFSET login_password_buffer
    MOV CX, 19
    CALL GET_STRING_INPUT
    MOV login_password_length, AL
    
    ; Search for user in database
    MOV SI, OFFSET login_username_buffer
    MOV CL, login_username_length
    CALL FIND_USER_BY_NAME
    JNC LOGIN_INVALID
    
    ; User found, now check password
    ; DI points to user record, password is at DI+20
    MOV SI, OFFSET login_password_buffer
    ADD DI, 20  ; Move to password field
    MOV CX, 20  ; Password field length
    
    ; Compare passwords
    PUSH DI
    PUSH SI
    CALL COMPARE_MEMORY
    POP SI
    POP DI
    JNE LOGIN_INVALID
    
    ; Valid login - Set current user
    MOV SI, OFFSET login_username_buffer
    MOV DI, OFFSET current_user
    MOV CL, login_username_length
    CALL copy_string
    
    ; Show success message
    setcursor 12, 19
    colorz 112, 41
    MOV AH, 09H
    MOV DX, OFFSET valid_account_msg
    INT 21H
    
    ; Wait a moment
    MOV CX, 3
DELAY_VALID_LOOP:
    PUSH CX
    MOV CX, 0FFFFH
DELAY_INNER:
    LOOP DELAY_INNER
    POP CX
    LOOP DELAY_VALID_LOOP
    
    ; Redirect to menu
    CALL menu_system
    JMP LOGIN_END

LOGIN_INVALID:
    setcursor 12, 19
    colorz 112, 41
    MOV AH, 09H
    MOV DX, OFFSET invalid_account_msg
    INT 21H

LOGIN_WAIT_NO_ACCOUNT:
    ; Wait for Enter
    MOV AH, 00H
    INT 16H
    CMP AL, 13
    JNE LOGIN_WAIT_NO_ACCOUNT

LOGIN_END:
    RET
login_process ENDP

; ============================================================
; MAIN MENU SYSTEM
; ============================================================

; Main menu system procedure
menu_system PROC
menu_loop:
    call display_menu_screen
    
    ; Clear the input area by displaying spaces
    setcursor 13, 34
    mov ah, 02h
    mov dl, ' '
    int 21h
    
    ; Set cursor for input
    setcursor 13, 34
    
    ; Wait for key press
    mov ah, 00h
    int 16h
    
    ; Display what we got
    mov ah, 02h
    mov dl, al
    int 21h

    ; Check input immediately (BEFORE any message display)
    cmp al, '1'
    jne check_2
    jmp show_add_book
check_2:
    cmp al, '2' 
    jne check_3
    jmp show_view_books
check_3:
    cmp al, '3'
    jne check_4
    jmp show_update_book
check_4:
    cmp al, '4'
    jne check_5
    jmp show_delete_book
check_5:
    cmp al, '5'
    jne invalid_choice
    jmp logout
invalid_choice:

    ; ====== INVALID INPUT ======
    setcursor 15, 19
    colorz 112, 41
    mov ah, 09h
    mov dx, offset invalid_menu_msg
    int 21h
    
    ; Wait a moment to see the error
    mov cx, 2
delay_invalid:
    push cx
    mov cx, 0FFFFh
inner_delay_invalid:
    loop inner_delay_invalid
    pop cx
    loop delay_invalid
    
    jmp menu_loop

show_add_book:
    ; Display valid message briefly
    setcursor 15, 21
    colorz 112, 38
    mov ah, 09h
    mov dx, offset valid_menu_msg
    int 21h
    
    ; Short delay to show message
    mov cx, 1
delay_add:
    push cx
    mov cx, 0FFFFh
inner_delay_add:
    loop inner_delay_add
    pop cx
    loop delay_add
    
    call display_add_book_screen
    jmp menu_loop

show_view_books:
    ; Display valid message briefly
    setcursor 15, 21
    colorz 112, 38
    mov ah, 09h
    mov dx, offset valid_menu_msg
    int 21h
    
    ; Short delay to show message
    mov cx, 1
delay_view:
    push cx
    mov cx, 0FFFFh
inner_delay_view:
    loop inner_delay_view
    pop cx
    loop delay_view
    
    call display_view_books_screen
    jmp menu_loop

show_update_book:
    ; Display valid message briefly
    setcursor 15, 21
    colorz 112, 38
    mov ah, 09h
    mov dx, offset valid_menu_msg
    int 21h
    
    ; Short delay
    mov cx, 1
delay_update:
    push cx
    mov cx, 0FFFFh
inner_delay_update:
    loop inner_delay_update
    pop cx
    loop delay_update
    
    call display_update_book_screen
    jmp menu_loop

show_delete_book:
    ; Display valid message briefly
    setcursor 15, 21
    colorz 112, 38
    mov ah, 09h
    mov dx, offset valid_menu_msg
    int 21h
    
    ; Short delay
    mov cx, 1
delay_delete:
    push cx
    mov cx, 0FFFFh
inner_delay_delete:
    loop inner_delay_delete
    pop cx
    loop delay_delete
    
    call display_delete_book_screen
    jmp menu_loop

logout:
    ; Display valid message briefly
    setcursor 15, 21
    colorz 112, 38
    mov ah, 09h
    mov dx, offset valid_menu_msg
    int 21h
    
    ; Short delay
    mov cx, 1
delay_logout:
    push cx
    mov cx, 0FFFFh
inner_delay_logout:
    loop inner_delay_logout
    pop cx
    loop delay_logout
    
    call clear_current_user
    ret
menu_system ENDP

; ============================================================
; MAIN PROGRAM
; ============================================================

start:
    mov ax, @data
    mov ds, ax

    ; Set to video mode 
    mov ah, 00h
    mov al, 03h ; 80x25 color text mode
    int 10h

    ; Display title screen
    call display_title_screen

    ; Wait for any key press
    mov ah, 00h
    int 16h

main_menu:
    ; Clear screen
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Display navigation screen
    call display_nav_screen

    ; Get navigation input with validation
    call get_nav_input

    ; Check which option was selected
    cmp al, '1'
    je show_registration
    cmp al, '2'
    je show_login  
    cmp al, '3'
    je exit_program

show_registration:
    ; Clear screen and show registration
    mov ah, 00h
    mov al, 03h
    int 10h
    
    ; Clear previous credentials
    call clear_credentials
    
    ; Perform registration process
    call registration_process
    
    ; After registration, go back to main menu
    jmp main_menu

show_login:
    ; Clear screen and show login
    mov ah, 00h
    mov al, 03h
    int 10h
    
    ; Perform login process
    call login_process
    
    ; After login, go back to main menu
    jmp main_menu

exit_program:
    mov ah, 4Ch
    mov al, 0
    int 21h

end start
