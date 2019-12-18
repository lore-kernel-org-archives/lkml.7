Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DC2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A8524676
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfLRPTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:19:03 -0500
Received: from 8bytes.org ([81.169.241.247]:57878 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfLRPTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:19:03 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0C4EF258; Wed, 18 Dec 2019 16:19:00 +0100 (CET)
Date:   Wed, 18 Dec 2019 16:18:57 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove incorrect PSI capability check
Message-ID: <20191218151856.GA2995@8bytes.org>
References: <20191120061016.31386-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120061016.31386-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 02:10:16PM +0800, Lu Baolu wrote:
> The PSI (Page Selective Invalidation) bit in the capability register
> is only valid for second-level translation. Intel IOMMU supporting
> scalable mode must support page/address selective IOTLB invalidation
> for first-level translation. Remove the PSI capability check in SVA
> cache invalidation code.
> 
> Fixes: 8744daf4b0699 ("iommu/vt-d: Remove global page flush support")
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied for v5.5, thanks.

