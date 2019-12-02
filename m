Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D7EC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A262070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfLBK3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:29:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:57574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727433AbfLBK3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:29:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2779B2BF;
        Mon,  2 Dec 2019 10:29:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 6/9] dt-bindings: arm: realtek: Add RTD1395 and Banana Pi BPI-M4
Date:   Mon,  2 Dec 2019 11:29:07 +0100
Message-Id: <20191202102910.26916-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202102910.26916-1-afaerber@suse.de>
References: <20191202102910.26916-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define compatible strings for Realtek RTD1395 SoC and BPI-M4 SBC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2: Unchanged
 * Picked up Reviewed-by from Rob
 
 Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index 445c56cbdcbb..dc097ed5a7e5 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -41,6 +41,12 @@ properties:
               - synology,ds418 # Synology DiskStation DS418
           - const: realtek,rtd1296
 
+      # RTD1395 SoC based boards
+      - items:
+          - enum:
+              - bananapi,bpi-m4 # Banana Pi BPI-M4
+          - const: realtek,rtd1395
+
       # RTD1619 SoC based boards
       - items:
           - enum:
-- 
2.16.4

