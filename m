Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C913BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF8E2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pch69Xzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfF1Ajk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:39:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF1Ajk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dn34CJYtdeAdfgrMOdzs/RPX0u6ZoHpXvhuSS9M6Llg=; b=Pch69XzlDh4te4bL9dzpMY9Jt
        0qjUt3DwCUucvEbBp7tio9AniFfq4tMzDDQLKexK+pMMw9i7qrRxGUNsxIAn/MRu9FNHW5PzTp3cA
        cNveYRTAHrvxyXTpINNMlFEKjGErWBs4rEsd2WG4nGTQxGoM7GaLRsbaCLRB4pSDL8iLLo7AE1wGR
        d+BvsmwhdhEK5Prtdtjkf+QOMWtzneMO6t3YXR6G/3HCkmaLtLD12ZPp23ecNzJ1bZxTepazks6oJ
        oWt8nqqUzq8Tmi09Ejy0GX+/bXlvon/tHTtTq9eoBLJD1pNRfGvd+6GZb8/5vTdr64AB+6tqQVo0z
        s1sERlxWA==;
Received: from [186.213.242.156] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgevQ-000587-UE; Fri, 28 Jun 2019 00:39:37 +0000
Date:   Thu, 27 Jun 2019 21:39:30 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, linux-tip-commits@vger.kernel.org,
        docutils-develop@lists.sourceforge.net
Subject: Re: [tip:timers/core] hrtimer: Use a bullet for the returns bullet
 list
Message-ID: <20190627213930.0d28a072@coco.lan>
In-Reply-To: <3740b16e5d0a3144e2d48af7cf56ae8020c3f9af.camel@perches.com>
References: <74ddad7dac331b4e5ce4a90e15c8a49e3a16d2ac.1561372382.git.mchehab+samsung@kernel.org>
        <tip-516337048fa40496ae5ca9863c367ec991a44d9a@git.kernel.org>
        <3740b16e5d0a3144e2d48af7cf56ae8020c3f9af.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 27 Jun 2019 15:08:59 -0700
Joe Perches <joe@perches.com> escreveu:

> On Thu, 2019-06-27 at 14:46 -0700, tip-bot for Mauro Carvalho Chehab
> wrote:
> > Commit-ID:  516337048fa40496ae5ca9863c367ec991a44d9a
> > Gitweb:     https://git.kernel.org/tip/516337048fa40496ae5ca9863c367ec991a44d9a
> > Author:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > AuthorDate: Mon, 24 Jun 2019 07:33:26 -0300
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Thu, 27 Jun 2019 23:30:04 +0200
> > 
> > hrtimer: Use a bullet for the returns bullet list
> > 
> > That gets rid of this warning:
> > 
> >    ./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.  
> 
> Doesn't this form occur multiple dozens of times in
> kernel sources?
> 
> For instance:
> 
> $ git grep -B3 -A5 -P "^ \* Returns:?$" | \
>   grep -P -A8 '\-\s+\*\s*@\w+:'

Yes, this is a common pattern, but not all patterns that match the above
regex are broken.

> 
> I think the warning is odd at best and docutils might
> be updated or the warning ignored or suppressed.
> 
> > and displays nicely both at the source code and at the produced
> > documentation.  

The warnings are painful - and they're the main reason why I wrote this
change: - I wanted to avoid new warnings actually unrelated to my
changes that were sometimes appearing while doing incremental
"make htmldocs" on a big patchset that I've been rebasing almost every
week over the last two months.

-

Yet, did you try to look how this pattern will appear at the html and pdf
output? Something like this:

	sound/soc/codecs/wm8960.c: * Returns:
	sound/soc/codecs/wm8960.c- *  -1, in case no sysclk frequency available found
	sound/soc/codecs/wm8960.c- * >=0, in case we could derive bclk and lrclk from sysclk using
	sound/soc/codecs/wm8960.c- *      (@sysclk_idx, @dac_idx, @bclk_idx) dividers


Will be displayed as:

	**Returns:**
	  -1, in case no sysclk frequency available found **>=0, in case we could derive bclk and lrclk from sysclk using** (@sysclk_idx, @dac_idx, @bclk_idx) dividers


(where **foo**) means that "foo" will be printed in bold.

E. g. it will just merge all returns values into a single line and, if 
there are alignment differences, it will make the previous line bold
and produce a warning.

On some places, however, what's there will be properly displayed,
like this one:
**
 * wimax_reset - Reset a WiMAX device
 *
 * @wimax_dev: WiMAX device descriptor
 *
 * Returns:
 *
 * %0 if ok and a warm reset was done (the device still exists in
 * the system).
 *
 * -%ENODEV if a cold/bus reset had to be done (device has
 * disconnected and reconnected, so current handle is not valid
 * any more).
 *
 * -%EINVAL if the device is not even registered.
 *
 * Any other negative error code shall be considered as
 * non-recoverable.
 *

As there are blank lines between each value, making each return code a
different line.

This one:

tools/lib/traceevent/parse-filter.c: * Returns:
tools/lib/traceevent/parse-filter.c- *  1 if the two filters hold the same content.
tools/lib/traceevent/parse-filter.c- *  0 if they do not.

will also not mangle too much, as the dots will help for someone to 
understand, if reading the html/pdf output, like this:

	**Returns:**
	  1 if the two filters hold the same content. 0 if they do not.

So, it all depends on the context.

-

While it would likely be possible to improve kernel-doc to present better
results, I'm afraid that it would be too complex for simple regex
expressions, and hard to tune, as it would be a hint-based approach,
and doing a natural language processing would be too much effort.


> 
> > diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c  
> []
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
> >   */
> >  int hrtimer_try_to_cancel(struct hrtimer *timer)  
> 



Thanks,
Mauro
