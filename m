Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA602C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E0020830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfCYQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:08:15 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:49074 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:08:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 57E4BFB03;
        Mon, 25 Mar 2019 17:08:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1hbNicdu3xHO; Mon, 25 Mar 2019 17:08:10 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 91D8540385; Mon, 25 Mar 2019 17:08:10 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: display/panel: Add missing unit names
Date:   Mon, 25 Mar 2019 17:08:10 +0100
Message-Id: <901e836ea06889a9d91a799102b2a6b836d93dcd.1553529797.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some examples were missing the unit names triggering

 Warning (unit_address_vs_reg): .../panel: node has a reg or ranges property, but no unit name

warnings when used verbatim in DTs and running dtc with W=1.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../devicetree/bindings/display/panel/innolux,p079zca.txt       | 2 +-
 .../devicetree/bindings/display/panel/innolux,p097pfg.txt       | 2 +-
 .../devicetree/bindings/display/panel/kingdisplay,kd097d04.txt  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt b/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
index d0f55161579a..3ab8c7412cf6 100644
--- a/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p079zca.txt
@@ -12,7 +12,7 @@ Optional properties:
 Example:
 
 	&mipi_dsi {
-		panel {
+		panel@0 {
 			compatible = "innolux,p079zca";
 			reg = <0>;
 			power-supply = <...>;
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
index 595d9dfeffd3..d1cab3a8f0fb 100644
--- a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
@@ -13,7 +13,7 @@ Optional properties:
 Example:
 
 	&mipi_dsi {
-		panel {
+		panel@0 {
 			compatible = "innolux,p079zca";
 			reg = <0>;
 			avdd-supply = <...>;
diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
index 164a5fa236da..cfefff688614 100644
--- a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
+++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd097d04.txt
@@ -12,7 +12,7 @@ Optional properties:
 Example:
 
 	&mipi_dsi {
-		panel {
+		panel@0 {
 			compatible = "kingdisplay,kd097d04";
 			reg = <0>;
 			power-supply = <...>;
-- 
2.20.1

