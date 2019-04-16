Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EA7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70852075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfDPGUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:20:17 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:60030 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbfDPGUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:20:15 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id 35/6D-19010-81475BC5; Tue, 16 Apr 2019 06:20:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleJIrShJLcpLzFFi42I5+OG9rq5EydY
  Yg95DTBZTHz5hs5h/5ByrRdP31cwW3650MFlc3jWHzWLp9YtMFq17j7A7sHusmbeG0WPnrLvs
  HptWdbJ5fN4kF8ASxZqZl5RfkcCa0X3gKWPBtKdMFWs617I1MN6fxdTFyMUhJLCWUaKxt4Oli
  5ETyKmQ6HyzgRXE5hVIl3jeuQzM5hRwlbh8rIkJosZF4sb5a2A2m4CJxKYjexhBbBYBVYmPO3
  uA6jk4hAW8JHb+ZgYJiwhkS9xddpIdZBezwBZGiV0bJrJBzBeUODnzCdheZgEJiYMvXjBDzNe
  T6J48D2yvhIC9xPT3V5khbH2Jl183MkHYhhLfZ31jgbDNJf69/8UIYVtLXP8wi20Co9AsJCtm
  IVmxgJFpFaNFUlFmekZJbmJmjq6hgYGuoaGxrpGuqbleYpVuol5qqW5yal5JUSJQUi+xvFivu
  DI3OSdFLy+1ZBMjMGZSCpksdzBuWJp+iFGSg0lJlDcvdGuMEF9SfkplRmJxRnxRaU5q8SFGGQ
  4OJQleg0KgnGBRanpqRVpmDjB6YdISHDxKIrx/i4DSvMUFibnFmekQqVOMuhz3Dj6fyyzEkpe
  flyolzjsFpEgApCijNA9uBCyRXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzNsMMoUnM68E
  btMroCOYgI6YorMa5IiSRISUVAOj0tvbfV8ieooXpu7NucFqHjXR9j9ngiTr+tumrnVLluo9+
  ior4+fQ/Ex15prg0o3+JyaV6JyyOe3Jd+3ht7evVmxLYv59Yb1Y5w5P7qKPjG4NrWKnojP0Qy
  dvPLkhSM728/28NRsn3w6cc7DsVtfXI/dr5pQv6XS8lKTav+Kc+6alGxksVz6Yr8RSnJFoqMV
  cVJwIAP+VXXAfAwAA
X-Env-Sender: eric.jeong.opensource@diasemi.com
X-Msg-Ref: server-18.tower-229.messagelabs.com!1555395606!4413668!4
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21513 invoked from network); 16 Apr 2019 06:20:07 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-18.tower-229.messagelabs.com with AES128-SHA256 encrypted SMTP; 16 Apr 2019 06:20:07 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 16 Apr 2019 08:20:06 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22095)      id
 268875F800; Tue, 16 Apr 2019 15:20:05 +0900 (KST)
Message-ID: <5e4a6a007e45feac6d35203305cafd865be48755.1555389447.git.eric.jeong.opensource@diasemi.com>
In-Reply-To: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
References: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
From:   Eric Jeong <eric.jeong.opensource@diasemi.com>
Date:   Tue, 16 Apr 2019 13:37:27 +0900
Subject: [PATCH V1 3/3] regulator: slg51000: add slg51000 regulator driver
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 16.04.2019 01:43:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eric Jeong <eric.jeong.opensource@diasemi.com>

Adding regulator driver for the device Dialog SLG51000.

The SLG51000 device contains seven compact and customizable low
dropout regulators and is designed for high performance camera modules
and other small multi-rail applications.

Signed-off-by: Eric Jeong <eric.jeong.opensource@diasemi.com>

---
This patch applies against linux-next and next-20190415


 drivers/regulator/Kconfig              |    9 +
 drivers/regulator/Makefile             |    1 +
 drivers/regulator/slg51000-regulator.c |  548 ++++++++++++++++++++++++++++++++
 drivers/regulator/slg51000-regulator.h |  505 +++++++++++++++++++++++++++++
 4 files changed, 1063 insertions(+)
 create mode 100644 drivers/regulator/slg51000-regulator.c
 create mode 100644 drivers/regulator/slg51000-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c4dc2bc..a85acd4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -828,6 +828,15 @@ config REGULATOR_SKY81452
 	  This driver can also be built as a module. If so, the module
 	  will be called sky81452-regulator.
 
+config REGULATOR_SLG51000
+        tristate "Dialog Semiconductor SLG51000 regulators"
+        depends on I2C
+        select REGMAP_I2C
+        help
+	  Say y here to support for the Dialog Semiconductor SLG51000.
+	  The SLG51000 is seven compact and customizable low dropout
+	  regulators.
+
 config REGULATOR_STM32_VREFBUF
 	tristate "STMicroelectronics STM32 VREFBUF"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 1169f8a..827d19a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
+obj-$(CONFIG_REGULATOR_SLG51000) += slg51000-regulator.o
 obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
