Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5899C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C262073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFNDWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:22:03 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:33330 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFNDWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:22:03 -0400
Received: from tony.xie?rock-chips.com (unknown [192.168.167.229])
        by lucky1.263xmail.com (Postfix) with ESMTP id 050DE37411;
        Fri, 14 Jun 2019 11:14:39 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13273T140214467016448S1560482074692142_;
        Fri, 14 Jun 2019 11:14:37 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b51261e4f9f8107af950d2ff69e11f3a>
X-RL-SENDER: tony.xie@rock-chips.com
X-SENDER: xxx@rock-chips.com
X-LOGIN-NAME: tony.xie@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Tony Xie <tony.xie@rock-chips.com>
To:     heiko@sntech.de
Cc:     broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
Subject: [PATCH v9 1/6] mfd: rk808: remove the id_table
Date:   Thu, 13 Jun 2019 23:14:20 -0400
Message-Id: <20190614031425.15741-2-tony.xie@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614031425.15741-1-tony.xie@rock-chips.com>
References: <20190614031425.15741-1-tony.xie@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the id_table because it's not used.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
---
 drivers/mfd/rk808.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 216fbf6adec9..94377782d208 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -568,14 +568,6 @@ static int rk808_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id rk808_ids[] = {
-	{ "rk805" },
-	{ "rk808" },
-	{ "rk818" },
-	{ },
-};
-MODULE_DEVICE_TABLE(i2c, rk808_ids);
-
 static struct i2c_driver rk808_i2c_driver = {
 	.driver = {
 		.name = "rk808",
@@ -583,7 +575,6 @@ static struct i2c_driver rk808_i2c_driver = {
 	},
 	.probe    = rk808_probe,
 	.remove   = rk808_remove,
-	.id_table = rk808_ids,
 };
 
 module_i2c_driver(rk808_i2c_driver);
-- 
2.17.1



