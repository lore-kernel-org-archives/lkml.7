Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C3C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7E720820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbfIDQK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:10:29 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731766AbfIDQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:00:56 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MryKp-1iYq7A0YsP-00o0MA; Wed, 04 Sep 2019 18:00:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] bus: imx-weim: remove incorrect __init annotations
Date:   Wed,  4 Sep 2019 18:00:21 +0200
Message-Id: <20190904160039.3350229-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:edSQpPbQz2i0QyQuA+gpW63iqvRaqDAQVKOzJ3suKf+nyFqMcMI
 RKLBf7wmMBsX3B6VL98jLw9HvRgEXOWqAn0lir9QaQkdbIqWjGOdCwOzCesPsKPDZpAPytU
 Clh0eqK029q8ih2vNOnoAQcxDdYCdoX9GBgduNipzMpBvbnC+VHkNDTahUYu0rgxX8Hic0R
 SlBCpbELBaATcVxUwqyPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/BMWc4WL1IA=:UQx49a3M/46yAIqufq86VM
 21sdTV7pJuWwJq7AbtHv9HfmlMBrqz8vmUsYWa39y97opPHXoyc1sIXe97gV0XC/kGnKj+Nd1
 Tt/oIBVkzFJ4LMbmMpntZdjy/pJiN1CfmTv1McQjMJdiFfZ2hpuk/6vNEEkVChe8MbHabbQ7V
 t8uH+4XMeyvvUkYoih/aDjRlXcsMwnHuu7boacviY0LDxIcAs7Umgb19jGciq+vemPjpfeOHR
 XbygfneBE2EpgJ2g3HZpqmA9zV1ouaUo4egHuag854s/+a+fxsYtaA5/pROTuEDTW5hq42gZy
 7tU3hYKuirDFCj3hRlcRMavDS7JTPi631dG7krtkUwds1iH9heTV7C6aAoFifpBpPJ9uHVrmT
 jqTp9kjYaUfnLpTbf29yLKXksB7vxKPWYa+YKyBaw7UpZJxpZ1VCbVEZd/xC3/1vI6IZFpnEs
 P4u4Fmj4wBTfC0BTmXuicKjIEZkCUnhgK6Ly6rYQFf2lX8zkoENzntEx9yPbpyDbOB5fnizXv
 oSPM1o30Cv2Cu7bDnicaflr7Etgh6CWuEdmrEsn1C03dRvsIawfFuB3t15y48Sxa8tmHartHF
 66RgCYPZZfNMhFNslVM9pK4Z4UgNHkFujrxCXdY9X2m4XhklZTRwc0CQCo8q6s0LLHH8sL77R
 CzckQD7lBVVuh8YqsM0HwQO+gdwTsYe8B0glWp8SjiGMh5wsjT3lGufB28kVHNOEDnmh+Vg13
 jLbk+CBHS6AgfQmVIClUAseuUJ2m54DCWQ/uBYAkSgE5MqLLPZQmJkr8nsIVdApZj1WHBvv2B
 828SZegT19VN2u1ywaaOouOFK8e+gX21cMHH44rYiESsKjdsCg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function is no longer __init, so anything it calls now
must also be available at runtime, as Kbuild points out when building
with clang-9:

WARNING: vmlinux.o(.text+0x6e7040): Section mismatch in reference from the function weim_probe() to the function .init.text:imx_weim_gpr_setup()
The function weim_probe() references
the function __init imx_weim_gpr_setup().
This is often because weim_probe lacks a __init
annotation or the annotation of imx_weim_gpr_setup is wrong.

WARNING: vmlinux.o(.text+0x6e70f0): Section mismatch in reference from the function weim_probe() to the function .init.text:weim_timing_setup()
The function weim_probe() references
the function __init weim_timing_setup().
This is often because weim_probe lacks a __init
annotation or the annotation of weim_timing_setup is wrong.

Remove the remaining __init markings that are now wrong.

Fixes: 4a92f07816ba ("bus: imx-weim: use module_platform_driver()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I applied this on top of the patch taht introduced the build error

 drivers/bus/imx-weim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 79af0c27f5a3..28bb65a5613f 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -76,7 +76,7 @@ static const struct of_device_id weim_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, weim_id_table);
 
-static int __init imx_weim_gpr_setup(struct platform_device *pdev)
+static int imx_weim_gpr_setup(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct property *prop;
@@ -126,10 +126,10 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
 }
 
 /* Parse and set the timing for this device. */
-static int __init weim_timing_setup(struct device *dev,
-				    struct device_node *np, void __iomem *base,
-				    const struct imx_weim_devtype *devtype,
-				    struct cs_timing_state *ts)
+static int weim_timing_setup(struct device *dev,
+			     struct device_node *np, void __iomem *base,
+			     const struct imx_weim_devtype *devtype,
+			     struct cs_timing_state *ts)
 {
 	u32 cs_idx, value[MAX_CS_REGS_COUNT];
 	int i, ret;
-- 
2.20.0

