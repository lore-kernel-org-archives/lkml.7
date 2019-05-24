Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87512C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7C21848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="iWpfqy8o";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="iWpfqy8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfEXSdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:33:14 -0400
Received: from node.akkea.ca ([192.155.83.177]:52666 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732058AbfEXSdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:33:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id A4A7E4E204E;
        Fri, 24 May 2019 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558722787; bh=duJfzh7N+uXE8UOPikoITZJHN+xJXuWQxWEXCUEz0yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iWpfqy8oAdV4GPnWb9v/ERiEuygQ+GXJby1L52bCW0uPMNCCzRa4GrXdgNXCOo9vs
         5pDo8t3xzXCdZRK6WJ/c2lvmc/kyzD6tGBer6pgIviMmmC0GxMxALFTwcaqZoGpH9y
         cupw1Tb8zvCIbE9FxfbzrQXkcSfVTJZpQf35gutM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RDhP_5DGI4bm; Fri, 24 May 2019 18:33:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [24.244.23.228])
        by node.akkea.ca (Postfix) with ESMTPSA id 95F944E204D;
        Fri, 24 May 2019 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558722787; bh=duJfzh7N+uXE8UOPikoITZJHN+xJXuWQxWEXCUEz0yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iWpfqy8oAdV4GPnWb9v/ERiEuygQ+GXJby1L52bCW0uPMNCCzRa4GrXdgNXCOo9vs
         5pDo8t3xzXCdZRK6WJ/c2lvmc/kyzD6tGBer6pgIviMmmC0GxMxALFTwcaqZoGpH9y
         cupw1Tb8zvCIbE9FxfbzrQXkcSfVTJZpQf35gutM=
From:   Angus Ainslie <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v14 3/3] dt-bindings: arm: fsl: Add the imx8mq boards
Date:   Fri, 24 May 2019 12:32:57 -0600
Message-Id: <20190524183257.16066-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524183257.16066-1-angus@akkea.ca>
References: <20190524183257.16066-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Add an entry for imx8mq based boards

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 407138ebc0d0..41364b127200 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -177,6 +177,13 @@ properties:
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
           - const: fsl,imx8mm
 
+      - description: i.MX8MQ based Boards
+        items:
+          - enum:
+              - fsl,imx8mq-evk            # i.MX8MQ EVK Board
+              - purism,librem5-devkit     # Purism Librem5 devkit
+          - const: fsl,imx8mq
+
       - description: i.MX8QXP based Boards
         items:
           - enum:
-- 
2.17.1

