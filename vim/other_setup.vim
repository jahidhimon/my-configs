" Airline " {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" airline symbols
let g:airline_left_sep = "\uE0B8"
let g:airline_left_alt_sep = "\uE0B9"
let g:airline_right_sep = "\uE0BA"
let g:airline_right_alt_sep = "\uE0BB"
" }}}

" ** tabular Haskell
let g:haskell_tabular = 1
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" ** vim slime
" let g:slime_no_mappings=1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}


