Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A7C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF6420844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kCkonxU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfGHI6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:58:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62390 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfGHI6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:58:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45hzr9568jz9txqj;
        Mon,  8 Jul 2019 10:58:17 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kCkonxU1; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZqjmSVTnCCYU; Mon,  8 Jul 2019 10:58:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45hzr93xKRz9txqh;
        Mon,  8 Jul 2019 10:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1562576297; bh=SEEbC4SVXv54ubiPmqZ/ohTZiQJHhOXXhOXl6IoW5uo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kCkonxU12IqU+OKoT05jmROmtyo56NkBiacWHjmlTOlOlpzmHasGBbSVt49awlH4a
         Ohvd50OfTyqC0MMR/Y/9hwvvVqL9oAhvHf6y1Fp0jfEBkr1KgWs5ACvOxOcuJmT6Xq
         4Vvk15dmwt8kvZk6z/25IRcXmt8UoTUKAIuyHbAQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D1998B790;
        Mon,  8 Jul 2019 10:58:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id U1bNWRlSm0cg; Mon,  8 Jul 2019 10:58:22 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1CA328B78C;
        Mon,  8 Jul 2019 10:58:22 +0200 (CEST)
Subject: Re: [PATCH v3 3/3] powerpc/module64: Use symbolic instructions names.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ulirch Weigand <Ulrich.Weigand@de.ibm.com>
References: <298f344bdb21ab566271f5d18c6782ed20f072b7.1556865423.git.christophe.leroy@c-s.fr>
 <6fb61d1c9104b0324d4a9c445f431c0928c7ea25.1556865423.git.christophe.leroy@c-s.fr>
 <87bly5ibsd.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9bc00fb4-379a-e19b-4d27-32fff8f9781b@c-s.fr>
Date:   Mon, 8 Jul 2019 10:58:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87bly5ibsd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/07/2019 à 02:56, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> To increase readability/maintainability, replace hard coded
>> instructions values by symbolic names.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> v3: fixed warning by adding () in an 'if' around X | Y (unlike said in v2 history, this change was forgotten in v2)
>> v2: rearranged comments
>>
>>   arch/powerpc/kernel/module_64.c | 53 +++++++++++++++++++++++++++--------------
>>   1 file changed, 35 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
>> index c2e1b06253b8..b33a5d5e2d35 100644
>> --- a/arch/powerpc/kernel/module_64.c
>> +++ b/arch/powerpc/kernel/module_64.c
>> @@ -704,18 +711,21 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
> ...
>>   			/*
>>   			 * If found, replace it with:
>>   			 *	addis r2, r12, (.TOC.-func)@ha
>>   			 *	addi r2, r12, (.TOC.-func)@l
>>   			 */
>> -			((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
>> -			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
>> +			((uint32_t *)location)[0] = PPC_INST_ADDIS | __PPC_RT(R2) |
>> +						    __PPC_RA(R12) | PPC_HA(value);
>> +			((uint32_t *)location)[1] = PPC_INST_ADDI | __PPC_RT(R2) |
>> +						    __PPC_RA(R12) | PPC_LO(value);
>>   			break;
> 
> This was crashing and it's amazing how long you can stare at a
> disassembly and not see the difference between `r2` and `r12` :)

Argh, yes. I was misleaded by the comment I guess. Sorry for that and 
thanks for fixing.

Christophe

> 
> Fixed now.
> 
> cheers
> 
