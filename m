Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C838CCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A769D222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfJRXRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 19:17:52 -0400
Received: from piie.net ([80.82.223.85]:44836 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbfJRXRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 19:17:51 -0400
Received: from localhost (HSI-KBW-078-043-057-186.hsi4.kabel-badenwuerttemberg.de [78.43.57.186])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id CAB8A161D;
        Sat, 19 Oct 2019 01:11:10 +0200 (CEST)
From:   Peter Kaestle <peter@piie.net>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Peter Feuerer <peter@piie.net>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 1/2] platform/x86: Adding support for Acer Aspire 7551
Date:   Sat, 19 Oct 2019 00:59:35 +0200
Message-Id: <20191018225936.131763-1-peter@piie.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Feuerer <peter@piie.net>

platform/x86: Adding support for Acer Aspire 7551

Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Peter Feuerer <peter@piie.net>

---
 drivers/platform/x86/acerhdf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 5ea8da5f0f70..d40f365d8d7a 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -224,6 +224,8 @@ static const struct bios_settings bios_tbl[] __initconst = {
 	{"Acer", "Aspire 5739G", "V1.3311", 0x55, 0x58, {0x20, 0x00}, 0},
 	/* Acer TravelMate 7730 */
 	{"Acer", "TravelMate 7730G", "v0.3509", 0x55, 0x58, {0xaf, 0x00}, 0},
+	/* Acer Aspire 7551 */
+	{"Acer", "Aspire 7551", "V1.18", 0x93, 0xa8, {0x14, 0x04}, 1},
 	/* Acer TravelMate TM8573T */
 	{"Acer", "TM8573T", "V1.13", 0x93, 0xa8, {0x14, 0x04}, 1},
 	/* Gateway */
@@ -815,6 +817,7 @@ MODULE_ALIAS("dmi:*:*Acer*:pnAspire*5739G:");
 MODULE_ALIAS("dmi:*:*Acer*:pnAspire*One*753:");
 MODULE_ALIAS("dmi:*:*Acer*:pnAspire*5315:");
 MODULE_ALIAS("dmi:*:*Acer*:TravelMate*7730G:");
+MODULE_ALIAS("dmi:*:*Acer*:pnAspire*7551:");
 MODULE_ALIAS("dmi:*:*Acer*:TM8573T:");
 MODULE_ALIAS("dmi:*:*Gateway*:pnAOA*:");
 MODULE_ALIAS("dmi:*:*Gateway*:pnLT31*:");
-- 
2.23.0

