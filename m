Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB415FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DCA21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vamFExu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436565AbfJPST4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:19:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36936 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436542AbfJPSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:19:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJp5G082681;
        Wed, 16 Oct 2019 13:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571249991;
        bh=+59uyIj8cvDaVeHuDErtWdqjicA/uMUOejrOVyySKNo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vamFExu+pc3j3u9/xDZ0xIVr08+X1K9v7z5uL7D201LsGLfmh7FeW4Ahf73YuPKjt
         vdoZ2gDUN9GaeeCUhMtWWZenX79ROosN3MN+poiaGQTgTx5SnyqFn1WNRA7lgRnHT3
         SQFlGXeJJNj77jz92h05hFOTGxW9veMxZmZoXJIQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GIJpXM125461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 13:19:51 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:19:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:19:51 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJpnw096159;
        Wed, 16 Oct 2019 13:19:51 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GIJoZ07886;
        Wed, 16 Oct 2019 13:19:50 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Jiri Kosina <trivial@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 06/10] thermal: devfreq_cooling: Remove unneeded conversions to bool
Date:   Wed, 16 Oct 2019 14:19:40 -0400
Message-ID: <20191016181944.25106-3-afd@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016181944.25106-1-afd@ti.com>
References: <20191016181944.25106-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found with scripts/coccinelle/misc/boolconv.cocci.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff..e386a3241700 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -85,7 +85,7 @@ static int partition_enable_opps(struct devfreq_cooling_device *dfc,
 		struct dev_pm_opp *opp;
 		int ret = 0;
 		unsigned int freq = dfc->freq_table[i];
-		bool want_enable = i >= cdev_state ? true : false;
+		bool want_enable = i >= cdev_state;
 
 		opp = dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
 
-- 
2.17.1

