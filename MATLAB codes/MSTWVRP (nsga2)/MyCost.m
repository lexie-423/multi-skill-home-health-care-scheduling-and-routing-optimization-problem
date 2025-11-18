function [z sol]=MyCost(q,model)
global NFE;
    if isempty(NFE)
        NFE=0;
    end
    NFE=NFE+1;

    % 1. 调用你刚写好的“解码器”
    sol=ParseSolution(q,model);

    % --- 2. 写入你的新目标 (简化版) ---

    % 目标1：最小化“被使用的医生总数”
    % cellfun('isempty', ...) 检查哪些医生的任务列表是空的
    doctors_used = sum(~cellfun('isempty', sol.Assignments));
    z1 = doctors_used;

    % 目标2：最小化“工作量不均衡度”
    % cellfun('length', ...) 计算每个医生被分配了多少个任务
    workload = cellfun('length', sol.Assignments);
    z2 = std(workload); % 计算工作量的标准差

    % 3. 设置最终输出
    z=[z1 z2];
   
end
