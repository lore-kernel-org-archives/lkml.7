Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF5C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70059206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MYOVk4Sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfICXSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 19:18:04 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:44292
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbfICXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567552682; bh=+X+Cb7cvDHPQSN9vQTrWuH6x2hXSpT1AODcX6RvFqVg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=MYOVk4ScFkkMHAKtybubF9cX6QL++ATEmQN0s3VEusLa7/GjI3WssRYfRpnJ/wEPOegCQi8GqqownU0XmPUI6fTZaUEnvtgj8DugcJbs7h0EQ+QPRmiI4BsBLKV2lb6lwIgIdyf0yJL7ighUpf2YsmQJfFmkF4a1T/soX4UdgFO5y52pwL/FoMazbkArGYuGtIAmoJUnJC+zHEk++CxWeXijVKP11iHWnKqoq70TIU5tdGPFq5hPshbprgqUmLls9BzpRzgq9TwWnPWyvu4zg5Wbm8s11U0hAOGMLqCWnj67aV33cq92xDkkmB731tEZ8YNKZP+sjrFuH9r051byKA==
X-YMail-OSG: kR8Apb4VM1nKGRKYmlCBY0w1.AUNYLkPyUDQ6uLVlTMfPj7y0VAQdBcSYVcksGc
 2GzKAyb4nlEWTCp54MlJjH6YW.0fuDPFLKgIbnLSmJsejzFooScEI2T4XWap69IgSA7G6kNY4SGp
 SVEVjSINY9_4G3A9iFEvTEikhbgGAxCRfL0bL5rwoGcYyxWmn8h7QqH0FZuUXu3JvOiNFy9iqjgC
 OjPO7SDl8YIUJj20FMklqnfiMmO0JHIzwbTT.PYNxw.0H1rd5.rxaoNTVzhqcjEHh19gVOIsKi_U
 VhxVqsODY6nEoTnTMPOZgGZgK5V51nZp37KleZOEWTn4jgMnFuBcFlLDsH_N966yoWOli1EIKozs
 M3NvCpWK5P.MPlIl8uzBp.a3UTnQP9FB73MgUfF1bKKZMBoWj0PVHxZb2M_iL7NiW4yUZIkrQxtH
 dIbxAVDgGDqkJj.Uyz6biHacWrGp2YwKU3sxFIHCMy93tKMcWdjXm9k4TUsHySfQNSBSpcHVBPIX
 jvWG68hrczfx9vmyVzVjJsTDy_87S2paiuJwxIipTRc4f9Xb.ZEJUl8looZ8qD7Kn_C2EHeR.8vm
 oZWzCscln2.vCha9MGY4ET3waqmF2SmCeVSBMD9U7Wl2aIoGjqtP9xPvevp.vbCq_nlKUF697AnN
 OUtqOHgEfGEpA6vHPe05xXOjs1n7K4C2vIO8LnnxhRjtWAy31HXEjT6XByLrCwSfxVIHe9dQHNuK
 uZIYnu80CdRpjLhite0BSs_Sa.3XF9GByE2gRBQ7MaeAlvakVPEufmf4cmW4oW4nycOjaMVRhTZA
 bJjCrNauQGjvk1MlJNyw5ZpCwV7M9sOhXAzrDnAsKbysbhR1UfNuoC13z6WhYKFO6JkcsC7mmx6b
 bvp_hagT33sOgBRksKZrfqQVZlWmN5KkO9h.rKJTYaTvEglsnvGl2nW6eQpnC2DoiZSvN.Qb17d9
 uMNiM5b2vvO_.mHEFCcfHQMT.0vqCp09Sb8fNsitj9k862ZdD4KuFdz0FRt4WUrYpyiYm0Ygo1Av
 .ExkJq1WM2l9AEf4L.f3_3q0LmplkfMcB46GjczvyE8zhUz5CFe3MowYYhPS4qVc8Iq5VM2r7YMI
 DAAQK5kZlXBSCVD3McoUgVxYq_XONCbFjjmHsSfxm9bTuDT_jqYqPHFC_lPGSN4KUgMOuy4tkZ.3
 B_4tu4wDxxU3x4WTtkn1FoJB50XGMZC.oGik1KBRTO9chLa5wJIHurwr13RLM5Co7HBvF9cHEI8M
 wNJPL2Jl.vWRYbWBR_fCcgQwPZuPVPD_axo.mqA9rbysm50Bj8kyYEWa_TrgYtzYoafesuUY.Q71
 XatWdjebEYZIB5wGR_jhq9MvC1mREJr8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Sep 2019 23:18:02 +0000
