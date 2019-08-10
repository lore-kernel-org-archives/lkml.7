Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EBEC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BFD2089E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="FgyPHLaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfHJEnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 00:43:22 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.35]:40536 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbfHJEnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 00:43:22 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D17BB1058E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2019 23:43:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wJDshTsaAdnCewJDshv5AI; Fri, 09 Aug 2019 23:43:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jNPEaYnHCISUpzL8rSKJSo1L0UnHhybBfeaApoLWE54=; b=FgyPHLaFMBuDN+uYhbVnBeuacU
        TAAF/OLgixORAslR5qQ2E00iwc1smkWC9L+VhnKBtrkj6eTKZtPjcVBCeip9X1gsMYwQOOPItf01K
        gYVaGt/MuMn/yvBS2zfeUHwfU5ARldEghR32qR6alI8yf+3r0artiS+LwqveXoEjbp6+d4YrX0lWf
        YouGtIxFDBVFv9qW64477hsPuQwWXIMQGR987KUtMdr/cswqPqsw4JGR6PIAvMLxoWNvI01st9u+M
        gjT23lms/CAz9h1cYaMyYMPgUl0kEaeeLoBd5WkFCoQpgamd3tKR26n0GxX1SEW6Sp16o9JpmD5k5
        gZeQjUsw==;
Received: from [187.192.11.120] (port=38232 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hwJDs-000R4e-FT; Fri, 09 Aug 2019 23:43:20 -0500
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Joe Perches <joe@perches.com>, Guenter Roeck <linux@roeck-us.net>
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
 <20190805032441.GO9017@brightrain.aerifal.cx>
 <20190809195630.GA15606@roeck-us.net>
 <5f26547f-b48e-4b9f-b8ef-858283915e3d@embeddedor.com>
 <20190809215608.GA11065@roeck-us.net>
 <6a06245f-33f2-1d92-0d0e-c8b270dc24af@embeddedor.com>
 <667995275e6a1cbcdaa93029c1b33e6b52fc6803.camel@perches.com>
 <afceec12-e5eb-42b7-c67e-0dc5a23affdf@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <32a4fa83-db72-f0b0-85ab-03f360a555a8@embeddedor.com>
Date:   Fri, 9 Aug 2019 23:43:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <afceec12-e5eb-42b7-c67e-0dc5a23affdf@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hwJDs-000R4e-FT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [187.192.11.120]:38232
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/19 11:31 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 8/9/19 11:20 PM, Joe Perches wrote:
>> On Fri, 2019-08-09 at 21:47 -0500, Gustavo A. R. Silva wrote:
>>> On 8/9/19 4:56 PM, Guenter Roeck wrote:
>>>> On Fri, Aug 09, 2019 at 04:36:01PM -0500, Gustavo A. R. Silva wrote:
>>>>> On 8/9/19 2:56 PM, Guenter Roeck wrote:
>>>>>> On Sun, Aug 04, 2019 at 11:24:41PM -0400, Rich Felker wrote:
>>>>>>> On Sun, Aug 04, 2019 at 07:14:23PM -0700, Guenter Roeck wrote:
>>>>>>>> Since commit a035d552a93b ("Makefile: Globally enable fall-through
>>>>>>>> warning"), all sh builds fail with errors such as
>>>>>>>>
>>>>>>>> arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
>>>>>>>> arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
>>>>>>>>
>>>>>>>> Since this effectively disables all build and boot tests for the
>>>>>>>> architecture, let's drop -Werror from the sh kernel Makefile until
>>>>>>>> the problems are fixed.
>> []
>>> On second thought it seems to me that this is not a good idea, at least
>>> for mainline. For the time being I'll take this patch for linux-next only.
>>>
>>> Who is the maintainer of sh?
>>
>> But whoever it may be, isn't particularly active.
>>
>> MAINTAINERS-SUPERH
>> MAINTAINERS-M:  Yoshinori Sato <ysato@users.sourceforge.jp>
>> MAINTAINERS-M:  Rich Felker <dalias@libc.org>
>> MAINTAINERS-L:  linux-sh@vger.kernel.org
>> MAINTAINERS-Q:  http://patchwork.kernel.org/project/linux-sh/list/
>> MAINTAINERS-S:  Maintained
>> MAINTAINERS-F:  Documentation/sh/
>> MAINTAINERS:F:  arch/sh/
>> MAINTAINERS-F:  drivers/sh/
>>
>>> The best solution is to fix those fall-through warnings you see. Could you
>>> please send me all the warnings you see? I can try to fix them.
>>
>> It's true it's a warning, but adding -Werror is rarely
>> a good idea as gcc error output can change with every
>> version.
>>
> 
> In the meantime I'll install sh4 and fix those warnings.
> 

Well, I think it has paid off. It seems there is an ancient bug right there:

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index 3bd010b4c55f..f10d64311127 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -157,6 +157,7 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
        switch (sh_type) {
        case SH_BREAKPOINT_READ:
                *gen_type = HW_BREAKPOINT_R;
+               break;
        case SH_BREAKPOINT_WRITE:
                *gen_type = HW_BREAKPOINT_W;
                break;

--
Gustavo
