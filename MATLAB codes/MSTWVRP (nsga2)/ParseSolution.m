function sol=ParseSolution(q, model) % (确保你的文件名和函数名一致)

    % --- 1. 从 model 中获取参数 (规则书) ---
    N = model.N;
    Puc = model.Puc;
    Puh = model.Puh;
    
    docskill = model.docskill;
    patskillc = model.patskilluc; 
    patskillh = model.patskilluh;
    
    % --- 2. 从 q 中切割染色体 (基因蓝图) ---
    X_D = q(1:N);
    X_Pc = q(N+1 : N+Puc);
    X_Ph = q(N+Puc+1 : end);

    % --- 3. 初始化 sol (输出的“解”) ---
    sol.Assignments = cell(1, N); % 使用 model.N (即 N)

    % --- 4. 解析 X_D，划分医生团队 ---
    % (修正：使用来自 q 的 X_D，而不是 model.X_D)
    teamc = find(X_D == 1);
    teamh = find(X_D == 2);
    
    % (防崩溃逻辑)
    if isempty(teamc)
        teamc = [1]; 
    end
    if isempty(teamh)
        teamh = [1];
    end

    % --- 5. 遍历中心患者 (Puc 循环) ---
    for p = 1:Puc % (Puc 来自 model，是正确的)
        
        k = X_Pc(p); % (修正：使用来自 q 的 X_Pc)
        skillreq = patskillc(p); % (修正：使用第7行定义的 patskillc)
        
        Lp = [];
        for doc_index = teamc
            % (修正：使用第6行定义的 docskill)
            if docskill(doc_index) == skillreq 
                Lp = [Lp, doc_index];
            end
        end
        
        if isempty(Lp)
            Lp = teamc;
            if isempty(Lp)
                Lp = [1];
            end
        end
        
        kprime = mod(k-1, numel(Lp)) + 1;
        assigndoc = Lp(kprime);
        sol.Assignments{assigndoc} = [sol.Assignments{assigndoc}, p];
    end
    
    % --- 6. 遍历上门患者 (Puh 循环) ---
    for p = 1:Puh % (Puh 来自 model，是正确的)
        
        k = X_Ph(p); % (你这行本来就是对的)
        skillreq = patskillh(p); % (你这行本来就是对的)
        
        Lp = [];
        for doc_index = teamh 
            % (修正：使用第6行定义的 docskill)
            if docskill(doc_index) == skillreq 
                Lp = [Lp, doc_index];
            end
        end
        
        if isempty(Lp)
            Lp = teamh;
            if isempty(Lp)
                Lp = [1];
            end
        end
        
        kprime = mod(k-1, numel(Lp)) + 1; 
        assigndoc = Lp(kprime);
        
        sol.Assignments{assigndoc} = [sol.Assignments{assigndoc}, p + Puc];
    end
    
end
