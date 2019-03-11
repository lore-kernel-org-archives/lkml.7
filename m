Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594A82087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfCKNYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8ysi-1h66nd0sHW-0065oz for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 088/114] drivers: irqchip: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:40 +0100
Message-Id: <1552310346-7629-89-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:izFnSWKW5Fl5xyJWegRlQ0UQxYVWbLywyoiMjxJDw64ZN/hs15a
 u+iPh7jVw8x4nsCMhAXlw6/AWHU54rEIMEcqkgXvU47+q06+VSqWcL3jEIVKE71KdHV3APz
 Bnqb9YXcaCB3GD3uI6JSx5iBC2s8JQfH1+vfqjuv+WRrTxWpxwn7ffVgMI76KdE7FTLEmCF
 7yUYMhKDtP4MKjfzXM8QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nhYAlfBmieQ=:H3fPckh85zpWyMwsxwLFuH
 ZxTW8ZmIw6BzN+ROfJyPfBuVq0HpkqUgOd1S3tHsu+0c1kz4dpd+zs3SZ34uIsf3uL4DtSN3d
 67PhlI4viEfSnt0fu91LnzSFF6jcenHzhj0SdiqPx6/Kspg9WPZ+WyspSD1RY7JOhNhvpH7QE
 RN5MIZtoXDeQZ2XifOrc3yhqZJsnTdAiDjh/uJ7VoTqdDeNfd8gDvkyWEPnaVWOyVUR2MnJWJ
 CG+SDEZFNa5A9m974Z27W17jx2nsCUhUE+oFDbeLoriH/jlTKRdXS2D0QJxMlF7Qz+w+LzT9k
 0G1LHfZ1KRYMnsiWxOJESsk6IH3a1WcdcEsPr1hUfQW5Uj5SWwujzmQ01edbOehFSrvEbdKxJ
 EThaFN16Qn6zxddV3xa/eRghejZMNPk+dENV/RdXFaE8PQxLVcxFQcfcqKtC5crIBy3rvN8Yd
 gyqhtLPng+F/j6z7RQXO0jLTybiOpMO22qs6BNXVRsfl1Wu2rjeRxSXH3VgcUdew8uoI8Wxgm
 BKi84yVheflc3GGWzaSw6RiVdsLzx4K3xah0zWErNyNH9aidAc27YPMGiLr0zjf29hDxmphDY
 sgZaCDwC2o7UAniCQXtG0hNCHkFPOPtQ/7gYuVmDIokXLzgA51hjXAKTlgtDP81SMx+T8QAkY
 BMPH4EnzbuImJPB9jxY22ItXzqmpgkW3Xf0qZrQ1Ykok+++JZnVtLLb3U11/YXstYBSxrSmwi
 nyQshvO8TGaPeWW8asunbTQjE5kbiZHlzvsXEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/irqchip/Kconfig | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5438abb..134c7c8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -251,9 +251,9 @@ config VERSATILE_FPGA_IRQ
 	select IRQ_DOMAIN
 
 config VERSATILE_FPGA_IRQ_NR
-       int
-       default 4
-       depends on VERSATILE_FPGA_IRQ
+	int
+	default 4
+	depends on VERSATILE_FPGA_IRQ
 
 config XTENSA_MX
 	bool
@@ -276,8 +276,8 @@ config KEYSTONE_IRQ
 	tristate "Keystone 2 IRQ controller IP"
 	depends on ARCH_KEYSTONE
 	help
-		Support for Texas Instruments Keystone 2 IRQ controller IP which
-		is part of the Keystone 2 IPC mechanism
+	  Support for Texas Instruments Keystone 2 IRQ controller IP which
+	  is part of the Keystone 2 IPC mechanism
 
 config MIPS_GIC
 	bool
@@ -291,11 +291,11 @@ config INGENIC_IRQ
 	default y
 
 config RENESAS_H8300H_INTC
-        bool
+	bool
 	select IRQ_DOMAIN
 
 config RENESAS_H8S_INTC
-        bool
+	bool
 	select IRQ_DOMAIN
 
 config IMX_GPCV2
@@ -328,7 +328,7 @@ config MVEBU_PIC
 	bool
 
 config MVEBU_SEI
-        bool
+	bool
 
 config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
@@ -367,20 +367,20 @@ config IRQ_UNIPHIER_AIDET
 	  Support for the UniPhier AIDET (ARM Interrupt Detector).
 
 config MESON_IRQ_GPIO
-       bool "Meson GPIO Interrupt Multiplexer"
-       depends on ARCH_MESON
-       select IRQ_DOMAIN
-       select IRQ_DOMAIN_HIERARCHY
-       help
-         Support Meson SoC Family GPIO Interrupt Multiplexer
+	bool "Meson GPIO Interrupt Multiplexer"
+	depends on ARCH_MESON
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support Meson SoC Family GPIO Interrupt Multiplexer
 
 config GOLDFISH_PIC
-       bool "Goldfish programmable interrupt controller"
-       depends on MIPS && (GOLDFISH || COMPILE_TEST)
-       select IRQ_DOMAIN
-       help
-         Say yes here to enable Goldfish interrupt controller driver used
-         for Goldfish based virtual platforms.
+	bool "Goldfish programmable interrupt controller"
+	depends on MIPS && (GOLDFISH || COMPILE_TEST)
+	select IRQ_DOMAIN
+	help
+	  Say yes here to enable Goldfish interrupt controller driver used
+	  for Goldfish based virtual platforms.
 
 config QCOM_PDC
 	bool "QCOM PDC"
@@ -431,10 +431,10 @@ config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
 	help
-	   This enables support for the PLIC chip found in SiFive (and
-	   potentially other) RISC-V systems.  The PLIC controls devices
-	   interrupts and connects them to each core's local interrupt
-	   controller.  Aside from timer and software interrupts, all other
-	   interrupt sources are subordinate to the PLIC.
+	  This enables support for the PLIC chip found in SiFive (and
+	  potentially other) RISC-V systems.  The PLIC controls devices
+	  interrupts and connects them to each core's local interrupt
+	  controller.  Aside from timer and software interrupts, all other
+	  interrupt sources are subordinate to the PLIC.
 
-	   If you don't know what to do here, say Y.
+	  If you don't know what to do here, say Y.
-- 
1.9.1

