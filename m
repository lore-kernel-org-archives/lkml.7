Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECDDC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1942921670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfH3PD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:03:29 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:54114 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfH3PDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:03:10 -0400
Received: from ramsan ([84.194.98.4])
        by andre.telenet-ops.be with bizsmtp
        id vT382000805gfCL01T38d5; Fri, 30 Aug 2019 17:03:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iQe-0003gl-6l; Fri, 30 Aug 2019 17:03:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iQe-0005MP-5t; Fri, 30 Aug 2019 17:03:08 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/5] dt-bindings: arm: idle-states: Correct "constraint guarantees"
Date:   Fri, 30 Aug 2019 17:03:00 +0200
Message-Id: <20190830150302.20551-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830150302.20551-1-geert+renesas@glider.be>
References: <20190830150302.20551-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct "constraints guarantees" to "constraint guarantees".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 6e651b7e62c328be..4ef0de5c0c7f5990 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -107,7 +107,7 @@ the worst case since it depends on the CPU operating conditions, i.e. caches
 state).
 
 An OS has to reliably probe the wakeup-latency since some devices can enforce
-latency constraints guarantees to work properly, so the OS has to detect the
+latency constraint guarantees to work properly, so the OS has to detect the
 worst case wake-up latency it can incur if a CPU is allowed to enter an
 idle state, and possibly to prevent that to guarantee reliable device
 functioning.
-- 
2.17.1

