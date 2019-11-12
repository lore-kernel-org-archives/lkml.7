Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4260C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3C920650
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wlRHM3yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfKLO27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:28:59 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39090 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfKLO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:28:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACESvZr099195;
        Tue, 12 Nov 2019 08:28:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568937;
        bh=TsBneoZKzB5CGJwt7jeP9UzozJx7lt2k4GHROFzZFr4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wlRHM3yWHL0rFtBAk6uDypIdACh9ZLDgvbPgdkg13Hcn+r6MUdiidiOqxuGpwm9tM
         qCZ6k+MQGl51wGA+q610eJaBTw3j2lgXFLbNxjjQtq45NNH4gOHop2wJJtfEYPmCOJ
         bfwiNpDWmZUi3vxHOZ5RKKHTNJBbrPsCDcbFqvNM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACESvwA018187
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:28:57 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:28:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:39 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriE044422;
        Tue, 12 Nov 2019 08:28:56 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 02/20] dt-bindings: media: cal: update binding example
Date:   Tue, 12 Nov 2019 08:31:34 -0600
Message-ID: <20191112143152.23176-3-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112143152.23176-1-bparrot@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update binding example to show proper endpoint properties and linkage.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 .../devicetree/bindings/media/ti-cal.txt      | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/ti-cal.txt b/Documentation/devicetree/bindings/media/ti-cal.txt
index 93096d924786..7e960cf26e23 100644
--- a/Documentation/devicetree/bindings/media/ti-cal.txt
+++ b/Documentation/devicetree/bindings/media/ti-cal.txt
@@ -27,7 +27,6 @@ Documentation/devicetree/bindings/media/video-interfaces.txt.
 Example:
 	cal: cal@4845b000 {
 		compatible = "ti,dra72-cal";
-		ti,hwmods = "cal";
 		reg = <0x4845B000 0x400>,
 		      <0x4845B800 0x40>,
 		      <0x4845B900 0x40>;
@@ -45,9 +44,10 @@ Example:
 
 			csi2_0: port@0 {
 				reg = <0>;
-				endpoint {
-					slave-mode;
-					remote-endpoint = <&ar0330_1>;
+				csi2_phy0: endpoint {
+					remote-endpoint = <&csi2_cam0>;
+					clock-lanes = <0>;
+					data-lanes = <1 2>;
 				};
 			};
 			csi2_1: port@1 {
@@ -57,19 +57,20 @@ Example:
 	};
 
 	i2c5: i2c@4807c000 {
-		ar0330@10 {
-			compatible = "ti,ar0330";
-			reg = <0x10>;
+		clock-frequency = <400000>;
 
-			port {
-				#address-cells = <1>;
-				#size-cells = <0>;
+		camera-sensor@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+
+			clocks = <&clk_fixed>;
+			clock-names = "xclk";
 
-				ar0330_1: endpoint {
-					reg = <0>;
-					clock-lanes = <1>;
-					data-lanes = <0 2 3 4>;
-					remote-endpoint = <&csi2_0>;
+			port {
+				csi2_cam0: endpoint {
+					remote-endpoint = <&csi2_phy0>;
+					clock-lanes = <0>;
+					data-lanes = <1 2>;
 				};
 			};
 		};
-- 
2.17.1

