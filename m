Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5898D21736
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfK1GhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:37:14 -0500
Received: from mail-eopbgr790054.outbound.protection.outlook.com ([40.107.79.54]:64800
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727300AbfK1GhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:37:12 -0500
Received: from SN4PR0201CA0061.namprd02.prod.outlook.com
 (2603:10b6:803:20::23) by CH2PR02MB6342.namprd02.prod.outlook.com
 (2603:10b6:610:f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Thu, 28 Nov
 2019 06:37:10 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN4PR0201CA0061.outlook.office365.com
 (2603:10b6:803:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Thu, 28 Nov 2019 06:37:10 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 06:37:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQL-0007Yr-0y; Wed, 27 Nov 2019 22:37:09 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQF-0005G6-V2; Wed, 27 Nov 2019 22:37:03 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAS6b2d6004690;
        Wed, 27 Nov 2019 22:37:03 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQE-00059i-GZ; Wed, 27 Nov 2019 22:37:02 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3 09/10] staging: clocking-wizard: Delete the driver from the staging
Date:   Thu, 28 Nov 2019 12:06:16 +0530
Message-Id: <9d8288380a387418b01396147a98b9d197a3992b.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--12.573-7.0-31-1
X-imss-scan-details: No--12.573-7.0-31-1;No--12.573-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132193966299994003;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(9686003)(73392003)(86362001)(2906002)(336012)(76482006)(450100002)(4326008)(82202003)(30864003)(8676002)(2870700001)(8936002)(5660300002)(26005)(426003)(11346002)(6306002)(446003)(14444005)(107886003)(9786002)(81156014)(966005)(36756003)(23676004)(498600001)(50226002)(66574012)(316002)(7696005)(76176011)(70206006)(118296001)(50466002)(47776003)(70586007)(81166006)(305945005)(6666004)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6342;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d10ca0fc-4d67-488b-6754-08d773cd652c
X-MS-TrafficTypeDiagnostic: CH2PR02MB6342:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <CH2PR02MB6342366F12C21794999B41E787470@CH2PR02MB6342.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0235CBE7D0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tk63eZHv1phQDtBJ4vlwJXk7wtcxSfzGBZypXffzL//0HuyWVmr42YYG2Y1JeoSWVanolC29IlPj3orrIpFUSnIyq4Xw8MK+eHS2Vd/MPk7WfVssOi2MyvdVDojec0Yr5N9IidcxovGAnN5XlV2hlPSO2K5yEUWlDDx99TsfFWJHuz3sJZ6gQjbf6Hk6PHJj9s9VoBHWP2dvfFApcaMUZcsdTj4VYXM1BeCqcO9WK3mJLOkVJDwLx/yOf8SpSWlZDWjfazg2Cew8L8imraj3X6ur8XGba7u2y9xnUeOhOzdVZd91BUrvhpo8P01IptLCowfafrrcKc2Yn31MCQG7LQo4M7HRPoetDKf+ZaKc7MwafnAUPazJ4tCAKEzbhfi6Q7scMsImD1mcuUMzTf8RHyBQGQntDKyP7/G5AXhWLMFXBHj9LDXR+YohgU0phqTiRpfgnEVB++iU5DKw1thn4V4YwEYyhbvPtMew+xR2E10=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 06:37:09.6020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10ca0fc-4d67-488b-6754-08d773cd652c
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Delete the driver from the staging as it is in drivers/clk.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/clocking-wizard/Kconfig            |  10 -
 drivers/staging/clocking-wizard/Makefile           |   2 -
 drivers/staging/clocking-wizard/TODO               |  12 -
 .../clocking-wizard/clk-xlnx-clock-wizard.c        | 335 ---------------------
 drivers/staging/clocking-wizard/dt-binding.txt     |  30 --
 7 files changed, 392 deletions(-)
 delete mode 100644 drivers/staging/clocking-wizard/Kconfig
 delete mode 100644 drivers/staging/clocking-wizard/Makefile
 delete mode 100644 drivers/staging/clocking-wizard/TODO
 delete mode 100644 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
 delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 6f1fa4c..29e7ab7 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -78,8 +78,6 @@ source "drivers/staging/gs_fpgaboot/Kconfig"
 
 source "drivers/staging/unisys/Kconfig"
 
-source "drivers/staging/clocking-wizard/Kconfig"
-
 source "drivers/staging/fbtft/Kconfig"
 
 source "drivers/staging/fsl-dpaa2/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index a90f9b3..7de50e3 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_FIREWIRE_SERIAL)	+= fwserial/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
 obj-$(CONFIG_GS_FPGABOOT)	+= gs_fpgaboot/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
-obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
 obj-$(CONFIG_FSL_DPAA2)		+= fsl-dpaa2/
 obj-$(CONFIG_WILC1000)		+= wilc1000/
diff --git a/drivers/staging/clocking-wizard/Kconfig b/drivers/staging/clocking-wizard/Kconfig
deleted file mode 100644
index 04be22d..0000000
--- a/drivers/staging/clocking-wizard/Kconfig
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Xilinx Clocking Wizard Driver
-#
-
-config COMMON_CLK_XLNX_CLKWZRD
-	tristate "Xilinx Clocking Wizard"
-	depends on COMMON_CLK && OF
-	help
-	  Support for the Xilinx Clocking Wizard IP core clock generator.
diff --git a/drivers/staging/clocking-wizard/Makefile b/drivers/staging/clocking-wizard/Makefile
deleted file mode 100644
index b1f9152..0000000
--- a/drivers/staging/clocking-wizard/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clk-xlnx-clock-wizard.o
diff --git a/drivers/staging/clocking-wizard/TODO b/drivers/staging/clocking-wizard/TODO
deleted file mode 100644
index ebe99db..0000000
--- a/drivers/staging/clocking-wizard/TODO
+++ /dev/null
@@ -1,12 +0,0 @@
-TODO:
-	- support for fractional multiplier
-	- support for fractional divider (output 0 only)
-	- support for set_rate() operations (may benefit from Stephen Boyd's
-	  refactoring of the clk primitives: https://lkml.org/lkml/2014/9/5/766)
-	- review arithmetic
-	  - overflow after multiplication?
-	  - maximize accuracy before divisions
-
-Patches to:
-	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-	Sören Brinkmann <soren.brinkmann@xilinx.com>
diff --git a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c b/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
deleted file mode 100644
index 15b7a82..0000000
--- a/drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
+++ /dev/null
@@ -1,335 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Xilinx 'Clocking Wizard' driver
- *
- *  Copyright (C) 2013 - 2014 Xilinx
- *
- *  Sören Brinkmann <soren.brinkmann@xilinx.com>
- */
-
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/module.h>
-#include <linux/err.h>
-
-#define WZRD_NUM_OUTPUTS	7
-#define WZRD_ACLK_MAX_FREQ	250000000UL
-
-#define WZRD_CLK_CFG_REG(n)	(0x200 + 4 * (n))
-
-#define WZRD_CLKOUT0_FRAC_EN	BIT(18)
-#define WZRD_CLKFBOUT_FRAC_EN	BIT(26)
-
-#define WZRD_CLKFBOUT_MULT_SHIFT	8
-#define WZRD_CLKFBOUT_MULT_MASK		(0xff << WZRD_CLKFBOUT_MULT_SHIFT)
-#define WZRD_DIVCLK_DIVIDE_SHIFT	0
-#define WZRD_DIVCLK_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
-#define WZRD_CLKOUT_DIVIDE_SHIFT	0
-#define WZRD_CLKOUT_DIVIDE_MASK		(0xff << WZRD_DIVCLK_DIVIDE_SHIFT)
-
-enum clk_wzrd_int_clks {
-	wzrd_clk_mul,
-	wzrd_clk_mul_div,
-	wzrd_clk_int_max
-};
-
-/**
- * struct clk_wzrd:
- * @clk_data:		Clock data
- * @nb:			Notifier block
- * @base:		Memory base
- * @clk_in1:		Handle to input clock 'clk_in1'
- * @axi_clk:		Handle to input clock 's_axi_aclk'
- * @clks_internal:	Internal clocks
- * @clkout:		Output clocks
- * @speed_grade:	Speed grade of the device
- * @suspended:		Flag indicating power state of the device
- */
-struct clk_wzrd {
-	struct clk_onecell_data clk_data;
-	struct notifier_block nb;
-	void __iomem *base;
-	struct clk *clk_in1;
-	struct clk *axi_clk;
-	struct clk *clks_internal[wzrd_clk_int_max];
-	struct clk *clkout[WZRD_NUM_OUTPUTS];
-	unsigned int speed_grade;
-	bool suspended;
-};
-
-#define to_clk_wzrd(_nb) container_of(_nb, struct clk_wzrd, nb)
-
-/* maximum frequencies for input/output clocks per speed grade */
-static const unsigned long clk_wzrd_max_freq[] = {
-	800000000UL,
-	933000000UL,
-	1066000000UL
-};
-
-static int clk_wzrd_clk_notifier(struct notifier_block *nb, unsigned long event,
-				 void *data)
-{
-	unsigned long max;
-	struct clk_notifier_data *ndata = data;
-	struct clk_wzrd *clk_wzrd = to_clk_wzrd(nb);
-
-	if (clk_wzrd->suspended)
-		return NOTIFY_OK;
-
-	if (ndata->clk == clk_wzrd->clk_in1)
-		max = clk_wzrd_max_freq[clk_wzrd->speed_grade - 1];
-	else if (ndata->clk == clk_wzrd->axi_clk)
-		max = WZRD_ACLK_MAX_FREQ;
-	else
-		return NOTIFY_DONE;	/* should never happen */
-
-	switch (event) {
-	case PRE_RATE_CHANGE:
-		if (ndata->new_rate > max)
-			return NOTIFY_BAD;
-		return NOTIFY_OK;
-	case POST_RATE_CHANGE:
-	case ABORT_RATE_CHANGE:
-	default:
-		return NOTIFY_DONE;
-	}
-}
-
-static int __maybe_unused clk_wzrd_suspend(struct device *dev)
-{
-	struct clk_wzrd *clk_wzrd = dev_get_drvdata(dev);
-
-	clk_disable_unprepare(clk_wzrd->axi_clk);
-	clk_wzrd->suspended = true;
-
-	return 0;
-}
-
-static int __maybe_unused clk_wzrd_resume(struct device *dev)
-{
-	int ret;
-	struct clk_wzrd *clk_wzrd = dev_get_drvdata(dev);
-
-	ret = clk_prepare_enable(clk_wzrd->axi_clk);
-	if (ret) {
-		dev_err(dev, "unable to enable s_axi_aclk\n");
-		return ret;
-	}
-
-	clk_wzrd->suspended = false;
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(clk_wzrd_dev_pm_ops, clk_wzrd_suspend,
-			 clk_wzrd_resume);
-
-static int clk_wzrd_probe(struct platform_device *pdev)
-{
-	int i, ret;
-	u32 reg;
-	unsigned long rate;
-	const char *clk_name;
-	struct clk_wzrd *clk_wzrd;
-	struct resource *mem;
-	struct device_node *np = pdev->dev.of_node;
-
-	clk_wzrd = devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
-	if (!clk_wzrd)
-		return -ENOMEM;
-	platform_set_drvdata(pdev, clk_wzrd);
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	clk_wzrd->base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(clk_wzrd->base))
-		return PTR_ERR(clk_wzrd->base);
-
-	ret = of_property_read_u32(np, "speed-grade", &clk_wzrd->speed_grade);
-	if (!ret) {
-		if (clk_wzrd->speed_grade < 1 || clk_wzrd->speed_grade > 3) {
-			dev_warn(&pdev->dev, "invalid speed grade '%d'\n",
-				 clk_wzrd->speed_grade);
-			clk_wzrd->speed_grade = 0;
-		}
-	}
-
-	clk_wzrd->clk_in1 = devm_clk_get(&pdev->dev, "clk_in1");
-	if (IS_ERR(clk_wzrd->clk_in1)) {
-		if (clk_wzrd->clk_in1 != ERR_PTR(-EPROBE_DEFER))
-			dev_err(&pdev->dev, "clk_in1 not found\n");
-		return PTR_ERR(clk_wzrd->clk_in1);
-	}
-
-	clk_wzrd->axi_clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
-	if (IS_ERR(clk_wzrd->axi_clk)) {
-		if (clk_wzrd->axi_clk != ERR_PTR(-EPROBE_DEFER))
-			dev_err(&pdev->dev, "s_axi_aclk not found\n");
-		return PTR_ERR(clk_wzrd->axi_clk);
-	}
-	ret = clk_prepare_enable(clk_wzrd->axi_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "enabling s_axi_aclk failed\n");
-		return ret;
-	}
-	rate = clk_get_rate(clk_wzrd->axi_clk);
-	if (rate > WZRD_ACLK_MAX_FREQ) {
-		dev_err(&pdev->dev, "s_axi_aclk frequency (%lu) too high\n",
-			rate);
-		ret = -EINVAL;
-		goto err_disable_clk;
-	}
-
-	/* we don't support fractional div/mul yet */
-	reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-		    WZRD_CLKFBOUT_FRAC_EN;
-	reg |= readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2)) &
-		     WZRD_CLKOUT0_FRAC_EN;
-	if (reg)
-		dev_warn(&pdev->dev, "fractional div/mul not supported\n");
-
-	/* register multiplier */
-	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-		     WZRD_CLKFBOUT_MULT_MASK) >> WZRD_CLKFBOUT_MULT_SHIFT;
-	clk_name = kasprintf(GFP_KERNEL, "%s_mul", dev_name(&pdev->dev));
-	if (!clk_name) {
-		ret = -ENOMEM;
-		goto err_disable_clk;
-	}
-	clk_wzrd->clks_internal[wzrd_clk_mul] = clk_register_fixed_factor
-			(&pdev->dev, clk_name,
-			 __clk_get_name(clk_wzrd->clk_in1),
-			 0, reg, 1);
-	kfree(clk_name);
-	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul])) {
-		dev_err(&pdev->dev, "unable to register fixed-factor clock\n");
-		ret = PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul]);
-		goto err_disable_clk;
-	}
-
-	/* register div */
-	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-			WZRD_DIVCLK_DIVIDE_MASK) >> WZRD_DIVCLK_DIVIDE_SHIFT;
-	clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
-	if (!clk_name) {
-		ret = -ENOMEM;
-		goto err_rm_int_clk;
-	}
-
-	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_fixed_factor
-			(&pdev->dev, clk_name,
-			 __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
-			 0, 1, reg);
-	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
-		dev_err(&pdev->dev, "unable to register divider clock\n");
-		ret = PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
-		goto err_rm_int_clk;
-	}
-
-	/* register div per output */
-	for (i = WZRD_NUM_OUTPUTS - 1; i >= 0 ; i--) {
-		const char *clkout_name;
-
-		if (of_property_read_string_index(np, "clock-output-names", i,
-						  &clkout_name)) {
-			dev_err(&pdev->dev,
-				"clock output name not specified\n");
-			ret = -EINVAL;
-			goto err_rm_int_clks;
-		}
-		reg = readl(clk_wzrd->base + WZRD_CLK_CFG_REG(2) + i * 12);
-		reg &= WZRD_CLKOUT_DIVIDE_MASK;
-		reg >>= WZRD_CLKOUT_DIVIDE_SHIFT;
-		clk_wzrd->clkout[i] = clk_register_fixed_factor
-			(&pdev->dev, clkout_name, clk_name, 0, 1, reg);
-		if (IS_ERR(clk_wzrd->clkout[i])) {
-			int j;
-
-			for (j = i + 1; j < WZRD_NUM_OUTPUTS; j++)
-				clk_unregister(clk_wzrd->clkout[j]);
-			dev_err(&pdev->dev,
-				"unable to register divider clock\n");
-			ret = PTR_ERR(clk_wzrd->clkout[i]);
-			goto err_rm_int_clks;
-		}
-	}
-
-	kfree(clk_name);
-
-	clk_wzrd->clk_data.clks = clk_wzrd->clkout;
-	clk_wzrd->clk_data.clk_num = ARRAY_SIZE(clk_wzrd->clkout);
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_wzrd->clk_data);
-
-	if (clk_wzrd->speed_grade) {
-		clk_wzrd->nb.notifier_call = clk_wzrd_clk_notifier;
-
-		ret = clk_notifier_register(clk_wzrd->clk_in1,
-					    &clk_wzrd->nb);
-		if (ret)
-			dev_warn(&pdev->dev,
-				 "unable to register clock notifier\n");
-
-		ret = clk_notifier_register(clk_wzrd->axi_clk, &clk_wzrd->nb);
-		if (ret)
-			dev_warn(&pdev->dev,
-				 "unable to register clock notifier\n");
-	}
-
-	return 0;
-
-err_rm_int_clks:
-	clk_unregister(clk_wzrd->clks_internal[1]);
-err_rm_int_clk:
-	kfree(clk_name);
-	clk_unregister(clk_wzrd->clks_internal[0]);
-err_disable_clk:
-	clk_disable_unprepare(clk_wzrd->axi_clk);
-
-	return ret;
-}
-
-static int clk_wzrd_remove(struct platform_device *pdev)
-{
-	int i;
-	struct clk_wzrd *clk_wzrd = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	for (i = 0; i < WZRD_NUM_OUTPUTS; i++)
-		clk_unregister(clk_wzrd->clkout[i]);
-	for (i = 0; i < wzrd_clk_int_max; i++)
-		clk_unregister(clk_wzrd->clks_internal[i]);
-
-	if (clk_wzrd->speed_grade) {
-		clk_notifier_unregister(clk_wzrd->axi_clk, &clk_wzrd->nb);
-		clk_notifier_unregister(clk_wzrd->clk_in1, &clk_wzrd->nb);
-	}
-
-	clk_disable_unprepare(clk_wzrd->axi_clk);
-
-	return 0;
-}
-
-static const struct of_device_id clk_wzrd_ids[] = {
-	{ .compatible = "xlnx,clocking-wizard" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, clk_wzrd_ids);
-
-static struct platform_driver clk_wzrd_driver = {
-	.driver = {
-		.name = "clk-wizard",
-		.of_match_table = clk_wzrd_ids,
-		.pm = &clk_wzrd_dev_pm_ops,
-	},
-	.probe = clk_wzrd_probe,
-	.remove = clk_wzrd_remove,
-};
-module_platform_driver(clk_wzrd_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann@xilinx.com");
-MODULE_DESCRIPTION("Driver for the Xilinx Clocking Wizard IP core");
diff --git a/drivers/staging/clocking-wizard/dt-binding.txt b/drivers/staging/clocking-wizard/dt-binding.txt
deleted file mode 100644
index 723271e..0000000
--- a/drivers/staging/clocking-wizard/dt-binding.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Binding for Xilinx Clocking Wizard IP Core
-
-This binding uses the common clock binding[1]. Details about the devices can be
-found in the product guide[2].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Clocking Wizard Product Guide
-http://www.xilinx.com/support/documentation/ip_documentation/clk_wiz/v5_1/pg065-clk-wiz.pdf
-
-Required properties:
- - compatible: Must be 'xlnx,clocking-wizard'
- - reg: Base and size of the cores register space
- - clocks: Handle to input clock
- - clock-names: Tuple containing 'clk_in1' and 's_axi_aclk'
- - clock-output-names: Names for the output clocks
-
-Optional properties:
- - speed-grade: Speed grade of the device (valid values are 1..3)
-
-Example:
-	clock-generator@40040000 {
-		reg = <0x40040000 0x1000>;
-		compatible = "xlnx,clocking-wizard";
-		speed-grade = <1>;
-		clock-names = "clk_in1", "s_axi_aclk";
-		clocks = <&clkc 15>, <&clkc 15>;
-		clock-output-names = "clk_out0", "clk_out1", "clk_out2",
-				     "clk_out3", "clk_out4", "clk_out5",
-				     "clk_out6", "clk_out7";
-	};
-- 
2.1.1

