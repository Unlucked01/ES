domains
	BNO, RNO = integer
	COND = BNO*
	H = RNO*
	CAT = SYMBOL
database
	yes(BNO)
	no(BNO)
predicates
	rule(RNO, CAT, CAT, COND)
	cond(BNO, string)
	exp
	menu
	process(integer) 
	cconsult(CAT)
	clear
	work(H, CAT)
	check(RNO, H, COND)
	question(H, RNO, BNO, string)
	answer(H, RNO, string, BNO, integer)
clauses
	rule(1, "Фильм", "Полный метр", [1]).
	rule(2, "Фильм", "Короткий метр", [2]).

	rule(3, "Полный метр", "Побег из Шоушенка", [3,9]).
	rule(4, "Полный метр", "1+1", [3,7,10]).
	rule(5, "Полный метр", "Унесённые призраками", [4,7,9]).
	rule(6, "Полный метр", "Парк Юрского периода", [4,5,6,12]).
	rule(7, "Полный метр", "Интерстеллар", [5,3,4,12]).
	rule(8, "Полный метр", "Властелин колец", [4,5,6,3,10]).
	rule(9, "Полный метр", "Навсикая из долины ветров", [7,3,4,5,9]).
	rule(10,"Полный метр", "Мстители", [6,5]).
	
	rule(11, "Короткий метр", "Пила", [13,3,6,12]).
	rule(12, "Короткий метр", "Майор Гром", [4,5,6,8,9]).
	rule(13, "Короткий метр", "Путешествие на Луну", [5,12]).
	
	cond(1, "Полнометражный").
	cond(2, "Короткометражный").
	cond(3, "Драма").
	cond(4, "Приключение").
	cond(5, "Фантастика").
	cond(6, "Экшен").
	cond(7, "Аниме").
	cond(8, "Комедия").
	cond(9, "По роману").
	cond(10, "По книге").
	cond(11, "По реальным событиям").
	cond(12, "Оригинальный сценарий").
	cond(13, "Ужасы").
	
	exp:- 
		makewindow(1,7,7,"ЭС(1)",0,0,25,80), 
		menu, nl, 
		write("ПРОБЕЛ для выхода -> "), 
		readchar(_), exit.
	menu:-
		write("1, Консультация"), nl,
		write("2, Выход"), nl,
		write("Ваш выбор (1 или 2) -> "),
		readint(Ch), process(Ch).
	
	process(1):-
		cconsult("Фильм"), clear.
	process(2):-
		removewindow.
	
	cconsult(X):- work([],X), !.
	cconsult(_):- 
		nl, write("Нет подходящих фильмов").
	cconsult(_).
	
	work(_, X):- 
		not(rule(_,X,_,_)), !, nl,
		write("Ваш выбор -> ", X), nl.
	work(H, X):- 
		rule(RNO, X, NY, COND),
		check(RNO, H, COND),
		work([RNO|H], NY).
	
	check(RNO, H, [BNO|REST]):-
		yes(BNO),!,
		check(RNO, H, REST).
	check(_,_,[BNO|_]):-
		no(BNO),!, fail.
	check(RNO, H, [BNO|REST]):-
		cond(BNO, TEXT),
		question(H, RNO, BNO, TEXT),
		check(RNO, H, REST).
	check(_,_,[]).
	
	question(H, RNO, BNO, TEXT):-
		write("Вопрос: ", TEXT, "?"),
		write(" (1 или 2) -> "),
		readint(RESP),
		answer(H, RNO, TEXT, BNO, RESP).
	answer(_,_,_,BNO, 1):-
		asserta(yes(BNO)), 
		write("да"), nl.
	answer(_,_,_,BNO,2):-
		asserta(no(BNO)),
		write("нет"), nl, fail.
	
	clear:- 
		retract(yes(_)), fail;
		retract(no(_)), fail.
	clear.
goal
	exp.