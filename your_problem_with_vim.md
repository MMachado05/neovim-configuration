# Your problem with Vim is that you don't grok Vi.

You mention cutting with `yy` and complain that you almost never want to cut whole lines.
In fact programmers, editing source code, very often want to work on whole lines, ranges
of lines and blocks of code. However, `yy` is only one of many way to yank text into the
anonymous copy buffer (or "register" as it's called in **vi**).

The "Zen" of **vi** is that you're speaking a language. The initial `y` is a verb. The
statement `yy` is a synonym for `y_`. The `y` is doubled up to make it easier to type,
since it is such a common operation.

This can also be expressed as `dd` `P` (delete the current line and paste a copy back
into place; leaving a copy in the anonymous register as a side effect). The `y` and `d`
"verbs" take any movement as their "subject." Thus `yW` is "yank from here (the cursor)
to the end of the current/next (big) word" and `y'a` is "yank from here to the line
containing the mark named 'a'."

If you only understand basic up, down, left, and right cursor movements then vi will
be no more productive than a copy of "notepad" for you. (Okay, you'll still have syntax
highlighting and the ability to handle files larger than a piddling ~45KB or so; but
work with me here).

vi has 26 "marks" and 26 "registers." A mark is set to any cursor location using the `m`
command. Each mark is designated by a single lower case letter. Thus `ma` sets the 'a'
mark to the current location, and `mz` sets the 'z' mark. You can move to the line
containing a mark using the `'` (single quote) command. Thus `'a` moves to the beginning
of the line containing the 'a' mark. You can move to the precise location of any mark
using the `\`` (backquote) command. Thus  `\`z` will move directly to the exact location
of the 'z' mark.

Because these are "movements" they can also be used as subjects for other "statements."

So, one way to cut an arbitrary selection of text would be to drop a mark (I usually use
'a' as my "first" mark, 'z' as my next mark, 'b' as another, and 'e' as yet another
(I don't recall ever having interactively used more than four marks in 15 years of using
vi; one creates one's own conventions regarding how marks and registers are used by
macros that don't disturb one's interactive context). Then we go to the other end of our
desired text; we can start at either end, it doesn't matter. Then we can simply use
`d\`a` to cut or `y\`a` to copy. Thus the whole process has a 5 keystrokes overhead
(six if we started in "insert" mode and needed to Esc out command mode). Once we've cut
or copied then pasting in a copy is a single keystroke: `p`.

I say that this is one way to cut or copy text. However, it is only one of many.
Frequently we can more succinctly describe the range of text without moving our cursor
around and dropping a mark. For example if I'm in a paragraph of text I can use `{` and `}`
movements to the beginning or end of the paragraph respectively. So, to move a paragraph
of text I cut it using `{ d}` (3 keystrokes). (If I happen to already be on the first
or last line of the paragraph I can then simply use `d}` or `d{` respectively.

The notion of "paragraph" defaults to something which is usually intuitively reasonable.
Thus it often works for code as well as prose.

Frequently we know some pattern (regular expression) that marks one end or the other of
the text in which we're interested. Searching forwards or backwards are movements in vi.
Thus they can also be used as "subjects" in our "statements." So I can use `d/foo` to
cut from the current line to the next line containing the string "foo" and `y?bar` to
copy from the current line to the most recent (previous) line containing "bar." If I
don't want whole lines I can still use the search movements (as statements of their own),
drop my mark(s) and use the `\`x` commands as described previously.

In addition to "verbs" and "subjects" vi also has "objects" (in the grammatical sense
of the term). So far I've only described the use of the anonymous register. However, I
can use any of the 26 "named" registers by prefixing the "object" reference with `"`
(the double quote modifier). Thus if I use `"add` I'm cutting the current line into the
'a' register and if I use `"by/foo` then I'm yanking a copy of the text from here to
the next line containing "foo" into the 'b' register. To paste from a register I simply
prefix the paste with the same modifier sequence: `"ap` pastes a copy of the 'a'
register's contents into the text after the cursor and `"bP` pastes a copy from 'b' to
before the current line.

This notion of "prefixes" also adds the analogs of grammatical "adjectives" and
"adverbs" to our text manipulation "language." Most commands (verbs) and movement
(verbs or objects, depending on context) can also take numeric prefixes. Thus `3J` means
"join the next three lines" and `d5}` means "delete from the current line through the
end of the fifth paragraph down from here."

This is all intermediate level vi. None of it is Vim specific and there are far more
advanced tricks in vi if you're ready to learn them. If you were to master just these
intermediate concepts then you'd probably find that you rarely need to write any macros
because the text manipulation language is sufficiently concise and expressive to do most
things easily enough using the editor's "native" language.
