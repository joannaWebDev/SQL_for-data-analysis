/*
	
    Looking at data with the SQL basics
        

    Filtering: specifiying your condition further with AND, and OR.
        
    PURPOSE
	- Showing the data (useful for seeing what the data is, checking your work for mistakes, looking for specific examples)
	- Taking and using the data (useful later on when joining with other data sources)
    - Only using the rows that are relevant to the particular question you are answering (useful for broadening or narrowing your scope of problem solving, and for saving time and processing power).
    
    SYNTAX 
	- AND
    - OR
*/


##################################################################
###################      The AND operator     ####################
##################################################################
-- AND is used with a WHERE clause to make the conditions on rows stricter (i.e. adding a condition)

############ EXAMPLES ############
-- Find all direct debit transactions to National Australia Bank
SELECT *
FROM TRAN 
WHERE (TRAN_TYPE = 'Direct Debit' AND TRAN_DESC = 'National Australia Bank Cards PTY LTD')
;

-- Don't need the brackets 
SELECT *
FROM TRAN 
WHERE TRAN_TYPE = 'Direct Debit' 
AND TRAN_DESC = 'National Australia Bank Cards PTY LTD'
;



-- Find all card transactions on the 4th Aug 2017
SELECT *
FROM TRAN
WHERE TRAN_D = '2017-08-04'
AND TRAN_TYPE = 'Card'
;


############ TEST YOUR LEARNING ############
-- 1. Find all ATM withdrawals in Perth
SELECT *
FROM TRAN
WHERE TRAN_TYPE = 'ATM CASH WITHDRAWAL'
AND TRAN_LOCN = 'PERTH'
;



-- 2. Find all card payments in Sydney over $70
SELECT *
FROM TRAN
WHERE TRAN_TYPE = 'CARD'
AND TRAN_LOCN = 'SYDNEY'
AND TRAN_A > 70
;






##################################################################
###################      The OR operator     ####################
##################################################################
-- Used for relaxing or broadening a condition

############ EXAMPLES ############
-- Find all transactions at Lebanese chicken shops
SELECT *
FROM TRAN
WHERE (TRAN_DESC = 'Fatimas Lebanese Restaurant, Surry Hills PTY LTD' OR TRAN_DESC = 'Good Chicken, St Leonards PTY LTD')
;

-- Don't need the brackets
SELECT *
FROM TRAN
WHERE TRAN_DESC = 'Fatimas Lebanese Restaurant, Surry Hills PTY LTD' 
OR TRAN_DESC = 'Good Chicken, St Leonards PTY LTD'
;


-- Confusing Point Alert: When dealing with the same column, OR is the correct SQL to transcribe what in English is referred to as "and"
-- Find all transctions to betting companies bet365 and betEASY
-- Find all transctions to either bet365 or betEASY
SELECT *
FROM TRAN
WHERE TRAN_DESC = 'bet365'
OR TRAN_DESC = 'betEASY'
;
-- Find all transctions to betting companies bet365 and betEASY
SELECT *
FROM TRAN
WHERE TRAN_DESC = 'bet365'
AND TRAN_DESC = 'betEASY'
;


############ TEST YOUR LEARNING ############
-- 1. Find all transactions that are either ATM transactions or in Perth
SELECT *
FROM TRAN
WHERE TRAN_TYPE = 'ATM CASH WITHDRAWAL'
OR TRAN_LOCN = 'PERTH'
;



-- 2. Find all transactions that are either in Sydney, card transactions, or over $70
SELECT *
FROM TRAN
WHERE TRAN_LOCN = 'SYDNEY'
OR TRAN_TYPE = 'CARD'
OR TRAN_A > 70
;





##################################################################
###################  Combining AND with OR    ####################
##################################################################

-- 'Order of operations'
-- Just like multiplication preceeds addition, AND comes before OR
/* E.g.
	2 + 5 x 5 
  = 2 + 25 
  = 27 ... 
  NOT 
  2 + 5 x 5
= 7 x 5 
= 35
BUT
(2 + 5) x 5
= 7 x 5
= 35
*/

-- Suppose you are interested in gambling behaviour, especially by those betting a lot.
-- Find transactions to either bet365 or betEASY, which are over $100 

-- Your first attempt:
SELECT *
FROM TRAN
WHERE TRAN_A > 100
AND TRAN_DESC = 'bet365'
OR TRAN_DESC = 'betEASY'
; -- This was difficult to read, so always specify using brackets.

-- Your second attempt:
SELECT *
FROM TRAN
WHERE (	TRAN_A > 100 AND TRAN_DESC = 'bet365'
	  )
OR TRAN_DESC = 'betEASY'
; -- Easier to read. Now we can see it is the wrong logic.

