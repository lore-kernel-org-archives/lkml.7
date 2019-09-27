Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE1FC32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AAA2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="WgPi0LTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfI0GOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:14:48 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:59200 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfI0GOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iTjbjBLlZNUf7fiO+mpGesCCDR2lZgGlABUR+mKo1cM=; b=WgPi0LTndqKS9D43+DanAqzdIm
        4I6vgelYfFEjcDcgb74zCvk5MmFU9KDB5L6/t675voAvnFN2mpEJVqImm9uKUn6UdrlCnLgNK7mAd
        xorrY8/0XYYbMHcQGhqO57gpVZgdgggEaiW+cClZY/7dttGxR2iKHV+Efb9UygP2n+yY=;
Received: from p200300ccff0e5f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:5f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iDjWY-0001kN-HL; Fri, 27 Sep 2019 08:14:41 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1iDjWY-0004VZ-7U; Fri, 27 Sep 2019 08:14:38 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/3] dt-bindings: arm: fsl: add compatible string for Kobo Clara HD
Date:   Fri, 27 Sep 2019 08:14:22 +0200
Message-Id: <20190927061423.17278-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927061423.17278-1-andreas@kemnade.info>
References: <20190927061423.17278-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a compatible string fro the Kobo Clara HD eBook reader.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
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

