Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4DFC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADDB21479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IMY/z6lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfILKiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:38:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53966 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILKiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:38:08 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EEF533A;
        Thu, 12 Sep 2019 12:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1568284686;
        bh=oEZwKKZfoB39rIHVguV/Mi482TNps8xNyQ8BfbqvOB8=;
        h=From:To:Cc:Subject:Date:From;
        b=IMY/z6lqnv1bfvjbv0Gtt+hv07eVPmX/ydFh9YOmqr73nItwhbr5dAl7bcretH9li
         H+7uYGkb+AeI869DOfVw7tUk8xYZHoDWzKtn8e6xnIHxem9Kwxjnn1UERNgmJidY1m
         jh5IIHKQbFnvaFAJPMNbSMNYCBzZmxy5M9oUj1Jo=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm: dts: renesas: r8a77980: Remove r8a77970 DU compatible
Date:   Thu, 12 Sep 2019 11:37:34 +0100
Message-Id: <20190912103734.1879-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The r8a77970 was added with an compatible string for a differnet device
rather than adding the correct compatible to the driver.

Remove the unnecessary compatible which is for a different platform.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
Please note, this patch should not be integrated until the renesas,du-r8a77980
compatible string makes it into the DU [0].

[0] https://lore.kernel.org/linux-renesas-soc/a9cc2193-0a18-0490-c273-c64bd70992f5@ideasonboard.com/T/#t

 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 042f4089e546..c6195377d181 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -1487,8 +1487,7 @@
 		};
 
 		du: display@feb00000 {
-			compatible = "renesas,du-r8a77980",
-				     "renesas,du-r8a77970";
+			compatible = "renesas,du-r8a77980";
 			reg = <0 0xfeb00000 0 0x80000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 724>;
-- 
2.20.1

