function qnew=CreateNeighbor(q,modle)

    %get length
    N = modle.N;
    P_uc = modle.Puc;
    n = numel(q);

    %select a position
    i = randi([1,n]);
    qnew = q;

    %bianyi
    if i<= N
        qnew(i) = 3-q(i);

    elseif i <= (N+P_uc)
        qnew(i) = randi([1, N]);

    else
        qnew(i) = randi([1, N]);

    end
end


