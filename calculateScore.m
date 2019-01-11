function [score] = calculateScore(Label,LabelLists,targetRows)
    score = 0;
    for n =1:size(LabelLists)
        curPhotoLabels = LabelLists(1,:,n);
        index = find(curPhotoLabels == Label);
        if( ~isempty(index))
            if(find(targetRows==n))
                score  = score +  LabelLists(2,index,n);
            else
                score  = score -  LabelLists(2,index,n);
            end
        end
    end
end