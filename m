Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C71C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB0D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfDPRYO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:24:14 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37147 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPRYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:24:14 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0F28520009;
        Tue, 16 Apr 2019 17:24:09 +0000 (UTC)
Date:   Tue, 16 Apr 2019 19:24:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: cfi_util: mark expected switch fall-throughs
Message-ID: <20190416192408.0e321563@xps13>
In-Reply-To: <ee1f8c4a-92b0-db9d-6110-3acadeb9e457@embeddedor.com>
References: <20190208180202.GA16603@embeddedor>
        <69083203-0720-1943-8549-ddf3cea6060e@embeddedor.com>
        <71df15e7-af2e-0326-78fe-0271a1e240fe@embeddedor.com>
        <20190415104458.7faeec57@xps13>
        <ee1f8c4a-92b0-db9d-6110-3acadeb9e457@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Mon, 15 Apr
2019 07:57:11 -0500:

> Hi Miquel,
> 
> On 4/15/19 3:44 AM, Miquel Raynal wrote:
> > Hi Gustavo,
> > 
> > "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Wed, 10 Apr
> > 2019 16:16:51 -0500:
> >   
> >> Hi all,
> >>
> >> If no one cares I'll add this to my tree for 5.2.  
> > 
> > Which tree are you talking about?
> >   
> 
> This one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp
> 
> > Please let the MTD maintainers take patches through their tree. We
> > might be late but this is definitely not a good reason to bypass us.
> >   
> It's a bit confusing when patches are being ignored for more than two
> months:
> 
> https://lore.kernel.org/patchwork/patch/1040099/
> https://lore.kernel.org/patchwork/patch/1040100/
> https://lore.kernel.org/patchwork/patch/1040098/
> 

Patches posted at -rc6 right before the last release? Come on! Gustavo,
we always spend more time for you than for other contributors because we
do not trust your changes. We could apply them blindly but we don't do
that for other (worthy) contributions, so why shall we do it for you?

I think you could at least flag these changes as "automatic and
unverified" in the commit log so that when git blaming, people could
know that the additional explicit /* fallthrough */ comment might be
wrong and was just added in order to limit the number of warnings when
enabling the extra GCC warning.

> Certainly, Richard Weinberger replied to this one. But I couldn't
> find a tree to which this patch was applied, in case it actually
> was.
> 
> It's a common practice for maintainers to reply saying that a patch
> has been finally applied, and in most cases they also explicitly
> mention the tree and branch to which it was applied. All this info
> is really helpful for people working all over the tree.

It is common practice for contributors to understand what they
are doing before submitting a change and this is something that you
clearly don't try to do.


Thanks,
Miquèl
