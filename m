Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0254EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1F6233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LSvdl0ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404412AbfHVUy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:54:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:59623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731775AbfHVUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566507233;
        bh=2hVDH9MWH7A8zBxJ5P7SOwH/Biwrk+8uxfrdZSNVrfk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LSvdl0ft7Q5j3dCyx42JoOCtamaA9HRW3AuCxF0ynvftB24uy7UmzJPccXMpgPgVc
         4Hhr0dgt019MdykmPoZOp3V1wMLRG/pQNsAhLRIobIhwe1xdi+0dHYgOyQ7Wklc3k/
         +HcDH0uiPN6hWusf6XPfHWOhhBGBjaRM/HRUaA74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.179.28] ([84.179.83.118]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1ihQdb2UcA-00jnm1; Thu, 22
 Aug 2019 22:53:53 +0200
Subject: Re: [PATCH] parisc: fix compilation errrors
To:     Guenter Roeck <linux@roeck-us.net>, Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, James.Bottomley@HansenPartnership.com,
        kirill.shutemov@linux.intel.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190815205305.1382-1-cai@lca.pw>
 <20190815210208.GA9868@roeck-us.net>
From:   Helge Deller <deller@gmx.de>
Message-ID: <0f27b102-471a-e472-3e69-d9883a36efeb@gmx.de>
Date:   Thu, 22 Aug 2019 22:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815210208.GA9868@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GevPktSoCKEVGcbjLu9uz7kPh9LHwo9cSRfsldL4dpSufAnIzAO
 ir6L4uBz+GbQw6vXMEO6V/FwGBfLzATXkWxsX3CBuFNazxviNOFDNqiIbT/T/7U9XDoq8Uw
 H83+YhSnhAN3MMFGlddkgJ4raeq727zzaGATIkcwCzyRuXVtcH4X15GY9HbWc3tZrxmyZ7h
 nxfJOh4pvpoTw1Q9DWYmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hb+b3YAh90Q=:SzlH9x7VnAtVmC5gpKHGpI
 whqN6/ei0NM0NBwGYxwx62A7rRF7BeHW+E1TbzWhTAorN43ap/rMgM3xAU79ZFRaWKgjLbw9z
 /ryDDISBdXa/9wkw6i/pf6DvUUslEq6bxD5ZL/w8RUXCM04X65gNfa4fJrQz+WBIFlz71SEw7
 yYdIkRhxN+lAJ391hIfTSGzCJwcAXO4k7kQ9F6L4ZV2yY5RsAzRZdqbD9HIz7rQlGxYE4qKuN
 ytHwBr4L6ERabk0bnQ0EdJkCKaUozOwueI1TFzsRqavRCjD0ybHgjaKy9gURWGhfgald1tlsV
 X9ZqpMlLyfQQq1bsVSTURnWPBaI9EmcCvlsnQLtcznWmlkFnJMYOBcvcPsnswQnb55MIJ7O2a
 Zn131J1M4YkN2AwO8kHaByELbmUdUdLwwwvB5b7gCNnLAyADubyM0sUDeSJrzgg1zsRTzfbvE
 N6KW4BcO2agXblLfFLalpuC330H3dPEsyWOV2U/2+pTNRdg6Nx45a1pbLpumuiISjxkTlv8wx
 2IefimbF8oWu9VyHLGR60+OPMsTRnP6gD8LDiPZDGUj0yR0VCLra6JhcZJ6lvgr1qcvLcth6O
 Ha7DC78ZnVAgvPOVUxGVaUT1TKEzQmvcM25Q3bcP7YxaAYRLagvzV95TqZKNwHs6kQAFQ6b5U
 HH9PZPvOKl89dYARXiYmHmu34xQAKZY3wXg+5dQKr74zGp1dtQ1nnc4uUrCaD4+HSnmWnN5Yk
 b3cYgTIN7KpcH407Alb6qVVMVxX08IIYlomcUGvct3TsOg873LLGUonmOTPzQosx87jb7G7Mf
 G4YkaE1ayVuSMmhxjGfJewiz0Z95w3UHNjcvWaa4daENdBwNJdKKSX5GewZCjSUHTNEJGfVd3
 5wR2EYytJMDza8lKGF4QTO5E3gPvyITjMkxPejvjKI7Gnintz/5hQU0JkLyxHNcF0p6HB4mrs
 G82yPOrEqTql8Qhb+uk+a+J/GJ3/5zN4cYinJHigajD4Jjdscm93l8uB4pda9xZnZSmYl3BaR
 vyjeShsCP62nfrkXo+XTHDZzWhYuI/EPTS2hXAw1wOGhsri9OVhyklJGe+JqFukdu0RdqAwxo
 Lu46tJ6iO6oP0UrkFH+GknLkllMqDAjPtb2CBxVGEX8K71V4EomK404huUeHGxTuyzx1LgWOv
 dWndE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.19 23:02, Guenter Roeck wrote:
> On Thu, Aug 15, 2019 at 04:53:05PM -0400, Qian Cai wrote:
>> The commit 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix
>> variable 'p4d' set but not used") converted a few functions from macros
>> to static inline, which causes parisc to complain,
>>
>> In file included from ./include/asm-generic/4level-fixup.h:38:0,
>>                   from ./arch/parisc/include/asm/pgtable.h:5,
>>                   from ./arch/parisc/include/asm/io.h:6,
>>                   from ./include/linux/io.h:13,
>>                   from sound/core/memory.c:9:
>> ./include/asm-generic/5level-fixup.h:14:18: error: unknown type name
>> 'pgd_t'; did you mean 'pid_t'?
>>   #define p4d_t    pgd_t
>>                    ^
>> ./include/asm-generic/5level-fixup.h:24:28: note: in expansion of macro
>> 'p4d_t'
>>   static inline int p4d_none(p4d_t p4d)
>>                              ^~~~~
>>
>> It is because "4level-fixup.h" is included before "asm/page.h" where
>> "pgd_t" is defined.
>>
>> Fixes: 0cfaee2af3a0 ("include/asm-generic/5level-fixup.h: fix variable =
'p4d' set but not used")
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Qian Cai <cai@lca.pw>
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Helge Deller <deller@gmx.de>

Helge
