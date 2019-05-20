Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D5AC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFB320657
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="l4BU4Lfv";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="l4BU4Lfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbfETOXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:23:41 -0400
Received: from node.akkea.ca ([192.155.83.177]:50758 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730548AbfETOXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:23:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C01E94E2058;
        Mon, 20 May 2019 14:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558362218; bh=tOoqBy3aidFhwiqgQqY070/E2k6qxkmB9T3k1Kktj8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=l4BU4Lfvx1aaNv5VX5jdudxEGUl3OV3NahJtw5PTFyx9tkvBh8UzFJbgD90AfCL7l
         yjz0vL/NjHUkrhzXI6WvSXF5H5UmyLqczt/CxE/KArEsQKEgKP1CQWrh5RM5YpKdkh
         LdHj/zAJcvzZLLNMAJFXqvLXioIwUcBfUo8GACDY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dCEp_4mY6gO1; Mon, 20 May 2019 14:23:38 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 03CD64E204D;
        Mon, 20 May 2019 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558362218; bh=tOoqBy3aidFhwiqgQqY070/E2k6qxkmB9T3k1Kktj8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=l4BU4Lfvx1aaNv5VX5jdudxEGUl3OV3NahJtw5PTFyx9tkvBh8UzFJbgD90AfCL7l
         yjz0vL/NjHUkrhzXI6WvSXF5H5UmyLqczt/CxE/KArEsQKEgKP1CQWrh5RM5YpKdkh
         LdHj/zAJcvzZLLNMAJFXqvLXioIwUcBfUo8GACDY=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v13 3/4] dt-bindings: Add an entry for Purism SPC
Date:   Mon, 20 May 2019 07:23:29 -0700
Message-Id: <20190520142330.3556-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520142330.3556-1-angus@akkea.ca>
References: <20190520142330.3556-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 33a65a45e319..104595f55f34 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -683,6 +683,8 @@ patternProperties:
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

