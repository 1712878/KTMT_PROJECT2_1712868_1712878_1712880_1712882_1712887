 .data
	inDay: .asciiz "\nNhap ngay DAY: "
	inMonth: .asciiz "\nNhap thang MONTH: "
	inYear: .asciiz "\nNhap nam YEAR: "
	menu: .asciiz "\n\n--------------Ban hay chon 1 trong cac thao tac duoi day -------------\n\t0. Thoat\n\t1. Xuat chuoi TIME1 theo dinh dang DD/MM/YYYY\n\t2. Chuyen doi chuoi TIME1 thanh mot trong cac dinh dang sau: \n\t\tA. MM/DD/YYYY\n\t\tB. Month DD/YYYY\n\t\tC. DD Month,YYYY\n\t3. Kiem tra nam trong chuoi TIME1 co phai la nam nhuan khong\n\t4. Cho biet ngay vua nhap la ngay thu may trong tuan\n\t5. Cho biet ngay vua nhap la ngay thu may ke tu ngay 1/1/1.\n\t6. Cho biet nam can chi cua nam vua nhap . Vi du nam 2019 la Ky Hoi\n\t7. Cho biet khoang thoi gian giua chuoi TIME1_1 va TIME1_2\n\t8. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME1\n\t9. Nhap input tu file input.txt xuat ra ket qua toan bo cac\n\t   chuc nang tren ra file output.txt\n----------------------------------------------------------------------\n\n\tLua chon: "
	result: .asciiz "\n\nKet qua: "
	update: .asciiz "Chua co chuc nang nay!"
	chooseType: .asciiz "\n Chon loai dinh dang can xuat ra : "
	name_A: .asciiz "\n A. MM/DD/YYYY : "
	name_B: .asciiz "\n B. Month DD, YYYY : "
	name_C: .asciiz "\n C. DD Month, YYYY: "
	request: .asciiz "\nChon (1) de tiep tuc,chon (2) de nhap lai,chon (0) de thoat: "
	request1: .asciiz "\nChon (1) nhap xuat DL tu File, chon (2) nhap DL bang tay, chon (0) de thoat: "
	error: .asciiz "\nBan nhap ngay khong hop le.Vui long nhap lai!\n"
	success: .asciiz "\nFile thành công!\n"
	leap: .asciiz " La Nam Nhuan"
	noleap: .asciiz " La Nam Thuong"
	ip2: .asciiz ">>>>> TIME2: \n"

	day: .space 3
	month: .space 3
	year: .space 5
	TIME1: .space 11
	TIME2: .space 11
	type: .byte    
	ssr: .space 20
	buffer: .space 22
	time_A: .space 11
	time_B_C: .space 20
	
	# Month
	jan: .asciiz "January"
	feb: .asciiz "February"
	mar: .asciiz "March"
	apr: .asciiz "April"
	may: .asciiz "May"
	jun: .asciiz "June"
	jul: .asciiz "July"
	aug: .asciiz "August"
	sep: .asciiz "September"
	oct: .asciiz "October"
	nov: .asciiz "November"
	dec: .asciiz "December"
	month_label: .word m1, m2, m3, m4, m5,m6, m7, m8, m9, m10,m11, m12

	#Weekday
	mon: .asciiz " is Monday   "
	tue: .asciiz " is Tuesday  "
	wed: .asciiz " is Wednesday"
	thu: .asciiz " is Thursday "
	fri: .asciiz " is Friday   "
	sat: .asciiz " is Saturday "
	sun: .asciiz " is Sunday   "
	#CanChi
	can: .asciiz "Giap  AtBinhDinh Mau  KyCanh TanNham Quy"
	chi: .asciiz "Ty  Suu Dan Mao ThinTy  Ngo Mui ThanDau TuatHoi "
	canchi: .asciiz "---- ----"
	
	infile: .asciiz "input.txt"
	outfile: .asciiz "output.txt"
	acfile: .asciiz "\n"
	acfile1: .asciiz " 1. "
	acfile2a: .asciiz "2A. "
	acfile2b: .asciiz "2B. "
	acfile2c: .asciiz "2C. "
	acfile3: .asciiz "3. "
	acfile4: .asciiz "4. "
	acfile5a: .asciiz "5. Khoang cach tu ngay "
	acfile5b: .asciiz "01/01/0001"
	acfile5c: .asciiz " den ngay "
	acfile5d: .asciiz " la "
	acfile5e: .asciiz " ngay"
	acfile6a: .asciiz "6. "
	acfile6b: .asciiz " la nam "
	acfile7: .asciiz "7. Khoang cach tu ngay "
	acfile8a: .asciiz "8. Hai nam nhuan gan voi "
	acfile8b: .asciiz " nhat la "
	acfile8c: .asciiz " va "
	acfileerror: .asciiz "Chuoi Time_1 va Time_2 khong hop le"
	acfileerror1: .asciiz "Chuoi Time_1 khong hop le"
	acfileerror2: .asciiz "Chuoi Time_2 khong hop le"
.text
	.globl Main
Main:
	
	li $v0,4
	la $a0,request1
	syscall
	li $v0,5
	syscall
	
	beq $v0,1,Main.choose1
	beq $v0,2,Main.choose2
	beq $v0,0,Main.end
	Main.choose1:
		jal File
		j Main.end
	Main.choose2:
		jal Input
		choose2.rep: 
		jal Menu
		la $a0,request
		li $v0,4
		syscall
		li $v0,5
		syscall
		beq $v0,1,choose2.rep
		beq $v0,2,Main.choose2
		beq $v0,0,Main.end
	
	Main.end:
		li $v0,10
		syscall	
