Typewriter Custom Styles.

This Asset include C# scripts, that changes standard GUIText and add Typewriter effect to it.

Script can be added to every standard GUIText component. 

It will add some custom fields in Editor, that allow you:
	- on/of launching script on Start();
	- set speed of typewriter;
	- chose pointer symbol;
	- set number of custom strings(Multi Strings);
	- edit text of Multi Strings;

How to use:
	- create standard UnityEngine.UI.Text;
	- add any of Typewriter scripts to it;
	- set variables and edit text in editor like you want;
	- for Multi Strings scripts:
		* set number of strings by public variable "MultiStrings";
		* edit first in TextField of GUIText component;
		* edit other string in editor using custom TextArea and Popup;
	- public void functions:
		* StartTypewriter() - call to start typewriter;
		* SkipTypewriter() - call to skip typewriter and show text;
		* NextString() - call to show next string (only for MultiStrigs scripts);

IMPORTANT NOTE!!!:
You can use any kind of fonts for GUIText. But if you are using "RandomText" Style,
I advice you use Monospaced font (also called a fixed-pitch, fixed-width, or non-proportional font),
like included in asset UbuntuMono-Regular. 
Monospace is a font whose letters and characters each occupy the same amount of horizontal space.
If you use Proportional font (not Monospaced) Text will appear incorrect.

		
Description of scripts:

w/o multi strings function:

- TW_Regular.cs - standard typewriter effect
	- Launch On Start: 
		* if "true" - script start showing text on MonoBehaviour.Start()
		* if "false" - script start showing text on function StartTypewriter()
	- Time Out:
		* time before showing next char of string (if 0 - script stop on current char)
	- Pointer Symbol:
		* Popup for choosing pointer symbol; 

- TW_RandomPointer.cs - custom typewriter effect, pointer symbol is a random char;
	- Launch On Start(same);
	- Time Out(same);
	- Charstype:
		* Popup for choosing type of pointer char;

- TW_RandomText.cs - effect for creating random chars before appearing normal text;
	- Launch On Start(same);
	- Time Out:
		* time between showing random char and normal char (if 0 - show random text infinitely)
	- Charstype:
		* option for choosing type of random chars;

with multi strings function:

- TW_MultiStrings_Regular.cs
	- equal to TW_Regular.cs, with option of creating array of strings with editable text; 

- TW_MultiStrings_RandomPointer.cs
	- equal to TW_RandomPointer.cs, with option of creating array of strings with editable text;

- TW_MultiStrings_RandomText.cs
	- equal to TW_RandomText.cs, with option of creating array of strings with editable text;

- TW_MultiStrings_All.cs
	- include functionality of ALL MultiStrings scripts;
	- option of choosing type of Typewriter Style, and other specific attributes in Editor.
