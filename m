Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D1C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685D0207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLJTzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:55:09 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:43471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfLJTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:55:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBmDy-1iSdZE09bI-00CCMA; Tue, 10 Dec 2019 20:53:44 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: rt5677: add SPI_MASTER dependency
Date:   Tue, 10 Dec 2019 20:52:26 +0100
Message-Id: <20191210195333.648018-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FRkHOOKgb97GU78DRa4WO6ybtXkwJBdydEWXHFH0XK6ebufL9xV
 1EnlNmOIxy2m4DJZpwOSZDYe6VdSkLHIYTkUdRCdxb96bn4+i9aM5HDbv8Y7m7upSqX0g+4
 aZ7pxvErgtXqj88QUP5vZlUGYWZsThHweb+iyAH57kzxC10soq23IhgctvcW1mAt5mudX0M
 ofu4B2dzMSXFkyVJqr7fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aRxDfmwkuqQ=:Q5kIO/JyMKhASOEVpBGr79
 mltKx8dNXZy5JN2a10gY5qm3kf02KQ8QYkK/4v3cAdAbmccyzL4DXyE+PKfOKw6YenitwI12c
 8YbdnsOQ8CJRf8p4rEWHGUvRObVYsyum+gwXLcv7ROZGJT3/G/YCUikha20/xZ/QOXlfAzyia
 7c+O9S7Q5eND46EM3BY8MWxHHnw6vvaouoJcBvalhn6utMA4Xdyu6sQ8klBKG/OgtzUIK/5f5
 dgV1/mPcAfVkiDLHIOYY33Pv7BbxGikgB3SDFPgfExtJQj9YatmVAE8kJpv7eYxwqZEW9xR2U
 wUG2rEBAkKiD8Wfob5x3p4BZ7vIWifgoOi5pHHimENGsOT+B3UybUI5RUND6zaquO3rBi8evu
 rYtEPAxqZ5pKX8o/t6h14iPnoO/9+X619xrMLQmZMHVYg1lXfFU/da7NavX81GHaMC7DXR8lW
 yVoDxUCfei6PWs8RaBl7o7ewBIyGnUE4uocUG3rbI/SlP78kYT6tpS4PtTKHZQMiv7NbGvII1
 8/SzVaX+qN+X55J8eYxyg/eCefYiWim8pCMOjrJPOTeNSnV6RCH3iEeHZS48oGJvCIvexLTjY
 tVeasw/P6N94yIWtOgt5S1yqSEgIg0TJvze3ZruHI+ks3QwRINk3gVegkpgUvEBcd4IxFI2yl
 QDOUbechDBC9C1VkFW5voYcKksms6yCQrIFWzOrWWLxhO5Ahg3fDkwe272NzdQXH0pRQrq9nC
 OehoDnS0YYCsMz/8ALLgfgBpT9+mK0KV3838L/HVcBGhGfNBCXig+a9eqoEyQQ6SqIU83x0IQ
 C6Kx99oKCbEHzZkvBlwpEoLaMYnbY5DOCCrIY1KjWrOLqhhrYUQFyfH0Lmn7+kt/a+MbIJtvw
 QFiozHF88wZ3H1Nwewdw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SPI is disabled, the newly added code for the DSP
firmware loading fails to link:

ERROR: "rt5677_spi_hotword_detected" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
ERROR: "rt5677_spi_write" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!

Add a dependency to prevent this configuration.

Note: the does not work with the DT probing, as there is no binding
for the SPI half of the driver, but nothing seems to be using that
with the mainline kernel anyway.

Fixes: 461c623270e4 ("ASoC: rt5677: Load firmware via SPI using delayed work")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig       | 1 +
 sound/soc/intel/boards/Kconfig | 1 +
 sound/soc/mediatek/Kconfig     | 2 +-
 sound/soc/tegra/Kconfig        | 2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 71b7286d14f2..8e9c461a84f8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1047,6 +1047,7 @@ config SND_SOC_RT5670
 
 config SND_SOC_RT5677
 	tristate
+	depends on SPI_MASTER
 	select REGMAP_I2C
 	select REGMAP_IRQ
 
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index ef20316e83d1..da7f9111f3d3 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -34,6 +34,7 @@ if SND_SOC_INTEL_HASWELL || SND_SOC_SOF_BROADWELL
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "Broadwell with RT5677 codec"
 	depends on I2C
+	depends on SPI_MASTER
 	depends on I2C_DESIGNWARE_PLATFORM || COMPILE_TEST
 	depends on GPIOLIB || COMPILE_TEST
 	depends on X86_INTEL_LPSS || COMPILE_TEST
diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index a656d2014127..4699787c93ed 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -97,7 +97,7 @@ config SND_SOC_MT8173_RT5650_RT5514
 
 config SND_SOC_MT8173_RT5650_RT5676
 	tristate "ASoC Audio driver for MT8173 with RT5650 RT5676 codecs"
-	depends on SND_SOC_MT8173 && I2C
+	depends on SND_SOC_MT8173 && I2C && SPI_MASTER
 	select SND_SOC_RT5645
 	select SND_SOC_RT5677
 	select SND_SOC_HDMI_CODEC
diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index addadc827b91..df36e84c0116 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -122,7 +122,7 @@ config SND_SOC_TEGRA_MAX98090
 
 config SND_SOC_TEGRA_RT5677
 	tristate "SoC Audio support for Tegra boards using a RT5677 codec"
-	depends on SND_SOC_TEGRA && I2C && GPIOLIB
+	depends on SND_SOC_TEGRA && I2C && GPIOLIB && SPI_MASTER
 	select SND_SOC_RT5677
 	help
 	  Say Y or M here if you want to add support for SoC audio on Tegra
-- 
2.20.0

