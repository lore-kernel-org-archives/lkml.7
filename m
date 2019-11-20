Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA65C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FD6208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574270283;
	bh=fb8nKNqc7jB82mUKyaPrJPABVDpFUG9u9ZPLvFZpajI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=TsFAZb9Eb7e6UyqBiA7A9FhsfSXvCbidGMxcPKWdYmc7Ii5GYuly1AanXucverREr
	 mLGpoF80EILOQQYdT5Ja8gxHm0KsUr0S+u4i0Vcbk7kMl5Rnbymh5IBnxU6wZxLHew
	 lpn4Q/oSum8IdZBMFj2JEFA6n900uFBRN/OQp5Yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfKTRSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:18:02 -0500
Received: from foss.arm.com ([217.140.110.172]:43264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfKTRSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:18:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCC301FB;
        Wed, 20 Nov 2019 09:18:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39F8A3F703;
        Wed, 20 Nov 2019 09:18:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:17:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Fix Kconfig indentation" to the asoc tree
In-Reply-To: <20191120133252.6365-1-krzk@kernel.org>
Message-Id: <applied-20191120133252.6365-1-krzk@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Fix Kconfig indentation

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

From 3efd72330543da44e82e9371dfb639802c886f6c Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 20 Nov 2019 21:32:52 +0800
Subject: [PATCH] ASoC: Fix Kconfig indentation

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191120133252.6365-1-krzk@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 24 ++++++++++++------------
 sound/soc/sof/intel/Kconfig    | 10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index dfa2c365379f..6c9fd9ad566e 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -441,18 +441,18 @@ config SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH
 	   If unsure select "N".
 
 config SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH
-        tristate "CML with RT1011 and RT5682 in I2S Mode"
-        depends on I2C && ACPI
-        depends on MFD_INTEL_LPSS || COMPILE_TEST
-        select SND_SOC_RT1011
-        select SND_SOC_RT5682
-        select SND_SOC_DMIC
-        select SND_SOC_HDAC_HDMI
-        help
-          This adds support for ASoC machine driver for SOF platform with
-          RT1011 + RT5682 I2S codec.
-          Say Y if you have such a device.
-          If unsure select "N".
+	tristate "CML with RT1011 and RT5682 in I2S Mode"
+	depends on I2C && ACPI
+	depends on MFD_INTEL_LPSS || COMPILE_TEST
+	select SND_SOC_RT1011
+	select SND_SOC_RT5682
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+	help
+	  This adds support for ASoC machine driver for SOF platform with
+	  RT1011 + RT5682 I2S codec.
+	  Say Y if you have such a device.
+	  If unsure select "N".
 
 endif ## SND_SOC_SOF_COMETLAKE_LP && SND_SOC_SOF_HDA_LINK
 
diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 04d4929cf91f..92f7485b6994 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -264,16 +264,16 @@ config SND_SOC_SOF_ELKHARTLAKE
 config SND_SOC_SOF_JASPERLAKE_SUPPORT
 	bool "SOF support for JasperLake"
 	help
-          This adds support for Sound Open Firmware for Intel(R) platforms
-          using the JasperLake processors.
-          Say Y if you have such a device.
-          If unsure select "N".
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the JasperLake processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
 
 config SND_SOC_SOF_JASPERLAKE
 	tristate
 	select SND_SOC_SOF_HDA_COMMON
 	help
-          This option is not user-selectable but automagically handled by
+	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
 
 config SND_SOC_SOF_HDA_COMMON
-- 
2.20.1

