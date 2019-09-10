Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEC8C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658DD21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfIJUJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 16:09:15 -0400
Received: from cyberdimension.org ([80.67.179.20]:40988 "EHLO
        gnutoo.cyberdimension.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfIJUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:09:15 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 16:09:14 EDT
Received: from gnutoo.cyberdimension.org (localhost [127.0.0.1])
        by cyberdimension.org (OpenSMTPD) with ESMTP id b7f2586b;
        Tue, 10 Sep 2019 19:59:28 +0000 (UTC)
Received: from primarylaptop.localdomain (localhost.localdomain [IPv6:::1])
        by gnutoo.cyberdimension.org (OpenSMTPD) with ESMTP id 311edd07;
        Tue, 10 Sep 2019 19:59:28 +0000 (UTC)
From:   Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
To:     Chanwoo@gnutoo.cyberdimension.org, Choi@gnutoo.cyberdimension.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>,
        Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Subject: [PATCH 1/2] mfd: max77693: Add defines for charger current control
Date:   Tue, 10 Sep 2019 22:02:32 +0200
Message-Id: <20190910200233.3195-1-GNUtoo@cyberdimension.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>

This prepares for an updated regulator and charger driver. The defines
are needed to set the maximum input current and the fast charge
current.

Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
GNUtoo@cyberdimension.org: small fix
Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
---
 include/linux/mfd/max77693-private.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index e798c81aec31..1853f8602f65 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -217,6 +217,9 @@ enum max77693_charger_battery_state {
 #define CHG_CNFG_01_CHGRSTRT_MASK	(0x3 << CHG_CNFG_01_CHGRSTRT_SHIFT)
 #define CHG_CNFG_01_PQEN_MAKS		BIT(CHG_CNFG_01_PQEN_SHIFT)
 
+/* MAX77693_CHG_REG_CHG_CNFG_02 register */
+#define CHG_CNFG_02_CC_MASK		0x3F
+
 /* MAX77693_CHG_REG_CHG_CNFG_03 register */
 #define CHG_CNFG_03_TOITH_SHIFT		0
 #define CHG_CNFG_03_TOTIME_SHIFT	3
@@ -245,6 +248,10 @@ enum max77693_charger_battery_state {
 
 /* MAX77693 CHG_CNFG_09 Register */
 #define CHG_CNFG_09_CHGIN_ILIM_MASK	0x7F
+#define CHG_CNFG_09_CHGIN_ILIM_500_MAX	500000
+#define CHG_CNFG_09_CHGIN_ILIM_500_MIN	470000
+#define CHG_CNFG_09_CHGIN_ILIM_0_MAX	60000
+#define CHG_CNFG_09_CHGIN_ILIM_0_MIN	0
 
 /* MAX77693 CHG_CTRL Register */
 #define SAFEOUT_CTRL_SAFEOUT1_MASK	0x3
-- 
2.23.0

