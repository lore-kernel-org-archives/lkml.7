Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC72C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F9421670
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="DiyOYVdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfE2IFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:05:03 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:53555 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfE2IFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:05:00 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 120212035B;
        Wed, 29 May 2019 10:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1559117093; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXUHU3KH7YVJReexMZ00xlKxU7VTx97/4fQ5i+FXXbA=;
        b=DiyOYVdXPPQwPsz5v/+46zoYNuZb6sZTEm5fOSEo9wk29RZT7HxobxIRNuEwB2eubE5kI5
        MzsbYWZMP6MgFwzi2AiHK6uNEyTtkJMSMIX9hQB5Wt/cMw3moWZG3Oy/CuWwDHWIq/hwD3
        5jQMHPoUGAxcXStEhbm9pw+yisk6h2zfhxq8EuI++/IojhEZDKYrmEXhwur5tOq5wC/dbt
        fgXDX+L4CWp3hbUGstEAcDgKIQ2+QMMPIyidMqZLKJA+uRZxatfCxQ2sy6OCydeOTvFINf
        Lv4DgFW2NsvGtAO5Mp6ad0C0Mb9EoW87HlvO60HpGYcyqcCm2l/F4WMcwBeZYw==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id B2B04BEEBD;
        Wed, 29 May 2019 10:04:52 +0200 (CEST)
Message-ID: <5CEE3D24.8000700@bfs.de>
Date:   Wed, 29 May 2019 10:04:52 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     Pavel Machek <pavel@ucw.cz>, Theodore Ts'o <tytso@mit.edu>,
        Aung <aung.aungkyawsoe@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: need company for kernel upgrade
References: <5CE53BA9.4070906@bfs.de> <CABC7EG8NiiPycthdfb7Ng3MsxTvmmxk_LjcosM8ZD1F0CnuDFw@mail.gmail.com> <5CE64BC7.4010803@bfs.de> <20190524050116.GI2532@mit.edu> <20190528105853.GA21111@amd> <585d6508-ace2-02d8-95ca-8e437d7cec05@metux.net>
In-Reply-To: <585d6508-ace2-02d8-95ca-8e437d7cec05@metux.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-0.89 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-0.79)[84.57%];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         TO_DN_ALL(0.00)[];
         DKIM_SIGNED(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 28.05.2019 21:35, schrieb Enrico Weigelt, metux IT consult:
> On 28.05.19 12:58, Pavel Machek wrote:
> 
> Hi,
> 
>> On Fri 2019-05-24 01:01:16, Theodore Ts'o wrote:
>>> On Thu, May 23, 2019 at 09:29:11AM +0200, walter harms wrote:
>>>>
>>>> No,
>>>> the company i am working for has a custom build arm-board.
>>>> We bought the kernel from the assembler but found it has
>>>> some problems that need fixing.
> 
> basic rule: don't use vendor kernels for production, unless you
> *really* *really* have to.

we have custom hardware, so this was needed. But we used std. parts
with existing drivers, so the upcomming problems were hidden in details.
Of cause we tested the hardware but you can find only obvious problems.

> 
> HW vendors usually don't have the capacities to offer any decent
> kernel support. there're only few exceptions (eg. phytec) that have
> their own kernel hackers and actively participate in upstreaming.

We have noticed that also, *active* is a big point.

> 
>>>> Basically we want to improve the linux-kernel so it can run
>>>> native on our boards.
>>>>
>>>>>> Hi developers,
>>>>>> i am in search of a company that can help upgrading
>>>>>> a running linux-kernel on custom hardware.
>>>>>> Est. time 10 days.
>>>
>>> Have you tried contacting Linutronix (https://linutronix.de) or
>>> Collabora (https://collabora.com)?
>>>
>>> Both have EU offices --- well Collabora does for now, until Brexit
>>> happens.  :-)
>>
>> www.denx.de is another option.
> 
> continuing the list w/ my own company --> info@metux.net
> 
> by the way: should we create a separate list for commercial topics ?
> 

I used linux-arm and it worked surprisingly well (not all mails went truh the list)
but it look very silent and i was unsure if they were still alive. A big win
for everyone would be a FAQ/Lessons-learned something you can take to check a contract.
the customer will know what to expect and the contractor will know what to offer.

Having something a list of minimum requirements like that FAQ would improve the stand of
the hardware developed to support linux. Not everyone has a big budget or need to
produce in millions like the raspi guys did, and even they have sometimes troubles.

note: that will not solve every proble but even a starting point would be good.

re,
 wh
