Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EB4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1E620693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDKRVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:21:44 -0400
Received: from verein.lst.de ([213.95.11.211]:37093 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKRVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:21:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C814268B02; Thu, 11 Apr 2019 19:21:30 +0200 (CEST)
Date:   Thu, 11 Apr 2019 19:21:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190411172130.GA30189@lst.de>
References: <20190410102754.387743324@linutronix.de> <20190410103646.130022106@linutronix.de> <20190410110818.GA13904@lst.de> <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:08:19PM +0200, Thomas Gleixner wrote:
> On Wed, 10 Apr 2019, Christoph Hellwig wrote:
> 
> > On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> > > Replace the indirection through struct stack_trace with an invocation of
> > > the storage array based interface.
> > 
> > This seems to be missing some context, at least stack_trace_save does
> > not actually exist in mainline.
> > 
> > Please always send the whole series out to everyone on the To and Cc
> > list, otherwise patch series are not reviewable.
>  
> Bah. People complain about overly broad cc-lists and the context is on
> lkml. But sure, I just bounced it to you.

People should stop complaining about that.  Deleting a mail is a single
keystroke.  Finding all the patches to apply them and test, or even
to review them is a nightmare.  That is why depending on my mood I'll
either complain like now when people do that crap, or if I feel bad
enough just ignore them.  If you don't give me the full context you
can't expect me to have an informed opinion.

Btw, the private forwarding is the worst of all worlds - now I have
the patches, but can't sensibly reply to them..
