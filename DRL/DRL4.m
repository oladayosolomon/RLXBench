classdef DRL4 < PROBLEM
% <multi> <real> <large/none>
% Benchmark MOP with bias feature

%------------------------------- Reference --------------------------------
%
%------------------------------- Copyright --------------------------------
% Copyright (c) 2023 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        %% Default settings of the problem

        function Setting(obj)
            obj.M = 3;
            if isempty(obj.D); obj.D = 5380; end
            obj.lower     = ones(1,obj.D)*-1;
            obj.upper     = ones(1,obj.D);
            obj.encoding = ones(1,obj.D);

        end
        %% Calculate objective values
        function PopObj = CalObj(obj,X)
            
            PopObj = pyrunfile("mat_eval_env.py","fitnesses",env='four-room-v0', agent='A2C', policy='MlpPolicy', weights=X);
            PopObj = double(PopObj);
        end

    end
end 