new file mode 100644
index 0000000..5ff7e96
--- /dev/null
+++ b/drivers/regulator/slg51000-regulator.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// SLG51000 High PSRR, Multi-Output Regulators
+// Copyright (C) 2019  Dialog Semiconductor
+//
+// Author: Eric Jeong <eric.jeong.opensource@diasemi.com>
+
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include "slg51000-regulator.h"
+
+#define SLG51000_SCTL_EVT               7
+#define SLG51000_MAX_EVT_REGISTER       8
+#define SLG51000_LDOHP_LV_MIN           1200000
+#define SLG51000_LDOHP_HV_MIN           2400000
+
+enum slg51000_regulators {
+	SLG51000_REGULATOR_LDO1 = 0,
+	SLG51000_REGULATOR_LDO2,
+	SLG51000_REGULATOR_LDO3,
+	SLG51000_REGULATOR_LDO4,
+	SLG51000_REGULATOR_LDO5,
+	SLG51000_REGULATOR_LDO6,
+	SLG51000_REGULATOR_LDO7,
+	SLG51000_MAX_REGULATORS,
+};
+
+struct slg51000_pdata {
+	struct gpio_desc *ena_gpiod;
+};
+
+struct slg51000 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct slg51000_pdata regl_pdata[SLG51000_MAX_REGULATORS];
+	struct regulator_desc *rdesc[SLG51000_MAX_REGULATORS];
+	struct regulator_dev *rdev[SLG51000_MAX_REGULATORS];
+	struct gpio_desc *cs_gpiod;
+	int chip_irq;
+};
+
+struct slg51000_evt_sta {
+	unsigned int ereg;
+	unsigned int sreg;
+};
+
+static const struct slg51000_evt_sta es_reg[SLG51000_MAX_EVT_REGISTER] = {
+	{SLG51000_LDO1_EVENT, SLG51000_LDO1_STATUS},
+	{SLG51000_LDO2_EVENT, SLG51000_LDO2_STATUS},
+	{SLG51000_LDO3_EVENT, SLG51000_LDO3_STATUS},
+	{SLG51000_LDO4_EVENT, SLG51000_LDO4_STATUS},
+	{SLG51000_LDO5_EVENT, SLG51000_LDO5_STATUS},
+	{SLG51000_LDO6_EVENT, SLG51000_LDO6_STATUS},
+	{SLG51000_LDO7_EVENT, SLG51000_LDO7_STATUS},
+	{SLG51000_SYSCTL_EVENT, SLG51000_SYSCTL_STATUS},
+};
+
+static const struct regmap_range slg51000_writeable_ranges[] = {
+	regmap_reg_range(SLG51000_SYSCTL_MATRIX_CONF_A,
+			 SLG51000_SYSCTL_MATRIX_CONF_A),
+	regmap_reg_range(SLG51000_LDO1_VSEL, SLG51000_LDO1_VSEL),
+	regmap_reg_range(SLG51000_LDO1_MINV, SLG51000_LDO1_MAXV),
+	regmap_reg_range(SLG51000_LDO1_IRQ_MASK, SLG51000_LDO1_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO2_VSEL, SLG51000_LDO2_VSEL),
+	regmap_reg_range(SLG51000_LDO2_MINV, SLG51000_LDO2_MAXV),
+	regmap_reg_range(SLG51000_LDO2_IRQ_MASK, SLG51000_LDO2_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO3_VSEL, SLG51000_LDO3_VSEL),
+	regmap_reg_range(SLG51000_LDO3_MINV, SLG51000_LDO3_MAXV),
+	regmap_reg_range(SLG51000_LDO3_IRQ_MASK, SLG51000_LDO3_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO4_VSEL, SLG51000_LDO4_VSEL),
+	regmap_reg_range(SLG51000_LDO4_MINV, SLG51000_LDO4_MAXV),
+	regmap_reg_range(SLG51000_LDO4_IRQ_MASK, SLG51000_LDO4_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO5_VSEL, SLG51000_LDO5_VSEL),
+	regmap_reg_range(SLG51000_LDO5_MINV, SLG51000_LDO5_MAXV),
+	regmap_reg_range(SLG51000_LDO5_IRQ_MASK, SLG51000_LDO5_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO6_VSEL, SLG51000_LDO6_VSEL),
+	regmap_reg_range(SLG51000_LDO6_MINV, SLG51000_LDO6_MAXV),
+	regmap_reg_range(SLG51000_LDO6_IRQ_MASK, SLG51000_LDO6_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO7_VSEL, SLG51000_LDO7_VSEL),
+	regmap_reg_range(SLG51000_LDO7_MINV, SLG51000_LDO7_MAXV),
+	regmap_reg_range(SLG51000_LDO7_IRQ_MASK, SLG51000_LDO7_IRQ_MASK),
+	regmap_reg_range(SLG51000_OTP_IRQ_MASK, SLG51000_OTP_IRQ_MASK),
+};
+
+static const struct regmap_range slg51000_readable_ranges[] = {
+	regmap_reg_range(SLG51000_SYSCTL_PATN_ID_B0,
+			 SLG51000_SYSCTL_PATN_ID_B2),
+	regmap_reg_range(SLG51000_SYSCTL_SYS_CONF_A,
+			 SLG51000_SYSCTL_SYS_CONF_A),
+	regmap_reg_range(SLG51000_SYSCTL_SYS_CONF_D,
+			 SLG51000_SYSCTL_MATRIX_CONF_B),
+	regmap_reg_range(SLG51000_SYSCTL_REFGEN_CONF_C,
+			 SLG51000_SYSCTL_UVLO_CONF_A),
+	regmap_reg_range(SLG51000_SYSCTL_FAULT_LOG1, SLG51000_SYSCTL_IRQ_MASK),
+	regmap_reg_range(SLG51000_IO_GPIO1_CONF, SLG51000_IO_GPIO_STATUS),
+	regmap_reg_range(SLG51000_LUTARRAY_LUT_VAL_0,
+			 SLG51000_LUTARRAY_LUT_VAL_11),
+	regmap_reg_range(SLG51000_MUXARRAY_INPUT_SEL_0,
+			 SLG51000_MUXARRAY_INPUT_SEL_63),
+	regmap_reg_range(SLG51000_PWRSEQ_RESOURCE_EN_0,
+			 SLG51000_PWRSEQ_INPUT_SENSE_CONF_B),
+	regmap_reg_range(SLG51000_LDO1_VSEL, SLG51000_LDO1_VSEL),
+	regmap_reg_range(SLG51000_LDO1_MINV, SLG51000_LDO1_MAXV),
+	regmap_reg_range(SLG51000_LDO1_MISC1, SLG51000_LDO1_VSEL_ACTUAL),
+	regmap_reg_range(SLG51000_LDO1_EVENT, SLG51000_LDO1_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO2_VSEL, SLG51000_LDO2_VSEL),
+	regmap_reg_range(SLG51000_LDO2_MINV, SLG51000_LDO2_MAXV),
+	regmap_reg_range(SLG51000_LDO2_MISC1, SLG51000_LDO2_VSEL_ACTUAL),
+	regmap_reg_range(SLG51000_LDO2_EVENT, SLG51000_LDO2_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO3_VSEL, SLG51000_LDO3_VSEL),
+	regmap_reg_range(SLG51000_LDO3_MINV, SLG51000_LDO3_MAXV),
+	regmap_reg_range(SLG51000_LDO3_CONF1, SLG51000_LDO3_VSEL_ACTUAL),
+	regmap_reg_range(SLG51000_LDO3_EVENT, SLG51000_LDO3_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO4_VSEL, SLG51000_LDO4_VSEL),
+	regmap_reg_range(SLG51000_LDO4_MINV, SLG51000_LDO4_MAXV),
+	regmap_reg_range(SLG51000_LDO4_CONF1, SLG51000_LDO4_VSEL_ACTUAL),
+	regmap_reg_range(SLG51000_LDO4_EVENT, SLG51000_LDO4_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO5_VSEL, SLG51000_LDO5_VSEL),
+	regmap_reg_range(SLG51000_LDO5_MINV, SLG51000_LDO5_MAXV),
+	regmap_reg_range(SLG51000_LDO5_TRIM2, SLG51000_LDO5_TRIM2),
+	regmap_reg_range(SLG51000_LDO5_CONF1, SLG51000_LDO5_VSEL_ACTUAL),
+	regmap_reg_range(SLG51000_LDO5_EVENT, SLG51000_LDO5_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO6_VSEL, SLG51000_LDO6_VSEL),
+	regmap_reg_range(SLG51000_LDO6_MINV, SLG51000_LDO6_MAXV),
+	regmap_reg_range(SLG51000_LDO6_TRIM2, SLG51000_LDO6_TRIM2),
+	regmap_reg_range(SLG51000_LDO6_CONF1, SLG51000_LDO6_VSEL_ACTUAL),
+	regmap_reg_range(SLG51000_LDO6_EVENT, SLG51000_LDO6_IRQ_MASK),
+	regmap_reg_range(SLG51000_LDO7_VSEL, SLG51000_LDO7_VSEL),
+	regmap_reg_range(SLG51000_LDO7_MINV, SLG51000_LDO7_MAXV),
+	regmap_reg_range(SLG51000_LDO7_CONF1, SLG51000_LDO7_VSEL_ACTUAL),
+	regmap_reg_range(SLG51000_LDO7_EVENT, SLG51000_LDO7_IRQ_MASK),
+	regmap_reg_range(SLG51000_OTP_EVENT, SLG51000_OTP_EVENT),
+	regmap_reg_range(SLG51000_OTP_IRQ_MASK, SLG51000_OTP_IRQ_MASK),
+	regmap_reg_range(SLG51000_OTP_LOCK_OTP_PROG, SLG51000_OTP_LOCK_CTRL),
+	regmap_reg_range(SLG51000_LOCK_GLOBAL_LOCK_CTRL1,
+			 SLG51000_LOCK_GLOBAL_LOCK_CTRL1),
+};
+
+static const struct regmap_range slg51000_volatile_ranges[] = {
+	regmap_reg_range(SLG51000_SYSCTL_FAULT_LOG1, SLG51000_SYSCTL_STATUS),
+	regmap_reg_range(SLG51000_IO_GPIO_STATUS, SLG51000_IO_GPIO_STATUS),
+	regmap_reg_range(SLG51000_LDO1_EVENT, SLG51000_LDO1_STATUS),
+	regmap_reg_range(SLG51000_LDO2_EVENT, SLG51000_LDO2_STATUS),
+	regmap_reg_range(SLG51000_LDO3_EVENT, SLG51000_LDO3_STATUS),
+	regmap_reg_range(SLG51000_LDO4_EVENT, SLG51000_LDO4_STATUS),
+	regmap_reg_range(SLG51000_LDO5_EVENT, SLG51000_LDO5_STATUS),
+	regmap_reg_range(SLG51000_LDO6_EVENT, SLG51000_LDO6_STATUS),
+	regmap_reg_range(SLG51000_LDO7_EVENT, SLG51000_LDO7_STATUS),
+	regmap_reg_range(SLG51000_OTP_EVENT, SLG51000_OTP_EVENT),
+};
+
+static const struct regmap_access_table slg51000_writeable_table = {
+	.yes_ranges	= slg51000_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(slg51000_writeable_ranges),
+};
+
+static const struct regmap_access_table slg51000_readable_table = {
+	.yes_ranges	= slg51000_readable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(slg51000_readable_ranges),
+};
+
+static const struct regmap_access_table slg51000_volatile_table = {
+	.yes_ranges	= slg51000_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(slg51000_volatile_ranges),
+};
+
+static const struct regmap_config slg51000_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = 0x8000,
+	.wr_table = &slg51000_writeable_table,
+	.rd_table = &slg51000_readable_table,
+	.volatile_table = &slg51000_volatile_table,
+};
+
+static int slg51000_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct slg51000 *chip = rdev_get_drvdata(rdev);
+	int ret, id = rdev_get_id(rdev);
+	unsigned int state;
+
+	ret = regmap_read(chip->regmap, es_reg[id].sreg, &state);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read status register(%d)\n",
+			ret);
+		return ret;
+	}
+
+	if (!(state & SLG51000_STA_ILIM_FLAG_MASK) &&
+	    (state & SLG51000_STA_VOUT_OK_FLAG_MASK))
+		return 1;
+	else
+		return 0;
+}
+
+static struct regulator_ops slg51000_regl_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = slg51000_regulator_is_enabled,
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+static struct regulator_ops slg51000_switch_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = slg51000_regulator_is_enabled,
+};
+
+static int slg51000_of_parse_cb(struct device_node *np,
+				const struct regulator_desc *desc,
+				struct regulator_config *config)
+{
+	struct slg51000 *chip = config->driver_data;
+	struct slg51000_pdata *rpdata = &chip->regl_pdata[desc->id];
+	enum gpiod_flags gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+
+	rpdata->ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
+							"enable-gpios", 0,
+							gflags, "gpio-en-ldo");
+	if (rpdata->ena_gpiod) {
+		config->ena_gpiod = rpdata->ena_gpiod;
+		devm_gpiod_unhinge(chip->dev, config->ena_gpiod);
+	}
+
+	return 0;
+}
+
+#define SLG51000_REGL_DESC(_id, _name, _s_name, _min, _step) \
+	[SLG51000_REGULATOR_##_id] = {                             \
+		.name = #_name,                                    \
+		.supply_name = _s_name,				   \
+		.id = SLG51000_REGULATOR_##_id,                    \
+		.of_match = of_match_ptr(#_name),                  \
+		.of_parse_cb = slg51000_of_parse_cb,               \
+		.ops = &slg51000_regl_ops,                         \
+		.regulators_node = of_match_ptr("regulators"),     \
+		.n_voltages = 256,                                 \
+		.min_uV = _min,                                    \
+		.uV_step = _step,                                  \
+		.linear_min_sel = 0,                               \
+		.vsel_mask = SLG51000_VSEL_MASK,                   \
+		.vsel_reg = SLG51000_##_id##_VSEL,                 \
+		.enable_reg = SLG51000_SYSCTL_MATRIX_CONF_A,       \
+		.enable_mask = BIT(SLG51000_REGULATOR_##_id),      \
+		.type = REGULATOR_VOLTAGE,                         \
+		.owner = THIS_MODULE,                              \
+	}
+
+static struct regulator_desc regls_desc[SLG51000_MAX_REGULATORS] = {
+	SLG51000_REGL_DESC(LDO1, ldo1, NULL,   2400000,  5000),
+	SLG51000_REGL_DESC(LDO2, ldo2, NULL,   2400000,  5000),
+	SLG51000_REGL_DESC(LDO3, ldo3, "vin3", 1200000, 10000),
+	SLG51000_REGL_DESC(LDO4, ldo4, "vin4", 1200000, 10000),
+	SLG51000_REGL_DESC(LDO5, ldo5, "vin5",  400000,  5000),
+	SLG51000_REGL_DESC(LDO6, ldo6, "vin6",  400000,  5000),
+	SLG51000_REGL_DESC(LDO7, ldo7, "vin7", 1200000, 10000),
+};
+
+static int slg51000_regulator_init(struct slg51000 *chip)
+{
+	struct regulator_config config = { };
+	struct regulator_desc *rdesc;
+	unsigned int reg, val;
+	u8 vsel_range[2];
+	int id, ret = 0;
+	const unsigned int min_regs[SLG51000_MAX_REGULATORS] = {
+		SLG51000_LDO1_MINV, SLG51000_LDO2_MINV, SLG51000_LDO3_MINV,
+		SLG51000_LDO4_MINV, SLG51000_LDO5_MINV, SLG51000_LDO6_MINV,
+		SLG51000_LDO7_MINV,
+	};
+
+	for (id = 0; id < SLG51000_MAX_REGULATORS; id++) {
+		chip->rdesc[id] = &regls_desc[id];
+		rdesc = chip->rdesc[id];
+		config.regmap = chip->regmap;
+		config.dev = chip->dev;
+		config.driver_data = chip;
+
+		ret = regmap_bulk_read(chip->regmap, min_regs[id],
+				       vsel_range, 2);
+		if (ret < 0) {
+			dev_err(chip->dev,
+				"Failed to read the MIN register\n");
+			return ret;
+		}
+
+		switch (id) {
+		case SLG51000_REGULATOR_LDO1:
+		case SLG51000_REGULATOR_LDO2:
+			if (id == SLG51000_REGULATOR_LDO1)
+				reg = SLG51000_LDO1_MISC1;
+			else
+				reg = SLG51000_LDO2_MISC1;
+
+			ret = regmap_read(chip->regmap, reg, &val);
+			if (ret < 0) {
+				dev_err(chip->dev,
+					"Failed to read voltage range of ldo%d\n",
+					id + 1);
+				return ret;
+			}
+
+			rdesc->linear_min_sel = vsel_range[0];
+			rdesc->n_voltages = vsel_range[1] + 1;
+			if (val & SLG51000_SEL_VRANGE_MASK)
+				rdesc->min_uV = SLG51000_LDOHP_HV_MIN
+						+ (vsel_range[0]
+						   * rdesc->uV_step);
+			else
+				rdesc->min_uV = SLG51000_LDOHP_LV_MIN
+						+ (vsel_range[0]
+						   * rdesc->uV_step);
+			break;
+
+		case SLG51000_REGULATOR_LDO5:
+		case SLG51000_REGULATOR_LDO6:
+			if (id == SLG51000_REGULATOR_LDO5)
+				reg = SLG51000_LDO5_TRIM2;
+			else
+				reg = SLG51000_LDO6_TRIM2;
+
+			ret = regmap_read(chip->regmap, reg, &val);
+			if (ret < 0) {
+				dev_err(chip->dev,
+					"Failed to read LDO mode register\n");
+				return ret;
+			}
+
+			if (val & SLG51000_SEL_BYP_MODE_MASK) {
+				rdesc->ops = &slg51000_switch_ops;
+				rdesc->n_voltages = 0;
+				rdesc->min_uV = 0;
+				rdesc->uV_step = 0;
+				rdesc->linear_min_sel = 0;
+				break;
+			}
+			/* Fall through - to the check below.*/
+
+		default:
+			rdesc->linear_min_sel = vsel_range[0];
+			rdesc->n_voltages = vsel_range[1] + 1;
+			rdesc->min_uV = rdesc->min_uV
+					+ (vsel_range[0] * rdesc->uV_step);
+			break;
+		}
+
+		chip->rdev[id] = devm_regulator_register(chip->dev, rdesc,
+							 &config);
+		if (IS_ERR(chip->rdev[id])) {
+			ret = PTR_ERR(chip->rdev[id]);
+			dev_err(chip->dev,
+				"Failed to register regulator(%s):%d\n",
+				chip->rdesc[id]->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t slg51000_irq_handler(int irq, void *data)
+{
+	struct slg51000 *chip = data;
+	struct regmap *regmap = chip->regmap;
+	enum { R0 = 0, R1, R2, REG_MAX };
+	u8 evt[SLG51000_MAX_EVT_REGISTER][REG_MAX];
+	int ret, i, handled = IRQ_NONE;
+	unsigned int evt_otp, mask_otp;
+
+	/* Read event[R0], status[R1] and mask[R2] register */
+	for (i = 0; i < SLG51000_MAX_EVT_REGISTER; i++) {
+		ret = regmap_bulk_read(regmap, es_reg[i].ereg, evt[i], REG_MAX);
+		if (ret < 0) {
+			dev_err(chip->dev,
+				"Failed to read event registers(%d)\n", ret);
+			return IRQ_NONE;
+		}
+	}
+
+	ret = regmap_read(regmap, SLG51000_OTP_EVENT, &evt_otp);
+	if (ret < 0) {
+		dev_err(chip->dev,
+			"Failed to read otp event registers(%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	ret = regmap_read(regmap, SLG51000_OTP_IRQ_MASK, &mask_otp);
+	if (ret < 0) {
+		dev_err(chip->dev,
+			"Failed to read otp mask register(%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	if ((evt_otp & SLG51000_EVT_CRC_MASK) &&
+	    !(mask_otp & SLG51000_IRQ_CRC_MASK)) {
+		dev_info(chip->dev,
+			 "OTP has been read or OTP crc is not zero\n");
+		handled = IRQ_HANDLED;
+	}
+
+	for (i = 0; i < SLG51000_MAX_REGULATORS; i++) {
+		if (!(evt[i][R2] & SLG51000_IRQ_ILIM_FLAG_MASK) &&
+		    (evt[i][R0] & SLG51000_EVT_ILIM_FLAG_MASK)) {
+			regulator_lock(chip->rdev[i]);
+			regulator_notifier_call_chain(chip->rdev[i],
+					    REGULATOR_EVENT_OVER_CURRENT, NULL);
+			regulator_unlock(chip->rdev[i]);
+
+			if (evt[i][R1] & SLG51000_STA_ILIM_FLAG_MASK)
+				dev_warn(chip->dev,
+					 "Over-current limit(ldo%d)\n", i + 1);
+			handled = IRQ_HANDLED;
+		}
+	}
+
+	if (!(evt[SLG51000_SCTL_EVT][R2] & SLG51000_IRQ_HIGH_TEMP_WARN_MASK) &&
+	    (evt[SLG51000_SCTL_EVT][R0] & SLG51000_EVT_HIGH_TEMP_WARN_MASK)) {
+		for (i = 0; i < SLG51000_MAX_REGULATORS; i++) {
+			if (!(evt[i][R1] & SLG51000_STA_ILIM_FLAG_MASK) &&
+			    (evt[i][R1] & SLG51000_STA_VOUT_OK_FLAG_MASK)) {
+				regulator_lock(chip->rdev[i]);
+				regulator_notifier_call_chain(chip->rdev[i],
+					       REGULATOR_EVENT_OVER_TEMP, NULL);
+				regulator_unlock(chip->rdev[i]);
+			}
+		}
+		handled = IRQ_HANDLED;
+		if (evt[SLG51000_SCTL_EVT][R1] &
+		    SLG51000_STA_HIGH_TEMP_WARN_MASK)
+			dev_warn(chip->dev, "High temperature warning!\n");
+	}
+
+	return handled;
+}
+
+static void slg51000_clear_fault_log(struct slg51000 *chip)
+{
+	unsigned int val = 0;
+	int ret = 0;
+
+	ret = regmap_read(chip->regmap, SLG51000_SYSCTL_FAULT_LOG1, &val);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read Fault log register\n");
+		return;
+	}
+
+	if (val & SLG51000_FLT_OVER_TEMP_MASK)
+		dev_dbg(chip->dev, "Fault log: FLT_OVER_TEMP\n");
+	if (val & SLG51000_FLT_POWER_SEQ_CRASH_REQ_MASK)
+		dev_dbg(chip->dev, "Fault log: FLT_POWER_SEQ_CRASH_REQ\n");
+	if (val & SLG51000_FLT_RST_MASK)
+		dev_dbg(chip->dev, "Fault log: FLT_RST\n");
+	if (val & SLG51000_FLT_POR_MASK)
+		dev_dbg(chip->dev, "Fault log: FLT_POR\n");
+}
+
+static int slg51000_i2c_probe(struct i2c_client *client,
+			      const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct slg51000 *chip;
+	struct gpio_desc *cs_gpiod = NULL;
+	int error, ret;
+
+	chip = devm_kzalloc(dev, sizeof(struct slg51000), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	cs_gpiod = devm_gpiod_get_from_of_node(dev, dev->of_node,
+					       "dlg,cs-gpios", 0,
+					       GPIOD_OUT_HIGH
+					       | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+					       "slg51000-cs");
+	if (cs_gpiod) {
+		dev_info(dev, "Found chip selector property\n");
+		chip->cs_gpiod = cs_gpiod;
+	}
+
+	i2c_set_clientdata(client, chip);
+	chip->chip_irq = client->irq;
+	chip->dev = dev;
+	chip->regmap = devm_regmap_init_i2c(client, &slg51000_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		error = PTR_ERR(chip->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n",
+			error);
+		return error;
+	}
+
+	ret = slg51000_regulator_init(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to init regulator(%d)\n", ret);
+		return ret;
+	}
+
+	slg51000_clear_fault_log(chip);
+
+	if (chip->chip_irq) {
+		ret = devm_request_threaded_irq(dev, chip->chip_irq, NULL,
+						slg51000_irq_handler,
+						(IRQF_TRIGGER_HIGH |
+						IRQF_ONESHOT),
+						"slg51000-irq", chip);
+		if (ret != 0) {
+			dev_err(dev, "Failed to request IRQ: %d\n",
+				chip->chip_irq);
+			return ret;
+		}
+	} else {
+		dev_info(dev, "No IRQ configured\n");
+	}
+
+	return ret;
+}
+
+static const struct i2c_device_id slg51000_i2c_id[] = {
+	{"slg51000", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, slg51000_i2c_id);
+
+static struct i2c_driver slg51000_regulator_driver = {
+	.driver = {
+		.name = "slg51000-regulator",
+	},
+	.probe = slg51000_i2c_probe,
+	.id_table = slg51000_i2c_id,
+};
+
+module_i2c_driver(slg51000_regulator_driver);
+
+MODULE_AUTHOR("Eric Jeong <eric.jeong.opensource@diasemi.com>");
+MODULE_DESCRIPTION("SLG51000 regulator driver");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/regulator/slg51000-regulator.h b/drivers/regulator/slg51000-regulator.h
new file mode 100644
index 0000000..20feb7f
--- /dev/null
+++ b/drivers/regulator/slg51000-regulator.h
@@ -0,0 +1,505 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SLG51000 High PSRR, Multi-Output Regulators
+ * Copyright (C) 2019  Dialog Semiconductor
+ *
+ * Author: Eric Jeong <eric.jeong.opensource@diasemi.com>
+ */
+
+#ifndef __SLG51000_REGISTERS_H__
+#define __SLG51000_REGISTERS_H__
+
+/* Registers */
+
+#define SLG51000_SYSCTL_PATN_ID_B0              0x1105
+#define SLG51000_SYSCTL_PATN_ID_B1              0x1106
+#define SLG51000_SYSCTL_PATN_ID_B2              0x1107
+#define SLG51000_SYSCTL_SYS_CONF_A              0x1109
+#define SLG51000_SYSCTL_SYS_CONF_D              0x110c
+#define SLG51000_SYSCTL_MATRIX_CONF_A           0x110d
+#define SLG51000_SYSCTL_MATRIX_CONF_B           0x110e
+#define SLG51000_SYSCTL_REFGEN_CONF_C           0x1111
+#define SLG51000_SYSCTL_UVLO_CONF_A             0x1112
+#define SLG51000_SYSCTL_FAULT_LOG1              0x1115
+#define SLG51000_SYSCTL_EVENT                   0x1116
+#define SLG51000_SYSCTL_STATUS                  0x1117
+#define SLG51000_SYSCTL_IRQ_MASK                0x1118
+#define SLG51000_IO_GPIO1_CONF                  0x1500
+#define SLG51000_IO_GPIO2_CONF                  0x1501
+#define SLG51000_IO_GPIO3_CONF                  0x1502
+#define SLG51000_IO_GPIO4_CONF                  0x1503
+#define SLG51000_IO_GPIO5_CONF                  0x1504
+#define SLG51000_IO_GPIO6_CONF                  0x1505
+#define SLG51000_IO_GPIO_STATUS                 0x1506
+#define SLG51000_LUTARRAY_LUT_VAL_0             0x1600
+#define SLG51000_LUTARRAY_LUT_VAL_1             0x1601
+#define SLG51000_LUTARRAY_LUT_VAL_2             0x1602
+#define SLG51000_LUTARRAY_LUT_VAL_3             0x1603
+#define SLG51000_LUTARRAY_LUT_VAL_4             0x1604
+#define SLG51000_LUTARRAY_LUT_VAL_5             0x1605
+#define SLG51000_LUTARRAY_LUT_VAL_6             0x1606
+#define SLG51000_LUTARRAY_LUT_VAL_7             0x1607
+#define SLG51000_LUTARRAY_LUT_VAL_8             0x1608
+#define SLG51000_LUTARRAY_LUT_VAL_9             0x1609
+#define SLG51000_LUTARRAY_LUT_VAL_10            0x160a
+#define SLG51000_LUTARRAY_LUT_VAL_11            0x160b
+#define SLG51000_MUXARRAY_INPUT_SEL_0           0x1700
+#define SLG51000_MUXARRAY_INPUT_SEL_1           0x1701
+#define SLG51000_MUXARRAY_INPUT_SEL_2           0x1702
+#define SLG51000_MUXARRAY_INPUT_SEL_3           0x1703
+#define SLG51000_MUXARRAY_INPUT_SEL_4           0x1704
+#define SLG51000_MUXARRAY_INPUT_SEL_5           0x1705
+#define SLG51000_MUXARRAY_INPUT_SEL_6           0x1706
+#define SLG51000_MUXARRAY_INPUT_SEL_7           0x1707
+#define SLG51000_MUXARRAY_INPUT_SEL_8           0x1708
+#define SLG51000_MUXARRAY_INPUT_SEL_9           0x1709
+#define SLG51000_MUXARRAY_INPUT_SEL_10          0x170a
+#define SLG51000_MUXARRAY_INPUT_SEL_11          0x170b
+#define SLG51000_MUXARRAY_INPUT_SEL_12          0x170c
+#define SLG51000_MUXARRAY_INPUT_SEL_13          0x170d
+#define SLG51000_MUXARRAY_INPUT_SEL_14          0x170e
+#define SLG51000_MUXARRAY_INPUT_SEL_15          0x170f
+#define SLG51000_MUXARRAY_INPUT_SEL_16          0x1710
+#define SLG51000_MUXARRAY_INPUT_SEL_17          0x1711
+#define SLG51000_MUXARRAY_INPUT_SEL_18          0x1712
+#define SLG51000_MUXARRAY_INPUT_SEL_19          0x1713
+#define SLG51000_MUXARRAY_INPUT_SEL_20          0x1714
+#define SLG51000_MUXARRAY_INPUT_SEL_21          0x1715
+#define SLG51000_MUXARRAY_INPUT_SEL_22          0x1716
+#define SLG51000_MUXARRAY_INPUT_SEL_23          0x1717
+#define SLG51000_MUXARRAY_INPUT_SEL_24          0x1718
+#define SLG51000_MUXARRAY_INPUT_SEL_25          0x1719
+#define SLG51000_MUXARRAY_INPUT_SEL_26          0x171a
+#define SLG51000_MUXARRAY_INPUT_SEL_27          0x171b
+#define SLG51000_MUXARRAY_INPUT_SEL_28          0x171c
+#define SLG51000_MUXARRAY_INPUT_SEL_29          0x171d
+#define SLG51000_MUXARRAY_INPUT_SEL_30          0x171e
+#define SLG51000_MUXARRAY_INPUT_SEL_31          0x171f
+#define SLG51000_MUXARRAY_INPUT_SEL_32          0x1720
+#define SLG51000_MUXARRAY_INPUT_SEL_33          0x1721
+#define SLG51000_MUXARRAY_INPUT_SEL_34          0x1722
+#define SLG51000_MUXARRAY_INPUT_SEL_35          0x1723
+#define SLG51000_MUXARRAY_INPUT_SEL_36          0x1724
+#define SLG51000_MUXARRAY_INPUT_SEL_37          0x1725
+#define SLG51000_MUXARRAY_INPUT_SEL_38          0x1726
+#define SLG51000_MUXARRAY_INPUT_SEL_39          0x1727
+#define SLG51000_MUXARRAY_INPUT_SEL_40          0x1728
+#define SLG51000_MUXARRAY_INPUT_SEL_41          0x1729
+#define SLG51000_MUXARRAY_INPUT_SEL_42          0x172a
+#define SLG51000_MUXARRAY_INPUT_SEL_43          0x172b
+#define SLG51000_MUXARRAY_INPUT_SEL_44          0x172c
+#define SLG51000_MUXARRAY_INPUT_SEL_45          0x172d
+#define SLG51000_MUXARRAY_INPUT_SEL_46          0x172e
+#define SLG51000_MUXARRAY_INPUT_SEL_47          0x172f
+#define SLG51000_MUXARRAY_INPUT_SEL_48          0x1730
+#define SLG51000_MUXARRAY_INPUT_SEL_49          0x1731
+#define SLG51000_MUXARRAY_INPUT_SEL_50          0x1732
+#define SLG51000_MUXARRAY_INPUT_SEL_51          0x1733
+#define SLG51000_MUXARRAY_INPUT_SEL_52          0x1734
+#define SLG51000_MUXARRAY_INPUT_SEL_53          0x1735
+#define SLG51000_MUXARRAY_INPUT_SEL_54          0x1736
+#define SLG51000_MUXARRAY_INPUT_SEL_55          0x1737
+#define SLG51000_MUXARRAY_INPUT_SEL_56          0x1738
+#define SLG51000_MUXARRAY_INPUT_SEL_57          0x1739
+#define SLG51000_MUXARRAY_INPUT_SEL_58          0x173a
+#define SLG51000_MUXARRAY_INPUT_SEL_59          0x173b
+#define SLG51000_MUXARRAY_INPUT_SEL_60          0x173c
+#define SLG51000_MUXARRAY_INPUT_SEL_61          0x173d
+#define SLG51000_MUXARRAY_INPUT_SEL_62          0x173e
+#define SLG51000_MUXARRAY_INPUT_SEL_63          0x173f
+#define SLG51000_PWRSEQ_RESOURCE_EN_0           0x1900
+#define SLG51000_PWRSEQ_RESOURCE_EN_1           0x1901
+#define SLG51000_PWRSEQ_RESOURCE_EN_2           0x1902
+#define SLG51000_PWRSEQ_RESOURCE_EN_3           0x1903
+#define SLG51000_PWRSEQ_RESOURCE_EN_4           0x1904
+#define SLG51000_PWRSEQ_RESOURCE_EN_5           0x1905
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_UP0       0x1906
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_DOWN0     0x1907
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_UP1       0x1908
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_DOWN1     0x1909
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_UP2       0x190a
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_DOWN2     0x190b
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_UP3       0x190c
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_DOWN3     0x190d
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_UP4       0x190e
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_DOWN4     0x190f
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_UP5       0x1910
+#define SLG51000_PWRSEQ_SLOT_TIME_MIN_DOWN5     0x1911
+#define SLG51000_PWRSEQ_SLOT_TIME_MAX_CONF_A    0x1912
+#define SLG51000_PWRSEQ_SLOT_TIME_MAX_CONF_B    0x1913
+#define SLG51000_PWRSEQ_SLOT_TIME_MAX_CONF_C    0x1914
+#define SLG51000_PWRSEQ_INPUT_SENSE_CONF_A      0x1915
+#define SLG51000_PWRSEQ_INPUT_SENSE_CONF_B      0x1916
+#define SLG51000_LDO1_VSEL                      0x2000
+#define SLG51000_LDO1_MINV                      0x2060
+#define SLG51000_LDO1_MAXV                      0x2061
+#define SLG51000_LDO1_MISC1                     0x2064
+#define SLG51000_LDO1_VSEL_ACTUAL               0x2065
+#define SLG51000_LDO1_EVENT                     0x20c0
+#define SLG51000_LDO1_STATUS                    0x20c1
+#define SLG51000_LDO1_IRQ_MASK                  0x20c2
+#define SLG51000_LDO2_VSEL                      0x2200
+#define SLG51000_LDO2_MINV                      0x2260
+#define SLG51000_LDO2_MAXV                      0x2261
+#define SLG51000_LDO2_MISC1                     0x2264
+#define SLG51000_LDO2_VSEL_ACTUAL               0x2265
+#define SLG51000_LDO2_EVENT                     0x22c0
+#define SLG51000_LDO2_STATUS                    0x22c1
+#define SLG51000_LDO2_IRQ_MASK                  0x22c2
+#define SLG51000_LDO3_VSEL                      0x2300
+#define SLG51000_LDO3_MINV                      0x2360
+#define SLG51000_LDO3_MAXV                      0x2361
+#define SLG51000_LDO3_CONF1                     0x2364
+#define SLG51000_LDO3_CONF2                     0x2365
+#define SLG51000_LDO3_VSEL_ACTUAL               0x2366
+#define SLG51000_LDO3_EVENT                     0x23c0
+#define SLG51000_LDO3_STATUS                    0x23c1
+#define SLG51000_LDO3_IRQ_MASK                  0x23c2
+#define SLG51000_LDO4_VSEL                      0x2500
+#define SLG51000_LDO4_MINV                      0x2560
+#define SLG51000_LDO4_MAXV                      0x2561
+#define SLG51000_LDO4_CONF1                     0x2564
+#define SLG51000_LDO4_CONF2                     0x2565
+#define SLG51000_LDO4_VSEL_ACTUAL               0x2566
+#define SLG51000_LDO4_EVENT                     0x25c0
+#define SLG51000_LDO4_STATUS                    0x25c1
+#define SLG51000_LDO4_IRQ_MASK                  0x25c2
+#define SLG51000_LDO5_VSEL                      0x2700
+#define SLG51000_LDO5_MINV                      0x2760
+#define SLG51000_LDO5_MAXV                      0x2761
+#define SLG51000_LDO5_TRIM2                     0x2763
+#define SLG51000_LDO5_CONF1                     0x2765
+#define SLG51000_LDO5_CONF2                     0x2766
+#define SLG51000_LDO5_VSEL_ACTUAL               0x2767
+#define SLG51000_LDO5_EVENT                     0x27c0
+#define SLG51000_LDO5_STATUS                    0x27c1
+#define SLG51000_LDO5_IRQ_MASK                  0x27c2
+#define SLG51000_LDO6_VSEL                      0x2900
+#define SLG51000_LDO6_MINV                      0x2960
+#define SLG51000_LDO6_MAXV                      0x2961
+#define SLG51000_LDO6_TRIM2                     0x2963
+#define SLG51000_LDO6_CONF1                     0x2965
+#define SLG51000_LDO6_CONF2                     0x2966
+#define SLG51000_LDO6_VSEL_ACTUAL               0x2967
+#define SLG51000_LDO6_EVENT                     0x29c0
+#define SLG51000_LDO6_STATUS                    0x29c1
+#define SLG51000_LDO6_IRQ_MASK                  0x29c2
+#define SLG51000_LDO7_VSEL                      0x3100
+#define SLG51000_LDO7_MINV                      0x3160
+#define SLG51000_LDO7_MAXV                      0x3161
+#define SLG51000_LDO7_CONF1                     0x3164
+#define SLG51000_LDO7_CONF2                     0x3165
+#define SLG51000_LDO7_VSEL_ACTUAL               0x3166
+#define SLG51000_LDO7_EVENT                     0x31c0
+#define SLG51000_LDO7_STATUS                    0x31c1
+#define SLG51000_LDO7_IRQ_MASK                  0x31c2
+#define SLG51000_OTP_EVENT                      0x782b
+#define SLG51000_OTP_IRQ_MASK                   0x782d
+#define SLG51000_OTP_LOCK_OTP_PROG              0x78fe
+#define SLG51000_OTP_LOCK_CTRL                  0x78ff
+#define SLG51000_LOCK_GLOBAL_LOCK_CTRL1         0x8000
+
+/* Register Bit Fields */
+
+/* SLG51000_SYSCTL_PATTERN_ID_BYTE0 = 0x1105 */
+#define SLG51000_PATTERN_ID_BYTE0_SHIFT         0
+#define SLG51000_PATTERN_ID_BYTE0_MASK          (0xff << 0)
+
+/* SLG51000_SYSCTL_PATTERN_ID_BYTE1 = 0x1106 */
+#define SLG51000_PATTERN_ID_BYTE1_SHIFT         0
+#define SLG51000_PATTERN_ID_BYTE1_MASK          (0xff << 0)
+
+/* SLG51000_SYSCTL_PATTERN_ID_BYTE2 = 0x1107 */
+#define SLG51000_PATTERN_ID_BYTE2_SHIFT         0
+#define SLG51000_PATTERN_ID_BYTE2_MASK          (0xff << 0)
+
+/* SLG51000_SYSCTL_SYS_CONF_A = 0x1109 */
+#define SLG51000_I2C_ADDRESS_SHIFT              0
+#define SLG51000_I2C_ADDRESS_MASK               (0x7f << 0)
+#define SLG51000_I2C_DISABLE_SHIFT              7
+#define SLG51000_I2C_DISABLE_MASK               (0x01 << 7)
+
+/* SLG51000_SYSCTL_SYS_CONF_D = 0x110c */
+#define SLG51000_CS_T_DEB_SHIFT                 6
+#define SLG51000_CS_T_DEB_MASK                  (0x03 << 6)
+#define SLG51000_I2C_CLR_MODE_SHIFT             5
+#define SLG51000_I2C_CLR_MODE_MASK              (0x01 << 5)
+
+/* SLG51000_SYSCTL_MATRIX_CTRL_CONF_A = 0x110d */
+#define SLG51000_RESOURCE_CTRL_SHIFT            0
+#define SLG51000_RESOURCE_CTRL_MASK             (0xff << 0)
+
+/* SLG51000_SYSCTL_MATRIX_CTRL_CONF_B = 0x110e */
+#define SLG51000_MATRIX_EVENT_SENSE_SHIFT       0
+#define SLG51000_MATRIX_EVENT_SENSE_MASK        (0x07 << 0)
+
+/* SLG51000_SYSCTL_REFGEN_CONF_C = 0x1111 */
+#define SLG51000_REFGEN_SEL_TEMP_WARN_DEBOUNCE_SHIFT    2
+#define SLG51000_REFGEN_SEL_TEMP_WARN_DEBOUNCE_MASK     (0x03 << 2)
+#define SLG51000_REFGEN_SEL_TEMP_WARN_THR_SHIFT         0
+#define SLG51000_REFGEN_SEL_TEMP_WARN_THR_MASK          (0x03 << 0)
+
+/* SLG51000_SYSCTL_UVLO_CONF_A = 0x1112 */
+#define SLG51000_VMON_UVLO_SEL_THR_SHIFT        0
+#define SLG51000_VMON_UVLO_SEL_THR_MASK         (0x1f << 0)
+
+/* SLG51000_SYSCTL_FAULT_LOG1 = 0x1115 */
+#define SLG51000_FLT_POR_SHIFT                  5
+#define SLG51000_FLT_POR_MASK                   (0x01 << 5)
+#define SLG51000_FLT_RST_SHIFT                  4
+#define SLG51000_FLT_RST_MASK                   (0x01 << 4)
+#define SLG51000_FLT_POWER_SEQ_CRASH_REQ_SHIFT  2
+#define SLG51000_FLT_POWER_SEQ_CRASH_REQ_MASK   (0x01 << 2)
+#define SLG51000_FLT_OVER_TEMP_SHIFT            1
+#define SLG51000_FLT_OVER_TEMP_MASK             (0x01 << 1)
+
+/* SLG51000_SYSCTL_EVENT = 0x1116 */
+#define SLG51000_EVT_MATRIX_SHIFT               1
+#define SLG51000_EVT_MATRIX_MASK                (0x01 << 1)
+#define SLG51000_EVT_HIGH_TEMP_WARN_SHIFT       0
+#define SLG51000_EVT_HIGH_TEMP_WARN_MASK        (0x01 << 0)
+
+/* SLG51000_SYSCTL_STATUS = 0x1117 */
+#define SLG51000_STA_MATRIX_SHIFT               1
+#define SLG51000_STA_MATRIX_MASK                (0x01 << 1)
+#define SLG51000_STA_HIGH_TEMP_WARN_SHIFT       0
+#define SLG51000_STA_HIGH_TEMP_WARN_MASK        (0x01 << 0)
+
+/* SLG51000_SYSCTL_IRQ_MASK = 0x1118 */
+#define SLG51000_IRQ_MATRIX_SHIFT               1
+#define SLG51000_IRQ_MATRIX_MASK                (0x01 << 1)
+#define SLG51000_IRQ_HIGH_TEMP_WARN_SHIFT       0
+#define SLG51000_IRQ_HIGH_TEMP_WARN_MASK        (0x01 << 0)
+
+/* SLG51000_IO_GPIO1_CONF ~ SLG51000_IO_GPIO5_CONF =
+ * 0x1500, 0x1501, 0x1502, 0x1503, 0x1504
+ */
+#define SLG51000_GPIO_DIR_SHIFT                 7
+#define SLG51000_GPIO_DIR_MASK                  (0x01 << 7)
+#define SLG51000_GPIO_SENS_SHIFT                5
+#define SLG51000_GPIO_SENS_MASK                 (0x03 << 5)
+#define SLG51000_GPIO_INVERT_SHIFT              4
+#define SLG51000_GPIO_INVERT_MASK               (0x01 << 4)
+#define SLG51000_GPIO_BYP_SHIFT                 3
+#define SLG51000_GPIO_BYP_MASK                  (0x01 << 3)
+#define SLG51000_GPIO_T_DEB_SHIFT               1
+#define SLG51000_GPIO_T_DEB_MASK                (0x03 << 1)
+#define SLG51000_GPIO_LEVEL_SHIFT               0
+#define SLG51000_GPIO_LEVEL_MASK                (0x01 << 0)
+
+/* SLG51000_IO_GPIO6_CONF = 0x1505 */
+#define SLG51000_GPIO6_SENS_SHIFT               5
+#define SLG51000_GPIO6_SENS_MASK                (0x03 << 5)
+#define SLG51000_GPIO6_INVERT_SHIFT             4
+#define SLG51000_GPIO6_INVERT_MASK              (0x01 << 4)
+#define SLG51000_GPIO6_T_DEB_SHIFT              1
+#define SLG51000_GPIO6_T_DEB_MASK               (0x03 << 1)
+#define SLG51000_GPIO6_LEVEL_SHIFT              0
+#define SLG51000_GPIO6_LEVEL_MASK               (0x01 << 0)
+
+/* SLG51000_IO_GPIO_STATUS = 0x1506 */
+#define SLG51000_GPIO6_STATUS_SHIFT             5
+#define SLG51000_GPIO6_STATUS_MASK              (0x01 << 5)
+#define SLG51000_GPIO5_STATUS_SHIFT             4
+#define SLG51000_GPIO5_STATUS_MASK              (0x01 << 4)
+#define SLG51000_GPIO4_STATUS_SHIFT             3
+#define SLG51000_GPIO4_STATUS_MASK              (0x01 << 3)
+#define SLG51000_GPIO3_STATUS_SHIFT             2
+#define SLG51000_GPIO3_STATUS_MASK              (0x01 << 2)
+#define SLG51000_GPIO2_STATUS_SHIFT             1
+#define SLG51000_GPIO2_STATUS_MASK              (0x01 << 1)
+#define SLG51000_GPIO1_STATUS_SHIFT             0
+#define SLG51000_GPIO1_STATUS_MASK              (0x01 << 0)
+
+/* SLG51000_LUTARRAY_LUT_VAL_0 ~ SLG51000_LUTARRAY_LUT_VAL_11
+ * 0x1600, 0x1601, 0x1602, 0x1603, 0x1604, 0x1605,
+ * 0x1606, 0x1607, 0x1608, 0x1609, 0x160a, 0x160b
+ */
+#define SLG51000_LUT_VAL_SHIFT                  0
+#define SLG51000_LUT_VAL_MASK                   (0xff << 0)
+
+/* SLG51000_MUXARRAY_INPUT_SEL_0 ~ SLG51000_MUXARRAY_INPUT_SEL_63
+ * 0x1700, 0x1701, 0x1702, 0x1703, 0x1704, 0x1705,
+ * 0x1706, 0x1707, 0x1708, 0x1709, 0x170a, 0x170b,
+ * 0x170c, 0x170d, 0x170e, 0x170f, 0x1710, 0x1711,
+ * 0x1712, 0x1713, 0x1714, 0x1715, 0x1716, 0x1717,
+ * 0x1718, 0x1719, 0x171a, 0x171b, 0x171c, 0x171d,
+ * 0x171e, 0x171f, 0x1720, 0x1721, 0x1722, 0x1723,
+ * 0x1724, 0x1725, 0x1726, 0x1727, 0x1728, 0x1729,
+ * 0x173a, 0x173b, 0x173c, 0x173d, 0x173e, 0x173f,
+ */
+#define SLG51000_INPUT_SEL_SHIFT                0
+#define SLG51000_INPUT_SEL_MASK                 (0x3f << 0)
+
+/* SLG51000_PWRSEQ_RESOURCE_EN_0 ~ SLG51000_PWRSEQ_RESOURCE_EN_5
+ * 0x1900, 0x1901, 0x1902, 0x1903, 0x1904, 0x1905
+ */
+#define SLG51000_RESOURCE_EN_DOWN0_SHIFT        4
+#define SLG51000_RESOURCE_EN_DOWN0_MASK         (0x07 << 4)
+#define SLG51000_RESOURCE_EN_UP0_SHIFT          0
+#define SLG51000_RESOURCE_EN_UP0_MASK           (0x07 << 0)
+
+/* SLG51000_PWRSEQ_SLOT_TIME_MIN_UP0 ~ SLG51000_PWRSEQ_SLOT_TIME_MIN_UP5
+ * 0x1906, 0x1908, 0x190a, 0x190c, 0x190e, 0x1910
+ */
+#define SLG51000_SLOT_TIME_MIN_UP_SHIFT         0
+#define SLG51000_SLOT_TIME_MIN_UP_MASK          (0xff << 0)
+
+/* SLG51000_PWRSEQ_SLOT_TIME_MIN_DOWN0 ~ SLG51000_PWRSEQ_SLOT_TIME_MIN_DOWN5
+ * 0x1907, 0x1909, 0x190b, 0x190d, 0x190f, 0x1911
+ */
+#define SLG51000_SLOT_TIME_MIN_DOWN_SHIFT       0
+#define SLG51000_SLOT_TIME_MIN_DOWN_MASK        (0xff << 0)
+
+/* SLG51000_PWRSEQ_SLOT_TIME_MAX_CONF_A ~ SLG51000_PWRSEQ_SLOT_TIME_MAX_CONF_C
+ * 0x1912, 0x1913, 0x1914
+ */
+#define SLG51000_SLOT_TIME_MAX_DOWN1_SHIFT      6
+#define SLG51000_SLOT_TIME_MAX_DOWN1_MASK       (0x03 << 6)
+#define SLG51000_SLOT_TIME_MAX_UP1_SHIFT        4
+#define SLG51000_SLOT_TIME_MAX_UP1_MASK         (0x03 << 4)
+#define SLG51000_SLOT_TIME_MAX_DOWN0_SHIFT      2
+#define SLG51000_SLOT_TIME_MAX_DOWN0_MASK       (0x03 << 2)
+#define SLG51000_SLOT_TIME_MAX_UP0_SHIFT        0
+#define SLG51000_SLOT_TIME_MAX_UP0_MASK         (0x03 << 0)
+
+/* SLG51000_PWRSEQ_INPUT_SENSE_CONF_A = 0x1915 */
+#define SLG51000_TRIG_UP_SENSE_SHIFT            6
+#define SLG51000_TRIG_UP_SENSE_MASK             (0x01 << 6)
+#define SLG51000_UP_EN_SENSE5_SHIFT             5
+#define SLG51000_UP_EN_SENSE5_MASK              (0x01 << 5)
+#define SLG51000_UP_EN_SENSE4_SHIFT             4
+#define SLG51000_UP_EN_SENSE4_MASK              (0x01 << 4)
+#define SLG51000_UP_EN_SENSE3_SHIFT             3
+#define SLG51000_UP_EN_SENSE3_MASK              (0x01 << 3)
+#define SLG51000_UP_EN_SENSE2_SHIFT             2
+#define SLG51000_UP_EN_SENSE2_MASK              (0x01 << 2)
+#define SLG51000_UP_EN_SENSE1_SHIFT             1
+#define SLG51000_UP_EN_SENSE1_MASK              (0x01 << 1)
+#define SLG51000_UP_EN_SENSE0_SHIFT             0
+#define SLG51000_UP_EN_SENSE0_MASK              (0x01 << 0)
+
+/* SLG51000_PWRSEQ_INPUT_SENSE_CONF_B = 0x1916 */
+#define SLG51000_CRASH_DETECT_SENSE_SHIFT       7
+#define SLG51000_CRASH_DETECT_SENSE_MASK        (0x01 << 7)
+#define SLG51000_TRIG_DOWN_SENSE_SHIFT          6
+#define SLG51000_TRIG_DOWN_SENSE_MASK           (0x01 << 6)
+#define SLG51000_DOWN_EN_SENSE5_SHIFT           5
+#define SLG51000_DOWN_EN_SENSE5_MASK            (0x01 << 5)
+#define SLG51000_DOWN_EN_SENSE4_SHIFT           4
+#define SLG51000_DOWN_EN_SENSE4_MASK            (0x01 << 4)
+#define SLG51000_DOWN_EN_SENSE3_SHIFT           3
+#define SLG51000_DOWN_EN_SENSE3_MASK            (0x01 << 3)
+#define SLG51000_DOWN_EN_SENSE2_SHIFT           2
+#define SLG51000_DOWN_EN_SENSE2_MASK            (0x01 << 2)
+#define SLG51000_DOWN_EN_SENSE1_SHIFT           1
+#define SLG51000_DOWN_EN_SENSE1_MASK            (0x01 << 1)
+#define SLG51000_DOWN_EN_SENSE0_SHIFT           0
+#define SLG51000_DOWN_EN_SENSE0_MASK            (0x01 << 0)
+
+/* SLG51000_LDO1_VSEL ~ SLG51000_LDO7_VSEL =
+ * 0x2000, 0x2200, 0x2300, 0x2500, 0x2700, 0x2900, 0x3100
+ */
+#define SLG51000_VSEL_SHIFT                     0
+#define SLG51000_VSEL_MASK                      (0xff << 0)
+
+/* SLG51000_LDO1_MINV ~ SLG51000_LDO7_MINV =
+ * 0x2060, 0x2260, 0x2360, 0x2560, 0x2760, 0x2960, 0x3160
+ */
+#define SLG51000_MINV_SHIFT                     0
+#define SLG51000_MINV_MASK                      (0xff << 0)
+
+/* SLG51000_LDO1_MAXV ~ SLG51000_LDO7_MAXV =
+ * 0x2061, 0x2261, 0x2361, 0x2561, 0x2761, 0x2961, 0x3161
+ */
+#define SLG51000_MAXV_SHIFT                     0
+#define SLG51000_MAXV_MASK                      (0xff << 0)
+
+/* SLG51000_LDO1_MISC1 = 0x2064, SLG51000_LDO2_MISC1 = 0x2264 */
+#define SLG51000_SEL_VRANGE_SHIFT               0
+#define SLG51000_SEL_VRANGE_MASK                (0x01 << 0)
+
+/* SLG51000_LDO1_VSEL_ACTUAL ~ SLG51000_LDO7_VSEL_ACTUAL =
+ * 0x2065, 0x2265, 0x2366, 0x2566, 0x2767, 0x2967, 0x3166
+ */
+#define SLG51000_VSEL_ACTUAL_SHIFT              0
+#define SLG51000_VSEL_ACTUAL_MASK               (0xff << 0)
+
+/* SLG51000_LDO1_EVENT ~ SLG51000_LDO7_EVENT =
+ * 0x20c0, 0x22c0, 0x23c0, 0x25c0, 0x27c0, 0x29c0, 0x31c0
+ */
+#define SLG51000_EVT_ILIM_FLAG_SHIFT            0
+#define SLG51000_EVT_ILIM_FLAG_MASK             (0x01 << 0)
+#define SLG51000_EVT_VOUT_OK_FLAG_SHIFT         1
+#define SLG51000_EVT_VOUT_OK_FLAG_MASK          (0x01 << 1)
+
+/* SLG51000_LDO1_STATUS ~ SLG51000_LDO7_STATUS =
+ * 0x20c1, 0x22c1, 0x23c1, 0x25c1, 0x27c1, 0x29c1, 0x31c1
+ */
+#define SLG51000_STA_ILIM_FLAG_SHIFT            0
+#define SLG51000_STA_ILIM_FLAG_MASK             (0x01 << 0)
+#define SLG51000_STA_VOUT_OK_FLAG_SHIFT         1
+#define SLG51000_STA_VOUT_OK_FLAG_MASK          (0x01 << 1)
+
+/* SLG51000_LDO1_IRQ_MASK ~ SLG51000_LDO7_IRQ_MASK =
+ * 0x20c2, 0x22c2, 0x23c2, 0x25c2, 0x27c2, 0x29c2, 0x31c2
+ */
+#define SLG51000_IRQ_ILIM_FLAG_SHIFT            0
+#define SLG51000_IRQ_ILIM_FLAG_MASK             (0x01 << 0)
+
+/* SLG51000_LDO3_CONF1 ~ SLG51000_LDO7_CONF1 =
+ * 0x2364, 0x2564, 0x2765, 0x2965, 0x3164
+ */
+#define SLG51000_SEL_START_ILIM_SHIFT           0
+#define SLG51000_SEL_START_ILIM_MASK            (0x7f << 0)
+
+/* SLG51000_LDO3_CONF2 ~ SLG51000_LDO7_CONF2 =
+ * 0x2365, 0x2565, 0x2766, 0x2966, 0x3165
+ */
+#define SLG51000_SEL_FUNC_ILIM_SHIFT            0
+#define SLG51000_SEL_FUNC_ILIM_MASK             (0x7f << 0)
+
+/* SLG51000_LDO5_TRIM2 = 0x2763, SLG51000_LDO6_TRIM2 = 0x2963 */
+#define SLG51000_SEL_BYP_SLEW_RATE_SHIFT        2
+#define SLG51000_SEL_BYP_SLEW_RATE_MASK         (0x03 << 2)
+#define SLG51000_SEL_BYP_VGATE_SHIFT            1
+#define SLG51000_SEL_BYP_VGATE_MASK             (0x01 << 1)
+#define SLG51000_SEL_BYP_MODE_SHIFT             0
+#define SLG51000_SEL_BYP_MODE_MASK              (0x01 << 0)
+
+/* SLG51000_OTP_EVENT = 0x782b */
+#define SLG51000_EVT_CRC_SHIFT                  0
+#define SLG51000_EVT_CRC_MASK                   (0x01 << 0)
+
+/* SLG51000_OTP_IRQ_MASK = 0x782d */
+#define SLG51000_IRQ_CRC_SHIFT                  0
+#define SLG51000_IRQ_CRC_MASK                   (0x01 << 0)
+
+/* SLG51000_OTP_LOCK_OTP_PROG = 0x78fe */
+#define SLG51000_LOCK_OTP_PROG_SHIFT            0
+#define SLG51000_LOCK_OTP_PROG_MASK             (0x01 << 0)
+
+/* SLG51000_OTP_LOCK_CTRL = 0x78ff */
+#define SLG51000_LOCK_DFT_SHIFT                 1
+#define SLG51000_LOCK_DFT_MASK                  (0x01 << 1)
+#define SLG51000_LOCK_RWT_SHIFT                 0
+#define SLG51000_LOCK_RWT_MASK                  (0x01 << 0)
+
+/* SLG51000_LOCK_GLOBAL_LOCK_CTRL1 = 0x8000 */
+#define SLG51000_LDO7_LOCK_SHIFT                7
+#define SLG51000_LDO7_LOCK_MASK                 (0x01 << 7)
+#define SLG51000_LDO6_LOCK_SHIFT                6
+#define SLG51000_LDO6_LOCK_MASK                 (0x01 << 6)
+#define SLG51000_LDO5_LOCK_SHIFT                5
+#define SLG51000_LDO5_LOCK_MASK                 (0x01 << 5)
+#define SLG51000_LDO4_LOCK_SHIFT                4
+#define SLG51000_LDO4_LOCK_MASK                 (0x01 << 4)
+#define SLG51000_LDO3_LOCK_SHIFT                3
+#define SLG51000_LDO3_LOCK_MASK                 (0x01 << 3)
+#define SLG51000_LDO2_LOCK_SHIFT                2
+#define SLG51000_LDO2_LOCK_MASK                 (0x01 << 2)
+#define SLG51000_LDO1_LOCK_SHIFT                1
+#define SLG51000_LDO1_LOCK_MASK                 (0x01 << 1)
+
+#endif /* __SLG51000_REGISTERS_H__ */
+
-- 
end-of-patch for PATCH V1

