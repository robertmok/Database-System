?#!/bin/sh
. db2init
db2 connect to db2data
TITLE="          FAMILY PHARM MENU          "
CREATE_TABLES_TITLE="          CREATE TABLES MENU          "
POPULATE_TABLES_TITLE="          POPULATE TABLES MENU          "
DROP_TABLES_TITLE="          DROP TABLES MENU          "
QUERIES_TITLE1="           QUERIES MENU 1          "
QUERIES_TITLE2="           QUERIES MENU 2          "
QUERIES_TITLE3="           QUERIES MENU 3          "
ENTER_QUERIES_TITLE="      QUERIES MENU          "
QUERY1="1. Display customer information from Prescription Customers table."
QUERY2="2. Display employee information from Scheduling table."
QUERY3="3. Display employee information from Employee Record table."
QUERY4="4. Display products information from Inventory table."
QUERY5="5. Display sales information from Prescription Sales table."

QUERY6="6. Display employee id who works on Wednesday to Sunday from 11-7 and was hired in April."
QUERY7="7. Display all employee information and date of purchase of who have made prescription sales."
QUERY8="8. Display any employee information who works as a cashier"

QUERY9="9. Display all customer information who made a purchase between the amount of \$5 and \$25."
QUERY10="10. Display all customer information except the amount they pay is between \$15 and \$20."
QUERY11="11. Display all customer information sorted by the amount they paid in ascending order."

QUERY12="12. Display total of the sales where the quantity of product sold is 1."
QUERY13="13. Display the most expensive product sold."
QUERY14="14. Display the average of all products sold."

QUERY15="15. Display the number of employee who was hired in the 25th of a month from Employee Record table."
QUERY16="16. Display average amount paid by customers of each type of payment."
QUERY17="17. Display the number of products sold for each employee"

QUERY18="18. Add new record into prescription sales table."
QUERY19="19. Update employee id 116's date of termination to 12/12/12."
QUERY20="20. Delete all record from inventory table where quantity is 14."
QUERY21="21. Create the view of all information about every employee."
QUERY22="22. Create the view of all information about every pharmacist."
QUERY23="23. Delete the view of all information about every employee."
QUERY24="24. Delete the view of all information about every pharmacist."

QUERY25="25. Display unique customer id and product type where total payment is more than \$25."
QUERY26="26. Display employee name that is not David and Leo, and employee id is 112,114,116, or 118."
QUERY27="27. Display all customers who made a prescription sale purchase."
QUERY28="28. Display the customer with highest product quantity purchase."
QUERY29="29. Display the lowest payment from prescription sales table."

QUERY30="30. Create index of EN grouped by EI from Employee record table"
QUERY31="31. Assertion to make sure min product quantity is >= 10 in inventory"
QUERY32="32. A trigger to send an error message if product quantity is increased by more than 50%"
QUERY33="33. Display the second highest product quantity"
QUERY34="34. A trigger that limit max product quantity to 150 if it exceeds 150"
QUERY35="35. Display the 3 highest product quantity"

MENU1="1. Create a table";
MENU2="2. Populate a table";
MENU3="3. Drop a table";
MENU4="4. Queries";
MENU5="5. Manual Queries";
MENU6="6. Quit";

displayMenu(){
        clear
        echo $TITLE
        echo
        echo $MENU1
        echo $MENU2
        echo $MENU3
        echo $MENU4
        echo $MENU5
        echo $MENU6
        echo
        echo "Please ENTER menu choice (1-6)";
}

prescriptionCustomerCreate(){
	db2 "  CREATE TABLE prescriptionCustomer(
    CID INTEGER NOT NULL,
    CNAME CHAR(20) NOT NULL,
    CTELE BIGINT NOT NULL,
    CADDR CHAR(40) NOT NULL,
    CHLTHCRD INTEGER NOT NULL,
    PRIMARY KEY(CID)
	)"
