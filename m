Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B4DC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12221205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596186;
	bh=6Sp5x8S886L5spv2yGt0k07vOzOJRvdAmBeiH7wNofc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=brShiEZkcajcuVipkH0Q/BYnS7Wiufs1WA7H5Y2Rt7Y1baOSUD91CG9qasGNbqbFp
	 v8CCSRjZ3fb8Mq1dZOvcH47ZxYmE251Ne+vghDozS4ThI0QUVudoYS5Hc4LQFOzNcb
	 XizYQH95BrbmAE32W7wCXNchxwWCwIAPbVpxfm+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfF0AnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbfF0AnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:43:03 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4592205ED;
        Thu, 27 Jun 2019 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596181;
        bh=6Sp5x8S886L5spv2yGt0k07vOzOJRvdAmBeiH7wNofc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y5JP6LgMcJAPt7z759PrNLKYgcwQT/BYpM0yXY2JF/cJ16aFFCuKR+QZf5gSNYJq7
         WA+BuEUJiOBs0vFMKGlyUPeoDkPCT6ZpR9V6BNUS8J5Ttdp9iN2GvdEoRBH/hi7jlv
         79qbrh2iuTy4RjczxAiiqsDMCEnRktZfbqK07Y7c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/12] dt-bindings: can: mcp251x: add mcp25625 support
Date:   Wed, 26 Jun 2019 20:42:28 -0400
Message-Id: <20190627004236.21909-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627004236.21909-1-sashal@kernel.org>
References: <20190627004236.21909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

[ Upstream commit 0df82dcd55832a99363ab7f9fab954fcacdac3ae ]

Fully compatible with mcp2515, the mcp25625 have integrated transceiver.

This patch add the mcp25625 to the device tree bindings documentation.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
index ee3723beb701..33b38716b77f 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
@@ -4,6 +4,7 @@ Required properties:
  - compatible: Should be one of the following:
    - "microchip,mcp2510" for MCP2510.
    - "microchip,mcp2515" for MCP2515.
+   - "microchip,mcp25625" for MCP25625.
  - reg: SPI chip select.
  - clocks: The clock feeding the CAN controller.
  - interrupt-parent: The parent interrupt controller.
-- 
2.20.1

