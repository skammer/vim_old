function! s:swap_lines( n1, n2 )
    let line1 = getline( a:n1 )
    let line2 = getline( a:n2 )
    call setline( a:n1, line2 )
    call setline( a:n2, line1 )
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    let save_cursor = getpos(".")
    call s:swap_lines(n, n - 1)
    let save_cursor[1]-=1
    call setpos('.', save_cursor)
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    let save_cursor = getpos(".")
    call s:swap_lines(n, n + 1)
    let save_cursor[1]+=1
    call setpos('.', save_cursor)
endfunction

noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
noremap <silent> <c-s-down> :call <SID>swap_down()<CR>
inoremap <silent> <c-s-up> <Esc>:call <SID>swap_up()<CR>a
inoremap <silent> <c-s-down> <Esc>:call <SID>swap_down()<CR>a
vnoremap <silent> <c-s-up> :call <SID>swap_up()<CR>
vnoremap <silent> <c-s-down> :call <SID>swap_down()<CR>

