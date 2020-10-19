IDENTIFICATION DIVISION.
  PROGRAM-ID.           CALC-EXPENSES.
  AUTHOR.               ISOBEL SCOTT.


ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
   SELECT ExpenseFile ASSIGN TO 'expense_reports/CASABLANCA.csv'
   ORGANIZATION IS LINE SEQUENTIAL.    

   SELECT SortedExpenseFile ASSIGN TO 'processed/CASASORTED.csv'
   ORGANIZATION IS LINE SEQUENTIAL.    

   SELECT TP ASSIGN TO TEMP.

DATA DIVISION.
  FILE SECTION.
    FD ExpenseFile.
    01 IN-REC.
      03 ExpenseDate              PIC X(50).
      03 EmployeeName             PIC X(50).
      03 EmployeeId               PIC 9(6).
      03 City                     PIC X(15).                 
      03 Country                  PIC X(15).
      03 BusinessName             PIC X(50).
      03 Category                 PIC X(50).
      03 ReportId                 PIC 9(6).
      03 LocalAmount              PIC 9(10)V99.
      03 LocalCurrency            PIC X(3).
      03 UsdAmount                PIC 9(7)V99.

    FD SortedExpenseFile.
    01 OUT-REC.
      03 ExpenseDate-S            PIC X(50).
      03 EmployeeName-S           PIC X(50).
      03 EmployeeId-S             PIC 9(6).
      03 City-S                   PIC X(15).                 
      03 Country-S                PIC X(15).
      03 BusinessName-S           PIC X(50).
      03 Category-S               PIC X(50).
      03 ReportId-S               PIC 9(6).
      03 LocalAmount-S            PIC 9(10)V99.
      03 LocalCurrency-S          PIC X(3).
      03 UsdAmount-S              PIC 9(7)V99.

    SD TP.
      01 ExpenseDate-T             PIC X(50).
      01 EmployeeName-T            PIC X(50).
      01 City-T                    PIC X(15).                 
      01 Country-T                 PIC X(15).
      01 BusinessName-T            PIC X(50).
      01 Category-T                PIC X(50).
      01 ReportId-T                PIC 9(6).
      01 LocalAmount-T             PIC 9(10)V99.
      01 LocalCurrency-T           PIC X(3).
      01 UsdAmount-T               PIC 9(7)V99.


WORKING-STORAGE SECTION.

77 EOF pic x value 'n'.

PROCEDURE DIVISION.
  BEGIN.
  OPEN INPUT ExpenseFile.
  OPEN OUTPUT SortedExpenseFile.

  READ ExpenseFile AT END MOVE 'y' TO EOF.
  PERFORM p-para UNTIL EOF = 'y'.

  CLOSE ExpenseFile SortedExpenseFile.
  STOP RUN.

  p-para.
    WRITE OUT-REC FROM IN-REC AFTER ADVANCING 1 LINE.

  DISPLAY 'COMPLETED.'
  
  READ ExpenseFile AT END MOVE 'y' to EOF.
