Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9415CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F33A214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfJ1Hl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:41:59 -0400
Received: from verein.lst.de ([213.95.11.211]:33125 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbfJ1Hl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:41:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5AF8668C65; Mon, 28 Oct 2019 08:41:56 +0100 (CET)
Date:   Mon, 28 Oct 2019 08:41:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     isaacm@codeaurora.org
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191028074156.GB20443@lst.de>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org> <20191026053026.GA14545@lst.de> <e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 03:12:57AM -0700, isaacm@codeaurora.org wrote:
> On 2019-10-25 22:30, Christoph Hellwig wrote:
>> The definition makes very little sense.
> Can you please clarify what part doesn’t make sense, and why?

It looks like complete garbage to me.  That might just be because it
uses tons of terms I've never heard of of and which aren't used anywhere
in the DMA API.  It also might be because it doesn't explain how the
flag might actually be practically useful.

> This is 
> really just an extension of this patch that got mainlined, so that clients 
> that use the DMA API can use IOMMU_QCOM_SYS_CACHE as well: 
> https://patchwork.kernel.org/patch/10946099/
>>  Any without a user in the same series it is a complete no-go anyway.
> IOMMU_QCOM_SYS_CACHE does not have any current users in the mainline, nor 
> did it have it in the patch series in which it got merged, yet it is still 
> present? Furthermore, there are plans to upstream support for one of our 
> SoCs that may benefit from this, as seen here: 
> https://www.spinics.net/lists/iommu/msg39608.html.

Which means it should have never been merged.  As a general policy we do
not add code to the Linux kernel without actual users.
