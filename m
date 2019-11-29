Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A312CC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 22:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFC9208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 22:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbfK2WtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 17:49:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42180 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfK2WtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 17:49:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 277DE28A5AE
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joel Stanley <joel@jms.id.au>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-samsung-soc@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-tegra@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Daniel Mack <daniel@zonque.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tony Lindgren <tony@atomide.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: [RESEND PATCH] arm/arm64: defconfig: Update configs to use the new CROS_EC options
Date:   Fri, 29 Nov 2019 23:49:12 +0100
Message-Id: <20191129224912.32087-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we refactored the CrOS EC drivers moving part of the code from
the MFD subsystem to the platform chrome subsystem. During this change
we needed to rename some config options, so, update the defconfigs
accordingly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

 arch/arm/configs/exynos_defconfig   | 6 +++++-
 arch/arm/configs/multi_v7_defconfig | 6 ++++--
 arch/arm/configs/pxa_defconfig      | 4 +++-
 arch/arm/configs/tegra_defconfig    | 2 +-
 arch/arm64/configs/defconfig        | 6 ++++--
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 08db1c83eb2d..e09bb7642272 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -157,7 +157,11 @@ CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
-CONFIG_MFD_CROS_EC=y
+CONFIG_MFD_CROS_EC_DEV=y
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=y
+CONFIG_CROS_EC_I2C=y
+CONFIG_CROS_EC_SPI=y
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e4c8def9a0a5..fd9a3ba3a88f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -525,10 +525,12 @@ CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
-CONFIG_MFD_CROS_EC=m
+CONFIG_MFD_CROS_EC_DEV=m
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=m
 CONFIG_CROS_EC_I2C=m
 CONFIG_CROS_EC_SPI=m
-CONFIG_MFD_CROS_EC_CHARDEV=m
+CONFIG_CROS_EC_CHARDEV=m
 CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index b817c57f05f1..f1b084ace88d 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -393,7 +393,9 @@ CONFIG_SA1100_WATCHDOG=m
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_BCM590XX=m
 CONFIG_MFD_AXP20X=y
-CONFIG_MFD_CROS_EC=m
+CONFIG_MFD_CROS_EC_DEV=m
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=m
 CONFIG_CROS_EC_I2C=m
 CONFIG_CROS_EC_SPI=m
 CONFIG_MFD_ASIC3=y
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8f5c6a5b444c..061037012335 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -147,7 +147,7 @@ CONFIG_SENSORS_LM95245=y
 CONFIG_WATCHDOG=y
 CONFIG_TEGRA_WATCHDOG=y
 CONFIG_MFD_AS3722=y
-CONFIG_MFD_CROS_EC=y
+CONFIG_MFD_CROS_EC_DEV=y
 CONFIG_MFD_MAX8907=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a867ac32d4..952d4b915430 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -466,8 +466,7 @@ CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
-CONFIG_MFD_CROS_EC=y
-CONFIG_MFD_CROS_EC_CHARDEV=m
+CONFIG_MFD_CROS_EC_DEV=y
 CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_HI655X_PMIC=y
@@ -683,8 +682,11 @@ CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_XEN_GNTDEV=y
 CONFIG_XEN_GRANT_DEV_ALLOC=y
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=y
 CONFIG_CROS_EC_SPI=y
+CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_RK808=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
-- 
2.20.1

