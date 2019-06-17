Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492EEC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BC92073F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="S4U1Sxe+";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="bu2bbmvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfFQNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:52:40 -0400
Received: from node.akkea.ca ([192.155.83.177]:55030 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbfFQNwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:52:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 474224E2056;
        Mon, 17 Jun 2019 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1560779558; bh=Aj++pHqYU38RgUVjzVhEsZzLuCxpd2JOWAVI9sMYaRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S4U1Sxe+4C3i45G0++fjoKLLoPuGiYFnV45LIR7xwcQkULJRaR5cEBqgltUBTqJxQ
         yvqkDt4Hrhf5iYXT1GLniZvCZaUTWe4KHi6y/yEMigYxEtN7QoitL87wJxuA53YBnN
         vgtvIeADmhw402/LJsmHbwXc5VlVtFtN15yxd+i4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mZszWopw6Xxc; Mon, 17 Jun 2019 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id C689F4E204B;
        Mon, 17 Jun 2019 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1560779557; bh=Aj++pHqYU38RgUVjzVhEsZzLuCxpd2JOWAVI9sMYaRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bu2bbmvf3kv1ajxpc5pSLVRtt/qGYs3YFRSxRn9ek1HHdXi8vbftnE+Pg/HP+NuMd
         LrFfAYckOBiFIK/M//9PjNhkmj5RThaS+nI8i+sqkyaTaMsH+q0VafgGIRm2we3CcF
         dBrPRf6vdbp6om2cGXX2foxz5EmOJhbiIqKM53uY=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: [PATCH v16 2/3] dt-bindings: Add an entry for Purism SPC
Date:   Mon, 17 Jun 2019 07:52:14 -0600
Message-Id: <20190617135215.550-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617135215.550-1-angus@akkea.ca>
References: <20190617135215.550-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 64854a9e4c57..8835ef3aae4f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -735,6 +735,8 @@ patternProperties:
     description: PROBOX2 (by W2COMP Co., Ltd.)
   "^pulsedlight,.*":
     description: PulsedLight, Inc
+  "^purism,.*":
+    description: Purism, SPC
   "^qca,.*":
     description: Qualcomm Atheros, Inc.
   "^qcom,.*":
-- 
2.17.1

