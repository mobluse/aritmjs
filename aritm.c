/*** A_r_i_t_m  -  trÑnar dig i enkel huvudrÑkning
 *** Copyright (C) 1992-93  Mikael Bonnier, Lund, Sweden
 *** Prerequisite: ANSI.SYS or other equivalent ansidriver loaded.
 *** Compile: bcc -ms aritm.c
 ***/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <conio.h>
#include <dos.h>
#include <dir.h>
#include <string.h>

#define MAXQUEST 480
#define MULSIGN '\xFA'
#define DIVSIGN '/'
#define DECSIGN ','
#define COL 40       // Is where comments to user is written.
#define ATTNFQ 2000
#define KEYBFQ 5000
#define OTHERERR 2

#define bell(frequency) {    \
					sound(frequency);  \
					delay(100);  			 \
					nosound();   			 \
				} /*** bell() ***/

#define toupperx(ch) { 			   \
					(ch) = toupper(ch);  \
					if((ch) == 'Ü') 	   \
						(ch) = 'è'; 		   \
				} /*** toupperx(ch) ***/

void genadd(char mod);
void gensub(char mod);
void genmul(char mod);
void gendiv(char mod);
void shuffle(void);
void ask(void);
int pack(void);
void instructions(int exitstatus);
int ultragets(char *strbuf, int maxchars, const char *allwd);
char *itoword(int number);  // number<1000
void expndquest(char *qbuf, int indx);
void prequit(void);

/*** Yes I do know that some of these variables shouldn't be global
		in good style programming.
 ***/

struct entry
{
	char op1;
	char op1exp;
	char sign;
	char op2;
	char op2exp;
	char ans;
	char ansexp;
	char correct;
} quest[MAXQUEST];

int index[MAXQUEST];

int k;    // Number of elements in array quest[] that are used in ask().
int reqd; // Number of times a question must be answered correctly
					// 	 before it is removed from active part of quest[].
int tot;  // Total number of questions asked so far.

char switchar;
char *progpath; // argv[0] is assigned to this.
char argmode[20];
char wrongfile[13];


void main(int argc, char *argv[])
{
	int i;
	clock_t ticks1, ticks2;
	union REGS ioregs;

	progpath = argv[0];
	randomize();
	k = 0;
	reqd = 1;
	tot = 0;
	printf("A_r_i_t_m  -  trÑnar dig i enkel huvudrÑkning"
			 "\nCopyright (C) 1992-93  Mikael Bonnier, Lund, Sweden");
	ioregs.h.ah = 0x37; 		// DOS SWITCHAR subfunction of INT 21h
	ioregs.h.al = 0x00; 		// Get current SWITCHAR
	intdos(&ioregs, &ioregs);
	switchar = ioregs.h.dl;	// return in register DL
	if(argc<2 || argc>5) {
		printf("\n\nFel antal omkopplare. Mellan en och fyra Ñr pÜbjudet.");
		instructions(1);
	}
	strcpy(wrongfile, "prn");
	for(i=1; i<argc; ++i) {
		if(argv[i][0] != '-' && argv[i][0] != '/') {
			printf("\n\nOgiltigt omkopplartecken: '%c'", argv[i][0]);
			instructions(1);
		}
		switch(argv[i][1]) {
			case 'a': genadd(argv[i][2]);
								break;
			case 's': gensub(argv[i][2]);
								break;
			case 'm': genmul(argv[i][2]);
								break;
			case 'd': gendiv(argv[i][2]);
								break;
			case 'l': // literal number words
								break;
			case 'f': strcpy(wrongfile, &argv[i][2]);  // make more secure
								break;
			case '?': instructions(0);
			default:  printf("\n\nOgiltig omkopplare: '%c'", argv[i][1]);
									instructions(1);
		} /*** switch(argv[i][1]) ***/
		argmode[i-1] = argv[i][1];
	} /*** for(i=1...) ***/
	argmode[i-1] = '\0';

	for(i=0; i<k; ++i)
		quest[i].correct = 0;
	for(i=0; i<k; ++i)
		index[i] = i;
/*	for(i=0; i<1000; ++i)
		printf("\n%3d=\"%s\"", i, itoword(i));
*/
	printf("\n\n%d frÜgor.", k);
	ticks1 = clock();
	do {
		shuffle();
		ask();
	} while(pack());
	ticks2 = clock();
	printf("\n\nBra!!!   Du klarade %.0f frÜgor/minut.   \2 \1 \2 \1 \2"
			 , (CLK_TCK*tot*60)/(ticks2-ticks1) );
} /*** main() ***/


