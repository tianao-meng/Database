set autocommit=0;
-- read uncommitted, read committed, repeatable read, serializable
set session transaction isolation level repeatable read;
begin;
    update Offering set Enrollment = Enrollment - 20
    where courseID="ECE356" and section=2 and termCode=1191;