Input:
	# Dau thu tuc
	addi $sp,$sp,-20
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $a2,12($sp)
	sw $a3,16($sp)
	
	# Than thu tuc
	# Nhap ngay
	li $v0,4
	la $a0,inDay
	syscall
	
	li $v0,8
	la $a0,day
	li $a1,3
	syscall
	
	# Nhap thang
	li $v0,4
	la $a0,inMonth
	syscall
	
	li $v0,8
	la $a0,month
	li $a1,3
	syscall

	# Nhap nam
	li $v0,4
	la $a0,inYear
	syscall
	
	li $v0,8
	la $a0,year
	li $a1,5
	syscall
	
	# Luu ngay thang nam vao chuoi time de xu li
	la $a0,day
	la $a1,month
	la $a2,year
	la $a3,TIME1
	jal Date

	# Kiem tra tinh hop de cua du lieu nhap vao
	move $a0,$a3
	jal CheckDate
	beq $v0,0,Input.Error
	j Input.End

	Input.Error:
		li $v0,4
		la $a0,error
		syscall
		j Input
	
	Input.End:
	# Cuoi thu tuc
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $a2,12($sp)
	lw $a3,16($sp)
	addi $sp,$sp,20

	jr $ra
Input2:
	# Dau thu tuc
	addi $sp,$sp,-20
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $a2,12($sp)
	sw $a3,16($sp)
	
	# Than thu tuc
	# Nhap ngay
	li $v0,4
	la $a0,inDay
	syscall
	
	li $v0,8
	la $a0,day
	li $a1,3
	syscall
	
	# Nhap thang
	li $v0,4
	la $a0,inMonth
	syscall
	
	li $v0,8
	la $a0,month
	li $a1,3
	syscall

	# Nhap nam
	li $v0,4
	la $a0,inYear
	syscall
	
	li $v0,8
	la $a0,year
	li $a1,5
	syscall
	
	# Luu ngay thang nam vao chuoi time de xu li
	la $a0,day
	la $a1,month
	la $a2,year
	la $a3,TIME2
	jal Date

	# Kiem tra tinh hop de cua du lieu nhap vao
	move $a0,$a3
	jal CheckDate
	beq $v0,0,Input2.Error
	j Input2.End

	Input2.Error:
		li $v0,4
		la $a0,error
		syscall
		j Input2
	
	Input2.End:
	# Cuoi thu tuc
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $a2,12($sp)
	lw $a3,16($sp)
	addi $sp,$sp,20

	jr $ra
Menu:
	addi $sp,$sp,-8
	sw $ra,0($sp)
	sw $t0,4($sp)

	# Xuat menu
	li $v0, 4
	la $a0, menu
	syscall
	# Nhap lua chon
	li $v0, 5
	syscall
	move $t0, $v0

	# Xu li
	beq $t0,0,process_0 #ok
	beq $t0,1,process_1 #ok
	beq $t0,2,process_2 #ok
	beq $t0,3,process_3 #ok
	beq $t0,4,process_4 #ok
	beq $t0,5,process_5 #ok
	beq $t0,6,process_6 #ok
	beq $t0,7,process_7 #ok
	beq $t0,8,process_8 #ok
	beq $t0,9,process_9 #ok
	
	j Menu
# -------------------------------------------------------------------------------------------------------
#				Cac xu ly trong menu 
# -------------------------------------------------------------------------------------------------------
process_0:
	#Exit
	li $v0,10
	syscall

process_1:
	#Xuat ket qua
	li $v0, 4
	la $a0, result
	syscall

	# Xuat ra dinh dang dd/mm/yyyy
	li $v0,4
	la $a0, TIME1
	syscall
	
	#Tro ve menu
	j Menu.end

process_2:
	# Xuat thong bao chon kieu dinh dang
	addi $v0,$0,4
	la $a0,chooseType
	syscall

	addi $v0,$0,12
	syscall

	#Load du lieu
	add $a1,$v0,$0	# Luu type
	la $a0,TIME1


	#Goi ham
	jal Convert
	move $t0,$v0

	# Xuat ket qua
	li $v0, 4
	la $a0, result
	syscall

	addi $v0,$0,4
	add $a0,$0,$t0
	syscall
	
	#Tro ve menu
	j Menu.end

process_3:
	#Load du lieu
	la $a0,TIME1
	
	#Goi ham
	jal Year
	move $t1,$v0
	move $a0,$v0
	jal LeapYear
	move $t0,$v0

	#Xuat ket qua
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0,1
	move $a0,$t1
	syscall

	beq $t0,0,process3_noleap
	j process3_leap
	process3_noleap:
		li $v0,4
		la $a0,noleap
		syscall
		j Menu.end
	process3_leap:
		li $v0,4
		la $a0,leap
		syscall
		
	#Tro ve menu
	j Menu.end

process_4:
	#Load du lieu
	la $a0,TIME1
	
	#Goi ham
	jal Weekday
	move $t0,$v0

	#Xuat ket qua
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0,4
	la $a0,TIME1
	syscall

	li $v0,4
	move $a0, $t0
	syscall
	
	#Tro ve menu
	j Menu.end

process_5:
	#Load du lieu
	la $a0,TIME1
	
	#Goi ham
	jal CountDay
	move $t0,$v0

	#Xuat ket qua
	li $v0, 4
	la $a0, result
	syscall

	li $v0,1
	move $a0, $t0
	syscall
	
	#Tro ve menu
	j Menu.end
process_6:
	#Load du lieu
	la $a0, TIME1
	
	#Goi ham
	jal Year
	move $a0,$v0
	
	jal CanChi
	move $t1,$v0

	#Xuat ket qua
	li $v0, 4
	la $a0, result
	syscall
	
	move $a0,$t1
	li $v0,4
	syscall
	
	#Tro ve menu
	j Menu.end

process_7:
	#Xuat tb nhap TIME2
	li $v0,4
	la $a0,ip2
	syscall

	#Load du lieu
	la $a0,TIME1
	la $a1,TIME2
	
	#Goi ham
	jal Input2
	jal DayDiff
	move $t0,$v0 

	#Xuat ket qua
	li $v0, 4
	la $a0, result
	syscall

	li $v0,1
	move $a0, $t0
	syscall
	
	#Tro ve menu
	j Menu.end
