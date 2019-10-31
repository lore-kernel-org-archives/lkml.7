Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEE5CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1F120873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfJaQxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:53:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:34772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728561AbfJaQxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:53:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E88A8B2FB;
        Thu, 31 Oct 2019 16:53:10 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: arm: realtek: Add RTD1195 and MeLE X1000
Date:   Thu, 31 Oct 2019 17:53:04 +0100
Message-Id: <20191031165308.14102-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191031165308.14102-1-afaerber@suse.de>
References: <20191031165308.14102-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Realtek RTD1195 SoC and MeLE X1000 TV box.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2: Unchanged
 * Added Reviewed-by
 
 Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index ab59de17152d..091616880d25 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -14,6 +14,12 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      # RTD1195 SoC based boards
+      - items:
+          - enum:
+              - mele,x1000 # MeLE X1000
+          - const: realtek,rtd1195
+
       # RTD1293 SoC based boards
       - items:
           - enum:
-- 
2.16.4

