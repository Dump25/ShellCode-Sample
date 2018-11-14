.386

.model flat, stdcall

.code
start:
		xor ecx,ecx
		ASSUME fs:NOTHING
		mov eax,dword ptr fs:[ecx+30h]
		ASSUME fs:ERROR
		mov eax,dword ptr ds:[eax+0Ch]
		mov esi,dword ptr ds:[eax+14h]
		lodsd; eax,dword ptr ds:[esi]
		xchg eax,esi
		lodsd; eax,dword ptr ds:[esi]
		mov ebx,dword ptr ds:[eax+10h]
		mov edx,dword ptr ds:[ebx+3Ch]
		add edx,ebx
		mov edx,dword ptr ds:[edx+78h]
		add edx,ebx
		mov esi,dword ptr ds:[edx+20h]
		add esi,ebx
		xor ecx,ecx
jne_01:
		inc ecx
		lodsd; eax,dword ptr ds:[esi]
		add eax,ebx
		cmp dword ptr ds:[eax],50746547h
		jne jne_01
		cmp dword ptr ds:[eax+04h],41636F72h
		jne jne_01
		cmp dword ptr ds:[eax+08h],65726464h
		jne jne_01
		mov esi,dword ptr ds:[edx+24h]
		add esi,ebx
		mov cx,word ptr ds:[esi+ecx*2h]
		dec ecx
		mov esi,dword ptr ds:[edx+1Ch]
		add esi,ebx
		mov edx,dword ptr ds:[esi+ecx*4h]
		add edx,ebx
		xor ecx,ecx
		push ebx
		push edx
		push ecx
		push 41797261h
		push 7262694Ch
		push 64616F4Ch
		push esp
		push ebx
		call edx
		add esp,0Ch
		pop ecx
		push eax
		xor eax,eax
		mov ax,6C6Ch
		push eax
		push 642E3233h
		push 72657375h
		push esp
		call dword ptr ss:[esp+10h]
		add esp,0Ch
		push eax
		xor eax,eax
		mov eax,2341786Fh
		push eax
		sub dword ptr ss:[esp+3h],23h
		push 42656761h
		push 7373654Dh
		push esp
		push dword ptr ss:[esp+10h]
		call dword ptr ss:[esp+1Ch]
		add esp,0Ch
		push eax
		xor eax,eax
		mov eax,23737365h
		push eax
		sub dword ptr ss:[esp+03h],23h
		push 636F7250h
		push 74697845h
		push esp
		push dword ptr ss:[esp+20h]
		call dword ptr ss:[esp+20h]
		add esp,0Ch
		push eax
		xor eax,eax
		mov eax,236E6977h
		push eax
		sub dword ptr ss:[esp+03h],23h
		push esp
		xor eax,eax
		mov al,6Fh
		push eax
		push 6C6C6568h
		push esp
		xor eax,eax
		push eax
		push dword ptr ss:[esp+04h]
		push dword ptr ss:[esp+14h]
		xor eax,eax
		push eax
		call dword ptr ss:[esp+28h]
		add esp,14h
END start