Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F2C00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B47D20863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfCBNrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 08:47:48 -0500
Received: from sauhun.de ([88.99.104.3]:36264 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfCBNrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 08:47:46 -0500
Received: from localhost (p54B33179.dip0.t-ipconnect.de [84.179.49.121])
        by pokefinder.org (Postfix) with ESMTPSA id C28BE4A1773;
        Sat,  2 Mar 2019 14:47:43 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 1/7] i2c: apply coding style for struct i2c_adapter
Date:   Sat,  2 Mar 2019 14:47:29 +0100
Message-Id: <20190302134735.4393-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/i2c.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 383510b4f083..758a6db864c9 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -517,20 +517,23 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * Documentation file Documentation/i2c/fault-codes.
  */
 struct i2c_algorithm {
-	/* If an adapter algorithm can't do I2C-level access, set master_xfer
-	   to NULL. If an adapter algorithm can do SMBus access, set
-	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
-	   using common I2C messages */
-	/* master_xfer should return the number of messages successfully
-	   processed, or a negative value on error */
+	/*
+	 * If an adapter algorithm can't do I2C-level access, set master_xfer
+	 * to NULL. If an adapter algorithm can do SMBus access, set
+	 * smbus_xfer. If set to NULL, the SMBus protocol is simulated
+	 * using common I2C messages.
+	 *
+	 * master_xfer should return the number of messages successfully
+	 * processed, or a negative value on error
+	 */
 	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			   int num);
-	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,
-			   unsigned short flags, char read_write,
-			   u8 command, int size, union i2c_smbus_data *data);
+	int (*smbus_xfer)(struct i2c_adapter *adap, u16 addr,
+			  unsigned short flags, char read_write,
+			  u8 command, int size, union i2c_smbus_data *data);
 
 	/* To determine what the adapter supports */
-	u32 (*functionality) (struct i2c_adapter *);
+	u32 (*functionality)(struct i2c_adapter *adap);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	int (*reg_slave)(struct i2c_client *client);
-- 
2.11.0

