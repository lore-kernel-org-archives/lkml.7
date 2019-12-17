Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E016F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLQKIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:08:53 -0500
Received: from 8bytes.org ([81.169.241.247]:57660 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfLQKIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:08:53 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AAE48286; Tue, 17 Dec 2019 11:08:51 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:08:50 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] iommu: Implement iommu_put_resv_regions_simple()
Message-ID: <20191217100850.GI8689@8bytes.org>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry

On Mon, Dec 09, 2019 at 03:50:02PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Most IOMMU drivers only need to free the memory allocated for each
> reserved region. Instead of open-coding the loop to do this in each
> driver, extract the code into a common function that can be used by
> all these drivers.
> 
> Changes in v2:
> - change subject prefix to "iommu: virtio: " for virtio-iommu.c driver
> 
> Thierry
> 
> Thierry Reding (5):
>   iommu: Implement iommu_put_resv_regions_simple()
>   iommu: arm: Use iommu_put_resv_regions_simple()
>   iommu: amd: Use iommu_put_resv_regions_simple()
>   iommu: intel: Use iommu_put_resv_regions_simple()
>   iommu: virtio: Use iommu_put_resv_regions_simple()

Thanks, that is a nice consolidation. Just a minor nit, can you please
rename iommu_put_resv_regions_simple to
generic_iommu_put_resv_regsions(). That matches the naming in other
places where we have done similar things.

Thanks,

	Joerg
