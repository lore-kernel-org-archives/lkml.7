Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64C7224D0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257296;
	bh=5/qBU4WAlBhwNFmtfGSZNUkNgRIO1tzY+4rNWZNXFlU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HucWR2YjpVvJz8yDV8tAtMHWf4G9GxXbzPT+Q40JSvliW+zeONDKnrxjndAvCcDDa
	 MQB07Q1CsJFrO06qvU0aAcvEgp1d7cDZIeLUYQxDNKzKxlJVobxrDDqgswJOi/3fOf
	 +9M71SbWqSWugvHufj3m87cOpdf/RA7hlPlw29cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfKTNle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfKTNl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:29 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D98CB224FC;
        Wed, 20 Nov 2019 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257289;
        bh=5/qBU4WAlBhwNFmtfGSZNUkNgRIO1tzY+4rNWZNXFlU=;
        h=From:To:Cc:Subject:Date:From;
        b=A66G7h0CXBbVl9BumkM7+5rdfL/P6XUu7cciYW2IXc7EZTnQdXS3P5CLAKgzy7gDN
         TLKZn5lmMsTSTpNgXtPVL2pwFs3fYyCMDyW4qlurRd0WIhYnwrXNR6UvtZBYxGQ4WR
         4uu1+6Yjwlxp6RXV+/tTZF6nc+KY+smWR+88tJ7o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:25 +0800
Message-Id: <20191120134125.15069-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/irqchip/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 697e6a8ccaae..98042637e8ad 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -328,7 +328,7 @@ config INGENIC_TCU_IRQ
 	  If unsure, say N.
 
 config RENESAS_H8300H_INTC
-        bool
+	bool
 	select IRQ_DOMAIN
 
 config RENESAS_H8S_INTC
@@ -368,7 +368,7 @@ config MVEBU_PIC
 	bool
 
 config MVEBU_SEI
-        bool
+	bool
 
 config LS_EXTIRQ
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
@@ -414,15 +414,15 @@ config MESON_IRQ_GPIO
        depends on ARCH_MESON
        select IRQ_DOMAIN_HIERARCHY
        help
-         Support Meson SoC Family GPIO Interrupt Multiplexer
+	 Support Meson SoC Family GPIO Interrupt Multiplexer
 
 config GOLDFISH_PIC
        bool "Goldfish programmable interrupt controller"
        depends on MIPS && (GOLDFISH || COMPILE_TEST)
        select IRQ_DOMAIN
        help
-         Say yes here to enable Goldfish interrupt controller driver used
-         for Goldfish based virtual platforms.
+	 Say yes here to enable Goldfish interrupt controller driver used
+	 for Goldfish based virtual platforms.
 
 config QCOM_PDC
 	bool "QCOM PDC"
-- 
2.17.1

