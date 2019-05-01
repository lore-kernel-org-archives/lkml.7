Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F76CC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFCF2085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfEAP6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:58:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:25560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfEAP6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:58:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 08:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="296115684"
Received: from modiarvi-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.211])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2019 08:58:16 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v4 05/22] soundwire: bus: fix typos in comments
Date:   Wed,  1 May 2019 10:57:28 -0500
Message-Id: <20190501155745.21806-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spelling mistakes

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 74e04caa811b..efdcefc62e1a 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -49,7 +49,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	}
 
 	/*
-	 * Device numbers in SoundWire are 0 thru 15. Enumeration device
+	 * Device numbers in SoundWire are 0 through 15. Enumeration device
 	 * number (0), Broadcast device number (15), Group numbers (12 and
 	 * 13) and Master device number (14) are not used for assignment so
 	 * mask these and other higher bits.
@@ -282,7 +282,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	if (addr < SDW_REG_OPTIONAL_PAGE) { /* 32k but no page */
 		if (slave && !slave->prop.paging_support)
 			return 0;
-		/* no need for else as that will fall thru to paging */
+		/* no need for else as that will fall-through to paging */
 	}
 
 	/* paging mandatory */
-- 
2.17.1

