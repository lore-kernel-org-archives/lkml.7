Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE3C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EE421881
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596121;
	bh=6Sp5x8S886L5spv2yGt0k07vOzOJRvdAmBeiH7wNofc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yC0G80ZnK03oobOO2yZlGiOg5V0iIdfCZwZvs2OWXLzGWr4OeBUMvHuUahEJHbdIx
	 6LERqS76yHGnonfewQ2CAMSrS+B9MhZ3WKz7hUhiJfJg2v2S11fiosOC8sPTZy2cSa
	 +txg47gNjmrIGfnuRqjNfFHhpOZy1dwf0dL3kQnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfF0Al7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfF0Al4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:41:56 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7A821881;
        Thu, 27 Jun 2019 00:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596116;
        bh=6Sp5x8S886L5spv2yGt0k07vOzOJRvdAmBeiH7wNofc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sD/IHQBJaRCTj7dOTRvDmznsXSLd1gvgKM2HKD/zUstsunGJupHTMBPJNOLgcU0Yk
         dAzBmhlLZjXZl2ogI29dnGmGxQ46au0cHerZoDVcbfnL5u4Dmo39XkGcTr5wT5MGaz
         7+2nic7oLy4TQfKDscI8I/PcEz1p+gc+7f3JRHDg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 10/21] dt-bindings: can: mcp251x: add mcp25625 support
Date:   Wed, 26 Jun 2019 20:41:10 -0400
Message-Id: <20190627004122.21671-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627004122.21671-1-sashal@kernel.org>
References: <20190627004122.21671-1-sashal@kernel.org>
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

