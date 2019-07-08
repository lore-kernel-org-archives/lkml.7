Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965CCC606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7176621707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405098AbfGHUij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:38:39 -0400
Received: from verein.lst.de ([213.95.11.211]:36822 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404955AbfGHUij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:38:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B52468B05; Mon,  8 Jul 2019 22:38:37 +0200 (CEST)
Date:   Mon, 8 Jul 2019 22:38:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: m68k build failures in -next: undefined reference to
 `arch_dma_prep_coherent'
Message-ID: <20190708203837.GA15713@lst.de>
References: <20190708170647.GA12313@roeck-us.net> <CAMuHMdUnSqKHA7EN1S8U7eBODs4gi-raw4P3FxnR_afhb2Zd5g@mail.gmail.com> <20190708194516.GA18304@roeck-us.net> <CAMuHMdVKKkx_S_mXmCzckyiw1fbLQMEZroRT+UchHv+tgF-3RA@mail.gmail.com> <20190708202226.GA15167@lst.de> <CAMuHMdUUpyiRp3LdfE0M96dM6kAzse+gfXWqEQWe9ScwT9GX4A@mail.gmail.com> <20190708203733.GA15607@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708203733.GA15607@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 10:37:33PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 08, 2019 at 10:36:05PM +0200, Geert Uytterhoeven wrote:
> > Note that the build failure is more subtle: both m5307c3_defconfig and
> > m5475evb_defconfig build fine in m68k/for-linus, but fail in
> > next-20190708.  So it fails when combined with other changes, going
> > in through a different tree (the DMA tree?).
> 
> Yes, the dma tree adds the stub for the symbol and adds code relying
> on that.

If you give me an ack I can add the fix to the dma-mapping pull request.
