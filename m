Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F909C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A02341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfH3QE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:04:59 -0400
Received: from verein.lst.de ([213.95.11.211]:56833 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbfH3QE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:04:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 95CE5227A8A; Fri, 30 Aug 2019 18:04:54 +0200 (CEST)
Date:   Fri, 30 Aug 2019 18:04:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/26] x86: clean up ioremap
Message-ID: <20190830160454.GB26887@lst.de>
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-13-hch@lst.de> <20190817103402.GA7602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817103402.GA7602@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 12:34:02PM +0200, Ingo Molnar wrote:
> 
> * Christoph Hellwig <hch@lst.de> wrote:
> 
> > Use ioremap as the main implemented function, and defined
> > ioremap_nocache to it as a deprecated alias.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/x86/include/asm/io.h | 8 ++------
> >  arch/x86/mm/ioremap.c     | 8 ++++----
> >  arch/x86/mm/pageattr.c    | 4 ++--
> >  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

Can you pick it up through tip for 5.4?  That way we can get most
bits in through their maintainer trees, and then I'll resubmit the
rest for the next merge window.
