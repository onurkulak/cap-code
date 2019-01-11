function [count,label] = createLabel(photoList,targetRows,learned_weights1,learned_weights2)
    %Photolist is a matrix N x feature_vec_size. It has the feaute vectors
    %for each N photos in the photoList.
    count = 0;
    label = '';
    maxCost = 9999999999;
    N = size(photoList,1);
    labelLists = zeros(N,10);
    for i=1:N
        labelLists(i) = predictor(photoList(i,:),learned_weights1,learned_weights2);
    end
    
    for i=N:-1:1
        combos = combntns(1:N,i);
        for j= 1:size(combos,1)
            currentComb = combos(j,:);
            curLabelList = unique(labelLists(currentComb));
            if isempty(curLabelList)
                continue;
            end
            for k =1:size(curLabelList)
                %Check here if any non target photo has the label in a
                %higher rank than the target photos
                
                
                %Code goes here
                
                %Calculate Cost
                [cost] = calculateCost(curLabelList(k),labelLists,targetRows);
                if cost < max
                    max = cost;
                    label = curLabelList(k);
                    count = i;
                end
                
            end
        end
    end
end