Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F26C22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404665AbfHWGjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:39:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:36642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404612AbfHWGjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:39:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 23:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="181633845"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 22 Aug 2019 23:39:32 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v5 0/1] phy: intel-lgm-emmc: Add support for eMMC PHY
Date:   Fri, 23 Aug 2019 14:39:27 +0800
Message-Id: <20190823063928.6153-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for eMMC PHY on Intel's Lightning Mountain SoC.

 changes in v5:
  - many thanks to Andy's for giving me many hints regarding code optimization!	
  - added Andy's Reviewed-by to the emm-phy patch
  - replace magic.no '1' -> macro

 chnages in v4:
  - As per Andy's review comments,the following update
  - add license_tag, macro, blank_line, error_check and grouping

 changes in v3:
  - As per Andy's review comments macro optimization,aligned
    function call in proper order and udelay added.

 changes in v2:
  - optimize IS_CALDONE() and IS_DLLRDY() macro
  - remove unneccessary comment
  - remove redundant assignment
  - add return the error ptr

Ramuthevar Vadivel Murugan (1):
  phy: intel-lgm-emmc: Add support for eMMC PHY

 drivers/phy/Kconfig                |   1 +
 drivers/phy/Makefile               |   1 +
 drivers/phy/intel/Kconfig          |   9 ++
 drivers/phy/intel/Makefile         |   2 +
 drivers/phy/intel/phy-intel-emmc.c | 282 +++++++++++++++++++++++++++++++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 drivers/phy/intel/Kconfig
 create mode 100644 drivers/phy/intel/Makefile
 create mode 100644 drivers/phy/intel/phy-intel-emmc.c

-- 
2.11.0

