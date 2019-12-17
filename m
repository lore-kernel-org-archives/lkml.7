Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3880C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967102082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLQB5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:57:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:57635 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfLQB5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:57:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 17:57:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="227323430"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 16 Dec 2019 17:57:00 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v10 0/2] phy: intel-lgm-emmc: Add support for eMMC PHY
Date:   Tue, 17 Dec 2019 09:56:56 +0800
Message-Id: <20191217015658.23017-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eMMC-PHY support for Intel LGM SoC

changes in v10:
  - Rob's review comments update in YAML
  - drop clock-names since it is single entry
 
changes in v9:
  - Rob's review comments update in YAML

changes in v8:
 Remove the extra Signed-of-by

changes in v7:
 Rebased to maintainer kernel tree phy-tag-5.5

changes in v6:
   - cobined comaptible strings
   - added as contiguous and can be a single entry for reg properties
changes in v5:
   - earlier Review-by tag given by Rob
   - rework done with syscon parent node.

 changes in v4:
   - As per Rob's review: validate 5.2 and 5.3
   - drop unrelated items.

 changes in v3:
   - resolve 'make dt_binding_check' warnings

 changes in v2:
   As per Rob Herring review comments, the following updates
  - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
  - filename is the compatible string plus .yaml
  - LGM: Lightning Mountain
  - update maintainer
  - add intel,syscon under property list
  - keep one example instead of two



Ramuthevar Vadivel Murugan (2):
  dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
  phy: intel-lgm-emmc: Add support for eMMC PHY

 .../bindings/phy/intel,lgm-emmc-phy.yaml           |  56 ++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/intel/Kconfig                          |   9 +
 drivers/phy/intel/Makefile                         |   2 +
 drivers/phy/intel/phy-intel-emmc.c                 | 283 +++++++++++++++++++++
 6 files changed, 352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
 create mode 100644 drivers/phy/intel/Kconfig
 create mode 100644 drivers/phy/intel/Makefile
 create mode 100644 drivers/phy/intel/phy-intel-emmc.c

-- 
2.11.0

