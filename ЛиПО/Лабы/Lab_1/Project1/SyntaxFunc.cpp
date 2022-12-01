#include "Main.h";
#include "SyntaxFunc.h";


string alphabet = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
string numbers_ = "1234567890";

string lecsemsPath = "D:\\Универ\\PGU\\ЛиПО\\Лабы\\Lab_1\\files\\lecsems.txt";


lecsem lecsems[100];

lecsem Lecs[100];
int lecsLength = 0;




/// Если check - false
/// то возвращает true при разделительном символе не равным \r \n
/// 
/// Если check - true
/// то возвращает true при любом разделительном символе 
/// и false если это не разделительный символ
bool IsAlphabet(char s) {

    for (int i = 0; i < alphabet.length(); i++)
    {
        if (s == alphabet[i]) return true;
    }
    return false;
}

bool IsNumber(char s) {
    for (int i = 0; i < numbers_.length(); i++)
    {
        if (s == numbers_[i]) return true;
    }
    return false;
}


std::vector<Word> GetWords(char* buf, int length) {

    std::vector<Word> words;

    string currentWord = "";
    char lastS = '\0';
    int rowNum = 1;

    for (int i = 0; i < length; i++)
    {
        if (currentWord == "\n") rowNum++;
        // Если этот символ символ алфавита
        if (IsAlphabet(buf[i])) {
            // и последний считанный символ тоже символ алфавита
            if (IsAlphabet(lastS)) {
                currentWord += buf[i];
            } // но последний считанный символ это не символ алфавита
            else {
                if (currentWord != "" && currentWord != "\r" && currentWord != "\n" && currentWord != " " && currentWord != "\t") words.push_back(Word(currentWord, rowNum));



                currentWord = "";
                currentWord += buf[i];
                lastS = buf[i];
            }
        } // Если этот символ это число
        else if (IsNumber(buf[i])) {
            // и последний символ тоже число
            if (IsNumber(lastS)) {
                currentWord += buf[i];
                lastS = buf[i];
            }
            else {
                if (currentWord != "" && currentWord != "\r" && currentWord != "\n" && currentWord != " " && currentWord != "\t") words.push_back(Word(currentWord, rowNum));
                currentWord = "";
                currentWord += buf[i];
                lastS = buf[i];
            }
        } // Если этот символ это не число и не буква
        else
        {
            if (currentWord != "" && currentWord != "\r" && currentWord != "\n" && currentWord != " " && currentWord != "\t") words.push_back(Word(currentWord, rowNum));
            currentWord = "";
            currentWord += buf[i];
            lastS = buf[i];
        }

    }
    return words;

}

void GetType(Word &word) {


    for (int i = 0; i < lecsLength; i++)
    {
        if (word.word == lecsems[i].name) {

            word.lecsemType = lecsems[i].type;
            return;
        }
    }

    if (IsNumber(word.word[0])) {
        word.lecsemType = -1; // Это число
    }
    else {
        word.lecsemType = -2; // Это переменная
    }

    

}



void SetTypes(std::vector<Word>& words) 
{

    for (int i = 0; i < words.size(); i++)
    {

        GetType(words[i]);

    }

}


lecsem* CreateArrayOfLecsems() {

    std::ifstream isLecsem(lecsemsPath, std::ifstream::ate | std::ifstream::binary);

    if (!isLecsem)
    {
        cout << "can't find file \n\n";
        return NULL;
    }
    else
    {


        isLecsem.seekg(0, isLecsem.end);
        int length = isLecsem.tellg();
        isLecsem.seekg(0, isLecsem.beg);

        char* buffer = new char[length];

        //std::cout << "Reading " << length << " characters... ";
        // read data as a block:
        /*isLecsem.read(buffer, length);
        isLecsem.close();*/
        std::string line;
        int index = 0;
        if (isLecsem.is_open())
        {
            while (getline(isLecsem, line))
            {
                //std::cout << line << std::endl;
                auto pos = line.find(" ");
                if (pos != string::npos)
                {
                    string s1 = line.substr(0, pos);
                    string s2 = line.substr(pos + 1);
                    if (!s2.empty() && s2[s2.size() - 1] == '\r')
                        s2.erase(s2.size() - 1);
                    //auto pos_r = line.find("/r");
                    lecsems[index].name = s2;
                    lecsems[index].type = std::stoi(s1);
                    index++;
                    //cout << s1 << endl << s2 << endl;
                }
            }
        }
        isLecsem.close();     // закрываем файл

        //lecs = lecsems;




        return lecsems;

    }
}

void CreateLecsems() {
    ///////////////////////////////////////////
    // Заполнение массива лексем
    ///////////////////////////////////////////


    lecsem* lecsems = CreateArrayOfLecsems();

    int lecsemLength = 0;

    for (int i = 0; i < sizeof(*lecsems); i++)
    {
        if (lecsems[0].type != 0) {
            lecsems++;
            lecsemLength++;

        }
        else {
            break;
        }
    }

    lecsem* Lecs = new lecsem[lecsemLength];
    lecsems -= lecsemLength;
    lecsLength = lecsemLength;
    for (int i = 0; i < lecsemLength; i++)
    {
        Lecs[i] = lecsems[0];
        lecsems++;
    }


    ///////////////////////////////////////////
    // ------------------------------------- //
    ///////////////////////////////////////////


}


bool IsIdentificatedLecsem(string word) {

    for (int i = 0; i < lecsLength; i++)
    {
        if (word == lecsems[i].name) return true;
    }
    return false;

}
