## Deal with Primary Key (my notes)

 "choosing your key" 
 
 list key and hopeful characteristics, list the 3 diff type of imple. from simple code (immutable short code), simple mutable code (keep short code but make it historized), longer code (or concat of codes) but immutable (use hashing), long and mutable code (use independent and external surrogate ).
 


## Business rules

> Do not build rule into the data structure of a system unless you are confident that the rule will remain in > force for the life of the system.   Ex. modeling family:  1) Person and Marriage;  2) Man, woman, Marriage.

Use **generalization** to remove unwanted rules from the data model.

 
## Specialization (subtyping) and Generalization (supertyping)

At conceptual level, we use box-in-box diagramming techniques to express subtype/supertypes.  This leaves open the logical model to 3 choices :  1) create supertype table only, 2) create subtype tables only, 3) create both level tables.

The important constraints for all subtypes is that they must be **non-overlapping** and **exhaustive** (i.e. any person cannot be both man and woman, and all person are either man or woman... from the Person-marriage model).

Subtypes/SuperTypes also offers :
  * a mechanism to communicate a complexity model at different level of details.  
  * more creativity in model elaboration by asking 1) Can this entity class be subtypes into more specific entity class representing distinct business concepts? and 2) Are any of the entity classes candidates for generalzation into a common supertype?

When do we subtype/supertype:
  * Entities have differences in Identifiers (well used and recognized ids, not merely artificial attributes to support past DB structure)
  * Entities have different attribute **groups** (Insurance Policy: House and Motor vehicle policy)
  * Entities have different relationships (Physical asset: Vehicle and Machine, only Vehicle has a Driver)
  * Some instances participate in important processes while others not (Order : supplier type and customer type)
  * Simply for clearer communication purposes (to help explain the model)

Relational Model and relational DBMSs do not provide direct support for subtypes or supertypes. Therefore, any subtypes that were included in the conceptual data model are normally replaced by standard relational structures in the logical data model.   Object-relational DBMS are the only providing such support through inheritance, for RDBMS a multitude of logical models implementation are possible (subtypes-only implementation, supertypes-only implementation and in-between solution where some subtype-levels can be rolled-up onto supertype-level, and/or supertype can be inherited into subtype-level tables..).


## Attributes 
 
A simple and convenient taxonomies often used to categorize the Attributes are :
	
  1. Identifier (used purely to identify instance without carrying properties on those instances, can be system generated [ex. custno], administrator [ex. productCode] or extrnally defined [zip])
  2. Category (can hold one of defined set of values)
  3. Quantifier (allowing some arithmetic and comparison to be performed (other than = or !=) like quantifty, order date, price,..)
  4. Text (hold any string of characters) 

Rule : **Each Attribute must represent one and one fact only**   
Violations of this rule are frequent such as: aggregation, complex codes, meaningful ranges and inappropriate generalization.


## 3NF

3NF formal procedure:
	1. Identify any determinants (other than *candidate key*) and the attributes they determine in original table
	2. Extract each of these determinants with respective attributes into new tables (determinant becoming the primary key of new tables)
	3. Leave each determinant in original table to provide links between tables 

Note *candidate key* is used instead of *primary key* to account for the possibility that more than one key could serve as primary key (ex. product name and short name).

Summary of 3NF rule:  *every determinant of a non-key column MUST be a candidate key*



## Higher-normalization 

A consequence always remain when doing normalization: each new stage involves splitting a table into two or more tables!   This happens without losing anything as we the splitted table could always be reconstructed by joing the table throught the  match of determinant. 
  
Any structure that is normalized to some level, will always be normalized to lower level.  The higher Normal forms are 1) BCNF (Boyce Codd normal form), 2) the 4NF, 3) the 5NF and 4) the 6NF when one needs to address time-dependent data.

  1. BCNF :
  	Rule: *every determinant MUST be a candidate key*  [table is in BCNF if the only determinants of any columns (including key columns) are candidate keys].  
	Situation of 3NF that is not BCNF: usually happen when we have more than one candidate key (overlapping) (if some key columns are determined by other determinant then this other deteminant should reolace that key)
  2. 5NF (also includes 4NF):
  	 Rule: Keep on splitting until either 1) further split would lead to tables not joinable to produce the original table or 2) the only split left are trivial (i.e. based on candidate key:  [Emp_no, Emp_Name] and [Emp_no, Emp_birthdate]
	  

Violating 4NF happens when, for ex, we model 2 Many-to-Many relationship tables as one table (Dealer - Instrument - Location), then we end up with the same fact in more than one row (the fact that Bond can only be served in London will be repeated for all Dealer allow to deal Bond).   This happends when we model *derived* rules instead of *underlying* rules. 

Starting at the 4NF form, every problem addressed occurs with key-only tables (every columns are part of the key).

5NF defines an end-point after which any further normalization would cause a loss of information (as opposed to defining any anomaly corrected by this).

In all practical purposes,  one should moves straight to the 5NF definition, and look to see if there are simpler business rules underlying those represented by your current multiway relationship table!!  Ask the following questions: On what (business) basis do we add a row to this table? On what basis do we delete rows? Do we apply any rules? Understanding the business reasons behind changes to the table is the best way of discovering whether it can be split further.



## Time-Dependent Data









