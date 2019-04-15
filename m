Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D249B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="lj77zl2K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="fmScWsqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfDOXyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:54:05 -0400
Received: from node.akkea.ca ([192.155.83.177]:34158 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfDOXyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:54:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 025B14E2051;
        Mon, 15 Apr 2019 23:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555372443; bh=kefJ10uT59admwoknv1hs5rk9yWioJDK7dziWO0gvdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lj77zl2KmC537VWK5n5KfEA3GqIfF/ntsqg5AFbY6ChPAUu63Cpa4L+PYFdRx1tvb
         Ihjl1mBQgR5Rp4SCcoD29pOUngSTLpHHQn51Emh68SP2zC/ZCIVWViNxaOJJhsnCAb
         OHt8iX5C7sChS/YMUt6OftLxUmIYu0g1tGR27KnU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LMmRUur4CBik; Mon, 15 Apr 2019 23:54:02 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 3FD074E204B;
        Mon, 15 Apr 2019 23:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555372442; bh=kefJ10uT59admwoknv1hs5rk9yWioJDK7dziWO0gvdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fmScWsqmp/GlGOE9U7R/R01ySqWH53Qt1X9yYQNiT1KI2+FpwUxRZlLJVUsvcXb3I
         F2PCudBc79Fhi8EUEwpSWDkOeM5+1D918xQYuxkexx6pXek75BR0nF5QzM+YwgGe9T
         bIVUM8BqsHc3WxQPDl328ad1o0asCxGzFaISnGPM=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: Add an entry for Purism SPC
Date:   Mon, 15 Apr 2019 16:53:43 -0700
Message-Id: <20190415235343.16565-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415235343.16565-1-angus@akkea.ca>
References: <20190415235343.16565-1-angus@akkea.ca>
To:     unlisted-recipients:; (no To-header on input)
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
index 40f632db7bc2..44ba42e48007 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -331,6 +331,7 @@ poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 probox2	PROBOX2 (by W2COMP Co., Ltd.)
 pulsedlight	PulsedLight, Inc
+purism	Purism, SPC
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qemu	QEMU, a generic and open source machine emulator and virtualizer
-- 
2.17.1

