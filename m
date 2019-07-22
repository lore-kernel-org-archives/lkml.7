Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65F2C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850CA20449
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfGVL5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:57:05 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfGVL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:57:05 -0400
Received: from orion.localdomain ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2w0K-1hqdOd3Yho-003PSE for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019
 13:57:03 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] leds: apu: fix error message on probing failure
Date:   Mon, 22 Jul 2019 13:57:02 +0200
Message-Id: <1563796622-16233-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f54bb3f1-2699-1213-f568-b2c529488306@gmail.com>
References: <f54bb3f1-2699-1213-f568-b2c529488306@gmail.com>
X-Provags-ID: V03:K1:g3BRSpT3sGDHfiPAhfiiiVrIU1s7j7HdG9ff3EBy8IsNziaSFlk
 5JznDmpQYycUtW9SHxND8lsux9eRimSsNlx5qBUTXe42cG1JqeViytKf2LpR5yMVJ0t9sgR
 MspkIfthHNoywIyl1tvUfu0ugzrXkP4ilEN85BWayPPRyTAUb3M2FEdsPnx9BAXbTqFZUvO
 QwQWD8Fk/zA1AUrDdZrAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zh43nIgYIcM=:t0GENg7z1zIsbBuHjdX/R1
 7MvPrW0mYN/EyfFsqDLFGiOhEdQcS4VQU6phg3eGeBC4D/teyrtO0qq8G3IGjMIrrkfqESTX0
 ShT+ER4EJVYTxRMMwT5vcB1slmgjXoI2YH+M7i3g9POpqNyMNgQDe/cCwzTH36CZLJgIfsKu6
 cmau0punCJQlLkihiqVeUaitKlBjTnLREAn4CGtfg7rPueHVPVf9z21YZEvJv/H5fEA11EBcp
 k+MD0jqaZUfCGlehkPvlxxyAhyzmQJIB4yudryOZA87lzS1jaIZl2fBlq+xHM3PCobTncEgxG
 X4KlR1VqXXc2/fVzcRckRBJ9AEMEZyZUyRjF6vIuR9oQPDs4Z7QET6YL3Kjx4b3YqNFtvKh2B
 FH96sOhrm7LStLITFhuVaGfb+4ja12rFP8sXi/yp6kbVnrnp5GNuqATFEIcG6fCSHwGVnJPN2
 7/ge936Ptw4uXJUKgoN1fmpRyXoddjG2SYGpSd/bAZogTg5jdhxiaPZQdv4kNywr8NeEQQAxL
 l/cP5c1/eZLs2rJjY6APR7y/cuJMKkPqgDwPymACvc7JPeS5iiOr5YXlQEcqBUn6oH23Z0Vfa
 1VR+p8R7nj+kG6mpdEIQ5KINF00T/7q8PHGEvzjlYe3cQ0vAp1ABy3ckRXOnw6tMDnQoGc8Le
 uk67M3Ic5Qcl/zIcyFG9pTJYk0ynrmc92Rwux1B3BRBOKo6J/HPnnacroMW8nKHSM4sabUypi
 LNnwpzHsQg8XQDip+2zdHcJYI8DJHH89agVuww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

The current error message on failed probing tends to be a bit
misleading. Fix it to tell exactly that an APU v1 was not found.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/leds/leds-apu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-apu.c b/drivers/leds/leds-apu.c
index 451cb9f..d794f49 100644
--- a/drivers/leds/leds-apu.c
+++ b/drivers/leds/leds-apu.c
@@ -170,13 +170,9 @@ static int __init apu_led_init(void)
 	struct platform_device *pdev;
 	int err;
 
-	if (!dmi_match(DMI_SYS_VENDOR, "PC Engines")) {
-		pr_err("No PC Engines board detected\n");
-		return -ENODEV;
-	}
-	if (!(dmi_match(DMI_PRODUCT_NAME, "APU"))) {
-		pr_err("Unknown PC Engines board: %s\n",
-				dmi_get_system_info(DMI_PRODUCT_NAME));
+	if (!(dmi_match(DMI_SYS_VENDOR, "PC Engines") &&
+	      dmi_match(DMI_PRODUCT_NAME, "APU"))) {
+		pr_err("No PC Engines APUv1 board detected. For APUv2,3 support, enable CONFIG_PCENGINES_APU2\n");
 		return -ENODEV;
 	}
 
-- 
1.9.1

