Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500E5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EA92173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfDQQ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:26:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43102 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbfDQQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:26:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGnOH-0006bB-2R; Wed, 17 Apr 2019 16:26:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdmi-codec: fix spelling mistake "plalform" -> "platform"
Date:   Wed, 17 Apr 2019 17:26:28 +0100
Message-Id: <20190417162628.10976-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 35df73e42cbc..b9d9dde9fbaf 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -757,7 +757,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	dev_dbg(dev, "%s()\n", __func__);
 
 	if (!hcd) {
-		dev_err(dev, "%s: No plalform data\n", __func__);
+		dev_err(dev, "%s: No platform data\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.20.1

