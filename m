Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BBAC49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2A621924
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Oez2clrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfIJTFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:05:40 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:28971 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfIJTFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568142339; x=1599678339;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=Pwyi2LvRvU2P6PihSn1GXJczaDqXg7KVNUJ3MtlBRvI=;
  b=Oez2clrRHSJnHK4lsXySGpuF0pLrd9BsTjDl060bwxIfrULMlmBhQsBf
   PTXusiQBJcMpAfYwgb5RmdJuuKRROS9kfH/UFe/2qHM0LfHk7+aPzQm8J
   Sxb5mZR/W5/CqPSF92/1mOZzbF2yJRTDQewR0LLrfGeL8TYUyZHJ2GAyq
   4=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="420463916"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Sep 2019 19:05:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id D241DC5AB7;
        Tue, 10 Sep 2019 19:05:35 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 19:05:35 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.5) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Sep 2019 19:05:28 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <mchehab+samsung@kernel.org>,
        <shawn.lin@rock-chips.com>, <gregkh@linuxfoundation.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <talel@amazon.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: soc: al-pos: Amazon's Annapurna Labs POS
Date:   Tue, 10 Sep 2019 22:05:08 +0300
Message-ID: <1568142310-17622-2-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568142310-17622-1-git-send-email-talel@amazon.com>
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.5]
X-ClientProxiedBy: EX13D03UWC002.ant.amazon.com (10.43.162.160) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Amazon's Annapurna Labs POS SoC binding.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../devicetree/bindings/soc/amazon/amazon,al-pos.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt

diff --git a/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt b/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
new file mode 100644
index 00000000..035cc571
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
@@ -0,0 +1,18 @@
+Amazon's Annapurna Labs POS
+
+POS node is defined to describe the Point Of Serialization (POS) logger
+unit.
+
+Required properties:
+- compatible:	Shall be "amazon,al-pos".
+- reg:		POS logger resources.
+- interrupts:	should contain the interrupt for pos error event.
+
+Example:
+
+al_pos {
+	compatible = "amazon,al-pos";
+	reg = <0x0 0xf0070084 0x0 0x00000008>;
+	interrupt-parent = <&amazon_system_fabric>;
+	interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4

