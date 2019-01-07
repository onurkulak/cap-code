function y = printCaption(word_key, word_index)
num_of_index = length(word_index);
y = '';
    for i=1:num_of_index
        str = sprintf(word_key.id_2_word(:,word_index(i)));
        y = [y, ' ', str];
    end
end