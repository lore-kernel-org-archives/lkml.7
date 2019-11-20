Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936B3C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E7F22523
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfKTNVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56834 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfKTNV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPvA-0007F9-Qt; Wed, 20 Nov 2019 14:21:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 803C71C1A1F;
        Wed, 20 Nov 2019 14:21:06 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:06 -0000
From:   "tip-bot2 for Florian Fainelli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: Document brcm, irq-can-wake for brcm,
 bcm7038-l1-intc.txt
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191024201415.23454-3-f.fainelli@gmail.com>
References: <20191024201415.23454-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <157425606646.12247.14831145441040729864.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b94f9008f2ad551f4d6a9537b10238847cb81e5d
Gitweb:        https://git.kernel.org/tip/b94f9008f2ad551f4d6a9537b10238847cb81e5d
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Thu, 24 Oct 2019 13:14:12 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:46 

dt-bindings: Document brcm, irq-can-wake for brcm, bcm7038-l1-intc.txt

The BCM7038 L1 interrupt controller can be used as a wake-up interrupt
controller on MIPS and ARM-based systems, document the brcm,irq-can-wake
which has been "standardized" across Broadcom interrupt controllers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191024201415.23454-3-f.fainelli@gmail.com
---
 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
index 2117d4a..4eb0432 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
@@ -31,6 +31,11 @@ Required properties:
 - interrupts: specifies the interrupt line(s) in the interrupt-parent controller
   node; valid values depend on the type of parent interrupt controller
 
+Optional properties:
+
+- brcm,irq-can-wake: If present, this means the L1 controller can be used as a
+  wakeup source for system suspend/resume.
+
 If multiple reg ranges and interrupt-parent entries are present on an SMP
 system, the driver will allow IRQ SMP affinity to be set up through the
 /proc/irq/ interface.  In the simplest possible configuration, only one
