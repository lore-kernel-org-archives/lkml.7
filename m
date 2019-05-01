Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2344C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9212085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfEAP7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:59:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:25560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfEAP6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:58:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 08:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="296115736"
Received: from modiarvi-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.211])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2019 08:58:35 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v4 16/22] soundwire: intel: protect macro parameters
Date:   Wed,  1 May 2019 10:57:39 -0500
Message-Id: <20190501155745.21806-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extra parentheses required here

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 56d6c1dda0ff..8c653a563534 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -24,18 +24,18 @@
 #define SDW_SHIM_IPPTR			0x8
 #define SDW_SHIM_SYNC			0xC
 
-#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * x)
-#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * x)
-#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * x)
-#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * x)
-#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * x)
-#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * x)
-
-#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * x) + (0x2 * y))
-#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * x) + (0x2 * y))
-#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * x)
-#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * x)
-#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * x)
+#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * (x))
+#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * (x))
+#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * (x))
+#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * (x))
+#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * (x))
+#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * (x))
+
+#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * (x)) + (0x2 * (y)))
+#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * (x)) + (0x2 * (y)))
+#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * (x))
+#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * (x))
+#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
 
 #define SDW_SHIM_WAKEEN			0x190
 #define SDW_SHIM_WAKESTS		0x192
@@ -82,7 +82,7 @@
 #define SDW_SHIM_WAKESTS_STATUS		BIT(0)
 
 /* Intel ALH Register definitions */
-#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * x))
+#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * (x)))
 
 #define SDW_ALH_STRMZCFG_DMAT_VAL	0x3
 #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
-- 
2.17.1

