Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57484C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DE4218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfIQIfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:35:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47382 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfIQIfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:35:16 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8x7-0005kM-VW; Tue, 17 Sep 2019 10:35:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] dt-bindings: arm: rockchip: fix Theobroma-System board bindings
Date:   Tue, 17 Sep 2019 10:34:53 +0200
Message-Id: <20190917083453.25744-1-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naming convention for the existing Theobroma boards is
soc-q7module-baseboard, so rk3399-puma-haikou and the in-kernel
devicetrees also follow that scheme.

For some reason in the binding a wrong or outdated naming slipped
in which does not match the used devicetrees and makes the dt-schema
complain now.

Fix this by using the names used in the wild by actual boards.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7ecee58842f5..d85983de7919 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -501,12 +501,12 @@ properties:
 
       - description: Theobroma Systems RK3368-uQ7 with Haikou baseboard
         items:
-          - const: tsd,rk3368-uq7-haikou
+          - const: tsd,rk3368-lion-haikou
           - const: rockchip,rk3368
 
       - description: Theobroma Systems RK3399-Q7 with Haikou baseboard
         items:
-          - const: tsd,rk3399-q7-haikou
+          - const: tsd,rk3399-puma-haikou
           - const: rockchip,rk3399
 
       - description: Tronsmart Orion R68 Meta
-- 
2.20.1

