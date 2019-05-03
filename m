Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0739CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12702087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfECLpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:45:24 -0400
Received: from foss.arm.com ([217.140.101.70]:59078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfECLpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:45:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8953374;
        Fri,  3 May 2019 04:45:23 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FD403F220;
        Fri,  3 May 2019 04:45:22 -0700 (PDT)
Date:   Fri, 3 May 2019 12:45:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/25] iommu/dma: move the arm64 wrappers to common code
Message-ID: <20190503114519.GE55449@arrakis.emea.arm.com>
References: <20190430105214.24628-1-hch@lst.de>
 <20190430105214.24628-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430105214.24628-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:51:55AM -0400, Christoph Hellwig wrote:
> There is nothing really arm64 specific in the iommu_dma_ops
> implementation, so move it to dma-iommu.c and keep a lot of symbols
> self-contained.  Note the implementation does depend on the
> DMA_DIRECT_REMAP infrastructure for now, so we'll have to make the
> DMA_IOMMU support depend on it, but this will be relaxed soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
