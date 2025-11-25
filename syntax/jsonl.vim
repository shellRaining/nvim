" Vim syntax file
" Language: JSON Lines (JSONL)
" Maintainer: shellraining
" Latest Revision: 2025-01-18

if exists("b:current_syntax")
  finish
endif

" Use JSON syntax as the base
runtime! syntax/json.vim

" Set the syntax name
let b:current_syntax = "jsonl"

" Ensure each line is treated independently
" This allows proper syntax highlighting for each JSON object on its own line
syn sync minlines=1