process_8:
	#Load du lieu
	la $a0,TIME1
	
	#Goi ham
	jal PreNextLeapYear
	move $t0,$v0
	move $t1,$v1

	#Xuat ket qua
	li $v0, 4
	la $a0, result
	syscall

	li $v0,1
	move $a0, $t0
	syscall

	li $v0,11
	la $a0,' '
	syscall

	li $v0,1
	move $a0, $t1
	syscall

	#Tro ve menu
	j Menu.end

process_9:
	#Load du lieu
	la $a0,infile
	
	#Doc Filein
	jal ReadFile

	move $a0,$v0
	
	#Load Du lieu tu File vua doc vao TIME1, TIME2
	jal ProcessFile
	
	#Ghi ket qua ra Fileout
	move $a0,$v0	
	la $a1,outfile
	jal WriteFile
	
	#Xuat ket qua
	add $v0,$0,4
	la $a0,success
	syscall

	#Tro ve menu
	j Menu.end

Menu.end:
	lw $ra,0($sp)
	lw $t0,4($sp)
	addi $sp,$sp,8

	jr $ra
File:
	#Dau thu tuc
	addi $sp,$sp,-12
	sw $ra,($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	
	#Than thu tuc
	la $a0,infile
	jal ReadFile

	move $a0,$v0
	jal ProcessFile

	move $a0,$v0	
	la $a1,outfile
	jal WriteFile
	

	li $v0,4
	la $a0,success
	syscall
	
	#Cuoi thu tuc
	lw $ra,($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	addi $sp,$sp,12
	jr $ra
# ---------------------------------------------------------------------------------------------------------
#				Các hàm yêu cau va phu tro
# ---------------------------------------------------------------------------------------------------------

# Tinh so ngay trong thang
DayOfMonth:
	#Dau thu tuc
	addi $sp,$sp,-12
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)

	#Than thu tuc
	move $t0,$a0

	beq $t0,1,DayOfMonth.d31
	beq $t0,2,DayOfMonth.Leap
	beq $t0,3,DayOfMonth.d31
	beq $t0,4,DayOfMonth.d30
	beq $t0,5,DayOfMonth.d31
	beq $t0,6,DayOfMonth.d30
	beq $t0,7,DayOfMonth.d31
	beq $t0,8,DayOfMonth.d31
	beq $t0,9,DayOfMonth.d30
	beq $t0,10,DayOfMonth.d31
	beq $t0,11,DayOfMonth.d30
	beq $t0,12,DayOfMonth.d31
	DayOfMonth.Leap:
		move $a0,$a1
		jal LeapYear
		beq $v0,$0,DayOfMonth.d28
		j DayOfMonth.d29
	DayOfMonth.d28:
		li $v0,28
		j DayOfMonth.End
	DayOfMonth.d29:
		li $v0,29
		j DayOfMonth.End
	DayOfMonth.d30:
		li $v0,30
		j DayOfMonth.End
	DayOfMonth.d31:
		li $v0,31

	DayOfMonth.End:
	#Cuoi thu tuc
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra

#Kiem tra ngay hop le
CheckDate:
	#Dau thu tuc
	addi $sp,$sp,-28
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $t4,20($sp)
	sw $s0,24($sp)

	#-Than thu tuc
	la $s0,($a0)
	jal Day 
	move $t0,$v0

	jal Month
	move $t1,$v0

	#Check Year
	li $t3,0
	addi $s0,$s0,6
	CheckDate.Loop:
		beq $t3,4,Loop.Continue
		lb $t4,0($s0)
		blt $t4,48,CheckDate.False
		bgt $t4,57,CheckDate.False
		addi $t3,$t3,1
		addi $s0,$s0,1
		j CheckDate.Loop
	Loop.Continue:
	jal Year
	move $t2,$v0
	
	blt $t2,1,CheckDate.False
	
	#Check Month
	blt $t1,1,CheckDate.False	
	bgt $t1,12,CheckDate.False
	#Check Day
	move $a0,$t1
	move $a1,$t2
	jal DayOfMonth
	blt $t0,1,CheckDate.False	
	bgt $t0,$v0,CheckDate.False
	j CheckDate.True
	#Tra ve
	CheckDate.False:
		li $v0,0
		j CheckDate.End
	CheckDate.True:
		li $v0,1
	CheckDate.End:
	#Cuoi thu tuc
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $t4,20($sp)
	lw $s0,24($sp)
	addi $sp,$sp,28

	jr $ra


#  ----------------------------- 			1		----------------------------------------
Date:
	#Dau thu tuc
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)

	#Than thu tuc
	lb $t0,0($a0)
	sb $t0,0($a3)
	lb $t0,1($a0)
	sb $t0,1($a3)
	
	addi $t1,$0,'/'
	sb $t1,2($a3)

	lb $t0,0($a1)
	sb $t0,3($a3)
	lb $t0,1($a1)
	sb $t0,4($a3)

	addi $t1,$0,'/'
	sb $t1,5($a3)

	lb $t0,0($a2)
	sb $t0,6($a3)
	lb $t0,1($a2)
	sb $t0,7($a3)
	lb $t0,2($a2)
	sb $t0,8($a3)
	lb $t0,3($a2)
	sb $t0,9($a3)

	move $v0, $a3
	#Cuoi thu tuc 
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	addi $sp, $sp, 12
	jr $ra

#  ----------------------------- 			2		----------------------------------------
strlen:
	#Dau thu tuc
	addi $sp, $sp,-20
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	sw $a0, 16($sp)
	#Than thu tuc
	la $t0,($a0)
	addi $t1,$0,0
	strlen.Loop:
		lb $t2,($t0)
		beqz $t2,strlen.End
		addi $t0,$t0,1
		addi $t1,$t1,1
		j strlen.Loop
	strlen.End:
	add $v0,$0,$t1

	#Cuoi thu tuc
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	lw $t2, 12($sp)
	lw $a0, 16($sp)
	addi $sp,$sp,20
	jr $ra

