Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99855C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677202075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="IZJySXYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfC0A1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:27:34 -0400
Received: from vps.xff.cz ([195.181.215.36]:53764 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfC0A1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553645935; bh=3YIZXT9GyH/9ALbi8NHunTbQp5Nx8/5Bd1EDvonk1yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZJySXYWqzn0BpBmntjpUGxmrvYYF662KhzxL4Uw9d1GIBkU9tn/mqy/kFGMwsQyJ
         TcyOxdGBPjd+/eGjuWMg29gNzt4iHkrdSocQp8+XMyOVq5zcQ4jc1Pushv5jdw02wC
         nMVGW2SqAX2MHA4h8upE0U3II19yZzk53R2YUdo0=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 5/7] gnss: Add u-blox,neo-6m compatible
Date:   Wed, 27 Mar 2019 01:18:41 +0100
Message-Id: <20190327001843.2420-6-megous@megous.com>
In-Reply-To: <20190327001843.2420-1-megous@megous.com>
References: <20190327001843.2420-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Add compatible for u-blox NEO-6M GPS module.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gnss/ubx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 12568aebb7f6..1ada2fad1d4e 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -132,6 +132,7 @@ static void ubx_remove(struct serdev_device *serdev)
 static const struct of_device_id ubx_of_match[] = {
 	{ .compatible = "u-blox,neo-8" },
 	{ .compatible = "u-blox,neo-m8" },
+	{ .compatible = "u-blox,neo-6m" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ubx_of_match);
-- 
2.21.0

