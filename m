Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F197C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3448D20870
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfCVTaU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:30:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59824 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfCVTaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:30:20 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44QtzH0VkLz9tyvj;
        Fri, 22 Mar 2019 20:30:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nshErp7imjiD; Fri, 22 Mar 2019 20:30:18 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44QtzG5tFqz9tyvg;
        Fri, 22 Mar 2019 20:30:18 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id B81D5556; Fri, 22 Mar 2019 20:30:18 +0100 (CET)
Received: from 37.171.246.171 ([37.171.246.171]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 22 Mar 2019 20:30:18 +0100
Date:   Fri, 22 Mar 2019 20:30:18 +0100
Message-ID: <20190322203018.Horde.HcjA5xJcxFAiEJOUjrO2DA1@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Meelis Roos <mroos@linux.ee>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc32 boot crash in 5.1-rc1
References: <20190321221632.Horde.sUFPCFV5Nrk0KQFVNqmMjw2@messagerie.si.c-s.fr>
 <6c3bfa43-4b11-ab27-fcc6-3732ccbed304@linux.ee>
In-Reply-To: <6c3bfa43-4b11-ab27-fcc6-3732ccbed304@linux.ee>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> a écrit :

>>> While 5.0.0 worked fine on my PowerMac G4, 5.0 + git (unknown rev  
>>> as of Mar 13), 5.0.0-11520-gf261c4e and todays git all fail to boot.
>>>
>>> The problem seems to be in page fault handler in load_elf_binary()  
>>> of init process.
>>
>> The patch at https://patchwork.ozlabs.org/patch/1053385/ should fix it
>
> Tested it - yes, it fixes the boot.

Thanks for testing. It will be merged in 5.1-rc2

Christophe

>
> -- 
> Meelis Roos <mroos@linux.ee>