# $a0 : luu dia chi chuoi dich
# $a1 : luu dia chi chuoi nguon
# $a2 : so ky tu can sao chep
strcpy:
	#Dau thu tuc
	addi $sp, $sp,-16
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	
	#Than thu tuc
	la $t0, ($a0)
	la $t1, ($a1)
	addi $t2,$0,0

	strcpy.Loop:
		beq $t2,$a2,strcpy.End
		lb $t3,0($t1)
		sb $t3,0($t0)
		addi $t1,$t1,1
		addi $t0,$t0,1
		addi $t2,$t2,1
		j strcpy.Loop

	strcpy.End:

	la $v0,0($a0)
	
	#Cuoi thu tuc
	lw $ra, 0($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	lw $t2, 12($sp)
	addi $sp,$sp,16
	jr $ra

Convert:
	#Dau thu tuc	
	addi $sp,$sp,-28
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $a2,12($sp)
	sw $t0,16($sp)
	sw $t1,20($sp)
	sw $t2,24($sp)

	lw $t2,8($sp)
	blt $t2,'a',type_A
	# Upper case character 'type'
	addi $t2,$t2,-32
	sw $t2,8($sp)
	
	#Than thu tuc
	# Format : MM/DD/YYYY
	type_A:
		lw $t2,8($sp)
		bne $t2,'A',type_B

		la $a0,time_A
		lw $a1,4($sp)
		
		# load lai MM
		lb $t0,3($a1)
		sb $t0,0($a0)
		lb $t0,4($a1)
		sb $t0,1($a0)


		# load dau /
		lb $t0,2($a1)
		sb $t0,2($a0)	

		# load lai DD
		lb $t0,0($a1)
		sb $t0,3($a0)
		lb $t0,1($a1)
		sb $t0,4($a0)

		# load dau /
		lb $t0,5($a1)
		sb $t0,5($a0)
		
		# Load lai YYYY
		lb $t0,6($a1)
		sb $t0,6($a0)
		lb $t0,7($a1)
		sb $t0,7($a0)
		lb $t0,8($a1)
		sb $t0,8($a0)
		lb $t0,9($a1)
		sb $t0,9($a0)
		add $v0,$0,$a0

		j Convert.End

	# Format : Month DD, YYYY
	type_B:
		lw $t2,8($sp)
		bne $t2,'B',type_C

		lw $a0,4($sp)
		jal NameEachMonth
		
		# Sao chep chuoi vao time_B_C
		add $a1,$0,$v0
		add $a0,$0,$v0
		jal strlen
		add $a2,$0,$v0
		la $a0,time_B_C
		jal strcpy	
		add $v0,$v0,$a2
		
		addi $t0,$0,' '
		sb $t0,($v0)
		
		add $t2,$0,$a0
		la $a1,TIME1
		lb $t0,($a1)
		sb $t0,1($v0)
		lb $t0,1($a1)
		sb $t0,2($v0)

		addi $t0,$0,','
		sb $t0,3($v0)
		addi $t0,$0,' '
		sb $t0,4($v0)

		la $a0,5($v0)
		la $a1,6($a1)
		addi $a2,$0,4
		jal strcpy
		add $v0,$0,$t2

		j Convert.End

	# Format : Month DD, YYYY
	type_C:

		lw $a1,4($sp)
		la $t0,time_B_C
		# copy DD
		lb $t1,0($a1)
		sb $t1,0($t0)
		lb $t1,1($a1)
		sb $t1,1($t0)

		addi $t1,$0,' '
		sb $t1,2($t0)

		la $a0,TIME1
		jal NameEachMonth
		
		add $a0,$0,$v0
		add $a1,$0,$v0
		jal strlen
		add $a2,$0,$v0
		la $a0,3($t0)
		jal strcpy

		add $a0,$a0,$a2
		addi $t1,$0,','
		sb $t1,($a0)

		addi $t1,$0,' '
		sb $t1,1($a0)

		la $a1,TIME1
		la $a1,6($a1)
		la $a0,2($a0)
		addi $a2,$0,4
		jal strcpy
		add $v0,$0,$t0

		j Convert.End

	#Cuoi thu tuc
	Convert.End:	
		lw $ra,0($sp)
		lw $a0,4($sp)
		lw $a1,8($sp)
		lw $a2,12($sp)
		lw $t0,16($sp)
		lw $t1,20($sp)
		lw $t2,24($sp)
		addi $sp,$sp,28
		jr $ra

# ----------------------
	
NameEachMonth:

	#Dau thu tuc
	addi $sp,$sp,-12
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	
	#Than thu tuc
	jal Month
	add $a0,$0,$v0
	addi $a0,$a0,-1
	sll $a0,$a0,2

	la $a1,month_label
	add $a1,$a1,$a0
	lw $a0,($a1)
	jr $a0
	
	m1:
		la $v0,jan
		j NameEachMonth.End
	m2:
		la $v0,feb
		j NameEachMonth.End
	m3:
		la $v0,mar
		j NameEachMonth.End
	m4:
		la $v0,apr
		j NameEachMonth.End
	m5:
		la $v0,may
		j NameEachMonth.End
	m6:
		la $v0,jun
		j NameEachMonth.End
	m7:
		la $v0,jul
		j NameEachMonth.End
	m8:
		la $v0,aug
		j NameEachMonth.End
	m9:
		la $v0,sep
		j NameEachMonth.End
	m10:
		la $v0,oct
		j NameEachMonth.End
	m11:
		la $v0,nov
		j NameEachMonth.End
	m12:
		la $v0,dec
		j NameEachMonth.End
	
	NameEachMonth.End:
	
	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
    addi $sp,$sp,12
	jr $ra
#  ----------------------------- 			3		----------------------------------------

Day:
	#Dau thu tuc
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	
	#Than thu tuc
	lb $t0,0($a0)
	addi $t0,$t0,-48
	li $t2,10
	mul $t0,$t0,$t2
	lb $t1,1($a0)
	addi $t1,$t1,-48
	add $t0,$t0,$t1
	move $v0,$t0
	
	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	addi $sp,$sp,16
	jr $ra

Month:
	#Dau thu tuc
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	
	#Than thu tuc
	lb $t0,3($a0)
	addi $t0,$t0,-48
	li $t2,10
	mul $t0,$t0,$t2
	lb $t1,4($a0)
	addi $t1,$t1,-48
	add $t0,$t0,$t1
	move $v0,$t0
	
	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	addi $sp,$sp,16
	jr $ra

Year:
	#Dau thu tuc
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $a0,12($sp)
	
	#Than thu tuc
	la $a0,6($a0)
	jal Day
	move $t0,$v0
	li $t1,100
	mul $t0,$t0,$t1

	la $a0,2($a0)
	jal Day
	add $v0,$v0,$t0

	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $a0,12($sp)
	addi $sp,$sp,16
	jr $ra

LeapYear:
	#Dau thu tuc
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)

	#Than thu tuc
	move $s0,$a0

	#Kiem tra chia het 400
	la $t0,400
	div $s0,$t0
	mfhi $t0
	beq $t0,$0,LeapYear.True
	
	#Kiem tra chia het 4
	la $t1,4
	div $s0,$t1
	mfhi $t1
	beq $t1,$0,LeapYear.Continue #Neu chia het cho 4
	j LeapYear.False

	#Kiem tra khong chia het 100
	LeapYear.Continue:
		la $t2,100
		div $s0,$t2
		mfhi $t2 
		slt $t2,$0,$t2
		bne $t2,$0,LeapYear.True
	
	#Tra ve 0 neu nam k nhuan	
	LeapYear.False:
		la $v0,0
		j LeapYear.End	
	
	#Tra ve 1 neu nam nhuan
	LeapYear.True:
		la $v0,1
	LeapYear.End:

	#Cuoi thu tuc
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	addi $sp,$sp,20
	jr $ra

