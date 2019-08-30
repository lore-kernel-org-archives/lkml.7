Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D9AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17CC21670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfH3PDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:03:18 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:38990 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3PDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:03:11 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id vT382000705gfCL01T38c2; Fri, 30 Aug 2019 17:03:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iQe-0003gs-82; Fri, 30 Aug 2019 17:03:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iQe-0005MV-78; Fri, 30 Aug 2019 17:03:08 +0200
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
Subject: [PATCH 5/5] dt-bindings: arm: idle-states: Move exit-latency-us explanation
Date:   Fri, 30 Aug 2019 17:03:02 +0200
Message-Id: <20190830150302.20551-6-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830150302.20551-1-geert+renesas@glider.be>
References: <20190830150302.20551-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move exit-latency-us explanation to exit-latency-us section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index eb9d725be7a93f4a..771f5d20ae18768c 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -287,14 +287,14 @@ follows:
 		Value type: <prop-encoded-array>
 		Definition: u32 value representing worst case latency in
 			    microseconds required to enter the idle state.
-			    The exit-latency-us duration may be guaranteed
-			    only after entry-latency-us has passed.
 
 	- exit-latency-us
 		Usage: Required
 		Value type: <prop-encoded-array>
 		Definition: u32 value representing worst case latency
 			    in microseconds required to exit the idle state.
+			    The exit-latency-us duration may be guaranteed
+			    only after entry-latency-us has passed.
 
 	- min-residency-us
 		Usage: Required
-- 
2.17.1

