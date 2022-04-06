return {
    check = function(text, listener, blocks)
        local text = UTF8.trim(text)

        if UTF8.len(text) > 0 then
            for i = 1, #blocks do
                if blocks[i].text.text == text then
                    listener({isError = true, typeError = 'name'}) return
                end
            end
        else
            listener({isError = true, typeError = 'filter'}) return
        end

        listener({isError = false, text = text}) return
    end
}
