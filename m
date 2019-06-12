Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F08C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1B02086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408692AbfFLIdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:33 -0400
Received: from 8bytes.org ([81.169.241.247]:43542 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408672AbfFLIdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:31 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F412164D; Wed, 12 Jun 2019 10:33:29 +0200 (CEST)
Date:   Wed, 12 Jun 2019 10:33:28 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        robin.murphy@arm.com, alex.williamson@redhat.com,
        shameerali.kolothum.thodi@huawei.com, jean-philippe.brucker@arm.com
Subject: Re: [PATCH v6 0/7] RMRR related fixes and enhancements
Message-ID: <20190612083328.GD17505@8bytes.org>
References: <20190603065336.10524-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603065336.10524-1-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 08:53:29AM +0200, Eric Auger wrote:
> Eric Auger (7):
>   iommu: Fix a leak in iommu_insert_resv_region
>   iommu/vt-d: Duplicate iommu_resv_region objects per device list
>   iommu/vt-d: Introduce is_downstream_to_pci_bridge helper
>   iommu/vt-d: Handle RMRR with PCI bridge device scopes
>   iommu/vt-d: Handle PCI bridge RMRR device scopes in
>     intel_iommu_get_resv_regions
>   iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions
>   iommu/vt-d: Differentiate relaxable and non relaxable RMRRs

Applied, thanks.
