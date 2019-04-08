Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D274CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A4A20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708329;
	bh=dCNcnkOJ+pwmWzKcihivS0gytr3JUKfIaaTmrnpPb+Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HRSdDcOYOTdOJoDCtjlJyczq1HcKhm8ABXHauvyEs280bgFK8cCeZ8FEJ9rg3oDKK
	 e0FD6X8RVUp9hMZPH3WxM7uf5R074Wgwwp5yVKe/szrojic3vk3QCcYa/IEGyb0G55
	 n+yzKLNY9lG+laa9vg6hH2eQwWn4nkg09N+HvG2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDHHZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:25:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60426 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDHHZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hrvU3KmX+veuLkO4nUMkBgb9eTK9uvZcDy/c06SA3U4=; b=Bmsj+9xMS+C7
        SCwvXmiCqYVrnIj48RIjxhIONjIrTIPamMJe2VK1hzQuha/2xnI5yt5/i55/bNyWhhPfkHM+taSQe
        lVrl1BqrxNur+o9Vu0spXlxG0JKAARBeIBMCrp+JNkeS3+RX2O+ZQm2f0CGFtEexev59++43BK5k9
        njme8=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOe0-0003o7-Kk; Mon, 08 Apr 2019 07:24:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 38023441D3B; Mon,  8 Apr 2019 14:24:31 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II" to the asoc tree
In-Reply-To:  <20190329215045.6254-3-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190408072431.38023441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:24:31 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II

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

From a8d218f4fe8116395e4c4a13b63029ecf00d4035 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 29 Mar 2019 22:50:45 +0100
Subject: [PATCH] ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II

The Teclast X98+ II is a Cherrytrail tablet, which require two quirks:
- it has stereo speakers,
- its jack detection mechanism is inverted.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index ccf552e92d53..38975827e276 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -22,6 +22,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -441,11 +442,25 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 	{ },
 };
 
+/* Please keep this list alphabetically sorted */
+static const struct dmi_system_id byt_cht_es8316_quirk_table[] = {
+	{	/* Teclast X98 Plus II */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
+		},
+		.driver_data = (void *)(BYT_CHT_ES8316_INTMIC_IN1_MAP
+					| BYT_CHT_ES8316_JD_INVERTED),
+	},
+	{}
+};
+
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
 	static const char * const mic_name[] = { "in1", "in2" };
 	struct property_entry props[MAX_NO_PROPS] = {};
 	struct byt_cht_es8316_private *priv;
+	const struct dmi_system_id *dmi_id;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
@@ -488,7 +503,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Check for BYTCR or other platform and setup quirks */
-	if (x86_match_cpu(baytrail_cpu_ids) &&
+	dmi_id = dmi_first_match(byt_cht_es8316_quirk_table);
+	if (dmi_id) {
+		quirk = (int)dmi_id->driver_data;
+	} else if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
 		/* On BYTCR default to SSP0, internal-mic-in2-map, mono-spk */
 		quirk = BYT_CHT_ES8316_SSP0 | BYT_CHT_ES8316_INTMIC_IN2_MAP |
-- 
2.20.1

