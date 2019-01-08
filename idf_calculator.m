function idfs = idf_calculator(dict,captions)
    idfs = zeros(size(dict,2),1);
    n_total_files = size(captions,2);
    for i=  1:size(dict,2)
        cur_word = dict(i);
        [I,J] = find(captions == cur_word);
        included_files = unique(J);
        idfs(i) = log(n_total_files / (size(included_files,1)+1));
    end
end