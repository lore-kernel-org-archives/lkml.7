Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546FEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30843206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLQKSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:18:04 -0500
Received: from 8bytes.org ([81.169.241.247]:57688 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfLQKSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:18:03 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1B698286; Tue, 17 Dec 2019 11:18:02 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:18:00 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stephan@gerhold.net, natechancellor@gmail.com,
        nsaenzjulienne@suse.de, arnd@arndb.de
Subject: Re: [PATCH v2] iommu/dma: Rationalise types for DMA masks
Message-ID: <20191217101800.GL8689@8bytes.org>
References: <00d1ddf9439a8c79fb561b0fc740bddf9e6fe6b1.1576089015.git.robin.murphy@arm.com>
 <20191211190235.GA17854@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211190235.GA17854@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 08:02:35PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 11, 2019 at 06:33:26PM +0000, Robin Murphy wrote:
> > Since iommu_dma_alloc_iova() combines incoming masks with the u64 bus
> > limit, it makes more sense to pass them around in their native u64
> > rather than converting to dma_addr_t early. Do that, and resolve the
> > remaining type discrepancy against the domain geometry with a cheeky
> > cast to keep things simple.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Joerg, let me know if you want to pick this up through the iommu tree as
> it touches the iommu code, or through the dma-mapping tree that
> introduced the warning.

I'll take it through my tree, as I am about to collect fixes anyway.

Patch is now applied, thanks everyone.
