Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5A2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141C1217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554432201;
	bh=Jx56qruxv4rLPYpJLJwRUir3f/DUFSFVOHoVq4eZ8H8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=e59DpP4uoRODxE1l1W8vtzRYJMrbEOjytjEDkSkhkds1fgkUldWC7cWVqq7oWKx0x
	 0yyZC+t6qDeFNArcOieXAoJHiRGoAGH1N+cY6EW1AJ+GNi+DEVkn5bntUvWbpkmMzc
	 qerKMkShOaioxtUnA9PkjNHBPk6euFsUX0F2ZrdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfDECnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:43:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45208 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDECnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3Adxfw4V9KYe6gzscEgCxBTHFk+e9nP7+1yN6ci5ptw=; b=ApCyJIUTxj8O
        4Qkbo0t0OuwspQTuDYNIuW1VqqkS1TBSpbHBFUct6Gwf2DLz6dn+vnu2tKLFI99pnnZBquEpK7qtR
        sFPYQXKUkR/DUCGZwuOVYTgNxrZCntaCTYgb+LR947VDV8Oeo/aldKrLv7ZPS9P2ceXnwKyA2WYsA
        FNHZ8=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCEou-0005E7-Jx; Fri, 05 Apr 2019 02:43:08 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 05F38441D3B; Fri,  5 Apr 2019 09:43:06 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: axg-tdmout: add g12a support" to the asoc tree
In-Reply-To:  <20190404111733.28705-7-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405024306.05F38441D3B@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 09:43:05 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-tdmout: add g12a support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From aa191a37b801be6c5abebe77e67dcec7c5c0faee Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:17:33 +0200
Subject: [PATCH] ASoC: meson: axg-tdmout: add g12a support

The axg tdmout driver just need a different skew offset to operate
correctly on the g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdmout.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
index 3984818e2a7c..527bfc4487e0 100644
--- a/sound/soc/meson/axg-tdmout.c
+++ b/sound/soc/meson/axg-tdmout.c
@@ -243,10 +243,23 @@ static const struct axg_tdm_formatter_driver axg_tdmout_drv = {
 	},
 };
 
+static const struct axg_tdm_formatter_driver g12a_tdmout_drv = {
+	.component_drv	= &axg_tdmout_component_drv,
+	.regmap_cfg	= &axg_tdmout_regmap_cfg,
+	.ops		= &axg_tdmout_ops,
+	.quirks		= &(const struct axg_tdm_formatter_hw) {
+		.invert_sclk = true,
+		.skew_offset = 2,
+	},
+};
+
 static const struct of_device_id axg_tdmout_of_match[] = {
 	{
 		.compatible = "amlogic,axg-tdmout",
 		.data = &axg_tdmout_drv,
+	}, {
+		.compatible = "amlogic,g12a-tdmout",
+		.data = &g12a_tdmout_drv,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_tdmout_of_match);
-- 
2.20.1

