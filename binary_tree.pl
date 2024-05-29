% Бобков, Жигалов, Копылов
% Вариант №7 задание 2
% Поиск максимальной длины бинарного дерева
% Определение, является ли бинарное дерево сбалансированным

% Предикат для определения длины (глубины) бинарного дерева
% Работает следующим образом: 
% Рекурсивно доходит до конца левой ветви, инициализируем счётчик
% Возращаясь из рекурсии прибавляет 1 за каждый узел дерева 
% к максимальному значению глубины его поддеревьев, 
% тем самым получая глубину текущего узла
% В конце возвращает максимальное значение из левых и правых поддеревьев для корня
depth(nil, 0).
depth(tree(_, Left, Right), Depth) :-
    depth(Left, LeftDepth),
    depth(Right, RightDepth),
    Depth is max(LeftDepth, RightDepth) + 1.

% Предикат для проверки сбалансированности бинарного дерева
% Бинарное дерево является сбалансированным, когда глубина левого поддерева
% отличается максимум на 1 от глубины правого, иначе бинарное дерево несбалансировано 
% Внутри предиката реализован подсчёт левого и правого поддерева, 
% затем сравнение модуля их разности, будет ли он <= 1
% если да, то бинарное дерево сбалансированно
% иначе - несбалансированно 
balanced(nil).
balanced(tree(_, Left, Right)) :-
    depth(Left, LeftDepth),
    depth(Right, RightDepth),
    abs(LeftDepth - RightDepth) =< 1.

% Пример использования:
% Сбалансированное бинарное дерево.
%       1
%      / \
%     2   3
%    / \ / \
%   4  5 6  7
%  /
% 8

%% test_tree(tree(1, tree(2, tree(4, tree(8, nil, nil), nil), tree(5, nil, nil)), tree(3, tree(6, nil, nil), tree(7, nil, nil)))).

% Несбалансированное бинарное дерево.
%         1
%        / \
%       2   3
%      / \ / \
%     4  5 6  7
%    /
%   8
%  /
% 10

test_tree(tree(1, tree(2, tree(4, tree(8, tree(10, nil, nil), nil), nil), tree(5, nil, nil)), tree(3, tree(6, nil, nil), tree(7, nil, nil)))).

run :-
	test_tree(Tree), 
	depth(Tree, Depth),
	write("Максимальная глубина: "),
	write(Depth),
	write("\nСбалансированно: "),
	balanced(Tree).
