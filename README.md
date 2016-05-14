# Database-System

###Enterprise Description###

Family Pharm is a retail pharmaceutical store located in southern Ontario. The store can hold up to a max 50 customers at any given time. It sells a wide variety of drugs, beauty care products, and other personal care products. The drug types consist of: antibiotics, anti-allergy, antiviral, decongestants, antidepressants, antacids, antipyretics, analgesics, antiseptics. laxatives, and can be prescribed and non-prescribed. The beauty supply products consist of: eyeliner, primer, nail polish, nail polish remover, blemish, and many more. Other personal care product types include: deodorants, antiperspirants, toothpaste, shampoos, body wash, soaps, and many more.  There are 3 departments in the pharmacy: drugs, beauty products, and health products. The store has 5 main positions: store manager, assistant manager, professional pharmacist, shift supervisor, and store clerk. There is 1 owner, 1 manager and 4 professional pharmacists. There are 5 cashiers currently employed who have all worked for the company for varying years. The pharmacy also has accountants who handle the finance of the company.

Family Pharm provides many different ways of purchasing drugs from the store such as walk-in, call-in, or delivery to certain areas.  The drugs can only be refilled if the prescription states it is allowed. For the exchange of a product and refund, the conditions are: 30 days unopened with receipt. No receipt can get you a store credit but no cash refund. 

The POS system keeps a sales history for each annum. If a customer is purchasing prescribed medication, a unique identifier is assigned the the customer along with a record of their address, OHIP number, and contact information.  Included in the history is the number of times the customer have refilled their prescribed drugs.

###Functional Requirement###

**Record Customer's Information**

When a customer makes a prescription drug purchase, his/her information such as name, telephone number, address, and health card number are recorded. That record is also indexed as customer identification number (CID).

**Record Payment Method**

The pharmacy accepts three type of payment; cash, credit, and certified check. Once the payment is received, the salesperson gives proof-of-payment note to the customer.

**Recording a Sale**

When a sale is completed, the system records customer id, the product purchased, total payment, date of purchase, and type of payment. The system also records the pharmacist id (PID) that sells the medicine for legal purposes. The inventory also changes according to the product(s) and amount purchased.

**Adding/removing Employee's Data**

The system keeps record of all employee data such as employee id, name, date of beginning employment, date of end employment and employee's bank account for the sake any positional changes and tax revenue.
Recording a refund

Employee makes the appropriate changes to the inventory on its newly updated from the refund according to the product and its quantity. The employee also makes record in the sale if the he system records customer id, product returned, total refunds, date of purchase, and type of refund (to debit or cash) for legal reasons.

**Inventory Purchase**

Employee makes the appropriate changes to the inventory on its newly updated from the refund according to the product and its quantity. The employee also makes record in the sale if the he system records customer id, product returned, total refunds, date of purchase, and type of refund (to debit or cash) for legal reasons.

**Paying Employees**

All employees are paid on a bi-weekly basis. It is either deposited directly to employees' bank accounts or by cheque. 

###Installation###

1.	Make sure user has all the files: dbui.sh, prescriptionSales.txt, prescriptionCustomer.txt, employeeRecords.txt, inventory.txt, scheduling.txt
2.	Make dbui.sh executable using the command “chmod 700 dbui.sh” in the terminal of a Linux operating system.
3.	Move all files listed in the step 1 into turing.acs.ryerson.ca by using SSH File Transfer Client.
4.	Login to “turing.acs.ryerson.ca”.
5.	Run the program by typing “sh dbui.sh”.

#NOTE: For more details and information, please refer to the Database Report document.
