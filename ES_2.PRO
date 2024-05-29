domains
database
	xpositive(symbol)
	xnegative(symbol)
predicates
	exp
	cconsult
	clear_rules
	film_is(symbol)
	it_is(symbol)
	pos(symbol)
	neg(symbol)
	question(symbol)
	remember(symbol, symbol)
clauses
	film_is("Побег из Шоушенка"):-
		it_is("Полный метр"),
		pos("Драма"),
		pos("По роману").
	film_is("1+1"):-
		it_is("Полный метр"),
		pos("Драма"),
		pos("Комедия"),
		pos("По книге").
	film_is("Унесённые призраками"):-
		it_is("Полный метр"),
		pos("Аниме"),
		pos("Приключение"),
		pos("По роману").
	film_is("Парк Юрского периода"):-
		it_is("Полный метр"),
		pos("Приключение"),
		pos("Фантастика"),
		pos("Экшен"),
		pos("Оригинальный сценарий").
	film_is("Интерстеллар"):-
		it_is("Полный метр"),
		pos("Драма"),
		pos("Приключение"),
		pos("Фантастика"),
		pos("Оригинальный сценарий").
	film_is("Властелин колец"):-
		it_is("Полный метр"),
		pos("Драма"),
		pos("Приключение"),
		pos("Фантастика"),
		pos("Экшен"),
		pos("По книге").
	film_is("Навсикая из долины ветров"):-
		it_is("Полный метр"),
		pos("Аниме"),
		pos("Драма"),
		pos("Приключение"),
		pos("Фантастика"),
		pos("По роману").
	film_is("Мстители"):-
		it_is("Полный метр"),
		pos("Экшен"),
		pos("Фантастика").
	film_is("Пила"):-
		it_is("Короткий метр"),
		pos("Ужасы"),
		pos("Драма"),
		pos("Экшен"),
		pos("Оригинальный сценарий").
	film_is("Майор Гром"):-
		it_is("Короткий метр"),
		pos("Приключение"),
		pos("Фантастика"),
		pos("Экшен"),
		pos("Комедия"),
		pos("По роману").
	film_is("Путешествие на Луну"):-
		it_is("Короткий метр"),
		pos("Фантастика"),
		pos("Оригинальный сценарий").

	it_is("Полный метр"):-
		pos("Полный метр"),!.
	it_is("Короткий метр"):-
		pos("Короткий метр"),!.
	
	exp:- 
		makewindow(1,7,7,"ЭС-2",1,16,22,58), 
		nl, cconsult, nl, nl,
		write("ПРОБЕЛ для выхода -> "), 
		readchar(_), removewindow, exit.
	
	cconsult:- 
		film_is(X),!,nl, 
		write("Ваш выбор -> ", X,"."), nl, 
		clear_rules.
	cconsult:- 
		nl, write("Нет подходящих фильмов"), nl, 
		clear_rules.
	
	question(X):-
		write("Вопрос: ", X, "?"),
		write(" ('да/д' или 'нет/н') -> "),
		readln(REPLY),
		remember(X, REPLY).

	pos(X):- xpositive(X),!.
	pos(X) :- not(neg(X)), !, question(X).
	neg(X) :- xnegative(X),!.

	remember(X, "да"):- asserta(xpositive(X)).
	remember(X, "д"):- asserta(xpositive(X)).
	
	remember(X, "нет"):- asserta(xnegative(X)), fail.
	remember(X, "н"):- asserta(xnegative(X)), fail.
	
	clear_rules:- 
		retract(xpositive(_)), fail.
	clear_rules:-
		retract(xnegative(_)), fail.
goal
	exp.