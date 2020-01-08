Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7DC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598BE20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578499140;
	bh=rBa+H4m2gw7F7r1zF/Fr0VPqeyKfeHcuYUPRBzde970=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=VnpEICrtaoiRlpUZ7pKUhTnWMQoDVmtl1QVZPLsDPBRgJdqzaAF/bqYIQ/cbsFsmF
	 DOgSSXlHaCJFA+m4lJlazD3+TUAql5nskxj6oUo/ASHYXuX+HHNVwQRPTSJuVmm+2N
	 JA829nTpJDSw3Ei9MS6wbjsp7J5JJe2UV863UVM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAHP67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:58:59 -0500
Received: from foss.arm.com ([217.140.110.172]:46626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbgAHP65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:58:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B61B7106F;
        Wed,  8 Jan 2020 07:58:56 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F7A23F534;
        Wed,  8 Jan 2020 07:58:56 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:58:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: mp8859: add config option and build entry" to the regulator tree
In-Reply-To: <20200106211633.2882-3-m.reichl@fivetechno.de>
Message-Id: <applied-20200106211633.2882-3-m.reichl@fivetechno.de>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mp8859: add config option and build entry

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From c66f1cbad53a61f00f8b6273e737d5e560b69ec7 Mon Sep 17 00:00:00 2001
From: Markus Reichl <m.reichl@fivetechno.de>
Date: Mon, 6 Jan 2020 22:16:25 +0100
Subject: [PATCH] regulator: mp8859: add config option and build entry

Add entries for the mp8859 regulator driver
to the build system.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
Link: https://lore.kernel.org/r/20200106211633.2882-3-m.reichl@fivetechno.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig  | 11 +++++++++++
 drivers/regulator/Makefile |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 56512748a47d..593733a88a61 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -612,6 +612,17 @@ config REGULATOR_MCP16502
 	  through the regulator interface. In addition it enables
 	  suspend-to-ram/standby transition.
 
+config REGULATOR_MP8859
+	tristate "MPS MP8859 regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say y here to support the MP8859 voltage regulator. This driver
+	  supports basic operations (get/set voltage) through the regulator
+	  interface.
+	  Say M here if you want to include support for the regulator as a
+	  module. The module will be named "mp8859".
+
 config REGULATOR_MT6311
 	tristate "MediaTek MT6311 PMIC"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 9eccf93bc3ab..8ba8e5deebbd 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
 obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
 obj-$(CONFIG_REGULATOR_MCP16502) += mcp16502.o
+obj-$(CONFIG_REGULATOR_MP8859) += mp8859.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
-- 
2.20.1

