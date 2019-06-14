Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54CFC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC91E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544759;
	bh=9LfXJqPbTe49NZw+18AdoXCwnz+9y6RsODIwSQkuX3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWtVHZZLyMvLTBbOWpXBYOBxNi6y/zr/T+60EGjOl13cjqiDrcToX1O06tbR+wwG8
	 qj7hrw2YSnYOWDkMlmXpU5ARFbugfBBrKP6PZLeXfflWhYd0W/LkDH6f2kgLJ3AIY+
	 bxZmFdowEjNtFa31bVKgCWi1C3htjmyupaxE8ZMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfFNUjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfFNU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:28:53 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E36421852;
        Fri, 14 Jun 2019 20:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544132;
        bh=9LfXJqPbTe49NZw+18AdoXCwnz+9y6RsODIwSQkuX3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqyUKjFt2WThI8Eh3Z+dRlApivY5YgP23kFC7YwCyLYEnk3dKiF4GKk0TqppfL4jo
         7uZci1CtjW285YhCPUB1dge1spavFerkneieAPMy+rWba9l6ezPNfEWgaWrmkwN+Cx
         yzEvrtLrLegUI0uUQHit/E62XToiQLZP6ZPwvJsY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 5.1 12/59] ARC: [plat-hsdk]: Add missing FIFO size entry in GMAC node
Date:   Fri, 14 Jun 2019 16:27:56 -0400
Message-Id: <20190614202843.26941-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <joabreu@synopsys.com>

[ Upstream commit 4c70850aeb2e40016722cd1abd43c679666d3ca0 ]

Add the binding for RX/TX fifo size of GMAC node.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/boot/dts/hsdk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 699f372b2a6f..6219b372e9c1 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -196,6 +196,9 @@
 			mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
 			dma-coherent;
 
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <4096>;
+
 			mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.20.1

