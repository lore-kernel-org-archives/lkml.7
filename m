Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C6C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AB12083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDKPTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:19:22 -0400
Received: from 8bytes.org ([81.169.241.247]:34180 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfDKPTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:19:19 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7AEA2451; Thu, 11 Apr 2019 17:19:17 +0200 (CEST)
Date:   Thu, 11 Apr 2019 17:19:17 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/9] vfio/mdev: IOMMU aware mediated device
Message-ID: <20190411151917.GA29810@8bytes.org>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325013036.18400-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu Baolu,

thanks for these patches!

On Mon, Mar 25, 2019 at 09:30:27AM +0800, Lu Baolu wrote:
> Lu Baolu (9):
>   iommu: Add APIs for multiple domains per device
>   iommu/vt-d: Make intel_iommu_enable_pasid() more generic
>   iommu/vt-d: Add per-device IOMMU feature ops entries
>   iommu/vt-d: Move common code out of iommu_attch_device()
>   iommu/vt-d: Aux-domain specific domain attach/detach
>   iommu/vt-d: Return ID associated with an auxiliary domain

I applied the patches above to my tree. The first patch is in a new
branch called 'api-features' and the other are in the x86/vt-d branch.

>   vfio/mdev: Add iommu related member in mdev_device
>   vfio/type1: Add domain at(de)taching group helpers
>   vfio/type1: Handle different mdev isolation type

Can you please address the minor concern on these patches, add all
review and acks and re-send?

Thanks,

	Joerg

