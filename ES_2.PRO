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
	film_is("����� �� ���襭��"):-
		it_is("����� ����"),
		pos("�ࠬ�"),
		pos("�� ஬���").
	film_is("1+1"):-
		it_is("����� ����"),
		pos("�ࠬ�"),
		pos("�������"),
		pos("�� �����").
	film_is("������ �ਧࠪ���"):-
		it_is("����� ����"),
		pos("�����"),
		pos("�ਪ��祭��"),
		pos("�� ஬���").
	film_is("��� ��᪮�� ��ਮ��"):-
		it_is("����� ����"),
		pos("�ਪ��祭��"),
		pos("�����⨪�"),
		pos("��襭"),
		pos("�ਣ������ �業�਩").
	film_is("�����⥫���"):-
		it_is("����� ����"),
		pos("�ࠬ�"),
		pos("�ਪ��祭��"),
		pos("�����⨪�"),
		pos("�ਣ������ �業�਩").
	film_is("����⥫�� �����"):-
		it_is("����� ����"),
		pos("�ࠬ�"),
		pos("�ਪ��祭��"),
		pos("�����⨪�"),
		pos("��襭"),
		pos("�� �����").
	film_is("���ᨪ�� �� ������ ���஢"):-
		it_is("����� ����"),
		pos("�����"),
		pos("�ࠬ�"),
		pos("�ਪ��祭��"),
		pos("�����⨪�"),
		pos("�� ஬���").
	film_is("���⥫�"):-
		it_is("����� ����"),
		pos("��襭"),
		pos("�����⨪�").
	film_is("����"):-
		it_is("���⪨� ����"),
		pos("�����"),
		pos("�ࠬ�"),
		pos("��襭"),
		pos("�ਣ������ �業�਩").
	film_is("����� �஬"):-
		it_is("���⪨� ����"),
		pos("�ਪ��祭��"),
		pos("�����⨪�"),
		pos("��襭"),
		pos("�������"),
		pos("�� ஬���").
	film_is("�����⢨� �� ���"):-
		it_is("���⪨� ����"),
		pos("�����⨪�"),
		pos("�ਣ������ �業�਩").

	it_is("����� ����"):-
		pos("����� ����"),!.
	it_is("���⪨� ����"):-
		pos("���⪨� ����"),!.
	
	exp:- 
		makewindow(1,7,7,"��-2",1,16,22,58), 
		nl, cconsult, nl, nl,
		write("������ ��� ��室� -> "), 
		readchar(_), removewindow, exit.
	
	cconsult:- 
		film_is(X),!,nl, 
		write("��� �롮� -> ", X,"."), nl, 
		clear_rules.
	cconsult:- 
		nl, write("��� ���室��� 䨫쬮�"), nl, 
		clear_rules.
	
	question(X):-
		write("�����: ", X, "?"),
		write(" ('��/�' ��� '���/�') -> "),
		readln(REPLY),
		remember(X, REPLY).

	pos(X):- xpositive(X),!.
	pos(X) :- not(neg(X)), !, question(X).
	neg(X) :- xnegative(X),!.

	remember(X, "��"):- asserta(xpositive(X)).
	remember(X, "�"):- asserta(xpositive(X)).
	
	remember(X, "���"):- asserta(xnegative(X)), fail.
	remember(X, "�"):- asserta(xnegative(X)), fail.
	
	clear_rules:- 
		retract(xpositive(_)), fail.
	clear_rules:-
		retract(xnegative(_)), fail.
goal
	exp.