Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B17C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FE8206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfJHKje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:39:34 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:52530 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730580AbfJHKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:39:31 -0400
X-IronPort-AV: E=Sophos;i="5.67,270,1566831600"; 
   d="scan'208";a="28359376"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Oct 2019 19:39:30 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 14755400941B;
        Tue,  8 Oct 2019 19:39:25 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH 06/10] dt-bindings: usb: renesas_usb3: Document r8a774b1 support
Date:   Tue,  8 Oct 2019 11:38:48 +0100
Message-Id: <1570531132-21856-7-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2N (R8A774B1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
index 5eecfbc..1343dfc 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
+++ b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
@@ -3,6 +3,7 @@ Renesas Electronics USB3.0 Peripheral driver
 Required properties:
   - compatible: Must contain one of the following:
 	- "renesas,r8a774a1-usb3-peri"
+	- "renesas,r8a774b1-usb3-peri"
 	- "renesas,r8a774c0-usb3-peri"
 	- "renesas,r8a7795-usb3-peri"
 	- "renesas,r8a7796-usb3-peri"
-- 
2.7.4

