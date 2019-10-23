Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DDACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889FC21920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404207AbfJWKNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:13:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390935AbfJWKNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CD3FB514;
        Wed, 23 Oct 2019 10:13:29 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 04/11] reset: simple: Add Realtek RTD1195/RTD1295
Date:   Wed, 23 Oct 2019 12:13:10 +0200
Message-Id: <20191023101317.26656-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191023101317.26656-1-afaerber@suse.de>
References: <20191023101317.26656-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable RESET_SIMPLE for ARCH_REALTEK.
They can reuse the DesignWare bindings to avoid a new compatible.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Instead of adding a new driver, reuse reset-simple (Philipp)
 
 drivers/reset/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index fac356a9b818..3ad7817ce1f0 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -129,7 +129,7 @@ config RESET_SCMI
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
+	default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
@@ -139,6 +139,7 @@ config RESET_SIMPLE
 	   - Altera SoCFPGAs
 	   - ASPEED BMC SoCs
 	   - Bitmain BM1880 SoC
+	   - Realtek SoCs
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
-- 
2.16.4

