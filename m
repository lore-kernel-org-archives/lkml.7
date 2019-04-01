Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EBFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D2F20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dadz98qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbfDARp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:45:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34218 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387736AbfDAReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31HY513129032;
        Mon, 1 Apr 2019 12:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554140045;
        bh=NRAX1bmUD/a5vpTS0wktfjeVShF+ASYaJwyo80uQPIU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dadz98qRycyCc38L7Pl/A6M5ZbZcYBByuYZd8vwVY+5LYSkVS6VhyNyo+MgN8VPnc
         6hLbNCueKf12cjYrPjl/hwX0ye2jjmZJlWRJzTNKaNeaLJ3/sPdYsr/p/MxX9qUX6g
         3wM4ic0f88jrZ7g2kMfixpTLbAlIdbgC7vRx+iKw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31HY50N110657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 12:34:05 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 12:34:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 12:34:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31HY5Ep101354;
        Mon, 1 Apr 2019 12:34:05 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <marek.behun@nic.cz>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 4/5] dt-bindings: leds: Add LED_COLOR_ID and COLOR_NAME definitions
Date:   Mon, 1 Apr 2019 12:33:59 -0500
Message-ID: <20190401173400.14238-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190401173400.14238-1-dmurphy@ti.com>
References: <20190401173400.14238-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is being added to demonstrate reuse of Jacek's patch
https://lore.kernel.org/patchwork/patch/1056726/

I have added color name definitions to the above patch.
I do not claim authorship and the intent of this patch to strictly
for demonstration.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 include/dt-bindings/leds/common.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index e171d0a6beb2..7e1279d761e4 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -19,4 +19,23 @@
 #define LEDS_BOOST_ADAPTIVE	1
 #define LEDS_BOOST_FIXED	2
 
+#define LED_COLOR_ID_WHITE	 0
+#define LED_COLOR_ID_RED	 1
+#define LED_COLOR_ID_GREEN	 2
+#define LED_COLOR_ID_BLUE	 3
+#define LED_COLOR_ID_AMBER	 4
+#define LED_COLOR_ID_VIOLET	 5
+#define LED_COLOR_ID_YELLOW	 6
+#define LED_COLOR_ID_MAX	 LED_COLOR_ID_YELLOW
+
+#define LED_COLOR_NAME_WHITE	"white"
+#define LED_COLOR_NAME_RED	"red"
+#define LED_COLOR_NAME_GREEN	"green"
+#define LED_COLOR_NAME_BLUE	"blue"
+#define LED_COLOR_NAME_AMBER	"amber"
+#define LED_COLOR_NAME_VIOLET	"violet"
+#define LED_COLOR_NAME_YELLOW	"yellow"
+
+#define LED_COLOR_NAME_MAX_SZ	6
+
 #endif /* __DT_BINDINGS_LEDS_H */
-- 
2.19.0

