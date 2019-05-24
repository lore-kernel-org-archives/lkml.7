Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037FAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D083B21848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nzVtAW6q";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nF7p9akw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbfEXSdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:33:12 -0400
Received: from node.akkea.ca ([192.155.83.177]:52648 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732054AbfEXSdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:33:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 88BCE4E2050;
        Fri, 24 May 2019 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558722787; bh=LmQmUojdQSRgprO3m2DjN3DljwNQT9zOpEdeZGWgzBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nzVtAW6q5kxieimwEOFI9OX768YjDfMtsbfESF9mIf5p9c6UvL9qX788MupSFEVHx
         BCWHL8BjHulNrQTYbps3jzXTNqqLL37nRyXL05LItaKdy7VsBXcY5yqNfgUCm6p52p
         0pd1+/aNxBYCHYnJ3lEWYI+tBtCZbmV0H2JhF7xY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hgEYkabp4wt5; Fri, 24 May 2019 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [24.244.23.228])
        by node.akkea.ca (Postfix) with ESMTPSA id CEE034E204B;
        Fri, 24 May 2019 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558722786; bh=LmQmUojdQSRgprO3m2DjN3DljwNQT9zOpEdeZGWgzBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nF7p9akwmfKryeBlra/1SbTeWO7OO1fYEglIgqbQDnVccpRnHQ3nnxU7h0yo6XZ2D
         Ak81BB1OmadnQw76BTjTh2MND/0QhZuvGVdppTjTaHaFRI8uDClmRVSu3GPL3VFwJI
         zZo+sfIjsYkopt6ijoGKpJ/kebmPuVjhmynBPYCY=
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
Subject: [PATCH v14 2/3] dt-bindings: Add an entry for Purism SPC
Date:   Fri, 24 May 2019 12:32:56 -0600
Message-Id: <20190524183257.16066-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524183257.16066-1-angus@akkea.ca>
References: <20190524183257.16066-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 749e3c3843d0..07d5211a8192 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -687,6 +687,8 @@ patternProperties:
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

