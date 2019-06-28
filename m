Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB047C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F442083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i5aOwXeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfF1NKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:10:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfF1NKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fyFYJQdKoBaArYsx2rT155C55HNBC6YI3MROc7piGyQ=; b=i5aOwXeZ8ZFPUq2TT7VJg32oY
        xf4PFjpkGYuRayDGic7jTSzxKQTSe0l2zl4luT38nS4Giol4VY6nMIBX8UI0Uuwg77yl5Ep7yjQu5
        X6WOjRwxo+/dN16+gM02KMkLfLQGksEUbR63lxFiG8+IcDMzwVE3Sa0b2ov5G57hJAQ/0j7PzC6k1
        1USemBeVIdHO8YBH8db/T1mGCzdQd34wshqFOxb+mhC3Z8KYLyYyIAHZkKmgUYlLrDHl6qCZi3hBp
        N9pfhUSlqxDyNLBNbdJQNpL+fLTw1PYLEzq65+NvxT0luy3Vs4MW+PKefAQxru18+n02GQZIHJCV8
        Fl9JH263w==;
Received: from [186.213.242.156] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgqeR-0006qv-Um; Fri, 28 Jun 2019 13:10:52 +0000
Date:   Fri, 28 Jun 2019 10:10:47 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, linux-tip-commits@vger.kernel.org,
        docutils-develop@lists.sourceforge.net
Subject: Re: [tip:timers/core] hrtimer: Use a bullet for the returns bullet
 list
Message-ID: <20190628101047.36927826@coco.lan>
In-Reply-To: <2f1c88882fde00beebb6066e9bd561287f5932c5.camel@perches.com>
References: <74ddad7dac331b4e5ce4a90e15c8a49e3a16d2ac.1561372382.git.mchehab+samsung@kernel.org>
        <tip-516337048fa40496ae5ca9863c367ec991a44d9a@git.kernel.org>
        <3740b16e5d0a3144e2d48af7cf56ae8020c3f9af.camel@perches.com>
        <20190627213930.0d28a072@coco.lan>
        <2f1c88882fde00beebb6066e9bd561287f5932c5.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 27 Jun 2019 19:40:24 -0700
Joe Perches <joe@perches.com> escreveu:

> On Thu, 2019-06-27 at 21:39 -0300, Mauro Carvalho Chehab wrote:
> > Em Thu, 27 Jun 2019 15:08:59 -0700
> > Joe Perches <joe@perches.com> escreveu:  
> []
> > > > hrtimer: Use a bullet for the returns bullet list
> > > > 
> > > > That gets rid of this warning:
> > > > 
> > > >    ./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.    
> > > 
> > > Doesn't this form occur multiple dozens of times in
> > > kernel sources?
> > > 
> > > For instance:
> > > 
> > > $ git grep -B3 -A5 -P "^ \* Returns:?$" | \
> > >   grep -P -A8 '\-\s+\*\s*@\w+:'  
> > 
> > Yes, this is a common pattern, but not all patterns that match the above
> > regex are broken.
> >   
> > > I think the warning is odd at best and docutils might
> > > be updated or the warning ignored or suppressed.
> > >   
> > > > and displays nicely both at the source code and at the produced
> > > > documentation.    
> > 
> > The warnings are painful - and they're the main reason why I wrote this
> > change: - I wanted to avoid new warnings actually unrelated to my
> > changes that were sometimes appearing while doing incremental
> > "make htmldocs" on a big patchset that I've been rebasing almost every
> > week over the last two months.
> > 
> > -
> > 
> > Yet, did you try to look how this pattern will appear at the html and pdf
> > output?  
> 
> No I did not.
> 
> I just would like to avoid changing perfectly intelligible
> kernel-doc content into something less directly readable for
> the sake of external output.
> 
> I don't use the externally generated formatted output docs.
> I read and use the source when necessary.

Yeah, I do the same too, except when I want to se the hole
picture or on complex subsystems. You can't really understand
media subsystems if you don't read it from the docs, as
the rationale for a lot of things are there.

Yet, for newcomers that are studying a new subsystem, a
good documentation helps a lot.

> 
> Automatic creation of bulleted blocks from relatively
> unformatted content is a hard problem.
> 
> I appreciate the work Mauro, I just would like to minimize
> the necessary changes if possible.

Yeah, me too.

> 
> The grep I did was trivial, I'm sure there are better tools
> to isolate the kernel-doc bits where the Return: block
> is emitted.
> 
> 
> >  Something like this:
> > 
> > 	sound/soc/codecs/wm8960.c: * Returns:
> > 	sound/soc/codecs/wm8960.c- *  -1, in case no sysclk frequency available found
> > 	sound/soc/codecs/wm8960.c- * >=0, in case we could derive bclk and lrclk from sysclk using
> > 	sound/soc/codecs/wm8960.c- *      (@sysclk_idx, @dac_idx, @bclk_idx) dividers
> > 
> > 
> > Will be displayed as:
> > 
> > 	**Returns:**
> > 	  -1, in case no sysclk frequency available found **>=0, in case we could derive bclk and lrclk from sysclk using** (@sysclk_idx, @dac_idx, @bclk_idx) dividers
> > (where **foo**) means that "foo" will be printed in bold.>   
> 
> That's a yuck from me.

Agreed, but, when writing text docs, doing something like:

	parameter
		parameter description

and getting the first line bolded helps to reduce the need of
adding explicit bold markups and produce a nice visual.

> 
> > While it would likely be possible to improve kernel-doc to present better
> > results, I'm afraid that it would be too complex for simple regex
> > expressions, and hard to tune, as it would be a hint-based approach,
> > and doing a natural language processing would be too much effort.  
> 
> Yeah, tough problem.  I don't envy it.
> 
> cheers and g'luck...

Thank you!

Thanks,
Mauro