#  ----------------------------- 			4		----------------------------------------
Weekday:
	#Dau thu tuc
	addi $sp,$sp,-28
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $t4,20($sp)
	sw $t5,24($sp)

	#-Than thu tuc
	#1. Tinh d+ m + y + y/4 - y/100 + y/400
	#Luu day,month,year tu chuoi TIME1 vao t0,t1,t2
	jal Day 
	move $t0,$v0 #1.1 d
	jal Month
	move $t1,$v0
	jal Year
	move $t2,$v0
	#if thang <3 -> year -=1
	li $t3,3
	slt $t3,$t1,$t3
	sub $t2,$t2,$t3 #1.2 y
	#1.3 m
	beq $t1,1,Weekday.m0
	beq $t1,2,Weekday.m3
	beq $t1,3,Weekday.m2
	beq $t1,4,Weekday.m5
	beq $t1,5,Weekday.m0
	beq $t1,6,Weekday.m3
	beq $t1,7,Weekday.m5
	beq $t1,8,Weekday.m1
	beq $t1,9,Weekday.m4
	beq $t1,10,Weekday.m6
	beq $t1,11,Weekday.m2
	beq $t1,12,Weekday.m4
	Weekday.m0:
		li $t1,0
		j Weekday.break
	Weekday.m1:
		li $t1,1
		j Weekday.break
	Weekday.m2:
		li $t1,2
		j Weekday.break
	Weekday.m3:
		li $t1,3
		j Weekday.break
	Weekday.m4:
		li $t1,4
		j Weekday.break
	Weekday.m5:
		li $t1,5
		j Weekday.break
	Weekday.m6:
		li $t1,6
		j Weekday.break
	Weekday.break:
	
	#1.4 y/4, y/100, y/400
	la $t3,4
	div $t2,$t3
	mflo $t3	 # y/4=$t3
	la $t4,100
	div $t2,$t4
	mflo $t4 # y/100=$t4
	la $t5,400
	div $t2,$t5
	mflo $t5 # y/400=$t5

	#End 1.Tinh $t0 = d + m + y + y/4 - y/100 + y/400
	add $t0,$t0,$t1
	add $t0,$t0,$t2
	add $t0,$t0,$t3
	sub $t0,$t0,$t4
	add $t0,$t0,$t5

	#Tinh $t0 = $t0 % 7
	la $t1,7
	div $t0,$t1
	mfhi $t0
	#Convert
	beq $t0,0,Weekday.Sun
	beq $t0,1,Weekday.Mon
	beq $t0,2,Weekday.Tue
	beq $t0,3,Weekday.Wed
	beq $t0,4,Weekday.Thu
	beq $t0,5,Weekday.Fri
	beq $t0,6,Weekday.Sat
	Weekday.Sun:
		la $v0,sun
		j Weekday.End
	Weekday.Mon:
		la $v0,mon
		j Weekday.End
	Weekday.Tue:
		la $v0,tue
		j Weekday.End
	Weekday.Wed:
		la $v0,wed
		j Weekday.End
	Weekday.Thu:
		la $v0,thu
		j Weekday.End
	Weekday.Fri:
		la $v0,fri
		j Weekday.End
	Weekday.Sat:
		la $v0,sat
		j Weekday.End
	Weekday.End:

	#Cuoi thu tuc
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $t4,20($sp)
	lw $t5,24($sp)
	addi $sp,$sp,28
	jr $ra

