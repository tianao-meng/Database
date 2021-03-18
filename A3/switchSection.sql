DELIMITER $$
DROP PROCEDURE IF EXISTS switchSection$$
create procedure switchSection(

    in courseID char(8),
    in section1 int,
    in section2 int,
    in termcode decimal(4),
    in quantity int,
    out err_code int

)

proc_label:begin
    declare temp_enrollment int;
    declare temp_roomID char(8);
    declare temp_capacity int;
    declare count1 int;
    declare count2 int;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    start transaction;
        set err_code = 0;

        select count(*) from offering
        where offering.courseID = courseID and offering.section = section1 and offering.termcode = termcode
        into count1;

        select count(*) from offering
        where offering.courseID = courseID and offering.section = section2 and offering.termcode = termcode
        into count2;

        if (count1 = 0 or count2 = 0 or quantity <= 0 or section1 = section2) then
            set err_code = -1;
            leave proc_label;
        end if;

        select offering.enrollment from offering
        where (offering.courseID = courseID and offering.section = section1 and offering.termcode = termcode)
        into temp_enrollment;


        if ((temp_enrollment - quantity) < 0) then
            set err_code = -2;
            leave proc_label;
        end if;


        select offering.enrollment, offering.roomID from offering
        where (offering.courseID = courseID and offering.section = section2 and offering.termcode = termcode)
        into temp_enrollment, temp_roomID;


        select classroom.capacity from classroom
        where (classroom.roomID = temp_roomID)
        into temp_capacity;


        if ((temp_enrollment + quantity) > temp_capacity) then
            set err_code = -3;
            leave proc_label;

        end if;

        if (err_code = 0) then

            update offering set enrollment = enrollment - quantity
            where offering.courseID = courseID and offering.section = section1 and offering.termcode = termcode;

            update offering set enrollment = enrollment + quantity
            where offering.courseID = courseID and offering.section = section2 and offering.termcode = termcode;
        end if;
    commit;

end$$
DELIMITER ;