void genadd(char mod)
{
	int i, j;

	if(mod != '\0' && mod != '0' && mod != '1') {
		printf("\n\nAddition, ogiltig omkopplarmodifierare: '%c'", mod);
		instructions(1);
	}
	for(i=0; i<=9; ++i)
		for(j=0; j<=9; ++j) {
			quest[k].op1 = (mod=='1' ? 10*(random(8)+1) : 0) + i;
			quest[k].sign = '+';
			quest[k].op2 = j;
			quest[k].ans = quest[k].op1+j;
			k++;
		}
} /*** genadd() ***/


void gensub(char mod)
{
	int i, j;

	if(mod!='\0' && mod!='0' && mod!='1' && mod!='2' && mod!='3') {
		printf("\n\nSubtraktion, ogiltig omkopplarmodifierare: '%c'", mod);
		instructions(1);
	}
	for(i=0; i<=9; ++i)
		for(j=i; j<=9+i; ++j) {
			quest[k].op1 = (mod=='2' || mod=='3' ? 10*(random(9)+1) : 0)+j;
			quest[k].sign  =  mod=='1' || mod=='3' ? 'f' : '-';
			quest[k].op2 = i;
			quest[k].ans = quest[k].op1-i;
			k++;
		}
} /*** gensub() ***/


void genmul(char mod)
{
	int i, j;

	for(i=0; i<=9; ++i)
		for(j=0; j<=9; ++j) {
			quest[k].op1 = i;
			quest[k].sign = MULSIGN;
			quest[k].op2 = j;
			quest[k].ans = i*j;
			k++;
		}
} /*** genmul() ***/


void gendiv(char mod)
{
	int q, d;

	for(q=0; q<=9; ++q)
		for(d=1; d<=9; ++d) {
			quest[k].op1 = q*d+random(d);
			quest[k].sign = DIVSIGN;
			quest[k].op2 = d;
			quest[k].ans = q;
			k++;
		}
} /*** gendiv() ***/


void shuffle(void)
{
	int i, j, temp;

	for(i=0; i<k; ++i) {
		j = random(k);
		temp = index[i];
		index[i] = index[j];
		index[j] = temp;
	}
} /*** shuffle() ***/


void ask(void)
{
	int i, j;
	int ans;
	int anslen;
	int numdgt;
	char qbuf[81];
	char ansbuf[6];


	for(i=0; i<k; ++i) {
		j = index[i];
		expndquest(qbuf, j);
ierr:
			printf("\n\n%s", qbuf);
			anslen = ultragets(ansbuf, 5, "0123456789");
			if( ansbuf[0] == '\0' ) {
				bell(ATTNFQ);
				printf("\r\x1B[%dCFîrsîk igen.", COL);
							// Requires ANSI terminal, COL right.
				goto ierr;
			}
		// end of ierr loop
		ans = atoi(ansbuf);
		++tot;
		printf("\r\x1B[%dC", strlen(qbuf)+anslen);
		// Requires ANSI terminal, strlen(qbuf)+length_of_answer right.
		if(ans == quest[j].ans) {
			++quest[j].correct;
			printf(" RÑtt!");
		}
		else {
			--quest[j].correct;
			bell(ATTNFQ);
			printf(" Fel.%20c\r\x1B[%dC%s\b\b Ñr %d.", ' ', COL, qbuf,
				quest[j].ans);
			break; // Stop asking if wrong answer, break for(i=0...).
		}
	} /*** for(i=0...) ***/
} /*** ask() ***/


