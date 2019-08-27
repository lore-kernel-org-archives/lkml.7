Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F9A23407
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfH0I1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:27:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:32185 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbfH0I1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:27:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 01:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="scan'208";a="197256618"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2019 01:27:00 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v1 0/2] phy: intel-lgm-sdxc: Add support for SDXC PHY
Date:   Tue, 27 Aug 2019 16:26:50 +0800
Message-Id: <20190827082652.43840-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for eMMC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
Ramuthevar Vadivel Murugan (2):
  dt-bindings: phy: intel-sdxc-phy: Add YAML schema for LGM SDXC PHY
  phy: intel-lgm-sdxc: Add support for SDXC PHY

 .../bindings/phy/intel,lgm-sdxc-phy.yaml           |  50 +++++++
 drivers/phy/intel/Kconfig                          |   6 +
 drivers/phy/intel/Makefile                         |   1 +
 drivers/phy/intel/phy-intel-sdxc.c                 | 144 +++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
 create mode 100644 drivers/phy/intel/phy-intel-sdxc.c

-- 
2.11.0

