Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F215C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF16206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfCKNZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MJV9S-1hN4cI2QnI-00JvTH for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 053/114] drivers: pinctrl: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:05 +0100
Message-Id: <1552310346-7629-54-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:373aRWt57cBxVCZf0qGs0IxLmT780U7SLNQmOr+2/8FqQTiqeMG
 gMNg9sPvZeGSsZ2o5uYsBkKa8IcooTDAfwlbiGyajYk77rXCyzvekx1pMDRAKcUNKk+EgBV
 Xh8Tcach/gqEI3WpjfUT2ncumOxuwemUb8mhuxbgNhN8taI0PsoOU5jMRDBTQuqloFnzCW0
 cLmSkp9/9C8+sqiK2WWKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2z2SOFcfCp8=:ge66KsNNq5O4y13irnzx4y
 w3Q43hR7AX9hPEJDD2EWY2yjiukZpiUoEKPR7Y+IYMk+tFXsUmn2LjKHr2d0JCL1Q/hZu65AL
 3EaRP/P4QEFZDtl4q40K8D0bxfhETjnpZOjqv4JZT6HKSEtydvP9s3pZxrvCNP3Vte6vjGwVt
 Oa6iibDAIP5L09DkT8EjGeI35FE48EmnfaMtzrblD0c6rrN4aL/9CBDSqT0nIiO0ZB3eMzCfH
 h3S798HaCumlcgW9nXjdRR+3bSS0e+/zWpdCKmswXb4MQmaW/6Y+O+wUGv+yzdp2wiIaCApl5
 lIiDkKSfZR0ZzHwldvkNB055dz15jdGHW9IGZ+qzInHdAEz6+2K4rMwOmR14AOCjB2qSYIEGQ
 sinxTLhal+exthiOo7KUbmGKdiN3tSuw+YXsa4xJGnBh6GTq98wbSB8euTw+RF812J+7tgMq5
 vvXRDLL76x5cXQ8ucfqOTlqrd6zJsdw3fsJmNW0zE5kArMLDKN/WHsDnUYJXQX+kdBxSPhwxj
 MH+ajzLe+wXBCw16M/y/JfwYgycFZCDGeBmP58bt5N5YYQ9QgkXSZ7oTFSvqNLncTnYaNfZId
 9o4KMdeUPUm7xD8UjUusFXCSIAHtW1ShLwQBlZ0zmLkipiSybaliq0IfarXIzrdUPYnv6+vbT
 MHQ4551JWSnQJ8+cZMmez020T8qZyUC/w1/KSq9iPjFPXunuJ5SDp9zY91fGcauzcZ1REDhrK
 aELv98OgGFPp9XS6hKgAvlP86iiA7/CL8tQxFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/pinctrl/Kconfig           | 18 +++++-----
 drivers/pinctrl/freescale/Kconfig | 13 ++++---
 drivers/pinctrl/mvebu/Kconfig     | 10 +++---
 drivers/pinctrl/qcom/Kconfig      | 74 +++++++++++++++++++--------------------
 drivers/pinctrl/sh-pfc/Kconfig    | 48 ++++++++++++-------------
 5 files changed, 81 insertions(+), 82 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 2764d71..886c149 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -31,15 +31,15 @@ config DEBUG_PINCTRL
 	  Say Y here to add some extra checks and diagnostics to PINCTRL calls.
 
 config PINCTRL_ARTPEC6
-        bool "Axis ARTPEC-6 pin controller driver"
-        depends on MACH_ARTPEC6
-        select PINMUX
-        select GENERIC_PINCONF
-        help
-          This is the driver for the Axis ARTPEC-6 pin controller. This driver
-          supports pin function multiplexing as well as pin bias and drive
-          strength configuration. Device tree integration instructions can be
-          found in Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
+	bool "Axis ARTPEC-6 pin controller driver"
+	depends on MACH_ARTPEC6
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  This is the driver for the Axis ARTPEC-6 pin controller. This driver
+	  supports pin function multiplexing as well as pin bias and drive
+	  strength configuration. Device tree integration instructions can be
+	  found in Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 
 config PINCTRL_AS3722
 	tristate "Pinctrl and GPIO driver for ams AS3722 PMIC"
diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 72b869d..b87abb0 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -36,14 +36,13 @@ config PINCTRL_IMX27
 	help
 	  Say Y here to enable the imx27 pinctrl driver
 
-
 config PINCTRL_IMX25
-        bool "IMX25 pinctrl driver"
-        depends on OF
-        depends on SOC_IMX25
-        select PINCTRL_IMX
-        help
-          Say Y here to enable the imx25 pinctrl driver
+	bool "IMX25 pinctrl driver"
+	depends on OF
+	depends on SOC_IMX25
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imx25 pinctrl driver
 
 config PINCTRL_IMX35
 	bool "IMX35 pinctrl driver"
diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
index d9773b7..6eb69f2 100644
--- a/drivers/pinctrl/mvebu/Kconfig
+++ b/drivers/pinctrl/mvebu/Kconfig
@@ -45,8 +45,8 @@ config PINCTRL_ORION
 	select PINCTRL_MVEBU
 
 config PINCTRL_ARMADA_37XX
-       bool
-       select GENERIC_PINCONF
-       select MFD_SYSCON
-       select PINCONF
-       select PINMUX
+	bool
+	select GENERIC_PINCONF
+	select MFD_SYSCON
+	select PINCONF
+	select PINMUX
diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 2e66ab7..aac8f05 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -131,48 +131,48 @@ config PINCTRL_QDF2XXX
 	  Qualcomm Technologies QDF2xxx SOCs.
 
 config PINCTRL_QCOM_SPMI_PMIC
-       tristate "Qualcomm SPMI PMIC pin controller driver"
-       depends on GPIOLIB && OF && SPMI
-       select REGMAP_SPMI
-       select PINMUX
-       select PINCONF
-       select GENERIC_PINCONF
-       select IRQ_DOMAIN_HIERARCHY
-       help
-         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-         Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
-         which are using SPMI for communication with SoC. Example PMIC's
-         devices are pm8841, pm8941 and pma8084.
+	tristate "Qualcomm SPMI PMIC pin controller driver"
+	depends on GPIOLIB && OF && SPMI
+	select REGMAP_SPMI
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
+	  which are using SPMI for communication with SoC. Example PMIC's
+	  devices are pm8841, pm8941 and pma8084.
 
 config PINCTRL_QCOM_SSBI_PMIC
-       tristate "Qualcomm SSBI PMIC pin controller driver"
-       depends on GPIOLIB && OF
-       select PINMUX
-       select PINCONF
-       select GENERIC_PINCONF
-       select IRQ_DOMAIN_HIERARCHY
-       help
-         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-         Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
-         which are using SSBI for communication with SoC. Example PMIC's
-         devices are pm8058 and pm8921.
+	tristate "Qualcomm SSBI PMIC pin controller driver"
+	depends on GPIOLIB && OF
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
+	  which are using SSBI for communication with SoC. Example PMIC's
+	  devices are pm8058 and pm8921.
 
 config PINCTRL_SDM660
-       tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
-       depends on GPIOLIB && OF
-       select PINCTRL_MSM
-       help
-         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-         Qualcomm Technologies Inc TLMM block found on the Qualcomm
-         Technologies Inc SDM660 platform.
+	tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
+	depends on GPIOLIB && OF
+	select PINCTRL_MSM
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SDM660 platform.
 
 config PINCTRL_SDM845
-       tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
-       depends on GPIOLIB && OF
-       select PINCTRL_MSM
-       help
-         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-         Qualcomm Technologies Inc TLMM block found on the Qualcomm
-         Technologies Inc SDM845 platform.
+	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
+	depends on GPIOLIB && OF
+	select PINCTRL_MSM
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
+	  Technologies Inc SDM845 platform.
 
 endif
diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index e941ba6..903b879 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -46,24 +46,24 @@ config PINCTRL_PFC_R8A7744
 	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A7745
-        def_bool y
-        depends on ARCH_R8A7745
-        select PINCTRL_SH_PFC
+	def_bool y
+	depends on ARCH_R8A7745
+	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A77470
-        def_bool y
-        depends on ARCH_R8A77470
-        select PINCTRL_SH_PFC
+	def_bool y
+	depends on ARCH_R8A77470
+	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A774A1
-        def_bool y
-        depends on ARCH_R8A774A1
-        select PINCTRL_SH_PFC
+	def_bool y
+	depends on ARCH_R8A774A1
+	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A774C0
-        def_bool y
-        depends on ARCH_R8A774C0
-        select PINCTRL_SH_PFC
+	def_bool y
+	depends on ARCH_R8A774C0
+	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A7778
 	def_bool y
@@ -106,14 +106,14 @@ config PINCTRL_PFC_R8A7795
 	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A7796
-        def_bool y
-        depends on ARCH_R8A7796
-        select PINCTRL_SH_PFC
+	def_bool y
+	depends on ARCH_R8A7796
+	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A77965
-        def_bool y
-        depends on ARCH_R8A77965
-        select PINCTRL_SH_PFC
+	def_bool y
+	depends on ARCH_R8A77965
+	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A77970
 	def_bool y
@@ -126,14 +126,14 @@ config PINCTRL_PFC_R8A77980
 	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A77990
-        def_bool y
-        depends on ARCH_R8A77990
-        select PINCTRL_SH_PFC
+	def_bool y
+	depends on ARCH_R8A77990
+	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_R8A77995
-        def_bool y
-        depends on ARCH_R8A77995
-        select PINCTRL_SH_PFC
+	def_bool y
+	depends on ARCH_R8A77995
+	select PINCTRL_SH_PFC
 
 config PINCTRL_PFC_SH7203
 	def_bool y
-- 
1.9.1

