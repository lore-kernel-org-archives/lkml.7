Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E44C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3962178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436630AbfIGT1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 15:27:20 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:56317 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404763AbfIGT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:27:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A7C32181D33FB;
        Sat,  7 Sep 2019 19:27:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: day83_3fb643158d92c
X-Filterd-Recvd-Size: 2249
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Sep 2019 19:27:17 +0000 (UTC)
Message-ID: <a99b7481f26138ea01de0d271e9aec2a525c0aed.camel@perches.com>
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sandro Volery <sandro@volery.com>
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com
Date:   Sat, 07 Sep 2019 12:27:16 -0700
In-Reply-To: <20190907174232.GA20070@kroah.com>
References: <20190907172944.GB18166@kroah.com>
         <B45E122D-2B8B-43DA-8658-889E30CB2F0F@volery.com>
         <20190907174232.GA20070@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 18:42 +0100, Greg KH wrote:
> On Sat, Sep 07, 2019 at 07:35:42PM +0200, Sandro Volery wrote:
> > 
> > > > > On 7 Sep 2019, at 19:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > ﻿On Sat, Sep 07, 2019 at 07:23:59PM +0200, Sandro Volery wrote:
> > > > Dear Greg,
> > > > I am pretty sure the issue was, that I did too many things at once. However, all the things I did are related to spaces / tabs, maybe that still works?
> > > 
> > > <snip>
> > > 
> > > For some reason you sent this only to me, which is a bit rude to
> > > everyone else on the mailing list.  I'll be glad to respond if you
> > > resend it to everyone.
> > 
> > I'm sorry, newbie here. I thought it'd be better to not annoy everyone with responses but learning things everyday I guess :)
> 
> No problem, but you should also line-wrap your emails :)
> 
> > I am pretty sure the issue with my patch was that there was too many changes, however all of them were spaces and tabs related, so I think this could be fine?
> 
> As the bot said, break it out into "one patch per logical change", and
> "fix all whitespace issues" is not "one logical change".

As long as git diff -w shows no difference and a compiled
object comparison before and after the change shows no
difference, I think it's fine.

In fact, it avoid multiple commits where the only changes
are whitespace.



