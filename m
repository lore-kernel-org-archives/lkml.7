Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0D7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A992087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfD2MCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:02:39 -0400
Received: from foss.arm.com ([217.140.101.70]:54880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbfD2MCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:02:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985B6A78;
        Mon, 29 Apr 2019 05:02:34 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 323F53F5AF;
        Mon, 29 Apr 2019 05:02:33 -0700 (PDT)
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-13-hch@lst.de>
 <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de>
 <20190417063358.GA24139@lst.de>
 <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
 <20190418163512.GA25347@lst.de>
 <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
 <20190419082348.GA22299@lst.de>
 <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
 <20190429114918.GB30460@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6d99cda0-b7a9-49f2-fbdb-6563fcdd3309@arm.com>
Date:   Mon, 29 Apr 2019 13:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429114918.GB30460@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2019 12:49, Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 11:01:44AM +0100, Robin Murphy wrote:
>> Wouldn't this suffice? Since we also use alloc_pages() in the coherent
>> atomic case, the free path should already be able to deal with it.
>>
>> Let me take a proper look at v3 and see how it all looks in context.
> 
> Any comments on v3?  I've been deferring lots of other DMA work to
> not create conflicts, so I'd hate to miss this merge window.

Ah, I did skim the commits in the branch, but I'll run through again and 
reply on the patches while my head's still in email mode...

Robin.
