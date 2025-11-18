function PlotSolution(sol, model)

    % 1. 计算每个医生的工作量
    workload = cellfun('length', sol.Assignments);

    % 2. 画出柱状图
    bar(workload);

    xlabel('医生编号 (N)');
    ylabel('分配到的患者数量');
    title('最优解的工作量分配');

end