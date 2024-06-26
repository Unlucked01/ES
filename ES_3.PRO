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

  movie("����� � ���饥"):-positive("���筠� 䠭��⨪�"),positive("�ਪ��祭��"),
                            positive("�������"), negative("�ࠬ�"), negative("������"), positive("1985").


  movie("��⠭��"):-positive("�ࠬ�"),positive("஬��⨪�"), negative("���筠� 䠭��⨪�"), negative("�������"), negative("�������"),
                    positive("1997").

  movie("����⥫�� �����"):-positive("���⥧�"),positive("�ਪ��祭��"),
                            positive("����᪨�"), negative("���筠� 䠭��⨪�"), positive("2001").

  movie("��� �����"):-positive("������"),positive("�ਫ���"), negative("�������"),
                          positive("2008").

  movie("��᫮������"):-positive("�������"),positive("������"), negative("�������"),
                         positive("2014").

  movie("������� � ������㤥"):-positive("�������"),positive("�ࠬ�"),
                                positive("�ਬ����"), negative("������"), positive("2019").

  movie("��������� 䨫�").

  movie_positive("����� � ���饥", "���筠� 䠭��⨪�").
  movie_positive("����� � ���饥", "�ਪ��祭��").
  movie_positive("����� � ���饥", "�������").
  movie_positive("����� � ���饥", "1985").
  movie_negative("����� � ���饥", "�ࠬ�").
  movie_negative("����� � ���饥", "������").

  movie_positive("��⠭��", "�ࠬ�").
  movie_positive("��⠭��", "஬��⨪�").
  movie_positive("��⠭��", "1997").
  movie_negative("��⠭��", "�������").
  movie_negative("��⠭��", "���筠� 䠭��⨪�").
  movie_negative("��⠭��", "�������").

  movie_positive("����⥫�� �����", "���⥧�").
  movie_positive("����⥫�� �����", "�ਪ��祭��").
  movie_positive("����⥫�� �����", "����᪨�").
  movie_positive("����⥫�� �����", "2001").
  movie_negative("����⥫�� �����", "���筠� 䠭��⨪�").

  movie_positive("��� �����", "������").
  movie_positive("��� �����", "�ਫ���").
  movie_positive("��� �����", "2008").
  movie_negative("��� �����", "�������").

  movie_positive("��᫮������", "�������").
  movie_positive("��᫮������", "������").
  movie_positive("��᫮������", "2014").
  movie_negative("��᫮������", "�������").

  movie_positive("������� � ������㤥", "�������").
  movie_positive("������� � ������㤥", "�ࠬ�").
  movie_positive("������� � ������㤥", "�ਬ����").
  movie_positive("������� � ������㤥", "2019").
  movie_negative("������� � ������㤥", "������").

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
   write("���� 䨫쬠: ", MovieQuestions, "\n"),
   length(MovieQuestions, TotalQuestions),
   TotalQuestions > 0,
   find_matches(Movie, PositiveMatches, NegativeMatches),
   write("������⥫�� ᮢ�������: ", PositiveMatches, "\n"),
   write("����⨢�� ᮢ�������: ", NegativeMatches, "\n"),
   length(PositiveMatches, PositiveCount),
   length(NegativeMatches, NegativeCount),
   MatchesCount = PositiveCount + NegativeCount,
   MatchesCount > 0,
   Percentage = (MatchesCount * 100) / TotalQuestions.

run :-
  delete_all,
  repeat,
  write("�� ������ �⢥��� (y-��, n-���, q-�� ����).\n"),
  movie(X),
  write("�� 䨫� : ", X, "\n"),
  calculate_match_percentage(X, Percentage),
  write("���室�� � 㢥७������: ", Percentage, "%\n"),
  write("�������� ࠡ��� �ணࠬ�� (y/n): "), readchar(Z), write(Z), nl, Z='y'.

goal
  makewindow(1,7,7,"��-3",0,0,25,80), run.
