Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8FDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FD520578
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439362AbfJYKaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:30:17 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:58243 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407901AbfJYKaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:30:16 -0400
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9PATddR051879
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 25 Oct 2019 18:29:39 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 25 Oct 2019 18:29:40
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 1/3] dt-bindings: serial: Add a new compatible string for SC9863A
Date:   Fri, 25 Oct 2019 18:29:13 +0800
Message-ID: <20191025102915.23677-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9PATddR051879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


SC9863A use the same serial device which SC9836 uses.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/serial/sprd-uart.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index 9607dc616205..0a9f8a7809e1 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: must be one of:
   * "sprd,sc9836-uart"
   * "sprd,sc9860-uart", "sprd,sc9836-uart"
+  * "sprd,sc9863-uart", "sprd,sc9836-uart"
 
 - reg: offset and length of the register set for the device
 - interrupts: exactly one interrupt specifier
-- 
2.20.1


