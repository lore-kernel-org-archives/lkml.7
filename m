Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF52C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C981208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKUFC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:02:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbfKUFCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:02:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6FE5B14A;
        Thu, 21 Nov 2019 05:02:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 7/9] dt-bindings: interrupt-controller: rtd1195-mux: Add RTD1395
Date:   Thu, 21 Nov 2019 06:02:06 +0100
Message-Id: <20191121050208.11324-8-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121050208.11324-1-afaerber@suse.de>
References: <20191121050208.11324-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for Realtek RTD1395 SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4 -> v5: Unchanged
 
 v4: New
 
 .../devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml
index 5cf3a28cedba..7c2a31548d46 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1195-mux.yaml
@@ -19,6 +19,8 @@ properties:
       - realtek,rtd1195-iso-irq-mux
       - realtek,rtd1295-misc-irq-mux
       - realtek,rtd1295-iso-irq-mux
+      - realtek,rtd1395-misc-irq-mux
+      - realtek,rtd1395-iso-irq-mux
 
   reg:
     maxItems: 1
-- 
2.16.4

