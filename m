Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB3C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FAD22529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257058;
	bh=KefntvOFfkTYXk9bmaxgyhvHqX8oyAf04yPlNMKx08s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Htrwjrr4t409BDfHKzxHO9l/Iyuc0vqDsxdFf8HIxhPExdP8D5dxkoQKTSdntP1K5
	 SyBcc9dtaimZRnltPZLk+bEpMzmHgD+XeuTnqKh82GOa1h+H1Anx+lwLac8LX5NKuT
	 j7Skjs7m3OUm+V2jETgHHVgZr2bn0RDz/bIFUoB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfKTNhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfKTNhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:34 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0BE21939;
        Wed, 20 Nov 2019 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257053;
        bh=KefntvOFfkTYXk9bmaxgyhvHqX8oyAf04yPlNMKx08s=;
        h=From:To:Cc:Subject:Date:From;
        b=e+ZE8uYEbcLTDXVIFzDbcX2MJVqGDik6NrMyNXKYjUESFkwtuvOWBpKXzqNe3wude
         7DeRu5X2v5RH0wncHbue9Bl3QRMJnmExtE7Py0dvCcc939znTBXUAnczR3zG/GAT/b
         M0Im/Ayrb/sHCGPuDvQXdAOCZWRHI2E+4Pz9YFeA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:29 +0800
Message-Id: <20191120133730.12288-1-krzk@kernel.org>
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
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4d6d8d6b6c4..c8b672c46e7e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -263,7 +263,7 @@ config GENERIC_HWEIGHT
 	def_bool y
 
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
@@ -1670,7 +1670,7 @@ config EFI
 	help
 	  This option provides support for runtime services provided
 	  by UEFI firmware (such as non-volatile variables, realtime
-          clock, and platform reset). A UEFI stub is also provided to
+	  clock, and platform reset). A UEFI stub is also provided to
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
-- 
2.17.1

