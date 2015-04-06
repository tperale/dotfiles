#include <iostream>

using namespace std;

extern "C" void afficherInt32(long int i) {
  cout << i << " " << endl;
}

extern "C" void lireInt32(long int &i) {
  cin >> i;
}

extern "C" void afficherUns32(long unsigned i){
  cout << i << " " << endl;
}
extern "C" void lireUns32(long unsigned &i){
  cin >> i;
}

extern "C" void afficherHex32(long unsigned i) {
  ios_base::fmtflags old_options = cout.flags(ios_base::hex|ios_base::uppercase);
  cout.fill('0');

  cout << "0x";
  cout.width(8); cout << i << endl;

  cout.flags(old_options);
}


// pour appeler afficherRegistres à partir de l'assembleur :
//   PUSHA
//   CALL afficherRegistres
//   POPA
extern "C" void afficherRegistres(unsigned edi, unsigned esi, unsigned ebp, unsigned esp, unsigned ebx, unsigned edx, unsigned ecx, unsigned eax) {
  cout << "-------------------------------------" << endl;
  ios_base::fmtflags old_options = cout.flags(ios_base::hex|ios_base::uppercase);
  cout.fill('0');

  cout << " EAX : 0x";
  cout.width(8); cout << eax << "   ESI : 0x";
  cout.width(8); cout << esi << endl;

  cout << " EBX : 0x";
  cout.width(8); cout << ebx << "   EDI : 0x";
  cout.width(8); cout << edi << endl;

  cout << " ECX : 0x";
  cout.width(8); cout << ecx << "   EBP : 0x";
  cout.width(8); cout << ebp << endl;

  cout << " EDX : 0x";
  cout.width(8); cout << edx << "   ESP : 0x";
  cout.width(8); cout << esp << endl;

  cout.flags(old_options);
  cout << "-------------------------------------" << endl;
}

// pour appeler afficherFlags à partir de l'assembleur :
//   PUSHA
//   PUSHF
//   CALL afficherFlags
//   POPF
//   POPA
extern "C" void afficherFlags(unsigned flags) {
  cout << "-------------------------------------" << endl;
  cout << "  CF = " << (flags&1) << " ";
  cout << "  OF = " << ((flags>>11)&1) << " ";
  cout << "  ZF = " << ((flags>>6)&1) << " ";
  cout << "  SF = " << ((flags>>7)&1) << endl;
  cout << "-------------------------------------" << endl;
}
/*
*/
