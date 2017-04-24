
## 如果只是使用Def文件导出，但是不用 dllimport 引入，就会无法使用#pragma lib隐式加载方式加载dll

# Visual Studio 生成Console Dll 的 过程

```
1. define the macro ,such as:
#ifdef FILE_FIND_EX_DLL
	#define FILE_FIND_EX_API _declspec(dllimport)
#else 
	#define FILE_FIND_EX_API _declspec(dllexport)
#endif

2. use the macro ,such as:
class FILE_FIND_EX_API CFileFindEx
{	
};

3. set the dllFileName to UD (UnicodeDebug)

for Visual Studio 2008
Properties->Configuration Properties->Linker->General->Output File
	Debug : $(OutDir)\$(ProjectName)UD.dll
	Release : $(OutDir)\$(ProjectName)U.dll

for Visual Studio 2012
Properties->Configuration Properties->General->Target Name
	Debug : $(ProjectName)UD
	Release : $(ProjectName)U

4. copy dll&lib to Project Dir.
Properties->Configuration Properties->Build Events->Post-Build Event->CommandLine 
copy /y "$(OutDir)\$(ProjectName)UD.dll" "$(SolutionDir)\$(ProjectName)UD.dll"
copy /y "$(OutDir)\$(ProjectName)UD.lib" "$(SolutionDir)\$(ProjectName)UD.lib"

or for Visual Studio 2012
Debug move /y "$(OutDir)$(TargetName)$(TargetExt)" "$(SolutionDir)$(TargetName)D$(TargetExt)"    
Release move /y "$(OutDir)$(TargetName)$(TargetExt)" "$(SolutionDir)$(TargetName)$(TargetExt)"   

or for Visual Studio 2008
Debug move /y "$(OutDir)\$(ProjectName).exe" "$(SolutionDir)\$(ProjectName)D.exe"   
Release move /y "$(OutDir)\$(ProjectName).exe" "$(SolutionDir)\$(ProjectName).exe"   
```

## Build Event 复制文件
```
Debug 
	copy /y "$(OutDir)$(TargetName)$(TargetExt)" "$(SolutionDir)bin\$(TargetName)UD$(TargetExt)" 
	copy /y "$(OutDir)$(TargetName).pdb" "$(SolutionDir)bin\$(TargetName)UD.pdb" 
    copy /y "$(OutDir)$(TargetName).lib" "$(SolutionDir)bin\$(TargetName)UD.lib"
Release 
	copy /y "$(OutDir)$(TargetName)$(TargetExt)" "$(SolutionDir)bin\$(TargetName)U$(TargetExt)"
	copy /y "$(OutDir)$(TargetName).pdb" "$(SolutionDir)bin\$(TargetName)U.pdb"  
    copy /y "$(OutDir)$(TargetName).lib" "$(SolutionDir)bin\$(TargetName)U.lib" 	

DebugX64 
	copy /y "$(OutDir)$(TargetName)$(TargetExt)" "$(SolutionDir)bin\$(TargetName)64UD$(TargetExt)"  
	copy /y "$(OutDir)$(TargetName).pdb" "$(SolutionDir)bin\$(TargetName)64UD.pdb"  
    copy /y "$(OutDir)$(TargetName).lib" "$(SolutionDir)bin\$(TargetName)64UD.lib" 
ReleaseX64 
	copy /y "$(OutDir)$(TargetName)$(TargetExt)" "$(SolutionDir)bin\$(TargetName)64U$(TargetExt)"   
	copy /y "$(OutDir)$(TargetName).pdb" "$(SolutionDir)bin\$(TargetName)64U.pdb"  
    copy /y "$(OutDir)$(TargetName).lib" "$(SolutionDir)bin\$(TargetName)64U.lib" 
```
