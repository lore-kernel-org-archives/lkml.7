Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8172C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A682B205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfD2PA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:00:26 -0400
Received: from foss.arm.com ([217.140.101.70]:59644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfD2PA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:00:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E415280D;
        Mon, 29 Apr 2019 08:00:25 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D34E3F5C1;
        Mon, 29 Apr 2019 08:00:24 -0700 (PDT)
Subject: Re: [PATCH 26/26] arm64: trim includes in dma-mapping.c
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-27-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8d257026-870c-c183-4c34-48b9f8bc6872@arm.com>
Date:   Mon, 29 Apr 2019 16:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-27-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> With most of the previous functionality now elsewhere a lot of the
> headers included in this file are not needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 184ef9ccd69d..15bd768ceb7e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -5,20 +5,9 @@
>    */
>   
>   #include <linux/gfp.h>
> -#include <linux/acpi.h>
> -#include <linux/memblock.h>
>   #include <linux/cache.h>
> -#include <linux/export.h>
> -#include <linux/slab.h>
> -#include <linux/genalloc.h>
> -#include <linux/dma-direct.h>
>   #include <linux/dma-noncoherent.h>
> -#include <linux/dma-contiguous.h>
>   #include <linux/dma-iommu.h>
> -#include <linux/vmalloc.h>
> -#include <linux/swiotlb.h>
> -#include <linux/pci.h>
> -

Nit: please keep the blank line between linux/ and asm/ include blocks 
to match the predominant local style.

With that,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   #include <asm/cacheflush.h>
>   
>   pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> 
