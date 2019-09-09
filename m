Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786FDC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A1421479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfIIQgw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:36:52 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:46967 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728012AbfIIQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:36:52 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7Mem-0007BO-Rh; Mon, 09 Sep 2019 18:36:48 +0200
Received: from [213.55.220.251] (helo=[100.66.103.90])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7Mem-0003Cv-Kd; Mon, 09 Sep 2019 18:36:48 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
Date:   Mon, 9 Sep 2019 18:36:47 +0200
Message-Id: <5ACCE874-244F-4689-B606-05669BE080BE@volery.com>
References: <fbd0c88d97bf10ba9245755210a5b21362e57520.camel@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <fbd0c88d97bf10ba9245755210a5b21362e57520.camel@perches.com>
To:     Joe Perches <joe@perches.com>
X-Mailer: iPhone Mail (17A5831c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 9 Sep 2019, at 18:15, Joe Perches <joe@perches.com> wrote:
> 
> ﻿On Sat, 2019-09-07 at 18:12 +0200, Sandro Volery wrote:
>> Alright, I'll do that when I get home tonight!
> 
> I'm going to assume this is not an actual problem.
> 

Oh yeah I'm sorry, I was all busy reading documentations 
about the Kernel and stuff ;)
I got it to work, I actually just had my gitconfig name set as 'volery'.

Thanks




>> Thanks,
>> Sandro V
>> 
>>>> On 7 Sep 2019, at 18:08, Joe Perches <joe@perches.com> wrote:
>>> 
>>> ﻿On Sat, 2019-09-07 at 17:56 +0200, Sandro Volery wrote:
>>>>>> On 7 Sep 2019, at 17:44, Joe Perches <joe@perches.com> wrote:
>>>>> 
>>>>> ﻿On Sat, 2019-09-07 at 17:34 +0200, Sandro Volery wrote:
>>>>>> On patchwork I entered 'volery' as my username because I didn't know better, and now checkpatch always complains when I add 'signed-off-by' with my actual full name.
>>>>> 
>>>>> How does checkpatch complain?
>>>>> There is no connection between patchwork
>>>>> and checkpatch.
>>>> 
>>>> Checkpatch tells me that I haven't used 'volery' as
>>>> my signed off name.
>>> 
>>> Please send the both the patch and the actual checkpatch output
>>> you get when running 'perl ./scripts/checkpatch.pl <patch>'
>>> 
>>> If this patch is a commit in your own local git tree:
>>> 
>>> $ git format-patch -1 --stdout <commit_id> > tmp
>>> $ perl ./scripts/checkpatch.pl --strict tmp
>>> 
>>> and send tmp and the checkpatch output.
>>> 
>>> 
> 

