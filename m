Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03B3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B117620868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfEVMyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:54:51 -0400
Received: from foss.arm.com ([217.140.101.70]:49986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfEVMyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:54:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0035180D;
        Wed, 22 May 2019 05:54:51 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A1BE3F575;
        Wed, 22 May 2019 05:54:49 -0700 (PDT)
Date:   Wed, 22 May 2019 13:54:47 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/24] arm64/iommu: handle non-remapped addresses in
 ->mmap and ->get_sgtable
Message-ID: <20190522125447.GB7876@fuggles.cambridge.arm.com>
References: <20190520072948.11412-1-hch@lst.de>
 <20190520072948.11412-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520072948.11412-2-hch@lst.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 09:29:25AM +0200, Christoph Hellwig wrote:
> DMA allocations that can't sleep may return non-remapped addresses, but
> we do not properly handle them in the mmap and get_sgtable methods.
> Resolve non-vmalloc addresses using virt_to_page to handle this corner
> case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I'll send this one to Linus this week as part of the arm64 fixes.

Will
