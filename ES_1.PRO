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
	rule(1, "����", "����� ����", [1]).
	rule(2, "����", "���⪨� ����", [2]).

	rule(3, "����� ����", "����� �� ���襭��", [3,9]).
	rule(4, "����� ����", "1+1", [3,7,10]).
	rule(5, "����� ����", "������ �ਧࠪ���", [4,7,9]).
	rule(6, "����� ����", "��� ��᪮�� ��ਮ��", [4,5,6,12]).
	rule(7, "����� ����", "�����⥫���", [5,3,4,12]).
	rule(8, "����� ����", "����⥫�� �����", [4,5,6,3,10]).
	rule(9, "����� ����", "���ᨪ�� �� ������ ���஢", [7,3,4,5,9]).
	rule(10,"����� ����", "���⥫�", [6,5]).
	
	rule(11, "���⪨� ����", "����", [13,3,6,12]).
	rule(12, "���⪨� ����", "����� �஬", [4,5,6,8,9]).
	rule(13, "���⪨� ����", "�����⢨� �� ���", [5,12]).
	
	cond(1, "��������ࠦ��").
	cond(2, "���⪮���ࠦ��").
	cond(3, "�ࠬ�").
	cond(4, "�ਪ��祭��").
	cond(5, "�����⨪�").
	cond(6, "��襭").
	cond(7, "�����").
	cond(8, "�������").
	cond(9, "�� ஬���").
	cond(10, "�� �����").
	cond(11, "�� ॠ��� ᮡ���").
	cond(12, "�ਣ������ �業�਩").
	cond(13, "�����").
	
	exp:- 
		makewindow(1,7,7,"��(1)",0,0,25,80), 
		menu, nl, 
		write("������ ��� ��室� -> "), 
		readchar(_), exit.
	menu:-
		write("1, ���������"), nl,
		write("2, ��室"), nl,
		write("��� �롮� (1 ��� 2) -> "),
		readint(Ch), process(Ch).
	
	process(1):-
		cconsult("����"), clear.
	process(2):-
		removewindow.
	
	cconsult(X):- work([],X), !.
	cconsult(_):- 
		nl, write("��� ���室��� 䨫쬮�").
	cconsult(_).
	
	work(_, X):- 
		not(rule(_,X,_,_)), !, nl,
		write("��� �롮� -> ", X), nl.
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
		write("�����: ", TEXT, "?"),
		write(" (1 ��� 2) -> "),
		readint(RESP),
		answer(H, RNO, TEXT, BNO, RESP).
	answer(_,_,_,BNO, 1):-
		asserta(yes(BNO)), 
		write("��"), nl.
	answer(_,_,_,BNO,2):-
		asserta(no(BNO)),
		write("���"), nl, fail.
	
	clear:- 
		retract(yes(_)), fail;
		retract(no(_)), fail.
	clear.
goal
	exp.