Received: by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eabded102294463ffa8a3fd86ff39d7b;
          Tue, 03 Sep 2019 23:17:59 +0000 (UTC)
Subject: Re: general protection fault in smack_socket_sendmsg
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+5fd781d646d4fcbdfeb0@syzkaller.appspotmail.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, casey@schaufler-ca.com
References: <20190831053311.15704-1-hdanton@sina.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <5f34b914-ca5b-e527-9183-64dc0d83ec9f@schaufler-ca.com>
Date:   Tue, 3 Sep 2019 16:17:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190831053311.15704-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2019 10:33 PM, Hillf Danton wrote:
> On Fri, 30 Aug 2019 12:40:07 -0700
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    6525771f Merge tag 'arc-5.3-rc7' of git://git.kernel.org/p..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11486cea600000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=58485246ad14eafe
>> dashboard link: https://syzkaller.appspot.com/bug?extid=5fd781d646d4fcbdfeb0
>> compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
>> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+5fd781d646d4fcbdfeb0@syzkaller.appspotmail.com
>>
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 11983 Comm: kworker/0:0 Not tainted 5.3.0-rc6+ #94
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
>> Google 01/01/2011
>> Workqueue: krxrpcd rxrpc_peer_keepalive_worker
>> RIP: 0010:smack_socket_sendmsg+0x5b/0x480 security/smack/smack_lsm.c:3677
>> Code: e8 6a 07 71 fe 4c 89 e8 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 ef e8  
>> b4 ff a9 fe 4d 8b 65 00 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00  
>> 74 08 48 89 df e8 96 ff a9 fe 4c 8b 33 49 8d 9e 08
>> RSP: 0018:ffff8881daa1f9c8 EFLAGS: 00010206
>> RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff888048882500
>> RDX: 0000000000000000 RSI: ffff8881daa1fb18 RDI: 0000000000000000
>> RBP: ffff8881daa1fa80 R08: ffffffff8350cc90 R09: ffff8881daa1fb86
>> R10: ffffed103b543f72 R11: 0000000000000000 R12: ffff88803704c594
>> R13: ffff8881daa1fb18 R14: dffffc0000000000 R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f7d4f2b5028 CR3: 000000005e835000 CR4: 00000000001426f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   security_socket_sendmsg+0x6c/0xd0 security/security.c:1973
>>   sock_sendmsg net/socket.c:654 [inline]
>>   kernel_sendmsg+0x77/0x140 net/socket.c:677
>>   rxrpc_send_keepalive+0x254/0x3c0 net/rxrpc/output.c:655
>>   rxrpc_peer_keepalive_dispatch net/rxrpc/peer_event.c:369 [inline]
>>   rxrpc_peer_keepalive_worker+0x76e/0xb40 net/rxrpc/peer_event.c:430
>>   process_one_work+0x7ef/0x10e0 kernel/workqueue.c:2269
>>   worker_thread+0xc01/0x1630 kernel/workqueue.c:2415
>>   kthread+0x332/0x350 kernel/kthread.c:255
>>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>> Modules linked in:
>> ---[ end trace 61235a384085b26a ]---

If you want to add a description and signed-off-by I will take this.

>  
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3674,7 +3674,7 @@ static int smack_socket_sendmsg(struct s
>  	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
>  #endif
>  #ifdef SMACK_IPV6_SECMARK_LABELING
> -	struct socket_smack *ssp = sock->sk->sk_security;
> +	struct socket_smack *ssp;
>  	struct smack_known *rsp;
>  #endif
>  	int rc = 0;
> @@ -3684,6 +3684,15 @@ static int smack_socket_sendmsg(struct s
>  	 */
>  	if (sip == NULL)
>  		return 0;
> +	/*
> +	 * Fine if sock reaped
> +	 */
> +	if (!READ_ONCE(sock->sk))
> +		return 0;
> +
> +#ifdef SMACK_IPV6_SECMARK_LABELING
> +	ssp = sock->sk->sk_security;
> +#endif
>  
>  	switch (sock->sk->sk_family) {
>  	case AF_INET:
>
