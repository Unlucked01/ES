domains
  list = string*
  PositiveAnswers = string*
  NegativeAnswers = string*
  MaybeAnswers = string*
  MovieQuestions = string*
database
  yes(string)
  no(string)
  maybe(string)
predicates
  repeat
  run
  movie(string)
  positive(string)
  movie_positive(string, string)
  movie_negative(string, string)
  negative(string)
  xpositive(string)
  xnegative(string)
  ask(string,char)
  remember(string,char)
  delete_all
  calculate_match_percentage(string, integer)
  length(PositiveAnswers, integer)
  length(NegativeAnswers, integer)
  length(MovieQuestions, integer)

  append(PositiveAnswers, MovieQuestions, MovieQuestions)

  find_matches(string, PositiveAnswers, NegativeAnswers)
  find_movie_questions(string, MovieQuestions)
  check_positive(string, string)
  check_negative(string, string)


clauses
  repeat.
  repeat:-repeat.

  movie("Назад в будущее"):-positive("научная фантастика"),positive("приключения"),
                            positive("комедия"), negative("драма"), negative("военный"), positive("1985").


  movie("Титаник"):-positive("драма"),positive("романтика"), negative("научная фантастика"), negative("военное"), negative("комедия"),
                    positive("1997").

  movie("Властелин колец"):-positive("фэнтези"),positive("приключения"),
                            positive("эпический"), negative("научная фантастика"), positive("2001").

  movie("Тёмный рыцарь"):-positive("боевик"),positive("триллер"), negative("комедия"),
                          positive("2008").

  movie("Несломленный"):-positive("биография"),positive("военный"), negative("комедия"),
                         positive("2014").

  movie("Однажды в Голливуде"):-positive("комедия"),positive("драма"),
                                positive("криминал"), negative("боевик"), positive("2019").

  movie("неизвестный фильм").

  movie_positive("Назад в будущее", "научная фантастика").
  movie_positive("Назад в будущее", "приключение").
  movie_positive("Назад в будущее", "комедия").
  movie_positive("Назад в будущее", "1985").
  movie_negative("Назад в будущее", "драма").
  movie_negative("Назад в будущее", "военный").

  movie_positive("Титаник", "драма").
  movie_positive("Титаник", "романтика").
  movie_positive("Титаник", "1997").
  movie_negative("Титаник", "комедия").
  movie_negative("Титаник", "научная фантастика").
  movie_negative("Титаник", "военное").

  movie_positive("Властелин колец", "фэнтези").
  movie_positive("Властелин колец", "приключения").
  movie_positive("Властелин колец", "эпический").
  movie_positive("Властелин колец", "2001").
  movie_negative("Властелин колец", "научная фантастика").

  movie_positive("Тёмный рыцарь", "боевик").
  movie_positive("Тёмный рыцарь", "триллер").
  movie_positive("Тёмный рыцарь", "2008").
  movie_negative("Тёмный рыцарь", "комедия").

  movie_positive("Несломленный", "биография").
  movie_positive("Несломленный", "военный").
  movie_positive("Несломленный", "2014").
  movie_negative("Несломленный", "комедия").

  movie_positive("Однажды в Голливуде", "комедия").
  movie_positive("Однажды в Голливуде", "драма").
  movie_positive("Однажды в Голливуде", "криминал").
  movie_positive("Однажды в Голливуде", "2019").
  movie_negative("Однажды в Голливуде", "боевик").

  positive(X):-xpositive(X),!; xnegative(X),!,fail; ask(X,'y').
  negative(X):-xnegative(X),!; xpositive(X),!,fail; ask(X,'n').
  
  ask(X, R):- write(X, "?  : "), 
            readchar(Reply),
            write(Reply,"\n"),
            remember(X,Reply),
            R=Reply.

  xpositive(X):-yes(X); maybe(X).
  xnegative(X):-no(X); maybe(X).

  remember(X,'y'):-asserta(yes(X)).
  remember(X,'n'):-assertz(no(X)).
  remember(X,'q'):-asserta(maybe(X)).

  delete_all:-retract(yes(_)), delete_all.
  delete_all:-retract(no(_)), delete_all.
  delete_all:-retract(maybe(_)), delete_all.
  delete_all.

  length([], 0).
  length([_|T], N):- length(T, N1), N = N1 + 1.

  append([], L, L).
  append([H|T], L, [H|R]) :- append(T, L, R).

  find_matches(Movie, PositiveMatches, NegativeMatches) :-
    findall(X, check_positive(Movie, X), PositiveMatches),
    findall(X, check_negative(Movie, X), NegativeMatches).

  find_movie_questions(Movie, MovieQuestions):-
    findall(Y, movie_positive(Movie, Y), PositiveQuestions),
    findall(Y, check_negative(Movie, Y), NegativeQuestions),
    append(PositiveQuestions, NegativeQuestions, MovieQuestions).

  check_positive(Movie, X) :-
    movie_positive(Movie, X),
    yes(X).

  check_negative(Movie, X) :-
    movie_negative(Movie, X),
    no(X).

  calculate_match_percentage(Movie, Percentage) :-
   find_movie_questions(Movie, MovieQuestions),
   write("Поля фильма: ", MovieQuestions, "\n"),
   length(MovieQuestions, TotalQuestions),
   TotalQuestions > 0,
   find_matches(Movie, PositiveMatches, NegativeMatches),
   write("Положительные совпадения: ", PositiveMatches, "\n"),
   write("Негативные совпадения: ", NegativeMatches, "\n"),
   length(PositiveMatches, PositiveCount),
   length(NegativeMatches, NegativeCount),
   MatchesCount = PositiveCount + NegativeCount,
   MatchesCount > 0,
   Percentage = (MatchesCount * 100) / TotalQuestions.

run :-
  delete_all,
  repeat,
  write("На вопросы отвечать (y-да, n-нет, q-не знаю).\n"),
  movie(X),
  write("Это фильм : ", X, "\n"),
  calculate_match_percentage(X, Percentage),
  write("Подходит с уверенностью: ", Percentage, "%\n"),
  write("Завершить работу программы (y/n): "), readchar(Z), write(Z), nl, Z='y'.

goal
  makewindow(1,7,7,"ЭС-3",0,0,25,80), run.
