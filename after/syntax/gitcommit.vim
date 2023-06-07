" See https://github.com/tpope/vim-git/issues/21
syn clear   gitcommitSummary
syn match   gitcommitSummary	"^.*\%<72v." contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
