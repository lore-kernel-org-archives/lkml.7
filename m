Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19CFC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B040E2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oFzHm/8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfFEFzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 01:55:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49118 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfFEFzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 01:55:32 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x555tUUv002609;
        Wed, 5 Jun 2019 00:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559714130;
        bh=hIv3m0nvpBJjbhu7oWIXqB0Efd9SLUjlr+sYX36ES7k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oFzHm/8JLOkafo6DNDnsbggA5CY4l8R9Zpl3lij+T1JcLXcjX6JlyIlpJb3GgTs0T
         kLYST2p2Rhvk/WrFIyY8eEXq8rPQZkGuh+cvOxHAhs00Zm1BIjpc5z8fwicZoG+/XH
         2O/E1x85zriJPZMh1P2iY2BuSyl+vJDdbbaEeob0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x555tUTw115719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 00:55:30 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 00:55:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 00:55:29 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x555tMHd049531;
        Wed, 5 Jun 2019 00:55:28 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>
CC:     <lokeshvutla@ti.com>, <linux-gpio@vger.kernel.org>,
        <t-kristo@ti.com>, <j-keerthy@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] gpio: Davinci: Add K3 dependencies
Date:   Wed, 5 Jun 2019 11:25:19 +0530
Message-ID: <20190605055519.24079-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605055519.24079-1-j-keerthy@ti.com>
References: <20190605055519.24079-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add K3 dependencies to enable the driver on K3 platforms.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 62f3fe06cd2f..28dba62e2219 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -174,7 +174,7 @@ config GPIO_CLPS711X
 config GPIO_DAVINCI
 	bool "TI Davinci/Keystone GPIO support"
 	default y if ARCH_DAVINCI
-	depends on ARM && (ARCH_DAVINCI || ARCH_KEYSTONE)
+	depends on (ARM || ARM64) && (ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_K3)
 	help
 	  Say yes here to enable GPIO support for TI Davinci/Keystone SoCs.
 
-- 
2.17.1

