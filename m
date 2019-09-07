Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB54C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174DA20863
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436691AbfIGTvs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 15:51:48 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:33572 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404944AbfIGTvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:51:47 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6gkH-000B0W-98; Sat, 07 Sep 2019 21:51:41 +0200
Received: from [213.55.224.80] (helo=[100.100.89.92])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6gkG-00066A-PI; Sat, 07 Sep 2019 21:51:41 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
Date:   Sat, 7 Sep 2019 21:51:39 +0200
Message-Id: <9A23770B-49B8-4DB1-8B45-22F3650E0CB8@volery.com>
References: <a99b7481f26138ea01de0d271e9aec2a525c0aed.camel@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        jslaby@suse.com
In-Reply-To: <a99b7481f26138ea01de0d271e9aec2a525c0aed.camel@perches.com>
To:     Joe Perches <joe@perches.com>
X-Mailer: iPhone Mail (17A5572a)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Sep 2019, at 21:27, Joe Perches <joe@perches.com> wrote:
> 
> ﻿On Sat, 2019-09-07 at 18:42 +0100, Greg KH wrote:
>>> On Sat, Sep 07, 2019 at 07:35:42PM +0200, Sandro Volery wrote:
>>> 
>>>>>> On 7 Sep 2019, at 19:29, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>> ﻿On Sat, Sep 07, 2019 at 07:23:59PM +0200, Sandro Volery wrote:
>>>>> Dear Greg,
>>>>> I am pretty sure the issue was, that I did too many things at once. However, all the things I did are related to spaces / tabs, maybe that still works?
>>>> 
>>>> <snip>
>>>> 
>>>> For some reason you sent this only to me, which is a bit rude to
>>>> everyone else on the mailing list.  I'll be glad to respond if you
>>>> resend it to everyone.
>>> 
>>> I'm sorry, newbie here. I thought it'd be better to not annoy everyone with responses but learning things everyday I guess :)
>> 
>> No problem, but you should also line-wrap your emails :)
>> 
>>> I am pretty sure the issue with my patch was that there was too many changes, however all of them were spaces and tabs related, so I think this could be fine?
>> 
>> As the bot said, break it out into "one patch per logical change", and
>> "fix all whitespace issues" is not "one logical change".
> 
> As long as git diff -w shows no difference and a compiled
> object comparison before and after the change shows no
> difference, I think it's fine.

My thoughts, too. I didn't feel comfortable arguing as a newbie tho
so I'll see what I can do once I get home.

> 
> In fact, it avoid multiple commits where the only changes
> are whitespace.
> 
> 
> 

