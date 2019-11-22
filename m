Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DCBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EB720674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfKVL1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:27:50 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47188 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfKVKb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:31:59 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E259B1A00B2;
        Fri, 22 Nov 2019 11:31:57 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3903D1A01FD;
        Fri, 22 Nov 2019 11:31:52 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0071B4027F;
        Fri, 22 Nov 2019 18:31:44 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shengjiu.wang@nxp.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        allison@lohutok.net, tglx@linutronix.de,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ASoC: wm8524: Add support S32_LE
Date:   Fri, 22 Nov 2019 18:30:13 +0800
Message-Id: <cff745cc041c5208910821f0740f988926af8a66.1574418380.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow 32bit sample with this codec.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8524.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index 91e3d1570c45..4e9ab542f648 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -159,7 +159,9 @@ static int wm8524_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 
 #define WM8524_RATES SNDRV_PCM_RATE_8000_192000
 
-#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			SNDRV_PCM_FMTBIT_S24_LE |\
+			SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops wm8524_dai_ops = {
 	.startup	= wm8524_startup,
-- 
2.21.0