#  ----------------------------- 			5		----------------------------------------
CountDay:
	#Dau thu tuc
	addi $sp,$sp,-40
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $s0,16($sp)
	sw $s1,20($sp)
	sw $t4,24($sp)
	sw $t3,28($sp)
	sw $a0,32($sp)
	sw $a1,36($sp)

	#Than thu tuc
	li $s0,0	# $s0 dung de dem so ngay
	move $s1,$a0
	jal Day 
	move $t0,$v0
	jal Month
	move $t1,$v0
	addi $t1,$t1,-1
	jal Year
	move $t2,$v0	#Lay ra Date cua Time 1
	addi $t2,$t2,-1
	li $a0,0
	bgt $t2,0,CountDay.Loop
	j CountDay.Next
	CountDay.Loop:
		addi $a0,$a0,1
		jal LeapYear
		beq $v0,1,CountDay.D366
		beq $v0,0,CountDay.D365
		j CountDay.Next
	CountDay.D366:
		addi $s0,$s0,366
		blt $a0,$t2,CountDay.Loop
		j CountDay.Next
	CountDay.D365:
		addi $s0,$s0,365
		blt $a0,$t2,CountDay.Loop
		j CountDay.Next
	CountDay.Next:
		ble $t1,0,CountDay.End
	 	li $t4,0
		addi $t2,$t2,1
	CountDay.DayMonth:
		addi $t4,$t4,1
		move $a0,$t4
		move $a1,$t2
		jal DayOfMonth
		move $t3,$v0
		add $s0,$s0,$t3
		blt $t4,$t1,CountDay.DayMonth
	CountDay.End:	
		add $v0,$t0,$s0
		addi $v0,$v0,-1

	#Cuoi Thu Tuc
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $s0,16($sp)
	lw $s1,20($sp)
	lw $t4,24($sp)
	lw $t3,28($sp)
	lw $a0,32($sp)
	lw $a1,36($sp)
	addi $sp,$sp,40
	jr $ra
#  ----------------------------- 			6		----------------------------------------
CanChi:
	#Dau thu tuc
	addi $sp,$sp,-44
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $t4,20($sp)
	sw $a1,28($sp)
	sw $s0,32($sp)
	sw $s1,36($sp)
	sw $s2,40($sp)

	#Than thu tuc
	addi $t1,$a0,6				
	li $t0,10
	div $t1,$t0
	mfhi $t1		#t1 = (nam+6)%10

	addi $t2,$a0,8
	li $t0,12
	div $t2,$t0
	mfhi $t2		#t2 = (nam+8)%12

	li $t4,4
	mul $t1,$t1,$t4		#t1 = t1*4
	mul $t2,$t2,$t4		#t2 = t2*4
	
	la $s0,canchi		#"---- ----"
	la $s1,can			
	la $s2,chi

	la $a1,($s0)

	add $s1,$s1,$t1		#t1($s1)
	add $s2,$s2,$t2		#t2($s2)
	
	li $t0,0			
	CanChi.Loop1:		#"---- ----" -> "  Ky ----"
		beq $t0,$t4,CanChi.Continue
		lb $t3,0($s1)
		sb $t3,0($a1)
		addi $s1,$s1,1
		addi $a1,$a1,1
		addi $t0,$t0,1
		j CanChi.Loop1
	CanChi.Continue:
		addi $a1,$a1,1
		li $t0,0	

	CanChi.Loop2:		#"---- ----" -> "  Ky hoi "
		beq $t0,$t4,CanChi.End
		lb $t3,0($s2)
		sb $t3,0($a1)
		addi $s2,$s2,1
		addi $a1,$a1,1
		addi $t0,$t0,1
		j CanChi.Loop2	
	CanChi.End:
	la $v0,($s0)
	
	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $t4,20($sp)
	lw $a1,28($sp)
	lw $s0,32($sp)
	lw $s1,36($sp)
	lw $s2,40($sp)
	addi $sp,$sp,44
	jr $ra

#  ----------------------------- 			7		----------------------------------------
DayDiff:
	#Dau thu tuc
	addi $sp,$sp,-8
	sw $ra,0($sp)
	sw $t0,4($sp)
	
	#Than thu tuc
	jal CountDay
	move $t0,$v0
	move $a0,$a1
	jal CountDay

	sub $v0,$t0,$v0
	blez $v0,DayDiff.Abs
	j DayDiff.End
	DayDiff.Abs:
		li $t0,-1
		mul $v0,$v0,$t0
	DayDiff.End:

	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $t0,4($sp)
	addi $sp,$sp,8
	jr $ra
#  ----------------------------- 			8		----------------------------------------
PreNextLeapYear:
	#Dau thu tuc
	addi $sp,$sp,-16
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)

	#Than thu tuc
	jal Year
	move $t0,$v0
	#Tim nam nhuan Pre
	addi $t1,$t0,0
	PreNextLeapYear.Pre:
		addi $t1,$t1,-1
		move $a0,$t1
		jal LeapYear 
		bne $v0,1,PreNextLeapYear.Pre
		move $s0,$t1
	#Tim nam nhuan Next
	addi $t1,$t0,0
	PreNextLeapYear.Next:
		addi $t1,$t1,1
		move $a0,$t1
		jal LeapYear 
		bne $v0,1,PreNextLeapYear.Next

	# Tra ve v0,v1
	move $v1,$t1
	move $v0,$s0
	
	#Cuoi thu tuc
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	addi $sp,$sp,16
	jr $ra

#  ----------------------------- 			9 		----------------------------------------
ReadFile:
	#Dau thu tuc
	addi $sp,$sp,-20
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $a2,12($sp)
	sw $s0,16($sp)
 	
	#Than Thu tuc
	li $v0,13          # system call for open file
	la $a0,infile      # input file name
	li $a1,0           # flag for reading
	li $a2,0           # mode is ignored
	syscall               # open a file 
	move $s0, $v0         # save the file descriptor  

	# reading from file just opened
	li   $v0, 14        # system call for reading from file
	move $a0, $s0       # file descriptor 
	la   $a1, buffer    # address of buffer from which to read
	li   $a2,  1024       # hardcoded buffer length
	syscall             # read from file

	# close file input
	add $v0,$0,16
	add $a0,$0,$s0      # load file descriptor
	syscall
	
	la $v0,buffer

	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $a2,12($sp)
	lw $s0,16($sp)
	addi $sp,$sp,20
	
	jr $ra

