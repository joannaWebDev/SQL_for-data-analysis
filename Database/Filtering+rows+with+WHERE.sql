/*

    Looking at data with the SQL basics
        
 
    Filtering: Only displaying the rows you need using WHERE.
        
    PURPOSE
	- Showing the data (useful for seeing what the data is, checking your work for mistakes, looking for specific examples)
	- Taking and using the data (useful later on when joining with other data sources)
    - Only using the rows that are relevant to the particular question you are answering 
		- (useful for broadening or narrowing your scope of problem solving, and for saving time and processing power).
    
    SYNTAX 
	- WHERE
	- BASIC ARITHMETIC OPERATIONS =, <, >, <>, <=, >= 
*/


##################################################################
###################      The WHERE clause     ####################
##################################################################
-- Filters, limits, or restricts your rows based on a condition you specify

############ EXAMPLES ############
-- Suppose you're interested understanding more about how the transaction data is captured, so you use your own account. 
-- Let's find all transaction info but for only for the account 101. 
SELECT *						
FROM TRAN
WHERE ACCT_I = 101  		-- Note: Use inverted commas for text or dates
;							



-- Or imagine that you want to focus on card transactions only.
-- Let's find all card transactions, and all related information on those t ransactions.
SELECT *
FROM TRAN
WHERE TRAN_TYPE = 'Card'  
;


############ TEST YOUR LEARNING ############
-- 1. Find all transactions at the Star Gazing Tour in Coonabarrabran "Star Gazing Tour, Coonabarrabran PTY LTD"
SELECT *
FROM TRAN
WHERE TRAN_DESC = 'Star Gazing Tour, Coonabarrabran PTY LTD'
;



-- 2. Find all leisure transactions
SELECT *
FROM TRAN
WHERE TRAN_BUSN_CATG = 'LEISURE'
;



-- 3. Find a list of all transfers
SELECT *
FROM TRAN
WHERE TRAN_TYPE = 'TRANSFER'
;






##################################################################
###  Using WHERE with NOT EQUALS, LESS THAN, GREATER THAN, etc ###
##################################################################

############ SYNTAX ############
-- Equals 					=
-- Not equals 				<>
-- Less than 				<
-- Greater than 			>
-- Less than or equal to    <=
-- Greater than or equal to >=


############ EXAMPLES ############
-- Suppose we only want to see transactions from the 1st Jan 2018 onwards
-- Option 1: Using "greater than or equal to" 
SELECT *
FROM TRAN
WHERE TRAN_D >= '2018-01-01'
;
-- Option 2: Using "greater than"
SELECT *
FROM TRAN
WHERE TRAN_D > '2017-12-31'
;


############ TEST YOUR LEARNING ############
-- 1. Find transactions of over $100 in value
SELECT *
FROM TRAN
WHERE TRAN_A > 100
;
SELECT *
FROM TRAN
WHERE TRAN_A >= 101
;


-- 2. Find transactions that did not happen in Sydney
SELECT *
FROM TRAN
WHERE TRAN_LOCN <> 'SYDNEY'
;



-- 3. Find transactions that are credits, or money coming into the account (i.e. negative)
SELECT *
FROM TRAN
WHERE TRAN_A < 0
;








############ ECONOMIC REPORT CHALLENGE ############
-- Suppose that the Strategy and Finance Dept is writing a Economic Research Report for the CEO has approached the data analytics team.
-- The CEO needs to see the broader economic context behind the company financial statements he has seen since Jan 2018.
-- Specifically, he is concerned about how the Australian economy is recovering since the holiday season.


-- 1. Find all spending since 1st Jan 2018.
SELECT *
FROM TRAN
WHERE TRAN_D >= '2018-01-01'
;



-- 2. As the economy mostly shuts down on New Year's Day you decide to remove it.
SELECT *
FROM TRAN
WHERE TRAN_D > '2018-01-01'
;





-- 3. Specifically, the Economic Research team are most interested in discretionary spending as these businesses are most vulnerable to economic recessions.
--    So as an example find all spending on 'Dining out' during the same period to help understand challenges facing Australian restaurants.
SELECT *
FROM TRAN
WHERE TRAN_BUSN_CATG = 'DINING OUT'
;




-- 4. They also ask for a specific example of a restaurant and how spending has changed over time during the year.
-- 	  Get a list of transactions for all spending at Tony's Pizza (Tonys Pizza, Carlton PTY LTD)
SELECT *
FROM TRAN
WHERE TRAN_DESC = 'Tonys Pizza, Carlton PTY LTD'
;



