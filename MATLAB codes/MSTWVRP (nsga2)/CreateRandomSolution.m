function q=CreateRandomSolution(modle)

    %import parameters from CreatModel.m
    N = modle.N;
    Puc = modle.Puc;
    Puh = modle.Puh;

    %create segment X_D
    X_D = randi([1,2],1,N);

    %create segment X_P,c
    X_Pc = randi([1, N], 1, Puc);

    %create segment X_P,h
    X_Ph = randi([1, N], 1, Puh);

    %
    q = [X_D, X_Pc, X_Ph];

    disp(q);

end