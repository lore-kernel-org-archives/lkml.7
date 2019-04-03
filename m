Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073252084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDCNUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:20:14 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:54744 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:20:14 -0400
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hBfoF-00074u-33; Wed, 03 Apr 2019 13:20:08 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hBfo8-0003sm-9t; Wed, 03 Apr 2019 14:20:06 +0100
Subject: Re: [RESEND PATCH 0/4] um: build and irq fixes
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190403083902.3975-1-brgl@bgdev.pl>
 <CAMRc=MdBVwYiHLPRAJFVaS2OKx-006+P8R8VEfe+x6W_3uq37w@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <0d83eba7-f71c-53e0-57ef-29aacbef64f1@cambridgegreys.com>
Date:   Wed, 3 Apr 2019 14:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdBVwYiHLPRAJFVaS2OKx-006+P8R8VEfe+x6W_3uq37w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2019 09:39, Bartosz Golaszewski wrote:
> śr., 3 kwi 2019 o 10:39 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> I've previously sent these patches separately. I still don't see them
>> in next and I don't know what the policy is for picking up uml patches
>> but I thought I'd resend them rebased together on top of v5.1-rc3.
>>
> 


I test and ack stuff to the extent I can (especially the areas which I 
have worked on recently). Richard has the final say for what goes in on 
the next merge and he does it based on his own and my testing and/or 
markings in patchwork.


> And of course I forgot to pick up acks from Anton...

Indeed - I have acked some of these :)

> 
>> Bartosz Golaszewski (4):
>>    um: remove unused variable
>>    um: remove uses of variable length arrays
>>    um: define set_pte_at() as a static inline function, not a macro
>>    um: irq: don't set the chip for all irqs
>>
>>   arch/um/include/asm/pgtable.h |  7 ++++++-
>>   arch/um/kernel/irq.c          |  2 +-
>>   arch/um/kernel/skas/uaccess.c |  1 -
>>   arch/um/os-Linux/umid.c       | 36 ++++++++++++++++++++++++++---------
>>   4 files changed, 34 insertions(+), 12 deletions(-)
>>
>> --
>> 2.21.0
>>
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
