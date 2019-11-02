Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B1BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 02:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99AD21855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 02:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKBC42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 22:56:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:33710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfKBC42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 22:56:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 19:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="scan'208";a="226214138"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 19:56:26 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] MAINTAINERS: Update for INTEL IOMMU (VT-d) entry
Date:   Sat,  2 Nov 2019 10:53:11 +0800
Message-Id: <20191102025311.3440-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the INTEL IOMMU (VT-d) entry and add myself as the
co-maintainer. I have several years of VT-d development
experience and have actively contributed to Intel VT-d
driver during recent two years. I volunteer to take this
rule. With this role, I can better help review and test
patches.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095547fd..86b999000fcb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8299,11 +8299,14 @@ F:	drivers/hid/intel-ish-hid/
 
 INTEL IOMMU (VT-d)
 M:	David Woodhouse <dwmw2@infradead.org>
+M:	Lu Baolu <baolu.lu@linux.intel.com>
 L:	iommu@lists.linux-foundation.org
-T:	git git://git.infradead.org/iommu-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 S:	Supported
-F:	drivers/iommu/intel-iommu.c
+F:	drivers/iommu/dmar.c
+F:	drivers/iommu/intel*.[ch]
 F:	include/linux/intel-iommu.h
+F:	include/linux/intel-svm.h
 
 INTEL IOP-ADMA DMA DRIVER
 R:	Dan Williams <dan.j.williams@intel.com>
-- 
2.17.1

