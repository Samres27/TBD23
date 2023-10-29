ls= open("dataBaseScript3.sql","r");
ls2= open("baseMod.sql","w")
texto=ls.readlines()
text=[]
for x in texto:
   x=x.replace("drop table","drop table IF EXISTS")
   x=x.replace("drop index","drop index IF EXISTS")
   text.append(x);

ls2.writelines(text)