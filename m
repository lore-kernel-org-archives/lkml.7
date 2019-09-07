Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDAFC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4C21848
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391052AbfIGSaZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:30:25 -0400
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:28328 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfIGSaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:30:25 -0400
X-Greylist: delayed 1476 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Sep 2019 14:30:23 EDT
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <lkml.sandro@volery.com>)
        id 1i6f5m-0008Zi-3n; Sat, 07 Sep 2019 20:05:46 +0200
Received: from [213.55.224.80] (helo=[100.100.89.92])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <lkml.sandro@volery.com>)
        id 1i6f5l-0000dv-Sn; Sat, 07 Sep 2019 20:05:46 +0200
X-Authenticated-Sender-Id: lkml.sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery LKML <lkml.sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
Date:   Sat, 7 Sep 2019 20:05:44 +0200
Message-Id: <2894D531-1203-4992-9FF2-C259AAE7BC0F@volery.com>
References: <20190907180250.GA20602@kroah.com>
Cc:     Sandro Volery <sandro@volery.com>, linux-kernel@vger.kernel.org,
        jslaby@suse.com
In-Reply-To: <20190907180250.GA20602@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Sandro V

> On 7 Sep 2019, at 20:03, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> ﻿On Sat, Sep 07, 2019 at 07:49:43PM +0200, Sandro Volery wrote:
>> 
>> 
>> 
>> 
>>>> On 7 Sep 2019, at 19:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> 
>>> ﻿On Sat, Sep 07, 2019 at 07:35:42PM +0200, Sandro Volery wrote:
>>>> 
>>>> 
>>>>>>>> On 7 Sep 2019, at 19:29, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>> ﻿On Sat, Sep 07, 2019 at 07:23:59PM +0200, Sandro Volery wrote:
>>>>>>> Dear Greg,
>>>>>>> I am pretty sure the issue was, that I did too many things at once. However, all the things I did are related to spaces / tabs, maybe that still works?
>>>>> 
>>>>> <snip>
>>>>> 
>>>>> For some reason you sent this only to me, which is a bit rude to
>>>>> everyone else on the mailing list.  I'll be glad to respond if you
>>>>> resend it to everyone.
>>>> 
>>>> I'm sorry, newbie here. I thought it'd be better to not annoy everyone with responses but learning things everyday I guess :)
>>> 
>>> No problem, but you should also line-wrap your emails :)
>> 
>> I've just been told that before, I'll try to change 
>> those settings asap.
>> 
>>> 
>>>> I am pretty sure the issue with my patch was that there was too many changes, however all of them were spaces and tabs related, so I think this could be fine?
>>> 
>>> As the bot said, break it out into "one patch per logical change", and
>>> "fix all whitespace issues" is not "one logical change".
>> 
>> So a logical change would be if I make one patch
>> to replace all spaces with tabs and a separate
>> patch to add a space before the : ?
> 
> Yes, that would be good.  Make it a patch series please.

Thanks!

Any suggestion on how I should do the line wrapping
when I want to send emails from my phone?
Since I don't always have my laptop handy.

Sandro V.
