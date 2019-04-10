Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588D9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4D020850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbfDJOXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:23:40 -0400
Received: from ns.iliad.fr ([212.27.33.1]:33264 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732662AbfDJOXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:23:39 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 55C1921946;
        Wed, 10 Apr 2019 16:23:38 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3A0222189D;
        Wed, 10 Apr 2019 16:23:38 +0200 (CEST)
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH] ASoC: wcd9335: Fix missing regmap requirement
Message-ID: <8c0b22e2-2c67-8d45-a57d-dfc54043fbc9@free.fr>
Date:   Wed, 10 Apr 2019 16:23:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Apr 10 16:23:38 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wcd9335.c: undefined reference to 'devm_regmap_add_irq_chip'

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 419142111b6d..33778dc99108 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1162,6 +1162,7 @@ config SND_SOC_WCD9335
 	tristate "WCD9335 Codec"
 	depends on SLIMBUS
 	select REGMAP_SLIMBUS
+	select REGMAP_IRQ
 	help
 	  The WCD9335 is a standalone Hi-Fi audio CODEC IC, supports
 	  Qualcomm Technologies, Inc. (QTI) multimedia solutions,
-- 
2.17.1
