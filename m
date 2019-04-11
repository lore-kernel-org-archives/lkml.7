Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E292082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDKRop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:44:45 -0400
Received: from verein.lst.de ([213.95.11.211]:37239 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfDKRop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:44:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F289E68AFE; Thu, 11 Apr 2019 19:44:31 +0200 (CEST)
Date:   Thu, 11 Apr 2019 19:44:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190411174431.GA32109@lst.de>
References: <20190410102754.387743324@linutronix.de> <20190410103646.130022106@linutronix.de> <20190410110818.GA13904@lst.de> <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de> <20190411172130.GA30189@lst.de> <20190411133602.17e8ebdf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411133602.17e8ebdf@gandalf.local.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 01:36:02PM -0400, Steven Rostedt wrote:
> I guess the issue is when you get a 41 patch series, and there's only
> one patch you need to look at. There's times I get Cc'd on patch sets
> that I have no idea why I'm on the Cc. If I skim the patch set and
> don't see a relevance, I simply ignore it.

I sometimes do that as well, but then again ignoring/deleting is easy.
I wish people would think a little more on whom to Cc.  In general
I don't really need a personal Cc for drive by patches - I'll happily
pick them up from the mailing list and actually prefer it that way.
But I have received contrary feedback from people that do want to be
CCed on every little thing.
