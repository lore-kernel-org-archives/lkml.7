Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D17C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B213920848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=myself5.de header.i=@myself5.de header.b="yyECSCe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbfCARIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:08:07 -0500
Received: from myself5.de ([5.230.26.43]:41618 "EHLO myself5.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389295AbfCARIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:08:07 -0500
X-Greylist: delayed 1596 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Mar 2019 12:07:55 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=myself5.de; s=mail;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=PYz4NWpts1lRBV35Yfte+ZcwO/FR0chrlrmwXbARq98=;
        b=yyECSCe1ICsYmKgFFspbDUJgviq8fP/v8iR18K9h8RPyedbXMsyTHZy1+TwpCUDK7y94LdCItVf9Sy8F9F3RNXveo0TCTou+1l5kjAerviWGpJfXIoLyzDDCzBLpmShgPsayNLVldGtQghqWSzOEyOuVA0P2rlIXSRXemX4fvvkmYF5Ddd6urPc3UJudY3nzpU4PCL8gUGeywU9RAKIAxBkAaCS1KnRIBcMUZo7tSkOLcddf4PjsSsMFeflLot7Iv9PB1a76NnxbG/iRa50b82qmgBSIXQbFpDYfQPDc1fO+W6rHHvnLiT9zeCmT92A+MkPy9/jxIX5NW+DvkEBHjQ==;
Received: from hsi-kbw-085-216-078-008.hsi.kabelbw.de ([85.216.78.8] helo=M5MacBookPro.fritz.box)
        by myself5.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <me@myself5.de>)
        id 1gzlDV-0005y9-ME; Fri, 01 Mar 2019 17:41:07 +0100
From:   me@myself5.de
Cc:     Christian Oder <me@myself5.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the CHUWI Hi10 Air tablet
Date:   Fri,  1 Mar 2019 17:40:01 +0100
Message-Id: <20190301164002.6031-1-me@myself5.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Oder <me@myself5.de>

Add  touchscreen info for the CHUWUI Hi10 Air tablet.

Signed-off-by: Christian Oder <me@myself5.de>
---
 drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 167a156e3cc7..2d56ff7c8230 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -72,6 +72,25 @@ static const struct ts_dmi_data chuwi_hi8_pro_data = {
 	.properties	= chuwi_hi8_pro_props,
 };
 
+static const struct property_entry chuwi_hi10_air_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1981),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1271),
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 99),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 9),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_U32("touchscreen-fuzz-x", 5),
+	PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 4),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-hi10-air.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data chuwi_hi10_air_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= chuwi_hi10_air_props,
+};
+
 static const struct property_entry chuwi_vi8_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 6),
@@ -546,6 +565,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
 		},
 	},
+	{
+		/* Chuwi Hi10 Air */
+		.driver_data = (void *)&chuwi_hi10_air_data,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "P1W6_C109D_B"),
+		},
+	},
 	{
 		/* Chuwi Vi8 (CWI506) */
 		.driver_data = (void *)&chuwi_vi8_data,
-- 
2.20.1