db2 "create trigger pctrig after insert on prescriptionCustomer
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('prescriptionCustomer','insert');
end"
db2 "create trigger pcutrig after update on prescriptionCustomer
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('prescriptionCustomer','modify');
end"
db2 "create trigger pcdtrig after delete on prescriptionCustomer
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('prescriptionCustomer','delete');
end"
	echo "A prescription customer table has been created."
}
prescriptionCustomerPopulate(){
	while read var1 var2 var3 var4 var5
	do
		db2 "insert into prescriptionCustomer 
values($var1,$var2,$var3,$var4,$var5)"
	done < prescriptionCustomers.txt
	echo "A prescription customer table has been populated."
}
prescriptionCustomerDrop(){
	db2 "DROP TABLE prescriptionCustomer"
	db2 "DROP trigger pctrig"
	db2 "DROP trigger pcutrig"
	db2 "DROP trigger pcdtrig"
	echo "A prescription customer table has been dropped."
}
prescriptionSalesCreate(){
	db2 "CREATE TABLE prescriptionSales ( 
	SID INTEGER NOT NULL,
	CID INTEGER NOT NULL,
	PYMT INTEGER NOT NULL,
	PP INTEGER NOT NULL,
	DOPUR CHAR(10) NOT NULL,
	QP INTEGER NOT NULL,
	EI INTEGER NOT NULL,
	TOP CHAR(10) NOT NULL,
      PRIMARY KEY(SID),
	  FOREIGN KEY(EI) references employee_record
	)"
db2 "create trigger pstrig after insert on prescriptionSales
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('prescriptionSales','insert');
end"
db2 "create trigger psutrig after update on prescriptionSales
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('prescriptionSales','modify');
end"
db2 "create trigger psdtrig after delete on prescriptionSales
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('prescriptionSales','delete');
end"
	echo "A prescription sales table has been created."
}
prescriptionSalesPopulate(){
	while read var1 var2 var3 var4 var5 var6 var7 var8
	do
		db2 "insert into prescriptionSales 
values($var1,$var2,$var3,$var4,$var5,$var6,$var7,$var8)"
	done < prescriptionSales.txt
	echo "A prescription sales table has been populated."
}
prescriptionSalesDrop(){
	db2 "DROP TABLE prescriptionSales"
	db2 "DROP trigger pstrig"
	db2 "DROP trigger psutrig"
	db2 "DROP trigger psdtrig"
	echo "A prescription sales table has been dropped."
}
employeeRecordCreate(){
	db2 "CREATE TABLE employee_record (
    EI INTEGER NOT NULL,
    EN CHAR(40) NOT NULL,
	DOE CHAR(10) NOT NULL,
    DOT CHAR(20) NOT NULL,
	BAI INTEGER NOT NULL,
    PRIMARY KEY(EI)
	)"
db2 "create trigger ertrig after insert on employee_record
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('employee_record','insert');
end"
db2 "create trigger erutrig after update on employee_record
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('employee_record','modify');
end"
db2 "create trigger erdtrig after delete on employee_record
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('employee_record','delete');
end"
	echo "An employee records table has been created."
}
employeeRecordPopulate(){
	while read var1 var2 var3 var4 var5
	do
		db2 "insert into employee_record 
values($var1,$var2,$var3,$var4,$var5)"
	done < employeeRecord.txt
	echo "An employee records table has been populated."
}
employeeRecordDrop(){
	db2 "DROP TABLE employee_record"
	db2 "DROP trigger ertrig"
	db2 "DROP trigger erutrig"
	db2 "DROP trigger erdtrig"
	echo "A employee records table has been dropped."
}
schedulingCreate(){
	db2 "CREATE TABLE scheduling(
    EI INTEGER NOT NULL,
    PSTN CHAR(20) NOT NULL,
    WS CHAR(50) NOT NULL,
    PRIMARY KEY(EI)
	)"
db2 "create trigger strig after insert on scheduling
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('scheduling','insert');
end"
db2 "create trigger sutrig after update on scheduling
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('scheduling','modify');
end"
db2 "create trigger sdtrig after delete on scheduling
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('scheduling','delete');
end"
	echo "A scheduling table has been created."
}
schedulingPopulate(){
	while read var1 var2 var3
	do
		db2 "insert into scheduling values($var1,$var2,$var3)"
	done < scheduling.txt
	echo "A scheduling table has been populated."
}
schedulingDrop(){
	db2 "DROP TABLE scheduling"
	db2 "DROP trigger strig"
	db2 "DROP trigger sutrig"
	db2 "DROP trigger sdtrig"
	echo "A scheduling table has been dropped."
}
inventoryCreate(){
	db2 "CREATE TABLE inventory (
    IN CHAR(30) NOT NULL,
    PNum INTEGER NOT NULL,
    QTY INTEGER NOT NULL,
	DA CHAR(9) NOT NULL,
    PRIMARY KEY(IN)
	)"
