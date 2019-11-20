Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38749C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C34A22475
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257030;
	bh=duNY+VBU6lUzCzx1T0ATt0/eCL5uIdsG7lRXCgb9EJY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=seSgUwjhA0jnT7XuAyK5vPMLvbK+rA0bDNIpYm7gyERIB9unF6O/4oPZ7iL4hNSMi
	 cMEWs1ElMpu3jteud9Ojy9g4t3XkqQTllh1WZX8O1CfwiXSjNCjzZWPPg3K+woPuwM
	 w/IDwMjryo9bwg+YnQzREg69nd9OK/Oo2bwZ1ryU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfKTNhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfKTNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:07 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88E722475;
        Wed, 20 Nov 2019 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257027;
        bh=duNY+VBU6lUzCzx1T0ATt0/eCL5uIdsG7lRXCgb9EJY=;
        h=From:To:Cc:Subject:Date:From;
        b=fD9//T3lKbdwOprACds3bx1yCQNM32gU0WvZDmw//qGS1y1MLTaj8FstpMft/eQTb
         lzpkDWLhFl7Rdx59hEWmoVR2JYhmr1/Y0Aq5CuaPtUp2etybCxtkfGZ7vu4NjIVHhD
         ScNBzjsu4+vuNgTKj2Btd8qqi0851nOwA10KZJnU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:03 +0800
Message-Id: <20191120133703.11956-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/riscv/Kconfig.socs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 536c0ef4aee8..85199004c6ef 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -8,6 +8,6 @@ config SOC_SIFIVE
        select CLK_SIFIVE_FU540_PRCI
        select SIFIVE_PLIC
        help
-         This enables support for SiFive SoC platform hardware.
+	 This enables support for SiFive SoC platform hardware.
 
 endmenu
-- 
2.17.1

