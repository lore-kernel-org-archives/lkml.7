Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664ECC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 11:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362C62146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 11:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfHRLEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 07:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfHRLEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 07:04:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FEAD3086246;
        Sun, 18 Aug 2019 11:04:54 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FD0F8BE35;
        Sun, 18 Aug 2019 11:04:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Hiller <thomas.hiller@gmx.de>
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the Trekstor Primebook C11B 2-in-1
Date:   Sun, 18 Aug 2019 13:04:51 +0200
Message-Id: <20190818110451.20571-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 18 Aug 2019 11:04:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Trekstor Primebook C11B 2-in-1, note the C11B
used the same touchscreen as the regular C11, so we only add a new DMI
match.

Cc: Thomas Hiller <thomas.hiller@gmx.de>
Reported-and-tested-by: Thomas Hiller <thomas.hiller@gmx.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 20a943f519dd..8255273b6972 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -981,6 +981,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Primebook C11"),
 		},
 	},
+	{
+		/* Trekstor Primebook C11B (same touchscreen as the C11) */
+		.driver_data = (void *)&trekstor_primebook_c11_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PRIMEBOOK C11B"),
+		},
+	},
 	{
 		/* Trekstor Primebook C13 */
 		.driver_data = (void *)&trekstor_primebook_c13_data,
-- 
2.23.0.rc2

