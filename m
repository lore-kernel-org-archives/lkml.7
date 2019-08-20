Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358E4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1838205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566315328;
	bh=vDZYy9MTuzLGK/2LPbkV8unZtsGhbw0xmmDGyROJ4HA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Wf8pjJNzcMuEiYgMcONDsmWOKmgLhtsvIkRuCtf5wKCRxAdBQ9qK2YcFaU2WxGtUw
	 EL+2N89O+w0NVTd+oHpJ+W7/lmvkIsaEddkTjyRo4Ov1BH0SiBKy3KEl4MLwLXERtL
	 jAWJWJ0w9uGJGLF1LJbQ63Wg+xOF5Omr1Kneh6vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfHTPf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfHTPf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:35:26 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4862F2054F;
        Tue, 20 Aug 2019 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566315326;
        bh=vDZYy9MTuzLGK/2LPbkV8unZtsGhbw0xmmDGyROJ4HA=;
        h=From:To:Cc:Subject:Date:From;
        b=i1A3gY46/kM/M3DgofdWIxOe8Ic5riOHcLAVTEIcpEtj7svZrseHllPrYik69XMi9
         hWvVact5Xn6Rxa1RoYH179PEP50dlMFjb3wWGQWyhlZbMPv6hadYOsgyikwNivaB10
         IkslOwRyXsJ962oGYcqyEZ7VVymgr9jD1JbaLz8A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: vendor-prefixes: Add Anvo-Systems
Date:   Tue, 20 Aug 2019 17:35:15 +0200
Message-Id: <1566315318-30320-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Anvo-Systems Dresden GmbH.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v4:
None

Changes since v3:
1. Add Rob's tag,
2. Remove Admatec (not needed anymore).

Changes since v2:
1. Use admatecde vendor prefix.
2. Add Anvo-Systems Dresden GmbH.

Changes since v1:
New patch
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbbbffab..519889f5aec8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -81,6 +81,8 @@ patternProperties:
     description: Analogix Semiconductor, Inc.
   "^andestech,.*":
     description: Andes Technology Corporation
+  "^anvo,.*":
+    description: Anvo-Systems Dresden GmbH
   "^apm,.*":
     description: Applied Micro Circuits Corporation (APM)
   "^aptina,.*":
-- 
2.7.4

