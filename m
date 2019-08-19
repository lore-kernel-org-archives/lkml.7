Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D941C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1943822D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566238857;
	bh=MNZC6Uqf0f9r6GwGScL/7fsTZH9iOq4PrIAIf7lGyaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NXA1coxAH5Fget/Vwg6zj3o2/P3LUPgKEdqhDFjMiXo+zvRLsNm/EExbBap0hy9pP
	 9q3zXQYjxEBIWv5ibqaadoJIez3Xyi99QrJ9pfidoyW9GxZVD8LgC4lp8QLQ5Rflj8
	 H+s4504aAEel4GwP5Jk4B11CQiub6O3yk5LqoVOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfHSSUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfHSSUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:20:53 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DEA822CF8;
        Mon, 19 Aug 2019 18:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566238853;
        bh=MNZC6Uqf0f9r6GwGScL/7fsTZH9iOq4PrIAIf7lGyaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKC0uhVk/wnxsHfMuGkKO4ZYIvbGBQGkzT+FLFV2LJRmHX0f4KqQb/c0dRr7WaTzR
         0B22nnHOVxB3ApgIrz7RIxDLc3p/qpoDJD3s2TvDSRLuwP54Xa32pjKCtDqAefoJtM
         LckN3mO+SO/wfVHgFrqp8EyNvez5loTOcgHz9k5c=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 4/6] dt-bindings: watchdog: sun4i: Add the watchdog clock
Date:   Mon, 19 Aug 2019 20:20:37 +0200
Message-Id: <20190819182039.24892-4-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819182039.24892-1-mripard@kernel.org>
References: <20190819182039.24892-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The Allwinner watchdog has a clock that has been described in some DT, but
not all of them.

The binding is also completely missing that description. Let's add that
property to be consistent.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v1:
  - New patch
---
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
index 31c95c404619..3a54f58683a0 100644
--- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
@@ -31,12 +31,16 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
 required:
   - compatible
   - reg
+  - clocks
   - interrupts
 
 unevaluatedProperties: false
@@ -47,6 +51,7 @@ examples:
         compatible = "allwinner,sun4i-a10-wdt";
         reg = <0x01c20c90 0x10>;
         interrupts = <24>;
+        clocks = <&osc24M>;
         timeout-sec = <10>;
     };
 
-- 
2.21.0

