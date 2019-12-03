Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F37C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F9620640
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLDCoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:44:12 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:50616 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfLDCoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:44:12 -0500
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d59 with ME
        id Zek62100A3xPcdm03ek7w5; Wed, 04 Dec 2019 03:44:09 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 04 Dec 2019 03:44:09 +0100
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sbkim73@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regulator: s5m8767: Fix a warning message
Date:   Tue,  3 Dec 2019 22:48:38 +0100
Message-Id: <20191203214838.9680-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axe a duplicated word ("property") in a warning message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/regulator/s5m8767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index bdc07739e9a2..12d6b8d2e97e 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -588,7 +588,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 		if (of_property_read_u32(reg_np, "op_mode",
 				&rmode->mode)) {
 			dev_warn(iodev->dev,
-				"no op_mode property property at %pOF\n",
+				"no op_mode property at %pOF\n",
 				reg_np);
 
 			rmode->mode = S5M8767_OPMODE_NORMAL_MODE;
-- 
2.20.1

