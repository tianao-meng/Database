select count(*) / (select count(*) from second_chess) as white_win_fraction
from second_chess
where winner = 'white';


select avg(number_of_turns) as average_moves_white_win
from second_chess
where winner = 'white';


select avg(number_of_turns) as average_moves_black_win
from second_chess
where winner = 'black';

select count(*) / (select count(*) from moves_1) as pawn_move_fraction
from moves_1
where length(moves) < 3;
