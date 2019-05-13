Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EF0C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D115320879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="xMH57FpV";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="xMH57FpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfEMRlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:41:14 -0400
Received: from node.akkea.ca ([192.155.83.177]:42422 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731826AbfEMRlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:41:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id EEDF74E2056;
        Mon, 13 May 2019 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557769266; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xMH57FpVKbOPRJMQ/aOYfWAbHf+RQtfUKFy1l2Kc/AReh0dQ7DvLPD2fURm9qEHyg
         g2Biu1UxUtUJbax0aYax3nosozu8KfdtpVGh0GGrFlgl3XyN5LQ/Ek0cs2FA4M40M0
         yaj60NDJugQENm5BIiIpUewQy9qUBpwWtM+4LMTc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cK3IV_30aGiW; Mon, 13 May 2019 17:41:06 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 19DA54E204E;
        Mon, 13 May 2019 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557769266; bh=SfqX2EFJOvWCTClrRDpHw/tV94ED1IxtbtG2u/MWNBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xMH57FpVKbOPRJMQ/aOYfWAbHf+RQtfUKFy1l2Kc/AReh0dQ7DvLPD2fURm9qEHyg
         g2Biu1UxUtUJbax0aYax3nosozu8KfdtpVGh0GGrFlgl3XyN5LQ/Ek0cs2FA4M40M0
         yaj60NDJugQENm5BIiIpUewQy9qUBpwWtM+4LMTc=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v10 4/4] dt-bindings: arm: fsl: Add the imx8mq boards
Date:   Mon, 13 May 2019 10:40:57 -0700
Message-Id: <20190513174057.4410-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513174057.4410-1-angus@akkea.ca>
References: <20190513174057.4410-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

