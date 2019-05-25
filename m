Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBF4C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E8F2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfEYMeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 08:34:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43094 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfEYMeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:34:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4A9A79CAAB69822807A;
        Sat, 25 May 2019 20:34:14 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 20:34:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: cx2072x: remove set but not used variable 'is_right_j '
Date:   Sat, 25 May 2019 20:32:04 +0800
Message-ID: <20190525123204.16148-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/codecs/cx2072x.c: In function cx2072x_config_i2spcm:
sound/soc/codecs/cx2072x.c:679:6: warning: variable is_right_j set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/cx2072x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 23d2b25fe04c..a066ef83de1a 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -676,7 +676,6 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 	unsigned int bclk_rate = 0;
 	int is_i2s = 0;
 	int has_one_bit_delay = 0;
-	int is_right_j = 0;
 	int is_frame_inv = 0;
 	int is_bclk_inv = 0;
 	int pulse_len = 1;
@@ -740,7 +739,6 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 
 	case SND_SOC_DAIFMT_RIGHT_J:
 		is_i2s = 1;
-		is_right_j = 1;
 		pulse_len = frame_len / 2;
 		break;
 
-- 
2.17.1


