#include<dos.h>
#include<conio.h>
#include<stdio.h>
int main()
{
 char str[100]="   string!string!string!";
 unsigned int portn,regsn,regcn;
 int i=0;

 clrscr();
 /***** Получение номеров портов принтера ******/
 portn=peek(0x0,0x408);
 regsn=portn+1;
 regcn=regsn+1;
 /****** Инициализация принтера: начало ********/
 outportb(regcn,0x8);
 sleep(3);
 outportb(regcn,0xC);
 sleep(3);

 if(!(inportb(regsn)&0x8))
  {
  printf("Ошибка принтера: ");
  /****** Проверка на подключение к машине ******/
 if(!(inportb(regsn)&0x10)) {printf("Принтер не подключен");return 1;}
 /******* Проверка на отстутствие бумаги *******/
 if(inportb(regsn)&0x20) {printf("Нет бумаги");return 1;}
 /******* Проверка на занятость принтера ********/
 if(!(inportb(regsn)&0x80)) {printf("Принтер занят");return 1;}
 }
 printf("Печать:\n");

 while(str[i]!='\x0'){
  outportb(portn,str[i]);
  outportb(regcn,0xD);
  delay(10);
  outportb(regcn,0xC);

  while(!inportb(regsn)&0x80){
   if(!inportb(regsn)&0x8) {printf("Ошибка печати!\n"); return 1;}
  }
  i++;
 }

  outportb(portn,0xD);
  outportb(regcn,0xD);
  delay(10);
  outportb(regcn,0xC);

  outportb(portn,0xA);
  outportb(regcn,0xD);
  delay(10);
  outportb(regcn,0xC);

 printf("Пеpедача закончена.");
 getch();
 return 0;
}
