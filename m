Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC1920830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfDAJjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:39:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59414 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDAJjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:39:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E3C8A78;
        Mon,  1 Apr 2019 02:39:22 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E57A3F690;
        Mon,  1 Apr 2019 02:39:21 -0700 (PDT)
Subject: Re: [PATCH 20/21] arm64: switch copyright boilerplace to SPDX in
 dma-mapping.c
To:     Mukesh Ojha <mojha@codeaurora.org>, Christoph Hellwig <hch@lst.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-21-hch@lst.de>
 <872c92d0-53cd-a5e1-13ee-f2f715d017b4@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <caa88042-6338-43c1-960c-293a617ea194@arm.com>
Date:   Mon, 1 Apr 2019 10:39:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <872c92d0-53cd-a5e1-13ee-f2f715d017b4@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 07:28, Mukesh Ojha wrote:
> 
> On 3/27/2019 1:34 PM, Christoph Hellwig wrote:
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Acked-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   arch/arm64/mm/dma-mapping.c | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index bf49e982c978..ad46594b3799 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -1,20 +1,7 @@
>> +// SPDX-License-Identifier: GPL-2.0
> /* SPDX-License-Identifier: GPL-2.0   */
> 
> 
> Can we do this way as discussed in
> https://lkml.org/lkml/2019/2/13/570

But this isn't a header file... :/

Robin.

[FYI Christoph, this series is now at the top of my review pile and I 
promise I'll get it done by the end of this week :)]

> Once you fix it you can take mine review in all your this kind of patches.
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> Cheers,
> Mukesh
> 
>>   /*
>> - * SWIOTLB-based DMA API implementation
>> - *
>>    * Copyright (C) 2012 ARM Ltd.
>>    * Author: Catalin Marinas <catalin.marinas@arm.com>
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>>   #include <linux/gfp.h>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