ProcessFile:
	#Dau thu tuc
	addi $sp,$sp,-20
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $a2,12($sp)
	sw $s0,16($sp)

	#Than Thu tuc
	# load vao TIME1 va TIME2
	lw $a1,4($sp)
	la $a0,TIME1
	addi $a2,$0,10
	jal strcpy
	
	add $t0,$0,'/'
	sb $t0,2($a0)
	sb $t0,5($a0)

	la $a0,TIME2
	addi $a1,$a1,12
	addi $a2,$0,10
	jal strcpy
	add $t0,$0,'/'
	sb $t0,2($a0)
	sb $t0,5($a0)	
	
	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $a2,12($sp)
	lw $s0,16($sp)
	addi $sp,$sp,20
	jr $ra

WriteFile:
	#Dau thu tuc
	addi $sp,$sp,-28
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $a2,12($sp)
	sw $s0,16($sp)
	sw $t0,20($sp)
	sw $t1,24($sp)

	#Than Thu tuc
	# open file output
	add $v0,$0,13
	la $a0,outfile   # file output
	li $a1,1      # 0: read, 1: write
	li $a2,0    #  mode is ignored
	syscall

	move $s0,$v0
	#Check TIME1, TIME2
	la $a0,TIME1
	jal CheckDate
	move $t0,$v0
	la $a0,TIME2
	jal CheckDate

	beq $t0,1,WriteFile.Check21 #TIME1 true
	j WriteFile.Check22 #TIME1 false
	WriteFile.Check21:
		beq $v0,1,WriteFile.True #TIME2 true
		j WriteFile.False2 #TIME2 false
	WriteFile.Check22:
		beq $v0,1,WriteFile.False1 #TIME2 true
		j WriteFile.False #TIME2 false
	WriteFile.False1:
		li $v0,15
		move $a0, $s0 
  		la $a1,acfileerror1
  		li $a2,25
		syscall
		j WriteFile.End
	WriteFile.False2:
		li $v0,15
		move $a0, $s0 
  		la $a1,acfileerror2
  		li $a2,25
		syscall
		j WriteFile.End
	WriteFile.False:
		li $v0,15
		move $a0, $s0 
  		la $a1,acfileerror
  		li $a2,35
		syscall
		j WriteFile.End
	WriteFile.True:
	# Write to file just opened
	# 1.
  	li $v0,15	# system call for write to file
  	move $a0, $s0	# file descriptor 
  	la $a1,acfile1	# address of buffer from which to write
  	li $a2,4		# hardcoded buffer length
  	syscall

	li $v0,15
	move $a0,$s0 
	la $a1,TIME1  
  	li $a2,10     
  	syscall  
	
	li $v0,15 
	move $a0, $s0  
  	la $a1,acfile
  	li $a2,2
  	syscall             
	# 2.
	# 2.A
  	li $v0,15
	move $a0, $s0 
  	la $a1,acfile2a
  	li $a2,4
	syscall

	la $a0,TIME1
	li $a1,'A'
	jal Convert
	move $t0,$v0

	li $v0,15
	move $a0,$s0 
	move $a1,$t0   
	li $a2,10  
  	syscall

	li $v0,15  
	move $a0,$s0  
  	la $a1,acfile  
  	li $a2, 2   
  	syscall  
    
      	# 2.B
  	li $v0,15
	move $a0, $s0 
  	la $a1,acfile2b
  	li $a2,4
	syscall

	la $a0,TIME1
	li $a1,'B'
	jal Convert
	move $t0,$v0
	move $a0,$t0
	jal strlen
	move $t1,$v0

	li $v0,15
	move $a0,$s0 
	move $a1,$t0   
	move $a2,$t1
  	syscall

	li $v0,15  
	move $a0,$s0  
  	la $a1,acfile  
  	li $a2,2  
  	syscall 
	  
        # 2.C
  	li $v0,15
	move $a0, $s0 
  	la $a1,acfile2c
  	li $a2,4
	syscall

	la $a0,TIME1
	li $a1,'C'
	jal Convert
	move $t0,$v0
	move $a0,$t0
	jal strlen
	move $t1,$v0

	li $v0,15
	move $a0, $s0 
	move $a1,$t0   
	move $a2,$t1
  	syscall
	li $v0,15  
	move $a0,$s0  
  	la $a1,acfile  
  	li $a2,2  
  	syscall
 
	# 3.
  	li $v0,15
	move $a0, $s0 
  	la $a1,acfile3
  	li $a2,3
	syscall

	la $a0,TIME1
	jal Year
 	move $a0,$v0
	move $t1,$v0
	jal IntToStr
	move $a0,$v0
	move $t0,$v0
	jal strlen
	move $t2,$v0
	
	li $v0,15
	move $a0, $s0 
  	move $a1,$t0
  	move $a2,$t2
	syscall
	move $a0,$t1
	jal LeapYear
	beq $v0,1,_leap
	_noleap:
		li $v0,15
		move $a0, $s0 
  		la $a1,noleap
  		li $a2,14
		syscall
		j _end
	_leap:
		li $v0,15
		move $a0, $s0 
  		la $a1,leap
  		li $a2,13
		syscall
	_end:
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile  
  	li $a2, 2   
  	syscall

	#4. 
	li $v0,15
	move $a0, $s0 
  	la $a1,acfile4
  	li $a2,3
	syscall
	la $a0,TIME1

	li $v0,15
	move $a0,$s0 
	la $a1,TIME1 
	li $a2,10  
  	syscall

	la $a0,TIME1
	jal Weekday
	move $t0,$v0
	li $v0, 15  
	move $a0, $s0  
  	move $a1,$t0  
  	li $a2, 13 
  	syscall 
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile  
  	li $a2, 2   
  	syscall 

	#5.
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile5a  
  	li $a2, 23  
  	syscall	
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile5b
  	li $a2, 10  
  	syscall	

	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile5c
  	li $a2, 10  
  	syscall
	
	li $v0,15
	move $a0, $s0       
	la $a1,TIME1  
  	li $a2,10     
  	syscall  
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile5d
  	li $a2, 4  
  	syscall
	
	la $a0,TIME1
	jal CountDay
	move $a0,$v0
	jal IntToStr
	move $t0,$v0
	move $a0,$t0
	jal strlen
	move $t1,$v0 

	li $v0,15
	move $a0, $s0       
	move $a1,$t0  
  	move $a2, $t1     
  	syscall  
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile5e
  	li $a2, 5  
  	syscall
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile  
  	li $a2, 2   
  	syscall

	#6.
	li $v0,15
	move $a0, $s0 
  	la $a1,acfile6a
  	li $a2,3
	syscall

	la $a0,TIME1
	jal Year
 	move $a0,$v0
	move $t1,$v0
	jal IntToStr
	move $a0,$v0
	move $t0,$v0
	jal strlen
	move $t2,$v0
	
	li $v0,15
	move $a0, $s0 
  	move $a1,$t0
  	move $a2,$t2
	syscall
	
	li $v0,15
	move $a0, $s0 
  	la $a1,acfile6b
  	li $a2,8
	syscall
	
	la $a0,TIME1
	jal Year
	move $a0,$v0
	jal CanChi
	move $t0,$v0
	move $a0,$t0
	jal strlen
	move $t1,$v0
	
	li $v0,15
	move $a0, $s0       
	move $a1,$t0  
  	move $a2, $t1  
  	syscall 
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile  
  	li $a2, 2   
  	syscall
	
	#7.
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile7  
  	li $a2, 23  
  	syscall	
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,TIME1
  	li $a2, 10  
  	syscall	

	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile5c
  	li $a2, 10  
  	syscall
	
	li $v0,15
	move $a0, $s0       
	la $a1,TIME2  
  	li $a2,10     
  	syscall  
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile5d
  	li $a2, 4  
  	syscall
	
	la $a0,TIME1
	la $a1,TIME2
	jal DayDiff
	move $a0,$v0
	jal IntToStr
	move $t0,$v0
	move $a0,$t0
	jal strlen
	move $t1,$v0 
	li $v0,15
	move $a0, $s0       
	move $a1,$t0  
  	move $a2, $t1     
  	syscall  
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile5e
  	li $a2, 5  
  	syscall
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile  
  	li $a2, 2   
  	syscall
	
	#8.
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile8a
  	li $a2, 25  
  	syscall

	la $a0,TIME1
	jal Year
 	move $a0,$v0
	move $t1,$v0
	jal IntToStr
	move $t0,$v0
	move $a0,$v0
	jal strlen
	move $t2,$v0
	li $v0,15
	move $a0, $s0 
  	move $a1,$t0
  	move $a2,$t2
	syscall
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile8b
  	li $a2, 9 
  	syscall
	
	la $a0,TIME1
	
	jal PreNextLeapYear
	move $a0,$v0
	
	jal IntToStr
	move $t0,$v0
	move $a0,$v0
	jal strlen
	move $t2,$v0
	li $v0,15
	move $a0, $s0 
  	move $a1,$t0
  	move $a2,$t2
	syscall
	
	li $v0, 15  
	move $a0, $s0  
  	la $a1,acfile8c
  	li $a2, 4 
  	syscall	

	move $a0,$v1
	jal IntToStr
	move $t0,$v0
	move $a0,$v0
	jal strlen
	move $t2,$v0
	
	li $v0,15
	move $a0, $s0 
  	move $a1,$t0
  	move $a2,$t2
	syscall

	WriteFile.End:
	# close file input
	add $v0,$0,16
	add $a0,$0,$s0
	syscall

	#Cuoi thu tuc
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $a2,12($sp)
	lw $s0,16($sp)
	lw $t0,20($sp)
	lw $t1,24($sp)
	addi $sp,$sp,28

	jr $ra

