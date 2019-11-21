Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39781C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB0920C01
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306465;
	bh=BqQct8MurXEaQBIdn4W/JxxMj+Cw1+0kP+2a1H36etY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=P3EAs14BMq+Z7oLTiLQ0vxotBtk7AC6/zc48HkMIAwcVCTjEIJ7oYMpFz8rqkurMn
	 U6h6+dkL26ZxnDH0AzUSmer+KPoVESx8UnNcLym1+sWs9Jr8YatQzrZl/7pio7kxV8
	 mFqPSnLhGpE65NdoCC1tOMvKAxxTdGt7q9Twk+bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfKUDVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfKUDVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:21:01 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8AA208CE;
        Thu, 21 Nov 2019 03:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306461;
        bh=BqQct8MurXEaQBIdn4W/JxxMj+Cw1+0kP+2a1H36etY=;
        h=From:To:Cc:Subject:Date:From;
        b=wkTTcG/LeOpnQx+o0eJ95hmXusT7EtPXbJmXmcWOSzLxoD8b5QuXmh3ozlkv6gdM0
         siTTLCQ1N0XcKG+HqCit0fOPuz0Yn63XPj5QikxODO3Q9mOfxJ7CB7BKkk5FTLOiEJ
         f+ouWsVKT2xqhbUcmsi+aETAPi9pioz+/o3pJV0I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] riscv: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:57 +0100
Message-Id: <1574306457-6251-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 arch/riscv/Kconfig.socs | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 536c0ef4aee8..f89b73281737 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,13 +1,13 @@
 menu "SoC selection"
 
 config SOC_SIFIVE
-       bool "SiFive SoCs"
-       select SERIAL_SIFIVE
-       select SERIAL_SIFIVE_CONSOLE
-       select CLK_SIFIVE
-       select CLK_SIFIVE_FU540_PRCI
-       select SIFIVE_PLIC
-       help
-         This enables support for SiFive SoC platform hardware.
+	bool "SiFive SoCs"
+	select SERIAL_SIFIVE
+	select SERIAL_SIFIVE_CONSOLE
+	select CLK_SIFIVE
+	select CLK_SIFIVE_FU540_PRCI
+	select SIFIVE_PLIC
+	help
+	 This enables support for SiFive SoC platform hardware.
 
 endmenu
-- 
2.7.4

