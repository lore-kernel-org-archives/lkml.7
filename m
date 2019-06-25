Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F1FC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F332133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfFYOYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:24:13 -0400
Received: from verein.lst.de ([213.95.11.211]:35346 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFYOYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:24:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4554668B05; Tue, 25 Jun 2019 16:23:41 +0200 (CEST)
Date:   Tue, 25 Jun 2019 16:23:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rich Felker <dalias@libc.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove arch/sh?
Message-ID: <20190625142341.GA6948@lst.de>
References: <20190625085616.GA32399@lst.de> <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de> <20190625142144.GC1506@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625142144.GC1506@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:21:44AM -0400, Rich Felker wrote:
> I'm generally okay with all proposed non-functional changes that come
> up that are just eliminating arch-specific cruft to use new shared
> kernel infrastructure. I recall replying to a few indicating this, but
> I missed a lot more. If it would be helpful I think I can commit to
> doing at least this more consistently, but I'm happy to have other
> maintainers make that call too.

It woud be great if you could at least apply with a tentative ack.
At least for some trees we try very hard to get a maintainer ack,
so silence is holding things back to some extent.

I'd also like to second Arnds request to figure out if any bits
are truely dead.  E.g. 64-bit sh5 support very much appears so.
