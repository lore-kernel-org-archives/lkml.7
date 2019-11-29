Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97389C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08521774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfK2JWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:22:51 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55190 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2JWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:22:51 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 40F9C1A0407;
        Fri, 29 Nov 2019 10:22:49 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 81E491A03FE;
        Fri, 29 Nov 2019 10:22:45 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8DAA2402A7;
        Fri, 29 Nov 2019 17:22:40 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     peda@axentia.se, leoyang.li@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [v6,1/3] dt-bindings: i2c: support property idle-state
Date:   Fri, 29 Nov 2019 17:22:20 +0800
Message-Id: <20191129092222.2706-1-biwen.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports property idle-state

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v6:
	- none

Change in v5:
	- none

Change in v4:
	- none

Change in v3:
	- update subject and description
	- add some information for property idle-state

Change in v2:
	- update subject and description
	- add property idle-state

 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index 30ac6a60f041..7abda506b828 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -25,6 +25,8 @@ Required Properties:
 Optional Properties:
 
   - reset-gpios: Reference to the GPIO connected to the reset input.
+  - idle-state: if present, overrides i2c-mux-idle-disconnect,
+    Please refer to Documentation/devicetree/bindings/mux/mux-controller.txt
   - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
     children in idle state. This is necessary for example, if there are several
     multiplexers on the bus and the devices behind them use same I2C addresses.
-- 
2.17.1

