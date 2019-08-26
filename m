Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D889C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7E92189D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfHZWwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:52:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41528 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfHZWwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:52:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Nqa-0006ph-Qh; Tue, 27 Aug 2019 00:52:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1225B1C0DD9;
        Tue, 27 Aug 2019 00:52:19 +0200 (CEST)
Date:   Mon, 26 Aug 2019 22:52:18 -0000
From:   tip-bot2 for Magnus Damm <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas, cmt: Update R-Car
 Gen3 CMT1 usage
Cc:     Magnus Damm <damm+renesas@opensource.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156685993896.1336.8702361004191043112.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1be8c9fd2ac9ad730cf537b8909f66c357866c5d
Gitweb:        https://git.kernel.org/tip/1be8c9fd2ac9ad730cf537b8909f66c357866c5d
Author:        Magnus Damm <damm+renesas@opensource.se>
AuthorDate:    Tue, 20 Aug 2019 21:35:46 +09:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Aug 2019 00:31:39 +02:00

dt-bindings: timer: renesas, cmt: Update R-Car Gen3 CMT1 usage

The R-Car Gen3 SoCs so far come with a total for 4 on-chip CMT devices:
 - CMT0
 - CMT1
 - CMT2
 - CMT3

CMT0 includes two rather basic 32-bit timer channels. The rest of the on-chip
CMT devices support 48-bit counters and have 8 channels each.

Based on the data sheet information "CMT2/3 are exactly same as CMT1"
it seems that CMT2 and CMT3 now use the CMT1 compat string in the DTSI.

Clarify this in the DT binding documentation by describing R-Car Gen3 and
RZ/G2 CMT1 as "48-bit CMT devices".

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 20 ++++----
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index c7fdcb0..a444cfc 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -28,9 +28,9 @@ Required Properties:
     - "renesas,r8a77470-cmt0" for the 32-bit CMT0 device included in r8a77470.
     - "renesas,r8a77470-cmt1" for the 48-bit CMT1 device included in r8a77470.
     - "renesas,r8a774a1-cmt0" for the 32-bit CMT0 device included in r8a774a1.
-    - "renesas,r8a774a1-cmt1" for the 48-bit CMT1 device included in r8a774a1.
+    - "renesas,r8a774a1-cmt1" for the 48-bit CMT devices included in r8a774a1.
     - "renesas,r8a774c0-cmt0" for the 32-bit CMT0 device included in r8a774c0.
-    - "renesas,r8a774c0-cmt1" for the 48-bit CMT1 device included in r8a774c0.
+    - "renesas,r8a774c0-cmt1" for the 48-bit CMT devices included in r8a774c0.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
@@ -42,19 +42,19 @@ Required Properties:
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
     - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
     - "renesas,r8a7795-cmt0" for the 32-bit CMT0 device included in r8a7795.
-    - "renesas,r8a7795-cmt1" for the 48-bit CMT1 device included in r8a7795.
+    - "renesas,r8a7795-cmt1" for the 48-bit CMT devices included in r8a7795.
     - "renesas,r8a7796-cmt0" for the 32-bit CMT0 device included in r8a7796.
-    - "renesas,r8a7796-cmt1" for the 48-bit CMT1 device included in r8a7796.
+    - "renesas,r8a7796-cmt1" for the 48-bit CMT devices included in r8a7796.
     - "renesas,r8a77965-cmt0" for the 32-bit CMT0 device included in r8a77965.
-    - "renesas,r8a77965-cmt1" for the 48-bit CMT1 device included in r8a77965.
+    - "renesas,r8a77965-cmt1" for the 48-bit CMT devices included in r8a77965.
     - "renesas,r8a77970-cmt0" for the 32-bit CMT0 device included in r8a77970.
-    - "renesas,r8a77970-cmt1" for the 48-bit CMT1 device included in r8a77970.
+    - "renesas,r8a77970-cmt1" for the 48-bit CMT devices included in r8a77970.
     - "renesas,r8a77980-cmt0" for the 32-bit CMT0 device included in r8a77980.
-    - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in r8a77980.
+    - "renesas,r8a77980-cmt1" for the 48-bit CMT devices included in r8a77980.
     - "renesas,r8a77990-cmt0" for the 32-bit CMT0 device included in r8a77990.
-    - "renesas,r8a77990-cmt1" for the 48-bit CMT1 device included in r8a77990.
+    - "renesas,r8a77990-cmt1" for the 48-bit CMT devices included in r8a77990.
     - "renesas,r8a77995-cmt0" for the 32-bit CMT0 device included in r8a77995.
-    - "renesas,r8a77995-cmt1" for the 48-bit CMT1 device included in r8a77995.
+    - "renesas,r8a77995-cmt1" for the 48-bit CMT devices included in r8a77995.
     - "renesas,sh73a0-cmt0" for the 32-bit CMT0 device included in sh73a0.
     - "renesas,sh73a0-cmt1" for the 48-bit CMT1 device included in sh73a0.
     - "renesas,sh73a0-cmt2" for the 32-bit CMT2 device included in sh73a0.
@@ -69,7 +69,7 @@ Required Properties:
 		listed above.
     - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3
 		and RZ/G2.
-    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3
+    - "renesas,rcar-gen3-cmt1" for 48-bit CMT devices included in R-Car Gen3
 		and RZ/G2.
 		These are fallbacks for R-Car Gen3 and RZ/G2 entries listed
 		above.