int pack(void)
{
	int i, j, n = 0;

	for(i=0; i<k; ++i) {
		j = index[i];
		if(quest[j].correct < reqd)
			index[n++] = j;
	}
	k = n;
	return k;
} /*** pack() ***/


void instructions(int exitstatus) // uses global variable progpath.
{
	FILE *in;
	char *inst_str;
	int n;
	int ch;
	char derivname[128];
	char *completename;
	const size_t AHEAD = 2;

	strcpy(derivname, progpath);
	strcpy(strrchr(derivname, '.'), ".PRF");
	if( NULL == (completename = searchpath(derivname)) ) {
		fprintf(stderr, "\n\naritm: Filen '%s' hittas inte.", derivname);
		exit(OTHERERR);
	}
	if( NULL == (in = fopen(completename, "rt")) ) {
		fprintf(stderr, "\n\naritm: Filen '%s' kan inte îppnas.", completename);
		exit(OTHERERR);
	}
	fseek(in, 0L, SEEK_SET);
	n = 0;
	if((inst_str = (char *)malloc(AHEAD*sizeof(char)))!=NULL) {
		ch = fgetc(in);
		while( ch != EOF ) {
			inst_str[n++] = ch;
			ch = fgetc(in);
			if(n%AHEAD == 0)
				if((inst_str = (char *)realloc(inst_str, (n+AHEAD)*sizeof(char)))
						==NULL)
					break;
		} /*** while( ch != EOF ) ***/
	} /*** if((inst_str...)!=NULL) ***/
	fclose(in);
	if(inst_str == NULL) {
		fprintf(stderr, "\n\naritm: Slut pÜ minnet.");
		exit(OTHERERR);
	}
	inst_str[n] = '\0';
	printf(inst_str, switchar, DIVSIGN, /**DIVSIGN, DECSIGN,**/
				 MULSIGN/**, MULSIGN**/);
// Features to be inqluded:
//						  "\n\t\t\t\t1: ﬁ_X%cY_›, 0ÛXÛ89000, 0%c001ÛYÛ9000"
//							"\n\t\t\t\t1: X%cY, 0ÛXÛ9000, 0ÛYÛ9000"
	free(inst_str);
	exit(exitstatus);
} /*** instructions() ***/


/* Similar to gets, returns number_of_characters stored */
int ultragets(char *strbuf, int maxchars, const char *allwd)
{
		int n = 0;

		while(1) {
			strbuf[n] = getch();
			if(strbuf[n] == '\0')
				getch();
			if(strbuf[n] == '\r')
				break;
			if(strbuf[n] == '\x1B') // Esc
				prequit();
			if(strbuf[n] == '\b') {
				if(n>0) {
					printf("\b \b");
					--n;
				}
				else
					bell(KEYBFQ);
			}
			else if(n < maxchars) {
				if(strchr(allwd, strbuf[n]) && strbuf[n] != '\0')
					putchar(strbuf[n++]);
				else
					bell(KEYBFQ);
			}
			else
				bell(KEYBFQ);
		}  // while(1)
		strbuf[n] = '\0';
		return(n);
} /*** ultragets() ***/


char *itoword(int number)  // number<1000
{
	static char literal[21];
	static char *unitword[] = {"noll", "ett", "tvÜ", "tre", "fyra", "fem",
														 "sex", "sju", "Ütta", "nio"};
	// Vardagliga ord.
	static char *teenword[] = {"tio", "elva", "tolv", "tretton", "fjorton",
														"femton", "sexton", "sjutton", "arton", "nitton"};
	static char *tensword[] = {"noll", "tio", "tjugo", "tretti", "fîrti",
														"femti", "sexti", "sjutti", "Ütti", "nitti"};
	char decstr[4];
	int n, lenleft;

	literal[0] = '\0';
	if(number>=1000)
		return literal;
	itoa(number, decstr, 10);
	n = 0;
	lenleft = strlen(decstr);
	if(lenleft == 3) {
		strcat(literal, unitword[decstr[n]-'0']);
		strcat(literal, "hundra");
		++n;
		lenleft = 2;
	}
	if(lenleft == 2) {
		if(decstr[n] == '0') {
			if(decstr[++n] == '0')
				lenleft = 0;
			else
				lenleft = 1;
		}
		else if(decstr[n] == '1') {
			strcat(literal, teenword[decstr[n+1]-'0']);
			lenleft = 0;
		}
		else {
			strcat(literal, tensword[decstr[n]-'0']);
			if(decstr[++n] == '0')
				lenleft = 0;
			else
				lenleft = 1;
		}
	}
	if(lenleft == 1)
		strcat(literal, unitword[decstr[n]-'0']);
	return literal;
} /*** itoword() ***/


