Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B95DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC502071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfLBSXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:23:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:35968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727671AbfLBSWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AABAAECB;
        Mon,  2 Dec 2019 18:22:15 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Tai <james.tai@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 05/14] ARM: dts: rtd1195: Add CRT syscon node
Date:   Mon,  2 Dec 2019 19:21:55 +0100
Message-Id: <20191202182205.14629-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202182205.14629-1-afaerber@suse.de>
References: <20191202182205.14629-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare a CRT syscon mfd node.

Cc: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/boot/dts/rtd1195.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index a74f530dc439..ac37366ff7c4 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -100,6 +100,15 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x18000000 0x70000>;
 
+			crt: syscon@0 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x0 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x0 0x1000>;
+			};
+
 			iso: syscon@7000 {
 				compatible = "syscon", "simple-mfd";
 				reg = <0x7000 0x1000>;
-- 
2.16.4

