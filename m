Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE90C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A5B263A6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfFCGtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:49:23 -0400
Received: from verein.lst.de ([213.95.11.211]:54901 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfFCGtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:49:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9F53A68B05; Mon,  3 Jun 2019 08:48:55 +0200 (CEST)
Date:   Mon, 3 Jun 2019 08:48:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH 5/7 v2] MIPS: use the generic uncached segment support
 in dma-direct
Message-ID: <20190603064855.GA22023@lst.de>
References: <20190430110032.25301-1-hch@lst.de> <20190430110032.25301-6-hch@lst.de> <20190430201041.536amvinrcvd2wua@pburton-laptop> <20190430202947.GA30262@lst.de> <20190430211105.ielntedm46uqamca@pburton-laptop> <20190501131339.GA890@lst.de> <20190501171355.7wnrutfnax5djkpx@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501171355.7wnrutfnax5djkpx@pburton-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 05:13:57PM +0000, Paul Burton wrote:
> Hi Christoph,
> 
> On Wed, May 01, 2019 at 03:13:39PM +0200, Christoph Hellwig wrote:
> > Stop providing our arch alloc/free hooks and just expose the segment
> > offset instead.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/mips/Kconfig              |  1 +
> >  arch/mips/include/asm/page.h   |  3 ---
> >  arch/mips/jazz/jazzdma.c       |  6 ------
> >  arch/mips/mm/dma-noncoherent.c | 26 +++++++++-----------------
> >  4 files changed, 10 insertions(+), 26 deletions(-)
> 
> This one looks good to me now, for patches 1 & 5:
> 
>   Acked-by: Paul Burton <paul.burton@mips.com>

Thanks, I've merged thos into the dma-mapping tree.
