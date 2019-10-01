Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B6EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B492190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbfJAOVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:21:52 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfJAOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:21:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHoVE-1iKFDt0sgo-00ExaL; Tue, 01 Oct 2019 16:20:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF dependency
Date:   Tue,  1 Oct 2019 16:20:09 +0200
Message-Id: <20191001142026.1124917-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hL/OrOqx1oO4Bmp86kRM00tNRZ3chWT/eTPxi4JaUrsImLSXYp7
 i+qhAnFRG6eViMZ5TNl46bk0rixPpe+lc1OET7BF5YF7A071moylb49GvEj4GDKarj0uC0+
 ZU+hnVbZdw2WlCiPsgBt8jo3E/gi5h3MNgOBHDOJ3oB6ufIx8rjPWbFJglcQSltdef+vZ+z
 vb+eFvoyJkEdMHXsRPfSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UD9CBuUg62g=:c9PbZz2InB7poesIjc/J/C
 JDvhs0OAUieNXQYRdSS/AETOv3aLuELWRzX420aQAkLscCBi3TzXaYL5Je/C5Hm+pDziHPC+f
 c8/qVlqXWZtXwbsyGdhRNrkj5uwl96NnLUAmarjmwh68CXMZ4J5Wlk7oaKCVyRQTR1xHpL8LY
 qQmtbXueO1sAQqJOPbZ0gmzdpEn38ToU3i5ZPMCEdaGPjtjc6wZNAsBEpzCXzbM0wvamttdRp
 qFL00i6GPGw5UoBa93WdO4uW80+vaP2nutw/LwKluTurpcYBUxW8pAbE8fhr1w1RYRxhKVxt3
 HT+/vR6HrFTBo7WDfY+MbBySCYD++0Wdz0QsEkdWJLm7ctUU9hzcJqBTMIKjAGdaVpo37d3AD
 mRNIvoKo62Q4/zz8HhMoU0FQdSetGcri26tevKkt9l4KikSL4wOuPsST0tr69YqVrgcVgzF22
 +V1yiuUtuLwAt/ugNS6K6nKEqEJvVj4RBXVMM65FY/cjPMTxqDrCWBbqqeOBj7vhoLHMvE8St
 NFOraaDm6HFe+AkhgJARAGBMLUYhnge9RaJBRR25cyJyxaRE0LUUIBEKUzPp4HSO1nsFtEWuQ
 9Bkw1DY/URAci10xnfO4M3F5hP1e+OOcmOlhE+V8vtziqpcgbdCU9OZ1YbkOnq0pEVJ08CSYc
 rc/ngKrFD5pK+v45Kh1oKYzooYfgrtaaXRAdzZmKGka4RXtGgn7etgDRNjSM/XaWxgK0XmKkw
 Sp/xgUJie7+imAetJyXn6jXjV14HtyyqgV4WUPsCFFXwibYETjtOLmrT3eXFMYpC12WseKotV
 jpdjAT5MMl/74tC5GVYZpp1hjPswSP3wr1EcRlaWd58P0++zn5yiuZJagiOEELf8bYtx7wUqI
 /B4b2Dbt883pMpM4aFqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SND_SOC_SOF_IMX depends on CONFIG_SND_SOC_SOF, but is in
turn referenced by the sof-of-dev driver. This creates a reverse
dependency that manifests in a link error when CONFIG_SND_SOC_SOF_OF
is built-in but CONFIG_SND_SOC_SOF_IMX=m:

sound/soc/sof/sof-of-dev.o:(.data+0x118): undefined reference to `sof_imx8_ops'

Make the latter a 'bool' symbol and change the Makefile so the imx8
driver is compiled the same way as the driver using it.

A nicer way would be to reverse the layering and move all
the imx specific bits of sof-of-dev.c into the imx driver
itself, which can then call into the common code. Doing this
would need more testing and can be done if we add another
driver like the first one.

Fixes: f4df4e4042b0 ("ASoC: SOF: imx8: Fix COMPILE_TEST error")
Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/imx/Kconfig  | 2 +-
 sound/soc/sof/imx/Makefile | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
index 5acae75f5750..a3891654a1fc 100644
--- a/sound/soc/sof/imx/Kconfig
+++ b/sound/soc/sof/imx/Kconfig
@@ -12,7 +12,7 @@ config SND_SOC_SOF_IMX_TOPLEVEL
 if SND_SOC_SOF_IMX_TOPLEVEL
 
 config SND_SOC_SOF_IMX8
-	tristate "SOF support for i.MX8"
+	bool "SOF support for i.MX8"
 	depends on IMX_SCU
 	depends on IMX_DSP
 	help
diff --git a/sound/soc/sof/imx/Makefile b/sound/soc/sof/imx/Makefile
index 6ef908e8c807..9e8f35df0ff2 100644
--- a/sound/soc/sof/imx/Makefile
+++ b/sound/soc/sof/imx/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 snd-sof-imx8-objs := imx8.o
 
-obj-$(CONFIG_SND_SOC_SOF_IMX8) += snd-sof-imx8.o
+ifdef CONFIG_SND_SOC_SOF_IMX8
+obj-$(CONFIG_SND_SOC_SOF_OF) += snd-sof-imx8.o
+endif
-- 
2.20.0

