Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E84C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DAF20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfB1NZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:25:11 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60779 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfB1NZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:25:09 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 944FFFF804;
        Thu, 28 Feb 2019 13:25:05 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 02/15] net: mvpp2: update the port documentation regarding the GoP
Date:   Thu, 28 Feb 2019 14:21:15 +0100
Message-Id: <20190228132128.30154-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228132128.30154-1-antoine.tenart@bootlin.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell PPv2 port structure stores the GoP id of a given port. This
information is specific to PPv2.2, but cannot be used by PPv2.1. Update
its comment to denote this specificity.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 83fb2b03e789..9b05fcbc6953 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -803,7 +803,7 @@ struct mvpp2_port {
 	u8 id;
 
 	/* Index of the port from the "group of ports" complex point
-	 * of view
+	 * of view. This is specific to PPv2.2.
 	 */
 	int gop_id;
 
-- 
2.20.1

