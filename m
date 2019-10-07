Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DCC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B24F206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ss1qvHOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfJGRJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:09:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54526 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:09:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97H9HDV034666;
        Mon, 7 Oct 2019 12:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570468157;
        bh=qqvkpyb/zkfTPkxgRMnn6l/UTJ4GrNMbr9o3D9e32hE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ss1qvHOtn/k3L5BBiwEn+HG2R0xjf3yJP3LNZiNpgbp7011gHXPKoYeQpIEPEt/6I
         7Nz2VGN3FXe8mKAfXJQKpLZWH2wey5puHCybYHtBKCoyhvabHURK3STkStGToinHlJ
         xdUnMlu+cIMwK7kFYBGG/8dfH5odZRTISmh3VeSA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97H9Hww083178;
        Mon, 7 Oct 2019 12:09:17 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 12:09:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 12:09:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97H9G9s118747;
        Mon, 7 Oct 2019 12:09:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <shifu0704@thundersoft.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <navada@ti.com>, <perex@perex.cz>,
        <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 3/3] ASoc: tas2770: Remove unused defines and variables
Date:   Mon, 7 Oct 2019 12:11:57 -0500
Message-ID: <20191007171157.17813-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
In-Reply-To: <20191007171157.17813-1-dmurphy@ti.com>
References: <20191007171157.17813-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused defines and structure variables that are not
referenced by the code.  If these are needed for future
enhancements then they should be added at that time.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - New patch no v1

 sound/soc/codecs/tas2770.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index d597a8280707..cbb858369fe6 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -125,40 +125,19 @@
 #define ERROR_UNDER_VOLTAGE 0x0000008
 #define ERROR_BROWNOUT      0x0000010
 #define ERROR_CLASSD_PWR    0x0000020
-#define TAS2770_SLOT_16BIT  16
-#define TAS2770_SLOT_32BIT  32
-#define TAS2770_I2C_RETRY_COUNT      3
-
-struct tas2770_register {
-	int book;
-	int page;
-	int reg;
-};
-
-struct tas2770_dai_cfg {
-	unsigned int dai_fmt;
-	unsigned int tdm_delay;
-};
 
 struct tas2770_priv {
 	struct device *dev;
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
 	struct snd_soc_component *component;
-	struct mutex dev_lock;
-	struct hrtimer mtimer;
 	int power_state;
 	int asi_format;
 	struct gpio_desc *reset_gpio;
 	int sampling_rate;
-	int frame_size;
 	int channel_size;
 	int slot_width;
 	int v_sense_slot;
 	int i_sense_slot;
-	bool runtime_suspend;
-	unsigned int err_code;
-	struct mutex codec_lock;
 };
 
 #endif /* __TAS2770__ */
-- 
2.22.0.214.g8dca754b1e

