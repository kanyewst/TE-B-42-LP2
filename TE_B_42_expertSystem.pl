% Define performance factors
factor(punctuality).
factor(communication_skills).
factor(initiative).
factor(productivity).
factor(teamwork).
factor(problem_solving).

% Define possible performance levels
performance(excellent).
performance(good).
performance(satisfactory).
performance(needs_improvement).
performance(unsatisfactory).

% Define rules for evaluating performance based on factors
evaluate(excellent) :-
    factor(punctuality),
    factor(communication_skills),
    factor(initiative),
    factor(productivity),
    factor(teamwork),
    factor(problem_solving).

evaluate(good) :-
    factor(punctuality),
    factor(communication_skills),
    factor(productivity),
    factor(teamwork).

evaluate(satisfactory) :-
    factor(punctuality),
    factor(communication_skills),
    factor(teamwork).

evaluate(needs_improvement) :-
    factor(punctuality),
    not(factor(communication_skills)),
    not(factor(initiative)),
    not(factor(productivity)).

evaluate(unsatisfactory) :-
    not(factor(punctuality)).

% Define feedback for each performance level
feedback(excellent, 'Consistently exceeds expectations in all areas.').
feedback(good, 'Meets expectations and demonstrates competency in most areas.').
feedback(satisfactory, 'Meets basic requirements but may improve in some areas.').
feedback(needs_improvement, 'Below expectations in certain areas. Requires improvement.').
feedback(unsatisfactory, 'Performance is not meeting minimum standards. Immediate action needed.').

% Define predicates to consult the performance evaluation system
consult_performance_evaluation :-
    write('What factors are you evaluating? (Separate factors with a period and press Enter): '), nl,
    read_factors(Factors),
    evaluate_performance(Factors, Level),
    write('Based on the factors provided, the performance level is '), write(Level), nl,
    write('Feedback: '), feedback(Level, Feedback), write(Feedback), nl.

read_factors([Factor|Rest]) :-
    write('Factor: '), read(Factor),
    (Factor == end_of_file ->
        Rest = []
    ;   read_factors(Rest)
    ).

evaluate_performance(Factors, Level) :-
    evaluate(Level),
    \+ (member(Factor, Factors), \+ factor(Factor), \+ evaluate_performance(Factor, Level)),
    write(Level), nl.