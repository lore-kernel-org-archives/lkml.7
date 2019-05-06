Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E8C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E966F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfEFJLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:11:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44078 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfEFJLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:11:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D848F1A0017;
        Mon,  6 May 2019 11:11:36 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EF4DB1A001D;
        Mon,  6 May 2019 11:11:31 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9AD89402EB;
        Mon,  6 May 2019 17:11:25 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 4/4] dt-bindings: fsl-qdma: Add LS1028A qDMA bindings
Date:   Mon,  6 May 2019 09:03:44 +0000
Message-Id: <20190506090344.37784-4-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190506090344.37784-1-peng.ma@nxp.com>
References: <20190506090344.37784-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LS1028A qDMA controller bindings to fsl-qdma bindings.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-qdma.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
index 6a0ff90..da371c4 100644
--- a/Documentation/devicetree/bindings/dma/fsl-qdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -7,6 +7,7 @@ Required properties:
 
 - compatible:		Must be one of
 			 "fsl,ls1021a-qdma": for LS1021A Board
+			 "fsl,ls1028a-qdma": for LS1028A Board
 			 "fsl,ls1043a-qdma": for ls1043A Board
 			 "fsl,ls1046a-qdma": for ls1046A Board
 - reg:			Should contain the register's base address and length.
-- 
1.7.1

