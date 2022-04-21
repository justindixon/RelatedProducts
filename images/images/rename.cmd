setlocal EnableDelayedExpansion
set /a count=0
for %%a in (*.jpg) do (
set /a count+=1
ren "%%a" "!count!.jpg"
echo !count!
)



