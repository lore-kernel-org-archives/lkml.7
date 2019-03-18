Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C64EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97872087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfCRKF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:27 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45287 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfCRKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:26 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B11991BF21E;
        Mon, 18 Mar 2019 10:05:22 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH] dt-bindings: cpu: Fix JSON schema
Date:   Mon, 18 Mar 2019 11:05:21 +0100
Message-Id: <20190318100521.29109-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for
Milbeaut") added support for a new cpu enable-method, but did so using
tabulations to ident. This is however invalid in the syntax, and resulted
in a failure when trying to use that schemas for validation.

Use spaces instead of tabs to indent to fix this.

Fixes: fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for Milbeaut")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 365dcf384d73..82dd7582e945 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -228,7 +228,7 @@ patternProperties:
                 - renesas,r9a06g032-smp
                 - rockchip,rk3036-smp
                 - rockchip,rk3066-smp
-		- socionext,milbeaut-m10v-smp
+                - socionext,milbeaut-m10v-smp
                 - ste,dbx500-smp
 
       cpu-release-addr:
-- 
2.20.1

