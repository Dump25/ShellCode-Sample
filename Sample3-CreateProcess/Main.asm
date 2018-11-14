.386

.model flat, stdcall

.code
start:
		xor ebx, ebx

		;================================
		;Find Kernel32 Base
		;================================
		ASSUME fs:NOTHING
		mov edi,dword ptr fs:[ebx+30h]
		ASSUME fs:ERROR
		mov edi,dword ptr ds:[edi+0ch]
		mov edi,dword ptr ds:[edi+1ch]

	module_loop:
		mov eax,dword ptr ds:[edi+08h]
		mov esi,dword ptr ds:[edi+20h]
		mov edi,dword ptr ds:[edi]
		cmp byte ptr ds:[esi+12], '3'
		jne module_loop

		;================================
		;Kernel32 PE Header
		;================================
		mov edi, eax
		add edi,dword ptr ds:[eax+3ch]

		;================================
		; Export directory table
		;================================
		;0x00 Export Flags
		;0x04 Time/Date Stamp
		;0x08 Major Version
		;0x0A Minor Version
		;0x0C Name RVA
		;0x10 Ordinal Base
		;0x14 Address Table Entries
		;0x18 Number Of Names
		;0x1c Address Table RVA
		;0x20 Name Pointer Table RVA
		;0x24 Ordinal Table RVA
		;================================

		;================================
		;Kernel32 Export Directory Table
		;================================
		mov edx,dword ptr ds:[edi+78h]
		add edx, eax

		;================================
		;Kernel32 Name Pointers
		;================================
		mov edi,dword ptr ds:[edx+20h]
		add edi, eax

		;================================
		;Find CreateProcessA
		;================================
		mov ebp, ebx
	name_loop:
		mov esi,dword ptr ds:[edi+ebp*4]
		add esi, eax
		inc ebp
		cmp dword ptr ds:[esi],   61657243h ;Crea
		jne name_loop
		cmp dword ptr ds:[esi+8h], 7365636fh ;oces
		jne name_loop

		;================================
		;CreateProcessA Ordinal
		;================================
		mov edi,dword ptr ds:[edx+24h]
		add edi, eax
		mov bp,word ptr ds:[edi+ebp*2]

		;================================
		;CreateProcessA Address
		;================================
		mov edi,dword ptr ds:[edx+1Ch]
		add edi, eax
		mov edi,dword ptr ds:[edi+ebp*4-4] ;subtract ordinal base
		add edi, eax

		;================================
		;Zero Memory
		;================================
		mov ecx, ebx
		mov cl, 11111111b
	zero_loop:
		push ebx
		loop zero_loop

		push 636c6163h ;calc
		mov edx, esp

		;================================
		;Call CreateProcessA
		;================================
		push edx ;__out        LPPROCESS_INFORMATION lpProcessInformation
		push edx ;__in         LPSTARTUPINFO lpStartupInfo,
		push ebx ;__in_opt     LPCTSTR lpCurrentDirectory,
		push ebx ;__in_opt     LPVOID lpEnvironment,
		push ebx ;__in         DWORD dwCreationFlags,
		push ebx ;__in         BOOL bInheritHandles,
		push ebx ;__in_opt     LPSECURITY_ATTRIBUTES lpThreadAttributes,
		push ebx ;__in_opt     LPSECURITY_ATTRIBUTES lpProcessAttributes,
		push edx ;__inout_opt  LPTSTR lpCommandLine,
		push ebx ;__in_opt     LPCTSTR lpApplicationName,
		call edi

END start