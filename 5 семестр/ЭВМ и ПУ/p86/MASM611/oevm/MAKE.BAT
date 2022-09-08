rm test.obj
rm user.obj
ml /c /Zi test.asm
ml /c /Zi user.asm
link test.obj+user.obj,test1