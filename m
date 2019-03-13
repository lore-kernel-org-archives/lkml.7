Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1354BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE7C2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfCMM2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:28:17 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:62474 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMM2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:28:14 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2019 08:28:14 EDT
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="29869052"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with SMTP; 13 Mar 2019 20:18:24 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(51793:0:AUTH_RELAY)
        (envelope-from <kt.liao@emc.com.tw>); Wed, 13 Mar 2019 20:18:25 +0800 (CST)
Received: from 192.168.33.46
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(134705:2:AUTH_LOGIN)
        (envelope-from <kt.liao@emc.com.tw>); Wed, 13 Mar 2019 20:18:22 +0800 (CST)
From:   KT Liao <kt.liao@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     kt.liao@emc.com.tw
Subject: [PATCH] Input: elan_i2c - Add many hardware ID for lenovo laptop
Date:   Wed, 13 Mar 2019 20:17:43 +0800
Message-Id: <1552479463-3686-1-git-send-email-kt.liao@emc.com.tw>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many Lenovo laptop which need elan_i2c support.
Elan collects the list ands add to add to elan_acpi_id[]

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index a94b649..f9525d6 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1337,21 +1337,48 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
+	{ "ELAN0601", 0 },
 	{ "ELAN0602", 0 },
+	{ "ELAN0603", 0 },
+	{ "ELAN0604", 0 },
 	{ "ELAN0605", 0 },
+	{ "ELAN0606", 0 },
+	{ "ELAN0607", 0 },
 	{ "ELAN0608", 0 },
 	{ "ELAN0609", 0 },
 	{ "ELAN060B", 0 },
 	{ "ELAN060C", 0 },
+	{ "ELAN060F", 0 },
+	{ "ELAN0610", 0 },
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
+	{ "ELAN0615", 0 },
+	{ "ELAN0616", 0 },
+	{ "ELAN0617", 0 },
 	{ "ELAN0618", 0 },
+	{ "ELAN0619", 0 },
+	{ "ELAN061A", 0 },
+	{ "ELAN061B", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },
+	{ "ELAN061F", 0 },
 	{ "ELAN0620", 0 },
 	{ "ELAN0621", 0 },
 	{ "ELAN0622", 0 },
+	{ "ELAN0623", 0 },
+	{ "ELAN0624", 0 },
+	{ "ELAN0625", 0 },
+	{ "ELAN0626", 0 },
+	{ "ELAN0627", 0 },
+	{ "ELAN0628", 0 },
+	{ "ELAN0629", 0 },
+	{ "ELAN062A", 0 },
+	{ "ELAN062B", 0 },
+	{ "ELAN062C", 0 },
+	{ "ELAN062D", 0 },
+	{ "ELAN0631", 0 },
+	{ "ELAN0632", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };
-- 
2.7.4