-- 3rd time lucky
SELECT *
FROM TRAN
WHERE TRAN_A > 100
AND (  TRAN_DESC = 'bet365' OR TRAN_DESC = 'betEASY'
    )
;


############ TEST YOUR LEARNING ############
-- 1. Find all card transactions by accounts 301 and by 501 
SELECT *
FROM TRAN
WHERE ACCT_I = 301
OR ACCT_I = 501
;



-- 2. Find all transactions on the last 3 days of 2017
SELECT *
FROM TRAN
WHERE TRAN_D > '2017-12-28'
AND TRAN_D < '2018-01-01'
;



-- 3. Find card transactions on Leisure businesses in Sydney.
SELECT *
FROM TRAN
WHERE TRAN_TYPE = 'CARD'
AND TRAN_BUSN_CATG = 'LEISURE'
AND TRAN_LOCN = 'SYDNEY'
;



-- 4. Find all transactions over $150 spent on either leisure or dining out.
SELECT *
FROM TRAN
WHERE TRAN_A > 150
AND (TRAN_BUSN_CATG = 'LEISURE' OR TRAN_BUSN_CATG = 'DINING OUT'
    )
;




-- 5. Find all Leisure and Dining Out transactions over $150
SELECT *
FROM TRAN
WHERE TRAN_A > 150
AND (TRAN_BUSN_CATG = 'LEISURE' OR TRAN_BUSN_CATG = 'DINING OUT'
    )
;



-- 6. Find all Leisure transactions over $150 and all Dining Out transactions
SELECT *
FROM TRAN
WHERE (TRAN_A > 150 AND TRAN_BUSN_CATG = 'LEISURE')
OR TRAN_BUSN_CATG = 'DINING OUT'
;



-- 7. Find all leisure transactions under $150 and all dining out transactions over $150 in Sydney or Perth
SELECT *
FROM TRAN
WHERE (TRAN_BUSN_CATG = 'LEISURE' AND TRAN_A < 150)
OR (TRAN_BUSN_CATG = 'DINING OUT' AND TRAN_A > 150 AND (TRAN_LOCN = 'SYDNEY' OR TRAN_LOCN = 'PERTH')
   )
;
SELECT *
FROM TRAN
WHERE (TRAN_LOCN = 'SYDNEY' OR TRAN_LOCN = 'PERTH')
AND (
		(TRAN_BUSN_CATG = 'LEISURE' AND TRAN_A < 150)
	 OR (TRAN_BUSN_CATG = 'DINING OUT' AND TRAN_A > 150) 
    )
;

-- 8. Find all leisure transactions under $150 on the last 3 days of Dec17 in Sydney and Melbourne, and all dining out transactions over $150 in Melbourne
SELECT *
FROM TRAN
WHERE (
			 (TRAN_BUSN_CATG = 'LEISURE' AND TRAN_A < 150 AND TRAN_D > '2017-12-28' AND TRAN_D < '2018-01-01')
		 AND (TRAN_LOCN = 'SYDNEY' OR TRAN_LOCN = 'MELBOURNE')
      )
OR (TRAN_BUSN_CATG = 'DINING OUT' AND TRAN_A > 150 AND TRAN_LOCN = 'MELBOURNE')
;
SELECT *
FROM TRAN
WHERE TRAN_LOCN = 'MELBOURNE'
;




############ LOYALTY PROGRAM CHALLENGE ############
-- Suppose we are investigating to whom we might offer loyalty benefits. 
-- We want to reward long tenure and high value to the bank. 
-- But we need to be careful of the size of the investment and want to pinpoint the smallest group of customers who meet a reasonable definition of loyal customer.

-- 1. In one query find customers who meet any of these conditions:
	-- who joined the bank over 50 years ago (1970)
    -- who are branch users and joined the bank over 30 years ago (1990)
SELECT *
FROM CUST_BASE
WHERE JOIN_DATE < '1970-12-31'
OR (JOIN_DATE < '1990-12-31' AND BRCH_CUST = 1)
;



-- 2. Suppose that too many customers are on the list. 
-- Let's also stipulate that the customers have to bring at least $2k in revenue to the bank per year.
SELECT *
FROM CUST_BASE
WHERE RVNU_YEAR_A > 2000
AND (
		JOIN_DATE < '1970-12-31'
	OR (JOIN_DATE < '1990-12-31' AND BRCH_CUST = 1)
	)
;



-- 3. Perhaps this is unfair on customers who joined the bank 50 years ago, whom we should reward regardless of their current value to the bank (i.e. in thanks for past value)
-- So make the $2k revenue condition only apply to those who joined over 30 years ago.
SELECT *
FROM CUST_BASE
WHERE (
		JOIN_DATE < '1970-12-31'
	OR (JOIN_DATE < '1990-12-31' AND BRCH_CUST = 1 AND RVNU_YEAR_A > 2000)
	)
;

 