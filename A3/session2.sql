set autocommit = 0;
-- read uncommitted, read committed, repeatable read, serializable
set session transaction isolation level serializable;

begin;

    select enrollment from offering
    where courseID="ECE356" and section=2 and termCode=1191;