db2 "create trigger itrig after insert on inventory
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('inventory','insert');
end"
db2 "create trigger iutrig after update on inventory
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('inventory','modify');
end"
db2 "create trigger idtrig after delete on inventory
for each row mode db2sql
begin atomic
insert into transaction(TN,OP) values('inventory','delete');
end"
	echo "An inventory table has been created."
}
inventoryPopulate(){
	while read var1 var2 var3 var4
	do
		db2 "insert into inventory 
values($var1,$var2,$var3,$var4)"
	done < inventory.txt
	echo "An inventory table has been populated."
}
inventoryDrop(){
	db2 "DROP TABLE inventory"
	db2 "DROP trigger itrig"
	db2 "DROP trigger iutrig"
	db2 "DROP trigger idtrig"
	echo "An inventory table has been dropped."
}
transactionCreate(){
	db2 "CREATE TABLE transaction (
    TID INTEGER NOT NULL,
    TN CHAR(30) NOT NULL,
    OP CHAR(10) NOT NULL,
    PRIMARY KEY(TID)
	)"
# automatic insert unique primary key into transaction table every time before an insert
db2 "create sequence trans_seq as int start with 1 increment by 1"
db2 "create trigger taction no cascade before insert on
transaction referencing new as n for each row set
n.TID=nextval for trans_seq"
	echo "A transaction table has been created."
}
transactionDrop(){
	db2 "DROP TABLE transaction"
	db2 "DROP sequence trans_seq"
	db2 "DROP TRIGGER taction"
	echo "A transaction table has been dropped."
}

queriesMenu1(){
	clear
	while true
	do
		echo
		echo $QUERIES_TITLE1
		echo
		echo "Please select a query."
		echo $QUERY1
		echo $QUERY2
		echo $QUERY3
		echo $QUERY4
		echo $QUERY5
        	echo $QUERY6
		echo $QUERY7
		echo $QUERY8
		echo $QUERY9
		echo $QUERY10
		echo $QUERY11
		echo $QUERY12
		echo "M. More Queries"
		echo "Q. RETURN TO MAIN MENU"
		echo
		echo "Please select a NUMBER or KEY and press ENTER"
		read answer
		case $answer in
			1)echo $QUERY1
				db2 "select CID,CNAME,CTELE,CADDR,CHLTHCRD from prescriptionCustomer";;
			2)echo $QUERY2
				db2 "select EI,PSTN,WS from scheduling";;
			3)echo $QUERY3
				db2 "select EI,EN,DOE,DOT,BAI from employee_record";;
			4)echo $QUERY4
				db2 "select IN,PNum,QTY,DA from inventory";;
			5)echo $QUERY5
				db2 "select CID,PYMT,PP,DOPUR,QP,EI,TOP from prescriptionSales";;
			6)echo $QUERY6
				db2 "select EI from employee_record where DOE LIKE '04%' union select EI from scheduling where WS = 'Wed-Sun%11-7' ";;
			7)echo $QUERY7
				db2 "select employee_record.EI,employee_record.EN,employee_record.DOE,prescriptionSales.DOPUR from employee_record,prescriptionSales where employee_record.EI = prescriptionSales.EI";;
			8)echo $QUERY8
				db2 "select EI,WS from scheduling where PSTN = 'Cashier'";;
			9)echo $QUERY9
				db2 "select CID,PP,PYMT from prescriptionSales where PYMT BETWEEN 5 AND 25";;
			10)echo $QUERY10
				db2 "select CID,PP,PYMT from prescriptionSales where PYMT NOT BETWEEN 15 AND 20";;
			11)echo $QUERY11
				db2 "select CID,PP,PYMT from prescriptionSales ORDER BY 3";;
			12)echo $QUERY12
				db2 "select SUM(PYMT) AS sum from prescriptionSales where QP = 1";;
			m|M)clear
				queriesMenu2;;
			q|Q)clear
				break;;
			*)echo Invalid Choice;;
		esac
	done
}

