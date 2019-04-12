Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB738C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83CE20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="R0LCFj2o";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="R0LCFj2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfDLNEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:04:42 -0400
Received: from node.akkea.ca ([192.155.83.177]:40804 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfDLNEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:04:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 93A724E2051;
        Fri, 12 Apr 2019 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555074280; bh=eLm+QPgz/4ve0Ul3GtlGhU4wuFZpXZDhK971fTIHNZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R0LCFj2oDgniHJtvbluj+Zw47BAbEpm5CvKcr035m6HSyHH2xmoePX8idS+GaYnEh
         pAo6kpvseBegdUouiAraP07JQhxz1qdcCtKhv5vn2hbjy/32nkuQlD/qGZqJcwQqUO
         6QT5/bsLKK3X3HGCCZUlMBuV+DZOvXASNc43GIyc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y7vmAWg3_FI0; Fri, 12 Apr 2019 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id A23AB4E204D;
        Fri, 12 Apr 2019 13:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555074280; bh=eLm+QPgz/4ve0Ul3GtlGhU4wuFZpXZDhK971fTIHNZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R0LCFj2oDgniHJtvbluj+Zw47BAbEpm5CvKcr035m6HSyHH2xmoePX8idS+GaYnEh
         pAo6kpvseBegdUouiAraP07JQhxz1qdcCtKhv5vn2hbjy/32nkuQlD/qGZqJcwQqUO
         6QT5/bsLKK3X3HGCCZUlMBuV+DZOvXASNc43GIyc=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: Add an entry for Purism SPC
Date:   Fri, 12 Apr 2019 07:04:27 -0600
Message-Id: <20190412130427.13418-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412130427.13418-1-angus@akkea.ca>
References: <20190412130427.13418-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8162b0eb4b50..ea5f3c711186 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -324,6 +324,7 @@ poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 probox2	PROBOX2 (by W2COMP Co., Ltd.)
 pulsedlight	PulsedLight, Inc
+purism	Purism, SPC
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qemu	QEMU, a generic and open source machine emulator and virtualizer
-- 
2.17.1

