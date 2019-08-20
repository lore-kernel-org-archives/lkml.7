Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE62C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B8722CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="g6gNwASi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfHTKdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:33:35 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:9277 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTKdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:33:35 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46CRtP56PTzGK;
        Tue, 20 Aug 2019 12:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566297119; bh=tGIjlWo4R4Ae8siv2EZMaotG+hGJXlGdM2zBh7Grdl8=;
        h=Date:From:Subject:To:Cc:From;
        b=g6gNwASiLfwwQWeYqfu6g5HjeVFOLIxeg3X7gkSkt23XopTy4xKrI38Lq/ggoeQhZ
         EsMBMgmtKvnv68kOrGDoGy+kBUxeiwA/tY4uvFahFSiE3SRiKAWlV71PC/7nh/kfxx
         2HIrJmn20oHngmGOG/5A7dVkWmPqOXVfH3xDCGH/rotR03fqynn+4i9igQ7SjI9G1Y
         gTcUKlF7TStlZb4VxcHQge6UJdcu605RRVcgAfv1TVR8pkHGdK9LSpxcuBD9DxKb4J
         1m+Ct8VG2Pgl8fB/F2G2kE0yw9H7/hR3Ilsf5benojnZRnmNVqFJwfNz/JkYikha3l
         1Qyr4ycB1uTxg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Tue, 20 Aug 2019 12:33:29 +0200
Message-Id: <f95ae1085f9f3c137a122c4d95728711613c15f7.1566297120.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] ASoC: wm8904: fix typo in DAPM kcontrol name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for typo in "Capture Inverting Mux"es' name.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 sound/soc/codecs/wm8904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 5ebdd1d9afde..525e4ef654a1 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -866,7 +866,7 @@ static SOC_ENUM_SINGLE_DECL(lin_inv_enum, WM8904_ANALOGUE_LEFT_INPUT_1, 4,
 			    lin_text);
 
 static const struct snd_kcontrol_new lin_inv_mux =
-	SOC_DAPM_ENUM("Left Capture Inveting Mux", lin_inv_enum);
+	SOC_DAPM_ENUM("Left Capture Inverting Mux", lin_inv_enum);
 
 static const char *rin_text[] = {
 	"IN1R", "IN2R", "IN3R"
@@ -882,7 +882,7 @@ static SOC_ENUM_SINGLE_DECL(rin_inv_enum, WM8904_ANALOGUE_RIGHT_INPUT_1, 4,
 			    rin_text);
 
 static const struct snd_kcontrol_new rin_inv_mux =
-	SOC_DAPM_ENUM("Right Capture Inveting Mux", rin_inv_enum);
+	SOC_DAPM_ENUM("Right Capture Inverting Mux", rin_inv_enum);
 
 static const char *aif_text[] = {
 	"Left", "Right"
-- 
2.20.1