queriesMenu2(){
	clear
	while true
	do
		echo
		echo $QUERIES_TITLE2
		echo
		echo "Please select a query."
		echo $QUERY13
		echo $QUERY14
		echo $QUERY15
		echo $QUERY16
		echo $QUERY17
		echo $QUERY18
		echo $QUERY19
		echo $QUERY20
		echo $QUERY21
		echo $QUERY22
		echo $QUERY23
		echo $QUERY24
		echo "M. More Queries"
		echo "Q. RETURN TO PREVIOUS QUERY MENU 1"
		echo
		echo "Please select a NUMBER or KEY and press ENTER"
		read answer
		case $answer in
			13)echo $QUERY13
				db2 "select MAX(PYMT) AS max from prescriptionSales";;
			14)echo $QUERY14
				db2 "select AVG(PYMT) AS avg from prescriptionSales";;
			15)echo $QUERY15
				db2 "select COUNT(*) AS employees from employee_record where DOE LIKE '%25%'";;
			16)echo $QUERY16
				db2 "select TOP, COUNT(*) AS count, AVG(PYMT) as averagePYMT from prescriptionSales GROUP BY TOP HAVING count(*) > 1 order by TOP";;
			17)echo $QUERY17
				db2 "select EI,count(prescriptionSales.EI) AS prescription_sales from prescriptionSales,prescriptionCustomer where prescriptionSales.CID=prescriptionCustomer.CID group by prescriptionSales.EI";;
			18)echo $QUERY18
				db2 "insert into prescriptionSales values(7,001,40.00,99305,'2014-9-15',2,118,'Debit')";;
			19)echo $QUERY19
				db2 "update employee_record set DOT='12/12/12' where EI=116";;
			20)echo $QUERY20
				db2 "delete from inventory where QTY = 14";;
			21)echo $QUERY21
				db2 "create view allEmployees as (select employee_record.EI,employee_record.EN,employee_record.DOE,employee_record.DOT,employee_record.BAI, scheduling.PSTN, scheduling.WS from employee_record, scheduling where employee_record.EI = scheduling.EI)";;
			22)echo $QUERY22
				db2 "create view allPharmacists as (select employee_record.EI,employee_record.EN,employee_record.DOE,employee_record.DOT,employee_record.BAI, scheduling.PSTN, scheduling.WS from employee_record, scheduling where employee_record.EI = scheduling.EI AND scheduling.PSTN = 'Pharmacist')";;
			23)echo $QUERY23
				db2 "drop view allEmployees";;
			24)echo $QUERY24
				db2 "drop view allPharmacists";;
			m|M)clear
				queriesMenu3;;
			q|Q)clear
				break;;
			*)echo Invalid Choice;;
		esac
	done
}

queriesMenu3(){
	clear
	while true
	do
		echo
		echo $QUERIES_TITLE3
		echo
		echo "Please select a query."
		echo $QUERY25
		echo $QUERY26
		echo $QUERY27
		echo $QUERY28
		echo $QUERY29
		echo $QUERY30
		echo $QUERY31
		echo $QUERY32
		echo $QUERY33
		echo $QUERY34
		echo $QUERY35
		echo "Q. RETURN TO PREVIOUS QUERY MENU 2"
		echo
		echo "Please select a NUMBER or KEY and press ENTER"
		read answer
		case $answer in
			25)echo $QUERY25
				db2 "select DISTINCT x.CID,x.PP from prescriptionSales x,prescriptionSales y where x.PYMT*x.QP > y.PYMT*y.QP+25";;
			26)echo $QUERY26
				db2 "select EN from employee_record where EI IN (112,114,116,118) and EN not in ('David','Leo')";;
			27)echo $QUERY27
				db2 "select CID,CNAME from prescriptionCustomer WHERE EXISTS (select * from prescriptionSales where prescriptionCustomer.CID=prescriptionSales.CID)";;
			28)echo $QUERY28
				db2 "select CID from prescriptionSales x where QP >= ALL (select QP from prescriptionSales y)";;
			29)echo $QUERY29
				db2 "select MIN(PYMT) as minimum_prescriptionSales from prescriptionSales";;
			30)echo $QUERY30
				db2 "create INDEX en_by_ei ON employee_record (EI,EN)";;
			31)echo $QUERY31
				db2 "alter table inventory add constraint min_productQuantity check (QTY >= 10)";;
			32)echo $QUERY32
				db2 "create trigger qty_increase after update of QTY on inventory referencing new as new_inventory old as old_inventory for each row mode db2sql when (new_inventory.QTY > old_inventory.QTY*1.5) begin atomic signal sqlstate '75001' ('Invalid increase to QTY - Exceed 50%'); end";;
			33)echo $QUERY33
				db2 "select distinct QTY as SECOND_Highest_QTY from inventory x where 2 = (select count(distinct QTY) from inventory y where x.QTY <= y.QTY)";;
			34)echo $QUERY34
				db2 "create trigger max_QTY after update of QTY on inventory referencing new as n old as o for each row mode db2sql when (n.QTY > 150)begin atomic update inventory set QTY=150 where QTY>150; end";;
			35)echo $QUERY35
				db2 "select distinct QTY from inventory x where 3 >= (select count(distinct QTY) from inventory y where x.QTY <= y.QTY) order by x.QTY desc";;
			q|Q)clear
				break;;
			*)echo Invalid Choice;;
		esac
	done
}

