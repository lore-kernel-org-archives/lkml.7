Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD44C74A48
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EEE20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qEeq3U7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfGKGjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:39:25 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:4177 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKGjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562827163; x=1594363163;
  h=from:to:subject:date:message-id:mime-version;
  bh=3yDMhteaqF5Imx/WRe77nSJqYH+HoX6HUtBihhrqZRc=;
  b=qEeq3U7YRj8ufXlxSwYlp9pRdmrOok8Wpid6Buwuv4y3q4r6xOw0vusn
   m0tQr6dTQpVzACHTMQkrBAaSOp0ZjcTYY9l/AUmircJV9FzMRVx+7hMZr
   oDZIwBzKeRZXa7GAkE7pvhOZ60EoQzZwWN/vuAq0Dk0ugSWoKy6gdSSUj
   A=;
X-IronPort-AV: E=Sophos;i="5.62,476,1554768000"; 
   d="scan'208";a="741294779"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Jul 2019 06:39:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id BC8D7A2277;
        Thu, 11 Jul 2019 06:39:19 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 06:39:19 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.211) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 06:39:11 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <mchehab+samsung@kernel.org>,
        <shawn.lin@rock-chips.com>, <gregkh@linuxfoundation.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <talel@amazon.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/1] dt-bindings: interrupt-controller: al-fic: remove redundant binding
Date:   Thu, 11 Jul 2019 09:38:59 +0300
Message-ID: <1562827139-1666-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.211]
X-ClientProxiedBy: EX13D29UWA004.ant.amazon.com (10.43.160.33) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dt binding description for standard binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../bindings/interrupt-controller/amazon,al-fic.txt      | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
index 4e82fd5..c676b03 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
@@ -5,21 +5,19 @@ Required properties:
 - compatible: should be "amazon,al-fic"
 - reg: physical base address and size of the registers
 - interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: must be 2.
-  First cell defines the index of the interrupt within the controller.
-  Second cell is used to specify the trigger type and must be one of the
-  following:
-    - bits[3:0] trigger type and level flags
-	1 = low-to-high edge triggered
-	4 = active high level-sensitive
-- interrupt-parent: specifies the parent interrupt controller.
+- #interrupt-cells : must be 2. Specifies the number of cells needed to encode
+  an interrupt source. Supported trigger types are low-to-high edge
+  triggered and active high level-sensitive.
 - interrupts: describes which input line in the interrupt parent, this
   fic's output is connected to. This field property depends on the parent's
   binding
 
+Please refer to interrupts.txt in this directory for details of the common
+Interrupt Controllers bindings used by client devices.
+
 Example:
 
-amazon_fic: interrupt-controller@0xfd8a8500 {
+amazon_fic: interrupt-controller@fd8a8500 {
 	compatible = "amazon,al-fic";
 	interrupt-controller;
 	#interrupt-cells = <2>;
-- 
2.7.4

