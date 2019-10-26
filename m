Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA74CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4215E214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="I3ShKtuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfJZT6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 15:58:08 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:49996 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfJZT6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oSlep1pt4/IfMQQC9WaEIjdiLqtANiUjKDmtIT6GXB0=; b=I3ShKtuBgButoixg8Rg+yvFL9k
        W+LAYEJ7V3mzSeuvwNIG0jGp6XmBcazRb6TfVTXoFZ7r2Bj9dXYB8Kcq/csW2NQXYhJe6xaRm7BFn
        3Ig5jRe8y3zWr9uVXFvC8OpxiO1jKxUbqDYzsfw6ODKsPiSmUMB+losTJeJtbNH18Xc0=;
Received: from p5dc580b6.dip0.t-ipconnect.de ([93.197.128.182] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iOSC9-0006sG-Fn; Sat, 26 Oct 2019 21:57:53 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1iOSC8-0003pE-U7; Sat, 26 Oct 2019 21:57:52 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: arm: fsl: add compatible string for Kobo Clara HD
Date:   Sat, 26 Oct 2019 21:57:46 +0200
Message-Id: <20191026195748.14562-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026195748.14562-1-andreas@kemnade.info>
References: <20191026195748.14562-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a compatible string for the Kobo Clara HD eBook reader.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7294ac36f4c0..afa3bfeca0c0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -148,6 +148,7 @@ properties:
         items:
           - enum:
               - fsl,imx6sll-evk
+              - kobo,clarahd
           - const: fsl,imx6sll
 
       - description: i.MX6SX based Boards
-- 
2.20.1