manualQueriesMenu(){
	clear
	echo $ENTER_QUERIES_TITLE
	while true
	do
		echo
		echo "Please enter a query or press the Q key to return to the main menu"
		read answer
		case $answer in
			q|Q) clear;break;;
			*) echo db2 "$answer";echo;db2 "$answer";;
		esac
	done
}

createMenu(){
        clear
        while true
        do
                echo
                echo $CREATE_TABLES_TITLE
                echo
                echo "Please select a table to create."
		echo "1. Transaction Table"
                echo "2. Employee Record Table"
                echo "3. Prescription Sales Table"
                echo "4. Prescription Customer Table"
                echo "5. Scheduling Table"
                echo "6. Inventory Table"
		echo "7. QUIT TO MAIN MENU"
                echo
                echo "Please ENTER menu choice (1-7)"
                read input
                case $input in
			1)transactionCreate;;
			2)employeeRecordCreate;;
                        3)prescriptionSalesCreate;;
                        4)prescriptionCustomerCreate;;
                        5)schedulingCreate;;
                        6)inventoryCreate;;
                        7)confirmMenu;;
                        *)echo Invalid Input;;
                esac
        done
}
populateMenu(){
        clear
        while true
        do
                echo
                echo $POPULATE_TABLES_TITLE
                echo
                echo "Please select a table to populate."
                echo "1. Employee Record Table"
                echo "2. Prescription Sales Table"
                echo "3. Prescription Customer Table"
                echo "4. Scheduling Table"
                echo "5. Inventory Table"
                echo "6. QUIT TO MAIN MENU"
                echo
                echo "Please ENTER menu choice (1-6)"
                read input
                case $input in
			1)employeeRecordPopulate;;
                        2)prescriptionSalesPopulate;;
                        3)prescriptionCustomerPopulate;;
                        4)schedulingPopulate;;
                        5)inventoryPopulate;;
                        6)confirmMenu;;
                        *)echo Invalid Input;;
                esac
        done
}
dropMenu(){
        clear
        while true
        do
                echo
                echo $DROP_TABLES_TITLE
                echo
                echo "Please select a table to drop."
		echo "1. Employee Record Table"
                echo "2. Prescription Sales Table"
                echo "3. Prescription Customer Table"
                echo "4. Scheduling Table"
                echo "5. Inventory Table"
		echo "6. Transaction Table"
                echo "7. QUIT TO MAIN MENU"
                echo
                echo "Please ENTER menu choice (1-7)"
                read input
                case $input in
			1)employeeRecordDrop;;
                        2)prescriptionSalesDrop;;
                        3)prescriptionCustomerDrop;;
                        4)schedulingDrop;;
                        5)inventoryDrop;;
			6)transactionDrop;;
                        7)confirmMenu;;
                        *)echo Invalid Input;;
                esac
        done
}
confirmMenu(){
	echo
	echo "Press any key to return to the main menu."
	read answer
	break
}

while true
do
        displayMenu
        read input
        case $input in
                1) createMenu;;
                2) populateMenu;;
                3) dropMenu;;
                4) queriesMenu1;;
                5) manualQueriesMenu;;
                6) clear;break;;
                *) echo Invalid Input;;
        esac
done

