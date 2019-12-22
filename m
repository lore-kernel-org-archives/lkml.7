Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0142BC2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F49206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sAkCFpOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLVPwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 10:52:16 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:7962 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 10:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577029934; x=1608565934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=DEssGXIsB7EUj0Tn+8tY3DwWsX+hFqfa/2RyzoqrTJU=;
  b=sAkCFpOsUtq4mm/FQope71KeAWNoqNLq5JeCRt6riwmhHI30OR9N8TXt
   7Q5TVRTW9g669kdx/mcpC++Bv2C1lA9pP+wCgR3typeZWkGqN8uoik5qp
   c6TmsLsBYO4sr8fCpkCooKVnUEu4NjQdFOBBFBbAnu5iWuYrJcILFXujG
   g=;
IronPort-SDR: r0fWUtR0pvFmjl7zPSbXHD4FDWvblasRTPyc8Y7HVXLI/W3/y2A0EBhpI2hW1LppMcyJ5aP2VO
 xG+87qUWAByw==
X-IronPort-AV: E=Sophos;i="5.69,344,1571702400"; 
   d="scan'208";a="9682135"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 22 Dec 2019 15:52:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id F3D16A281E;
        Sun, 22 Dec 2019 15:52:07 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 22 Dec 2019 15:52:07 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.9) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Dec 2019 15:51:56 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <tglx@linutronix.de>,
        <xuwei5@hisilicon.com>, <scott.branden@broadcom.com>,
        <dinguyen@kernel.org>, <zhang.lyra@gmail.com>, <treding@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v3 3/6] dt-bindings: arm: amazon: update maintainers of amazon,al DT bindings
Date:   Sun, 22 Dec 2019 17:50:35 +0200
Message-ID: <20191222155038.30633-4-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222155038.30633-1-hhhawa@amazon.com>
References: <20191222155038.30633-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.9]
X-ClientProxiedBy: EX13D19UWA002.ant.amazon.com (10.43.160.204) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update maintainers of amazon,al DT bindings.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amazon,al.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amazon,al.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
index 58eb4ad55a76..19ee489396f9 100644
--- a/Documentation/devicetree/bindings/arm/amazon,al.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -7,8 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Amazon's Annapurna Labs Alpine Platform Device Tree Bindings
 
 maintainers:
-  - Tsahee Zidenberg <tsahee@annapurnalabs.com>
-  - Antoine Tenart <antoine.tenart@bootlin.com>
+  - Hanna Hawa <hhhawa@amazon.com>
+  - Talel Shenhar <talel@amazon.com>, <talelshenhar@gmail.com>
+  - Ronen Krupnik <ronenk@amazon.com>
 
 properties:
   compatible:
-- 
2.17.1

