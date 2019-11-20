Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0EB22528
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257073;
	bh=e4Hx2w9CUlEMUZpsptlAxS9898JO9B+VvzwEQN+NU2w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YVMbKp4ZSnG9o7zzHX+1SNYLK7A8SJl+KjCZOVWMz8xC+gDdH6RDDbnpTfYhI6vRy
	 GHpnUEJSiwLeu2hWH1SSixoRc2bdVeVwXudsNpmYvKnDHxw2p4fpJ6b3i3JMQTLE2N
	 A6RnHZM4XrKvDOqt8qzdLYDRdBRPfk5AWZ0ZJeu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfKTNhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:37:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfKTNht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:49 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B804222528;
        Wed, 20 Nov 2019 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257069;
        bh=e4Hx2w9CUlEMUZpsptlAxS9898JO9B+VvzwEQN+NU2w=;
        h=From:To:Cc:Subject:Date:From;
        b=K51aEQ4SSBj8GOy4J1U15O7l1Qude9IQrj3P6qv8r0F/+/geg9cZmmiNFpNNw839Q
         agN0IKksJKVbq1deXYhQ8+36TesGytqvp5a9x3WVdzsa5VlewRaw0A6BgDt/s6FfBF
         ucaF/e6REoXzEx/MlsPJYudM3zBM/mw9ui+oXIbA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] arch: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:46 +0800
Message-Id: <20191120133746.12461-1-krzk@kernel.org>
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
 arch/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3c6ec65596da..f6463f8b142f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -76,7 +76,7 @@ config JUMP_LABEL
        depends on HAVE_ARCH_JUMP_LABEL
        depends on CC_HAS_ASM_GOTO
        help
-         This option enables a transparent branch optimization that
+	 This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
 	 conditions even cheaper to execute within the kernel.
 
@@ -84,7 +84,7 @@ config JUMP_LABEL
 	 scheduler functionality, networking code and KVM have such
 	 branches and include support for this optimization technique.
 
-         If it is detected that the compiler has support for "asm goto",
+	 If it is detected that the compiler has support for "asm goto",
 	 the kernel will compile such branches with just a nop
 	 instruction. When the condition flag is toggled to true, the
 	 nop will be converted to a jump instruction to execute the
-- 
2.17.1

