Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F8C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B591720873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KriwyGQr";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ENmR4X3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEMUXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:23:10 -0400
Received: from node.akkea.ca ([192.155.83.177]:47936 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfEMUXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:23:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 128724E2058;
        Mon, 13 May 2019 20:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557778988; bh=bLmus07ZtGpPjQkmnxTr8q/vrmMNTrER0QBD1MkZdFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KriwyGQr13Xo4lEJDQfFI10YLsCyga4C5CUSuYXiA8grEfNOsDu33OFfF/LeboBpu
         IlAD9MBXFUBxA8wxTCRz56OzfLsZvnIoeeeqh9DY2UZsR9RrKaAf5o3DO04yYySsRs
         dxuFfu300RQ6MoZMfSUOUbyQ4/2aFJBxIVUDGcQQ=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SbmZdxK1_-PM; Mon, 13 May 2019 20:23:07 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 40B214E204D;
        Mon, 13 May 2019 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557778987; bh=bLmus07ZtGpPjQkmnxTr8q/vrmMNTrER0QBD1MkZdFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ENmR4X3KWgXDsIW8cF90ZO5pGXWekj5ntAm5zp6SNBu9xM+xyE92n8Wc4qsFobCWN
         ew5QiuzZECyfcdl5Ithsk+2ebLUKksdTFSkY4J3S370ZuOzvAx58IOYiVebv6W3oZ6
         gEHT0fmp5VNK+H5fe9ptiRjk9lV+2YVn0SZvWNl8=
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
Subject: [PATCH v11 3/4] dt-bindings: Add an entry for Purism SPC
Date:   Mon, 13 May 2019 13:22:57 -0700
Message-Id: <20190513202258.30949-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513202258.30949-1-angus@akkea.ca>
References: <20190513202258.30949-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index e9034a6c003a..64bb1fa1a4d5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -333,6 +333,7 @@ poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 probox2	PROBOX2 (by W2COMP Co., Ltd.)
 pulsedlight	PulsedLight, Inc
+purism	Purism, SPC
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qemu	QEMU, a generic and open source machine emulator and virtualizer
-- 
2.17.1

