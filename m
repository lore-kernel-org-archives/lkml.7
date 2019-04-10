Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF48C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A2320854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfDJOLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:11:20 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:42273 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732564AbfDJOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:11:19 -0400
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:49602 helo=purcell.lan)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1hEDwW-0003AE-Ns; Wed, 10 Apr 2019 16:11:12 +0200
From:   Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     heiko@sntech.de,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: simple-panel: Set compatible string to "simple-panel".
Date:   Wed, 10 Apr 2019 16:10:45 +0200
Message-Id: <20190410141045.58097-2-christoph.muellner@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190410141045.58097-1-christoph.muellner@theobroma-systems.com>
References: <20190410141045.58097-1-christoph.muellner@theobroma-systems.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for simple-panel lists "cptt,claa101wb01" as
compatible string. However, the kernel contains no driver, which
recognizes this string. Therefore this patch replaces the compatible
string with "simple-panel".

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 Documentation/devicetree/bindings/display/panel/simple-panel.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
index b2b872c710f2..2000692ba44f 100644
--- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
@@ -18,7 +18,7 @@ Optional properties:
 Example:
 
 	panel: panel {
-		compatible = "cptt,claa101wb01";
+		compatible = "simple-panel";
 		ddc-i2c-bus = <&panelddc>;
 
 		power-supply = <&vdd_pnl_reg>;
-- 
2.11.0

