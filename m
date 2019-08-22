Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE48EC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECC6233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfHVJec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:34:32 -0400
Received: from shell.v3.sk ([90.176.6.54]:35956 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387446AbfHVJe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:34:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 40298D7556;
        Thu, 22 Aug 2019 11:34:26 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zsL6hMHcVi52; Thu, 22 Aug 2019 11:34:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DE273D755E;
        Thu, 22 Aug 2019 11:33:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ihugTon7VsWS; Thu, 22 Aug 2019 11:33:05 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 36A7B57D64;
        Thu, 22 Aug 2019 11:31:45 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] clk: remove extra ---help--- tags in Kconfig
Date:   Thu, 22 Aug 2019 11:31:26 +0200
Message-Id: <20190822093126.594013-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes an extraneous "---help---" follows "help". That is probably a
copy&paste error stemming from their inconsistent use. Remove those.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 801fa1cd03217..c44247d0b83e8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -116,7 +116,6 @@ config COMMON_CLK_SI514
 	depends on OF
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports the Silicon Labs 514 programmable clock
 	  generator.
=20
@@ -125,7 +124,6 @@ config COMMON_CLK_SI544
 	depends on I2C
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports the Silicon Labs 544 programmable clock
 	  generator.
=20
@@ -135,7 +133,6 @@ config COMMON_CLK_SI570
 	depends on OF
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports Silicon Labs 570/571/598/599 programmable
 	  clock generators.
=20
@@ -153,7 +150,6 @@ config COMMON_CLK_CDCE925
 	depends on OF
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports the TI CDCE913/925/937/949 programmable clock
 	  synthesizer. Each chip has different number of PLLs and outputs.
 	  For example, the CDCE925 contains two PLLs with spread-spectrum
@@ -212,7 +208,6 @@ config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
 	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
 	help
-	---help---
 	  Support for the Analog Devices axi-clkgen pcore clock generator for X=
ilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
=20
@@ -279,26 +274,22 @@ config COMMON_CLK_VC5
 	depends on OF
 	select REGMAP_I2C
 	help
-	---help---
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
=20
 config COMMON_CLK_STM32MP157
 	def_bool COMMON_CLK && MACH_STM32MP157
 	help
-	---help---
 	  Support for stm32mp157 SoC family clocks
=20
 config COMMON_CLK_STM32F
 	def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F=
746)
 	help
-	---help---
 	  Support for stm32f4 and stm32f7 SoC families clocks
=20
 config COMMON_CLK_STM32H7
 	def_bool COMMON_CLK && MACH_STM32H743
 	help
-	---help---
 	  Support for stm32h7 SoC family clocks
=20
 config COMMON_CLK_BD718XX
--=20
2.21.0

