Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8291C004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C3E206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfECL7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:59:38 -0400
Received: from verein.lst.de ([213.95.11.211]:37221 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbfECL7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:59:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0F59368AFE; Fri,  3 May 2019 13:59:19 +0200 (CEST)
Date:   Fri, 3 May 2019 13:59:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: implement generic dma_map_ops for IOMMUs v4
Message-ID: <20190503115918.GA19657@lst.de>
References: <20190430105214.24628-1-hch@lst.de> <20190502132208.GA3069@lst.de> <20190503114731.GH55449@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503114731.GH55449@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 12:47:31PM +0100, Catalin Marinas wrote:
> On Thu, May 02, 2019 at 03:22:08PM +0200, Christoph Hellwig wrote:
> > can you quickly look over the arm64 parts?  I'd really like to still
> > get this series in for this merge window as it would conflict with
> > a lot of dma-mapping work for next merge window, and we also have
> > the amd and possibly intel iommu conversions to use it waiting.
> 
> Done. They look fine to me.

Ok, great.  Although I have to admit I feel about uneasy about
merging them for 5.2 unless Linus ends up doing an rc8.  I plan to
pull the prep_coherent patch into the dma-mapping tree as we'll
need it as a prepation for other things as well, and then we can
just have an immutable tree with the dma-iommu changes, so that
it doesn't block other DMA mapping changes that will touch this
code as well.

> 
> -- 
> Catalin
---end quoted text---
