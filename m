Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BB3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8437206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rqWH7SGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLVPwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 10:52:08 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6221 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfLVPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 10:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577029926; x=1608565926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=OPMX17Omz7JYkY/istcTHVeb5cJ/SKsg2S1n95nmmHo=;
  b=rqWH7SGwi24MjPhJdSqGHFHWFXbxc9KUiQgO0qTTQ/47PFgAnALyNrhr
   zjy4bzkF+bDgVE+tXJTRB37owSrzpU4s/DJ/3Ax3D+z57PHI8RSVJu0ZS
   /DBJbOYWTiqiGYF/xKN8JqKwB7OO6Cw9H+6xKpNYmwq/6k08CFyc2lEoE
   o=;
IronPort-SDR: B1F4uyfQ9UM6VLR390tWOMVdU+7cpK5QGPa46Tufzt0j5Ys7c0QqZmVQPFq9mQq/FxX1hyUksX
 HpcyWXA7/9KA==
X-IronPort-AV: E=Sophos;i="5.69,344,1571702400"; 
   d="scan'208";a="6616119"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Dec 2019 15:51:53 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id EE7FBA17FE;
        Sun, 22 Dec 2019 15:51:47 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 22 Dec 2019 15:51:46 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.9) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Dec 2019 15:51:35 +0000
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
Subject: [PATCH v3 1/6] dt-bindings: arm: amazon: rename al,alpine DT binding to amazon,al
Date:   Sun, 22 Dec 2019 17:50:33 +0200
Message-ID: <20191222155038.30633-2-hhhawa@amazon.com>
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

As preparation to add device tree binding for Amazon's Annapurna Labs
Alpine v3 support. Rename al,alpine DT binding to amazon,al.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/{al,alpine.yaml => amazon,al.yaml}           | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/arm/{al,alpine.yaml => amazon,al.yaml} (74%)

diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/amazon,al.yaml
similarity index 74%
rename from Documentation/devicetree/bindings/arm/al,alpine.yaml
rename to Documentation/devicetree/bindings/arm/amazon,al.yaml
index a70dff277e05..58eb4ad55a76 100644
--- a/Documentation/devicetree/bindings/arm/al,alpine.yaml
+++ b/Documentation/devicetree/bindings/arm/amazon,al.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
+$id: http://devicetree.org/schemas/arm/amazon,al.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Annapurna Labs Alpine Platform Device Tree Bindings
+title: Amazon's Annapurna Labs Alpine Platform Device Tree Bindings
 
 maintainers:
   - Tsahee Zidenberg <tsahee@annapurnalabs.com>
-- 
2.17.1

