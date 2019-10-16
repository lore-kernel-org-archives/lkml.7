Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB0FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C25C21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436517AbfJPSQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:16:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:44700 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732537AbfJPSQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:16:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 11:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="202145476"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2019 11:16:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iKnqk-000DNQ-GY; Thu, 17 Oct 2019 02:16:42 +0800
Date:   Thu, 17 Oct 2019 02:16:17 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     kbuild-all@lists.01.org, Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] iommu: Add gfp parameter to iommu_ops::
 __iommu_map() can be static
Message-ID: <20191016181617.re56kjwb6waohm43@332d0cec05f4>
References: <201910170219.0Cpe09fn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910170219.0Cpe09fn%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f8853dbf1c4eb..89bfdbbfaa11b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1854,7 +1854,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }
 
-int __iommu_map(struct iommu_domain *domain, unsigned long iova,
+static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	const struct iommu_ops *ops = domain->ops;
