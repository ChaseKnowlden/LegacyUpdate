!define TRUSTEDR "http://download.windowsupdate.com/msdownload/update/v3/static/trustedr/en"

Function UpdateRoots
	SetOutPath $PLUGINSDIR
	File "..\build\updroots.exe"
	DetailPrint "Downloading Certificate Trust List..."
	NSISdl::download "${TRUSTEDR}/authroots.sst"      "authroots.sst"
	NSISdl::download "${TRUSTEDR}/delroots.sst"       "delroots.sst"
	NSISdl::download "${TRUSTEDR}/roots.sst"          "roots.sst"
	NSISdl::download "${TRUSTEDR}/updroots.sst"       "updroots.sst"
	NSISdl::download "${TRUSTEDR}/disallowedcert.sst" "disallowedcert.sst"
	DetailPrint "Installing Certificate Trust List..."
	ExecWait "updroots.exe authroots.sst"
	ExecWait "updroots.exe updroots.sst"
	ExecWait "updroots.exe -l roots.sst"
	ExecWait "updroots.exe -d delroots.sst"
	ExecWait "updroots.exe -l -u disallowedcert.sst"
	Delete "updroots.exe"
	Delete "authroots.sst"
	Delete "updroots.sst"
	Delete "roots.sst"
	Delete "delroots.sst"
	Delete "disallowedcert.sst"
FunctionEnd
