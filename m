Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA3CCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18977222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571422122;
	bh=Vt0XxT7ZZkyc8I8SBdsLEI8L0p24+vOeF0RxPDpVDow=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aPxsD1LgSb2FSYnwzVuz3M8y1l/PTuUPVAfNe+SypjKCWc1pyFcNacxHafzKn7Q09
	 mu/137i8PrlGY9O+tWiyiObZXI6vNB0Mpg3Cwr8hc/T5RVeRjC88BVlSQ0dpwKY2c9
	 33mkboG6KQHo4n4hf+v1XmCPs6fVY+3JGhIzuLyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505707AbfJRSHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:07:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44778 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505687AbfJRSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zgj1k1MhkF4/2yUkMOt2RfyxHbkblu/gDQSDTPudqFM=; b=MA1YsvCVevf1
        y/cANjMIurKncfMJdq6PqpiDETClyN+z53ImVjSd78hrpFH/sSYgWaSkjdYoJVTOZNcwCyp+2Q+gA
        29POl6mNjveeCrhjqhagi2R8cJSIYvfkPi3sJbBdZ9q2hqAQEEmRhmCPDo2zcEPZaMTNwOLEtiAeJ
        pe6ns=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLWeS-0004FO-8N; Fri, 18 Oct 2019 18:07:00 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B5BCC2743276; Fri, 18 Oct 2019 19:06:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, dmurphy@ti.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, navada@ti.com, tiwai@suse.com
Subject: Applied "ASoC: tas2562: Fix misuse of GENMASK macro" to the asoc tree
In-Reply-To: <20191015200900.25798-1-rikard.falkeborn@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191018180659.B5BCC2743276@ypsilon.sirena.org.uk>
Date:   Fri, 18 Oct 2019 19:06:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas2562: Fix misuse of GENMASK macro

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 0e4b8717578e05ec6aa6d51939e6dc746f3198e9 Mon Sep 17 00:00:00 2001
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Date: Tue, 15 Oct 2019 22:09:00 +0200
Subject: [PATCH] ASoC: tas2562: Fix misuse of GENMASK macro

Arguments are supposed to be ordered high then low.

Fixes: c173dba44c2d ("ASoC: tas2562: Introduce the TAS2562 amplifier")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Link: https://lore.kernel.org/r/20191015200900.25798-1-rikard.falkeborn@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2562.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.h b/sound/soc/codecs/tas2562.h
index 60f2bb1d198b..62e659ab786d 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/sound/soc/codecs/tas2562.h
@@ -62,7 +62,7 @@
 
 #define TAS2562_TDM_CFG2_RIGHT_JUSTIFY	BIT(6)
 
-#define TAS2562_TDM_CFG2_RXLEN_MASK	GENMASK(0, 1)
+#define TAS2562_TDM_CFG2_RXLEN_MASK	GENMASK(1, 0)
 #define TAS2562_TDM_CFG2_RXLEN_16B	0x0
 #define TAS2562_TDM_CFG2_RXLEN_24B	BIT(0)
 #define TAS2562_TDM_CFG2_RXLEN_32B	BIT(1)
-- 
2.20.1

