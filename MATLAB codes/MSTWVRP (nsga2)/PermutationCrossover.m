function [y1 y2]=PermutationCrossover(x1,x2,model)

    %import parameters from CreatModel.m
    N = model.N;
    Puc = model.Puc;
    Puh = model.Puh;

    %define fnejiedian
    c1 = N;
    c2 = N + Puc;

    % 3. 分别提取三个片段
    x1_D = x1(1:c1);    x1_Pc = x1(c1+1:c2);    x1_Ph = x1(c2+1:end);
    x2_D = x2(1:c1);    x2_Pc = x2(c1+1:c2);    x2_Ph = x2(c2+1:end);

    % 4. 对每一段分别执行交叉 (这里用简单的"单点交叉"为例)
    
    % --- 交叉 X_D 段 ---
    % (我们选 1 到 N-1 之间的点)
    cut_D = randi([1, N-1]);
    y1_D = [x1_D(1:cut_D), x2_D(cut_D+1:end)];
    y2_D = [x2_D(1:cut_D), x1_D(cut_D+1:end)];
    
    % --- 交叉 X_P,c 段 ---
    % (我们选 1 到 P_uc-1 之间的点)
    % (如果 P_uc == 1, randi 会报错, 需要加个判断)
    if Puc > 1
        cut_Pc = randi([1, Puc-1]);
        y1_Pc = [x1_Pc(1:cut_Pc), x2_Pc(cut_Pc+1:end)];
        y2_Pc = [x2_Pc(1:cut_Pc), x1_Pc(cut_Pc+1:end)];
    else
        % 如果该段长度为1，就不交叉，直接继承
        y1_Pc = x1_Pc;
        y2_Pc = x2_Pc;
    end
    
    % --- 交叉 X_P,h 段 ---
    if Puh > 1
        cut_Ph = randi([1, Puh-1]);
        y1_Ph = [x1_Ph(1:cut_Ph), x2_Ph(cut_Ph+1:end)];
        y2_Ph = [x2_Ph(1:cut_Ph), x1_Ph(cut_Ph+1:end)];
    else
        y1_Ph = x1_Ph;
        y2_Ph = x2_Ph;
    end

    % 5. 重新拼接成子代
    y1 = [y1_D, y1_Pc, y1_Ph];
    y2 = [y2_D, y2_Pc, y2_Ph];

end