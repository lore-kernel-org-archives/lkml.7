Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6254C76190
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9122075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hl7TiFhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfG1Tw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:52:29 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:11886 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfG1Tw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564343547; x=1595879547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jp036A70PNKKSUR2d3ycNtKJ/DljExzQRQpJU5CYsQE=;
  b=hl7TiFhGep4uTeOXe/txzGFfE9eN96HJESnDSa/JLbTzg9eLarCYgDVV
   JXuvbt6bq2cpnCuE+SWj3Ob3DJhnnUOjj69gyG8ETtrbfUSG6+GYVpXjR
   57a08GBAEYes4GlT52cCCcSn4l8oedZPrriNf6N8oh+0vda98CSridwUD
   4=;
X-IronPort-AV: E=Sophos;i="5.64,319,1559520000"; 
   d="scan'208";a="814374163"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 28 Jul 2019 19:52:14 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 9B673A2173;
        Sun, 28 Jul 2019 19:52:14 +0000 (UTC)
Received: from EX13D05EUC002.ant.amazon.com (10.43.164.231) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Jul 2019 19:52:14 +0000
Received: from u18dbf258377358bea500.amazon.com (10.43.160.25) by
 EX13D05EUC002.ant.amazon.com (10.43.164.231) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Jul 2019 19:52:06 +0000
From:   Ronen Krupnik <ronenk@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <barakw@amazon.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <jonnyc@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <hanochu@amazon.com>, Ronen Krupnik <ronenk@amazon.com>
Subject: [PATCH 1/2] dt-bindings: amazon: add Amazon Annapurna Labs Alpine support
Date:   Sun, 28 Jul 2019 22:51:34 +0300
Message-ID: <20190728195135.12661-2-ronenk@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190728195135.12661-1-ronenk@amazon.com>
References: <20190728195135.12661-1-ronenk@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.25]
X-ClientProxiedBy: EX13P01UWA002.ant.amazon.com (10.43.160.46) To
 EX13D05EUC002.ant.amazon.com (10.43.164.231)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings info for Amazon Annapurna Labs Alpine SOC
and related reference boards.

Signed-off-by: Ronen Krupnik <ronenk@amazon.com>
---
 .../devicetree/bindings/arm/amazon,alpine.txt | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amazon,alpine.txt

diff --git a/Documentation/devicetree/bindings/arm/amazon,alpine.txt b/Documentation/devicetree/bindings/arm/amazon,alpine.txt
new file mode 100644
index 000000000000..58817208421b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amazon,alpine.txt
@@ -0,0 +1,23 @@
+Amazon Annapurna Labs Alpine v3 Platform Device Tree Bindings
+---------------------------------------------------------------
+
+Platforms based on Amazon Annapurna Labs Alpine SoC architecture
+shall follow the following scheme:
+
+SoCs
+----
+
+Each device tree root node must specify which exact SoC in alpine
+architecture it uses, using one of the following compatible values:
+
+- alpine v3
+  compatible = "amazon,alpine-v3";
+
+Boards
+------
+
+Each device tree must specify which one or more of the following
+board-specific compatible values:
+
+- alpine-v3 Evaluation Platform (EVP)
+  compatible = "amazon,alpine-v3-evp";
-- 
2.21.0

