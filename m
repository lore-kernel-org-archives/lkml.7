Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E8AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A142071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfKTPYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:24:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47060 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbfKTPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:24:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C1A382910E9
Received: by earth.universe (Postfix, from userid 1000)
        id 218143C0C77; Wed, 20 Nov 2019 16:24:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 1/6] ASoC: da7213: Add da7212 DT compatible
Date:   Wed, 20 Nov 2019 16:24:01 +0100
Message-Id: <20191120152406.2744-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120152406.2744-1-sebastian.reichel@collabora.com>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a compatible for da7212. It's handled exactly the
same way as DA7213 and follows the ACPI bindings.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/sound/da7213.txt | 4 ++--
 sound/soc/codecs/da7213.c                          | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7213.txt b/Documentation/devicetree/bindings/sound/da7213.txt
index 58902802d56c..759bb04e0283 100644
--- a/Documentation/devicetree/bindings/sound/da7213.txt
+++ b/Documentation/devicetree/bindings/sound/da7213.txt
@@ -1,9 +1,9 @@
-Dialog Semiconductor DA7213 Audio Codec bindings
+Dialog Semiconductor DA7212/DA7213 Audio Codec bindings
 
 ======
 
 Required properties:
-- compatible : Should be "dlg,da7213"
+- compatible : Should be "dlg,da7212" or "dlg,7213"
 - reg: Specifies the I2C slave address
 
 Optional properties:
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 925a03996db4..aff306bb58df 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1571,6 +1571,7 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
 #if defined(CONFIG_OF)
 /* DT */
 static const struct of_device_id da7213_of_match[] = {
+	{ .compatible = "dlg,da7212", },
 	{ .compatible = "dlg,da7213", },
 	{ }
 };
-- 
2.24.0

