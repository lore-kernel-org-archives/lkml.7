Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEAEC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDF62173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDKRgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDKRgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:36:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63DD62084D;
        Thu, 11 Apr 2019 17:36:04 +0000 (UTC)
Date:   Thu, 11 Apr 2019 13:36:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190411133602.17e8ebdf@gandalf.local.home>
In-Reply-To: <20190411172130.GA30189@lst.de>
References: <20190410102754.387743324@linutronix.de>
        <20190410103646.130022106@linutronix.de>
        <20190410110818.GA13904@lst.de>
        <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
        <20190411172130.GA30189@lst.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 19:21:30 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > Bah. People complain about overly broad cc-lists and the context is on
> > lkml. But sure, I just bounced it to you.  
> 
> People should stop complaining about that.  Deleting a mail is a single
> keystroke.  Finding all the patches to apply them and test, or even
> to review them is a nightmare.  That is why depending on my mood I'll
> either complain like now when people do that crap, or if I feel bad
> enough just ignore them.  If you don't give me the full context you
> can't expect me to have an informed opinion.

I guess the issue is when you get a 41 patch series, and there's only
one patch you need to look at. There's times I get Cc'd on patch sets
that I have no idea why I'm on the Cc. If I skim the patch set and
don't see a relevance, I simply ignore it.

But there may be one patch I was suppose to review and I miss it. I
personally prefer to get only Cc'd on the cover letter and the patch I
need to review. Now, if that patch is dependent on other patches, then
perhaps it would be nice to be Cc'd on them too.

In other words, I much rather be Cc'd on only the patches that pertain
to me (and the supporting patches for it) then the entire series.
Especially when it's 40 patches or more.

Yes, it's a single click to delete patches that I don't need to look
at, but what I usually do in these cases is just delete the entire
series.

Note, as I do a lot with stack traces, this entire series pertains to
me and I'm happy I was on the full Cc list. But there's other examples
where it does not.

> 
> Btw, the private forwarding is the worst of all worlds - now I have
> the patches, but can't sensibly reply to them..

BTW, lore.kernel.org has a way to reply back to the list.

-- Steve
