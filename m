Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D202C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E788F2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pI0gkYOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLIQO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:14:58 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:31192 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfLIQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575908096; x=1607444096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=et8DBA9iGSNYn794W2po2FRwgqVLEvj/odctMfNiqiM=;
  b=pI0gkYOwFt6GSlqqTPAUez0Cq7K1gMOkqT/vhXhM3+clJTq3mc9yNC32
   atG7+7IIahyxEjZHk6e/5yYu2/M+fStXUVwhR3MGO7CWCyTvmhOAK+9fH
   wEdCG3SpmiV/GGd/sUBH07Bg+0lyy1rX7Ob1306MdY2E1P3Y5h1g+E7XT
   s=;
IronPort-SDR: CJmDO2Q8poFkWWuGm/GhYyvwBJ/x7i4ts4IVlfSezi2H+lnNYRK8Adu9gbHaw1ULIO0zG8X3gT
 uuCpQQA/zMhQ==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="7762567"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Dec 2019 16:14:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 614CBA19F1;
        Mon,  9 Dec 2019 16:14:49 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:14:48 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.249) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:14:38 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <tglx@linutronix.de>,
        <khilman@baylibre.com>, <chanho.min@lge.com>, <heiko@sntech.de>,
        <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v2 4/6] dt-bindings: arm: amazon: add missing alpine-v2 DT binding
Date:   Mon, 9 Dec 2019 16:13:39 +0000
Message-ID: <20191209161341.29607-5-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209161341.29607-1-hhhawa@amazon.com>
References: <20191209161341.29607-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.249]
X-ClientProxiedBy: EX13D14UWB003.ant.amazon.com (10.43.161.162) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amazon Annapurna Labs Alpine family includes: Alpine-v1, Alpine-v2.

This patch adds the missing DT binding of Alpine-v2 in amazon,al.yaml.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 .../devicetree/bindings/arm/amazon,al.yaml        | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amazon,al.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
index 19ee489396f9..7de3a8c6e740 100644
--- a/Documentation/devicetree/bindings/arm/amazon,al.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -13,10 +13,15 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: al,alpine
-  model:
-    items:
-      - const: "Annapurna Labs Alpine Dev Board"
+    oneOf:
+      - description: Boards with Alpine V1 SoC
+        items:
+          - const: al,alpine
+
+      - description: Boards with Alpine V2 SoC
+        items:
+          - enum:
+              - al,alpine-v2-evp
+          - const: al,alpine-v2
 
 ...
-- 
2.17.1

