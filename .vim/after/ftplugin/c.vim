set formatoptions+=rocqln
set formatoptions-=t
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
syntax on
syntax keyword cType u8 u16 u32 u64 __u8 __u16 __u32 __u64 s8 s16 s32 s64 __s8 __s16 __s32 __s64
