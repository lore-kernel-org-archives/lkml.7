Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F8DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7584720850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LDPjh4HM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YmhVpyXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfDAG2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:28:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfDAG2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:28:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 149EA6086B; Mon,  1 Apr 2019 06:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554100089;
        bh=cRg+P2a3gaFeMJ1n5W1/27x7/gR89ubQ8mZbfYkej4U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LDPjh4HMKQEO6NaM+zih1Q2I6uvkAK47RumrJotva0CVaeY63gCORcfjvktruV9UD
         TAwzar3+BBXf6DQCCmnm3NiyR7s924qY6g+Y1v5V2Gya2xF2ckhHcOojvSmMssTgye
         vDTwoAFfuWkBuG997daL1gkyid+NhRcm3z24yYf4=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 784F560392;
        Mon,  1 Apr 2019 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554100088;
        bh=cRg+P2a3gaFeMJ1n5W1/27x7/gR89ubQ8mZbfYkej4U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YmhVpyXlmIO0Zg8u9fMbGn1rVuZ0aaB99y5ngzLaIYQFN3dy+hLwjubttbQLcABgq
         6W4Tn+0B8OJz8VnpOL1sbVL+1Z2v7JCCs61jjX/VYpAof2Ip4hSEBRy96BW7HvphhA
         MluWU/SeMtkOPsm1IUGRWu7VkpXTuiYoPN5kN1DY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 784F560392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 20/21] arm64: switch copyright boilerplace to SPDX in
 dma-mapping.c
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-21-hch@lst.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <872c92d0-53cd-a5e1-13ee-f2f715d017b4@codeaurora.org>
Date:   Mon, 1 Apr 2019 11:58:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-21-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/2019 1:34 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   arch/arm64/mm/dma-mapping.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index bf49e982c978..ad46594b3799 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -1,20 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
/* SPDX-License-Identifier: GPL-2.0   */


Can we do this way as discussed in
https://lkml.org/lkml/2019/2/13/570

Once you fix it you can take mine review in all your this kind of patches.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
Mukesh

>   /*
> - * SWIOTLB-based DMA API implementation
> - *
>    * Copyright (C) 2012 ARM Ltd.
>    * Author: Catalin Marinas <catalin.marinas@arm.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
>   #include <linux/gfp.h>
