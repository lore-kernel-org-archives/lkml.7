Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F00C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDD020851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHSFEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:04:33 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:26583 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHSFEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:04:33 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d86 with ME
        id qt4W2000V0Dzhgk03t4WdF; Mon, 19 Aug 2019 07:04:31 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Aug 2019 07:04:31 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     3chas3@gmail.com
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Kconfig: Fix the reference to the IDT77105 Phy driver in the description of ATM_NICSTAR_USE_IDT77105
Date:   Mon, 19 Aug 2019 07:04:25 +0200
Message-Id: <20190819050425.6119-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be IDT77105, not IDT77015.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/atm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/Kconfig b/drivers/atm/Kconfig
index 2e2efa577437..8c37294f1d1e 100644
--- a/drivers/atm/Kconfig
+++ b/drivers/atm/Kconfig
@@ -200,7 +200,7 @@ config ATM_NICSTAR_USE_SUNI
 	  make the card work).
 
 config ATM_NICSTAR_USE_IDT77105
-	bool "Use IDT77015 PHY driver (25Mbps)"
+	bool "Use IDT77105 PHY driver (25Mbps)"
 	depends on ATM_NICSTAR
 	help
 	  Support for the PHYsical layer chip in ForeRunner LE25 cards. In
-- 
2.20.1

