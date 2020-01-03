Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B99215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578071589;
	bh=OBmIUek42cnzUQDrrnU/oY+P3xCSkIfYAxlHss1KdT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZmU7OiIz74c9+Dt4rKqTnt0Qbc/j+cvLmpIT8w67vddJTZK7lBLGtZcmrJEMARqp
	 FDi/8jwG6G3TGBZ7pTltkizzSAIZ6QyNb4WPUx6wf2y8zvaEVe8+HZE6A0UdyuayQ/
	 vIqTlqU7WCPl6RGfKYkN9Fu6PSYRwqlbII+SuLqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgACRNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgACRND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:13:03 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8FB720866;
        Fri,  3 Jan 2020 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071583;
        bh=OBmIUek42cnzUQDrrnU/oY+P3xCSkIfYAxlHss1KdT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uiD9arbHhZ0CKZeFVc225Ku1AjGfslX4oMLieAR1Pyh85u4kv3cowzQAwxlDE1HBq
         PDPrCQefryo3lWg7CZx/GCCFAhGYRjed1f2wAPz/lEfP6SjkaIfHdKxIgDN9qA98LT
         ggJGdr9WnWGuCkxxJcG4UPudG/nVPMkvuz4IPEr0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Byungho An <bh74.an@samsung.com>,
        Girish K S <ks.giri@samsung.com>,
        Vipul Pandya <vipul.pandya@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org
Subject: [PATCH 18/19] net: ethernet: sxgbe: Rename Samsung to lowercase
Date:   Fri,  3 Jan 2020 18:11:30 +0100
Message-Id: <20200103171131.9900-19-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
name.

"SAMSUNG" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 2 +-
 include/linux/sxgbe_platform.h                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index cd6e0de48248..7d3a1c0df09c 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -2296,7 +2296,7 @@ __setup("sxgbeeth=", sxgbe_cmdline_opt);
 
 
 
-MODULE_DESCRIPTION("SAMSUNG 10G/2.5G/1G Ethernet PLATFORM driver");
+MODULE_DESCRIPTION("Samsung 10G/2.5G/1G Ethernet PLATFORM driver");
 
 MODULE_PARM_DESC(debug, "Message Level (-1: default, 0: no output, 16: all)");
 MODULE_PARM_DESC(eee_timer, "EEE-LPI Default LS timer value");
diff --git a/include/linux/sxgbe_platform.h b/include/linux/sxgbe_platform.h
index 85ec745767bd..966146f7267a 100644
--- a/include/linux/sxgbe_platform.h
+++ b/include/linux/sxgbe_platform.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * 10G controller driver for Samsung EXYNOS SoCs
+ * 10G controller driver for Samsung Exynos SoCs
  *
  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
-- 
2.17.1

