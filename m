Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C11C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5463F20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbfHBHYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:24:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33004 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbfHBHYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:24:16 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D9301A00E0;
        Fri,  2 Aug 2019 09:24:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 575C81A0112;
        Fri,  2 Aug 2019 09:24:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2CDB3402EE;
        Fri,  2 Aug 2019 15:24:06 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: mailbox: imx-mu: add imx7ulp MU support
Date:   Fri,  2 Aug 2019 15:01:39 +0800
Message-Id: <1564729300-30374-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564729300-30374-1-git-send-email-hongxing.zhu@nxp.com>
References: <1564729300-30374-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu" compatible
to support it.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index f3cf77e..9c43357 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -21,6 +21,8 @@ Required properties:
 		imx6sx, imx7s, imx8qxp, imx8qm.
 		The "fsl,imx6sx-mu" compatible is seen as generic and should
 		be included together with SoC specific compatible.
+		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
+		compatible to support it.
 - reg :		Should contain the registers location and length
 - interrupts :	Interrupt number. The interrupt specifier format depends
 		on the interrupt controller parent.
-- 
2.7.4