IntToStr:
	#Dau thu tuc
	addi $sp,$sp,-24
	sw $ra,($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $s0,12($sp)
	sw $t1,16($sp)
	sw $t0,20($sp)

	#Than thu tuc
	la $s0,ssr
	lb $t0,($s0)
	bne $t0,0,IntToStr.Zero
	j IntToStr.ZeroE
	IntToStr.Zero:
		sb $0,($s0)
		addi $s0,$s0,1
		lb $t0,($s0)
		bne $t0,0,IntToStr.Zero
	IntToStr.ZeroE:
	li $t0,0
	li $t1,10
	lw $a0,4($sp)
	la $s0,ssr
	bnez $a0, IntToStr.Loop1
	addi $t0,$0,'0'
	sb $t0,0($s0)
	j IntToStr.Exit2
	IntToStr.Loop1:
		beqz $a0,IntToStr.Exit1
		div $a0,$t1
		mflo $a0
		add $t0,$t0,1
		j IntToStr.Loop1
	IntToStr.Exit1:
	lw $a0,4($sp)
	
	add $s0,$s0,$t0
	IntToStr.Loop2:
		beqz $a0,IntToStr.Exit2
		div $a0,$t1
		mflo $a0
		addi $t0,$t0,-1
		addi $s0,$s0,-1
		mfhi $t2
		addi $t2,$t2,48
		sb $t2,0($s0)
		j IntToStr.Loop2
	IntToStr.Exit2:
	la $v0,ssr

	# Cuoi thu tuc	
	lw $ra,($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $s0,12($sp)
	sw $t1,16($sp)
	sw $t0,20($sp)
	addi $sp,$sp,24
	jr $ra