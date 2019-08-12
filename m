Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA2A216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TO9wVyVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfHLL3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18444 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbfHLL3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d890007>; Mon, 12 Aug 2019 04:29:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:29:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 04:29:03 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:02 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d7b0000>; Mon, 12 Aug 2019 04:29:02 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 07/14] serial: tegra: add compatible for new chips
Date:   Mon, 12 Aug 2019 16:58:16 +0530
Message-ID: <1565609303-27000-8-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609354; bh=xUV7cCxrNBKpWRz8LPBZJwzzZhog/ITvNlddt3ERxp8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TO9wVyVo9F0QArP5Fut2YL0fK80qmtM4SPMSt4tayGOf/dgXj6Ughh8DE6Xal2Iw6
         6Bnbw+Z7Q+q6FUvKQk3C2E3ypqpvMiEQS3Kf+MFNUVOFvv8l9y1QRytg+n4AHEg9Yj
         QAnhXTNGqPb31v2N3HQDWUwlImLV0lBf/OmVmshYuxOq/vLSDjisTThVDdKp5wO+sL
         bf8e4JJ+HdaYYEXEcC3lArr95o4vuKG/waa7vDAxeevwYgpqn/5wtyPP0bIHtsjHRu
         N90A9JJrZNRQCSSyMMIehrK156ArTq8pUkG5t8QnYhENYx+5CJjKuW0umrL/398iUC
         guqJf2dW2nXqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for Tegra186. It differs from earlier chips
as it has fifo mode enable check and 8 byte dma buffer.
Add new compatible string for Tegra194. Tegra194 has different error
tolerance levels for baud rate compared to older chips.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
index d7edf73..187ec78 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
@@ -1,7 +1,8 @@
 NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
 
 Required properties:
-- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
+- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart",
+  nvidia,tegra186-hsuart, nvidia,tegra194-hsuart.
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
 - clocks: Must contain one entry, for the module clock.
-- 
2.7.4

