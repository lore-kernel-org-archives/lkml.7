Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EBAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C30920657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfCKNVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:21:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfCKNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:44 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZkxd-1hWgBt1XSp-00Wndc for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:42 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 111/114] drivers: mcb: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:19:03 +0100
Message-Id: <1552310346-7629-112-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:kufdwtvauh3WOTZmDCvBTsLL9sGFJyqFHrhNc6mekNElo8AjgoZ
 Lw8ycjLqMbdElAzWHW74vUbpQpNuaOsLnUFapM7gyf58EqTkbcqO9fmVQLSwiJn7cxcyz5h
 0AhzbNEbVLfYuydMlE3kov5TNv6ngHSWKUa7Lqgobo37ZVr3RpAU/HEZ92Qbonn225L0cKv
 Bt9hBfrOSxvKidnD4Ko0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7qq78YANZTw=:GiiP5dNGc7nsJWX2wrZ4pf
 RETak7TBUOZ+Qvqa6PB0lShzMHqZbVv8kaT/G+gA3sCS4+w5DxMr5hmD6vwo1+ae00MBDoUwR
 MjvvQ7z2KbCJC2mc2OhlJPyDPwNMX0t7HdFI+8QzBrIaUwyAPdbs0lNNOFg8Mf7pMjiEJw9Bi
 AJHMJkn/lY4emuWwOeVNaUkCNOh2TgmexnPj/oooXBoRRYGS5Nk3APK7jUmEu17V+Ux0aB9hM
 dSv53JNNN51Ov/3s6hWa7rY8/7HPZ5hm6qofIbs++tod6DtoX1b3jyOWrVmECuUuRUMoytuaN
 0dcXteB1zdPxfrHgg9o0oA/FwmZA/BnYeRzzgYt5X6NhrYicwtjeIMdeOkZ8fXvGKYhirjzV3
 6WzMOe5ah7+r3BbH6NZMrPJ48V3xr6naC9NDq3TFb5pvUBdliC8kkJt19GJqHkQsNDp4vnhKt
 HIwqRHHfgqYgwNgSviutsYP4wieg5KcjM+Vxup8O+in9cU6/9JlkiAeoLClyurUJBPGukzuh0
 zxtdCPT4FLLmu/+o/sqX71DRgqcRb1zdPJ/hSmmlv4zFWaIC/6t7jYYbRkk6bcz27IQyz5Aav
 zL00Wff9qPt5rvIdhpPVtM8lxfSqzrumVTiU48PTa18LlNsgJSirPIUH/QMmTBnvCY9TsbRoj
 dxw/hlBSN1ZKF6yYle5X5Js2OyJoAjr85aB6ijYjOekrkPGNSpdumHnUUQNwa75WNm8Jc27pS
 KTCYMjsL9NqWRLtLd2SxlpBX3ZjVoLMiB6b6mw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/mcb/Kconfig | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/mcb/Kconfig b/drivers/mcb/Kconfig
index 76d9c51..85b4f22 100644
--- a/drivers/mcb/Kconfig
+++ b/drivers/mcb/Kconfig
@@ -3,38 +3,35 @@
 #
 
 menuconfig MCB
-	   tristate "MCB support"
-	   default n
-	   depends on HAS_IOMEM
-	   help
+	tristate "MCB support"
+	default n
+	depends on HAS_IOMEM
+	help
+	  The MCB (MEN Chameleon Bus) is a Bus specific to MEN Mikroelektronik
+	  FPGA based devices. It is used to identify MCB based IP-Cores within
+	  an FPGA and provide the necessary framework for instantiating drivers
+	  for these devices.
 
-	   The MCB (MEN Chameleon Bus) is a Bus specific to MEN Mikroelektronik
-	   FPGA based devices. It is used to identify MCB based IP-Cores within
-	   an FPGA and provide the necessary framework for instantiating drivers
-	   for these devices.
-
-	   If build as a module, the module is called mcb.ko
+	  If build as a module, the module is called mcb.ko
 
 if MCB
 config MCB_PCI
-	   tristate "PCI based MCB carrier"
-	   default n
-	   depends on PCI
-	   help
-
-	   This is a MCB carrier on a PCI device. Both PCI attached on-board
-	   FPGAs as well as CompactPCI attached MCB FPGAs are supported with
-	   this driver.
+	tristate "PCI based MCB carrier"
+	default n
+	depends on PCI
+	help
+	  This is a MCB carrier on a PCI device. Both PCI attached on-board
+	  FPGAs as well as CompactPCI attached MCB FPGAs are supported with
+	  this driver.
 
-	   If build as a module, the module is called mcb-pci.ko
+	  If build as a module, the module is called mcb-pci.ko
 
 config MCB_LPC
-	   tristate "LPC (non PCI) based MCB carrier"
-	   default n
-	   help
-
-	   This is a MCB carrier on a LPC or non PCI device.
+	tristate "LPC (non PCI) based MCB carrier"
+	default n
+	help
+	  This is a MCB carrier on a LPC or non PCI device.
 
-	   If build as a module, the module is called mcb-lpc.ko
+	  If build as a module, the module is called mcb-lpc.ko
 
 endif # MCB
-- 
1.9.1

