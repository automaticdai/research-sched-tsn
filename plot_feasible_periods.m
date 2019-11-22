S = candidate_solutions;

search_numel = size(candidate_solutions, 1);

X = [];
Y = [];
Z = [];

for i = 1:search_numel
    for j = 1:search_numel
        for k = 1:search_numel
            if(candidate_solutions(i,j,k) == 1)
                X = [X; i];
                Y = [Y; j];
                Z = [Z; k];
            end
        end
    end
end

scatter3(X,Y,Z, 'rx');
xlim([1 9])
ylim([1 9])
zlim([1 9])
