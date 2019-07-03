Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517FCC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316D1218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGCUB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:01:27 -0400
Received: from atlmailgw2.ami.com ([63.147.10.42]:47136 "EHLO
        atlmailgw2.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCUB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:01:26 -0400
X-AuditID: ac10606f-bd5ff70000003de9-2a-5d1d0994a27d
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw2.ami.com (Symantec Messaging Gateway) with SMTP id BE.26.15849.4990D1D5; Wed,  3 Jul 2019 16:01:25 -0400 (EDT)
Received: from hongweiz-Ubuntu-AMI.us.megatrends.com (172.16.98.93) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 3 Jul 2019 16:01:24 -0400
From:   Hongwei Zhang <hongweiz@ami.com>
To:     <devicetree@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Hongwei Zhang <hongweiz@ami.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support
Date:   Wed, 3 Jul 2019 16:01:09 -0400
Message-ID: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.93]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWyRiBhgu5UTtlYg5ZJzBa7LnNYzD9yjtXi
        9/m/zBZT/ixnsmhefY7Z4vKuOWwWS69fZLJo3XuE3YHD42r7LnaPNfPWMHpc/HiM2WPTqk42
        jzvX9rB5nJ+xkNHj8ya5APYoLpuU1JzMstQifbsErozTB56wF/zjrej8cY+pgfEIdxcjB4eE
        gInE3N8ZXYycHEICu5gkdv4Q62LkArIPMUocbNzGDpJgE1CT2Lt5DhNIQkSgl1Fi0tPpzCAO
        s8AGRokrJxeAVQkLeEisXHmICcRmEVCRmPrxASOIzSvgIHF50RZWEFtCQE7i5rlOZoi4oMTJ
        mU9YQGxmAQmJgy9eMEOcIStx69BjJoh6BYnnfY9ZJjDyzULSMgtJywJGplWMQoklObmJmTnp
        5UZ6ibmZesn5uZsYIUGbv4Px40fzQ4xMHIxAL3EwK4nwfv8tEyvEm5JYWZValB9fVJqTWnyI
        UZqDRUmcd9WabzFCAumJJanZqakFqUUwWSYOTqkGRv+ItRMDnwTcfciRc9481NuKRyDX13tV
        UvKEurlTJAuW8JsumbOunXnr9Bfl8+cc0gw4bHV22jMelRtvH/CLtz46KOcpPdHEInNPfvr2
        AI+0klwFcdEk7nvn3klXZrQlWit93/6yJ2ptW+Hlb1JHnTdFRdXuPrtVfKbxuTQpVf8sft/e
        uUcXKLEUZyQaajEXFScCAGoFEF9IAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to support SGPIO on AST2400 or AST2500.

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt

diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
new file mode 100644
index 0000000..f5fc6ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
@@ -0,0 +1,36 @@
+Aspeed SGPIO controller Device Tree Bindings
+-------------------------------------------
+
+Required properties:
+- compatible		: Either "aspeed,ast2400-sgpio" or "aspeed,ast2500-sgpio"
+
+- #gpio-cells 		: Should be two
+			  - First cell is the GPIO line number
+			  - Second cell is used to specify optional
+			    parameters (unused)
+
+- reg			: Address and length of the register set for the device
+- gpio-controller	: Marks the device node as a GPIO controller.
+- interrupts		: Interrupt specifier (see interrupt bindings for
+			  details)
+- interrupt-controller	: Mark the GPIO controller as an interrupt-controller
+
+Optional properties:
+
+- clocks                : A phandle to the clock to use for debounce timings
+
+The sgpio and interrupt properties are further described in their respective
+bindings documentation:
+
+- Documentation/devicetree/bindings/sgpio/gpio.txt
+- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+  Example:
+	sgpio@1e780200 {
+		#gpio-cells = <2>;
+		compatible = "aspeed,ast2500-sgpio";
+		gpio-controller;
+		interrupts = <40>;
+		reg = <0x1e780200 0x0100>;
+		interrupt-controller;
+	};
-- 
2.7.4

