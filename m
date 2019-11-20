Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8246DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF2822521
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256788;
	bh=H4SPYi/qnMyM0TSI7oix10uwgtqFdYpU3wzOTxKrDdg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Gv+Oa3WMgKxFDxzPI/xREnegOFXqqqu9v2bs8EGC3a/7MRBfZs5XHspOcJDO+ThWe
	 VSErUeKhMze5PSxPEFbFLTBJmj+5v1juadVPRry6s01AHkCpNFUNF5NWC834GbPjmB
	 +e2UBj4xB0skOSmSMZOKPGfmYK2YOiM2XTTh8RpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfKTNdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfKTNdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:33:07 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DCF2224DF;
        Wed, 20 Nov 2019 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256786;
        bh=H4SPYi/qnMyM0TSI7oix10uwgtqFdYpU3wzOTxKrDdg=;
        h=From:To:Cc:Subject:Date:From;
        b=YI7eNcNbmuAVTG9ALhT1vj8CqcdPHKS2ySybd90+5YYClkayN0WLU+siMilqB91qA
         bfIf6dVkj1fhxNwHW+T8eb0aD3DBedz7Emlh0vOiXSjjo5uZupRV84N4gnFuFdNd+a
         5+Z3KD7e8iPmv678msMuLLRr5xNwoQqDbEWIOhyk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:32:52 +0800
Message-Id: <20191120133252.6365-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 24 ++++++++++++------------
 sound/soc/sof/intel/Kconfig    | 10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 2702aefee775..ef20316e83d1 100644
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
index b27fd3fdf335..cc09bb606f7d 100644
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
2.17.1

