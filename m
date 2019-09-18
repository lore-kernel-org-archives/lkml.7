Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB4C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F33B21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfIRTuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:50:03 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:42200 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbfIRTuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:50:03 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994204AbfIRTuBXltuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Wed, 18 Sep 2019 21:50:01 +0200
Date:   Wed, 18 Sep 2019 20:50:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: remove support for DMA_ATTR_WRITE_COMBINE
In-Reply-To: <20190807061602.31217-3-hch@lst.de>
Message-ID: <alpine.LFD.2.21.1909182001260.31718@eddie.linux-mips.org>
References: <20190807061602.31217-1-hch@lst.de> <20190807061602.31217-3-hch@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Christoph Hellwig wrote:

> Mips uses the KSEG1 kernel memory segment to map dma coherent
> allocations for non-coherent devices as uncacheable, and does not have
> any kind of special support for DMA_ATTR_WRITE_COMBINE in the allocation
> path.  Thus supporting DMA_ATTR_WRITE_COMBINE in dma_mmap_attrs will
> lead to multiple mappings with different caching attributes.

 FYI, AFAIK _CACHE_UNCACHED_ACCELERATED (where supported) is effectively 
write-combine.  Though IIUC someone would have to wire it in first.

  Maciej
