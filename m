Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DFDC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C5E21670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934015;
	bh=2PGtoNThi1wmNK2eDCwm4czO2PFAuK2r3v/tdgqCp+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IcF5jfmwiNebtQkHDLBJPtR3l+uRD30i8Tk+fw7+rfExLPwyHaloQHV4R00bO6qXh
	 gkWxgODSBfoGNXljUAOl0KNZkbyjXg/dg63M2wEyp9NJKPEQFWnA452Y0QUYaqkl6N
	 EpfVZPBCVzuF5zasPpmzSuqDxcd27ML7qQy67DJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfGLMUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfGLMUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:20:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDBFD21670;
        Fri, 12 Jul 2019 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934011;
        bh=2PGtoNThi1wmNK2eDCwm4czO2PFAuK2r3v/tdgqCp+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4rfNxqXm183YYet9PXZHdP4mCcVJpLDl40M6KY6oojMDsRqcaevJGh99BBG05SY1
         u1cacX09SjebHm/W1nqDUFRQ6r7AiXaMOIVUVLRwfXRqZSOA2Xz8Zh1I567oQp0SFL
         BVLztyBreBUpAHO6tJw9VFw5u/T3573itrYIQr6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/91] dt-bindings: can: mcp251x: add mcp25625 support
Date:   Fri, 12 Jul 2019 14:18:21 +0200
Message-Id: <20190712121622.365085777@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 188c8bd4eb67..5a0111d4de58 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
@@ -4,6 +4,7 @@ Required properties:
  - compatible: Should be one of the following:
    - "microchip,mcp2510" for MCP2510.
    - "microchip,mcp2515" for MCP2515.
+   - "microchip,mcp25625" for MCP25625.
  - reg: SPI chip select.
  - clocks: The clock feeding the CAN controller.
  - interrupts: Should contain IRQ line for the CAN controller.
-- 
2.20.1