void expndquest(char *qbuf, int indx)
{
	char tmpbuf[21];
	int litr;
	char *opertn;

	litr = (int)strchr(argmode, 'l');
	switch(quest[indx].sign) {
		case DIVSIGN: if(litr) {
										strcpy(tmpbuf, itoword(quest[indx].op1));
										toupperx(tmpbuf[0]);
										sprintf(qbuf, "%s heltalsdelat med %s? ", tmpbuf,
														itoword(quest[indx].op2));
									}
									else
										sprintf(qbuf, "\xDE_%d%c%d_\xDD= ", quest[indx].op1,
														quest[indx].sign, quest[indx].op2);
									break;
		case 'f':			if(litr) {
										strcpy(tmpbuf, itoword(quest[indx].op2));
										toupperx(tmpbuf[0]);
										sprintf(qbuf, "%s frÜn %s? ", tmpbuf,
														itoword(quest[indx].op1));
									}
									else
										sprintf(qbuf, "%d frÜn %d= ", quest[indx].op2,
														quest[indx].op1);
									break;
		default:      if(litr) {
										switch(quest[indx].sign) {
											case '+': 		opertn = "plus";
																		break;
											case '-': 		opertn = "minus";
																		break;
											case MULSIGN: opertn = "gÜnger";
																		break;
										}
										strcpy(tmpbuf, itoword(quest[indx].op1));
										toupperx(tmpbuf[0]);
										sprintf(qbuf, "%s %s %s? ", tmpbuf, opertn,
														itoword(quest[indx].op2));
									}
									else
										sprintf(qbuf, "%d%c%d= ", quest[indx].op1,
														 quest[indx].sign, quest[indx].op2);
	} // switch(quest[indx].sign)
} /*** expndquest() ***/


void prequit(void)
{
	int i, n;
	char qbuf[81];
	char ans;
	int wrong = 0;
	FILE *out;

	for(i=0; i<k; ++i)
		if(quest[i].correct < 0)
			++wrong;
	if(wrong == 0)
		goto end;
	printf("\n\nVill du skriva ut de %s frÜgor som du har svarat fel pÜ\n"
				 "fler gÜnger Ñn du svarat rÑtt? [nj] ", itoword(wrong));
	ans = getch();
	printf("%s", (ans = toupper(ans)) == 'J' ? "ja" : "nej");
	if( ans == 'J' ) {
		if( NULL == (out = fopen(wrongfile, "at")) ) {
			fprintf(stderr, "\n\naritm: Filen '%s' gÜr inte att îppna.", wrongfile);
			exit(OTHERERR);
		}
		fprintf(out, "\n\nA_r_i_t_m  -  Att îva mer pÜ:\n\n");
		for(i=0, n=1; i<k; ++i) {
			if(quest[i].correct < 0) {
				expndquest(qbuf, i);
				fprintf(out, "(%3d)  %-53s%5d  -----  (%3d)\n", n, qbuf, quest[i].ans,
					n);
				++n;
			}
		} /*** for(i=0...) ***/
		fclose(out);
	}
end:
	printf("\n\nGîr om detta nÜgon annan gÜng.");
	exit(0);
} /*** prequit() ***/

/**** End of program file aritm.c ****/