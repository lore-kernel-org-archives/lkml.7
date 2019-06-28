Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BC9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00AA208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561726993;
	bh=l9C29CMJ7BtCf1PJLfQmnwZlxLus+A25uNUXNY46ObQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vqaQGguesfrmALIwDa/DcTU/8WPy5ucu/oH46EW/nAPz0W9O9fA8qi7RBihrmvFn5
	 dYTu3CDJEJe87q3LhGjbYPLAh2kFq70izOuym38wyjUftw5H+NwODKd4pF8c8gWmMm
	 shegjwA+/laZIdUA/kC+XMnd5Ebtf7vPhSLjlGdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfF1NDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:03:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfF1NDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RHFB6j7SDnBGNVDtypLVfMNOkUqCQLUXwY/TQLvDA8s=; b=qE9PNjHbHSh2Jre+S5SOlJr9Y
        zEntbtsPZyLP8hokouxEVHnMiwUccMZZf/FIKL6irWypETJlw+SW60ck31+NW4gCgtEOa5VqJxzUl
        lfXcrHmWtqQbqdxTPj+ob2dexyoDtzggxSwH2nmu6MMPSxSfEVrJXGqapyqyxh4V2veHCgRzZqspQ
        8YMZVcYwIh6IV4Liijazq3G3KYKDv7V8NH41BPpenB4Whh/5gnqznWPHcUCN7LscDGoGNDD41tQ70
        l2H6/5Hh/ZQm80C8EUas5vM+ZlMg1DFMSdILlp1VAsfy6vWSFRutVLAA00/A6CQTlnIkjkgVMy1Sq
        u+MsvPMrg==;
Received: from [186.213.242.156] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgqWz-000270-1v; Fri, 28 Jun 2019 13:03:09 +0000
Date:   Fri, 28 Jun 2019 10:03:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/9] hrtimer: Use a bullet for the returns bullet list
Message-ID: <20190628100305.4c5729fd@coco.lan>
In-Reply-To: <951e47de7dd6d86516c25ceb855c4b64f13fb65d.camel@perches.com>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
        <8176c9089f66796de6f62e74499eb3d3015f785d.1561723736.git.mchehab+samsung@kernel.org>
        <951e47de7dd6d86516c25ceb855c4b64f13fb65d.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 28 Jun 2019 05:39:25 -0700
Joe Perches <joe@perches.com> escreveu:

> On Fri, 2019-06-28 at 09:12 -0300, Mauro Carvalho Chehab wrote:
> > That gets rid of this warning:
> > 
> > 	./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.
> > 
> > and displays nicely both at the source code and at the produced
> > documentation.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  kernel/time/hrtimer.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> > index edb230aba3d1..5ee77f1a8a92 100644
> > --- a/kernel/time/hrtimer.c
> > +++ b/kernel/time/hrtimer.c
> > @@ -1114,9 +1114,10 @@ EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
> >   * @timer:	hrtimer to stop
> >   *
> >   * Returns:
> > - *  0 when the timer was not active
> > - *  1 when the timer was active
> > - * -1 when the timer is currently executing the callback function and
> > + *
> > + *  *  0 when the timer was not active
> > + *  *  1 when the timer was active
> > + *  * -1 when the timer is currently executing the callback function and
> >   *    cannot be stopped  
> 
> I think this last line should be indented 3 more spaces too

That would produce a warning, and will change the font for the content of 
the first line to bold. 

ReST is pedantic with whitespaces, as it uses it to identify continuation
lines.

For it to consider one line as a continuation of the previous one, the texts
on both lines (after markups) should start at the same place.

So, on:

	* foo
	  bar

"bar" is considered a continuation of the first line. So, identical to:

	* foo bar

But:

	* foo bar
	      foobar

the whitespace doesn't match. it will change the font for the first line
to bold, and place foobar on a separate line.


(yeah, I know that, for kernel-doc, this sucks)


Thanks,
Mauro
