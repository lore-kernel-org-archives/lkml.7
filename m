Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A691BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F10A217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfCNX4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:56:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54462 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCNX4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 19:56:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h4aDD-0007G1-QK; Thu, 14 Mar 2019 23:56:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     Daniele Venzano <venza@brownhat.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: sis900: fix indentation issues, remove some spaces
Date:   Thu, 14 Mar 2019 23:56:35 +0000
Message-Id: <20190314235635.11667-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several statements that contain extra spacing in
the indentation; clean this up by removing spaces. Also
add { } braces on if statement to keep to kernel coding
style.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/sis/sis900.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
index 6073387511f8..67f9bb6e941b 100644
--- a/drivers/net/ethernet/sis/sis900.c
+++ b/drivers/net/ethernet/sis/sis900.c
@@ -730,10 +730,10 @@ static u16 sis900_default_phy(struct net_device * net_dev)
 		status = mdio_read(net_dev, phy->phy_addr, MII_STATUS);
 
 		/* Link ON & Not select default PHY & not ghost PHY */
-		 if ((status & MII_STAT_LINK) && !default_phy &&
-					(phy->phy_types != UNKNOWN))
-		 	default_phy = phy;
-		 else {
+		if ((status & MII_STAT_LINK) && !default_phy &&
+		    (phy->phy_types != UNKNOWN)) {
+			default_phy = phy;
+		} else {
 			status = mdio_read(net_dev, phy->phy_addr, MII_CONTROL);
 			mdio_write(net_dev, phy->phy_addr, MII_CONTROL,
 				status | MII_CNTL_AUTO | MII_CNTL_ISOLATE);
@@ -741,7 +741,7 @@ static u16 sis900_default_phy(struct net_device * net_dev)
 				phy_home = phy;
 			else if(phy->phy_types == LAN)
 				phy_lan = phy;
-		 }
+		}
 	}
 
 	if (!default_phy && phy_home)
-- 
2.20.1

