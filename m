Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9104C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 01:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8252085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 01:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEBBky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 21:40:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:20681 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfEBBkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 21:40:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 18:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,419,1549958400"; 
   d="scan'208";a="320696564"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2019 18:40:50 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Small fixes for 5.2-rc1
Date:   Thu,  2 May 2019 09:34:24 +0800
Message-Id: <20190502013426.16989-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This includes two small fixes for virtual IOMMU running in
qemu enviroment. On bare metal, we always have an dedicated
IOMMU for Intel integrated graphic device. And some aspects
of the driver was designed according to this. Unfortunately,
in qemu environment, the virtual IOMMU has only a single
include-all IOMMU engine, as the result some interfaces don't
work as expected anymore. This includes two fixes for this.

Best regards,
Lu Baolu

Lu Baolu (2):
  iommu/vt-d: Set intel_iommu_gfx_mapped correctly
  iommu/vt-d: Make kernel parameter igfx_off work with vIOMMU

 drivers/iommu/intel-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.17.1

