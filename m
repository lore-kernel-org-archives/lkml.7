Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4A5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE3920B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfJVEXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:23:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55990 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbfJVEXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:23:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 663D01A0039;
        Tue, 22 Oct 2019 06:23:00 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A78B61A05CF;
        Tue, 22 Oct 2019 06:22:56 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1D0FD4030B;
        Tue, 22 Oct 2019 12:22:52 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     peda@axentia.se, leoyang.li@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [v5,1/3] dt-bindings: i2c: support property idle-state
Date:   Tue, 22 Oct 2019 12:11:50 +0800
Message-Id: <20191022041152.3663-1-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports property idle-state

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
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

