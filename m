Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6353AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309F4219FA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257424;
	bh=4E41fm/McBPwCs70C9UWumNq3T3Ql+3Yx15bViejMMw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iF4w0BJGXw6UBeUcFMTlz3ta/kge2Wtu2DxJFPCOFds8JkLlQ9+Twhuc3d4x82+R9
	 Yv//k8VDBXINOdPyCBUAWmVSdHUthbTd39ohFxO3ERjUdGeds6OYFwc8NNRrl1DrLZ
	 /YHZ6BxtSasx5Y7som1iPWuWD1r7+fcKpb/4BQfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfKTNnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbfKTNnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:40 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDE022528;
        Wed, 20 Nov 2019 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257420;
        bh=4E41fm/McBPwCs70C9UWumNq3T3Ql+3Yx15bViejMMw=;
        h=From:To:Cc:Subject:Date:From;
        b=nPCH32R06OjeVhp8VrpTuiN2nrT/a9TfU/Ryd7DCBOGDJE67iVtVSJvq/i5PIOdKR
         R7KsIfcaHzNL/e0/Ysvg3qMfCHW6u7d/6BPc2YelfQ/P17QOrT+vDtV3x+OK1dDmbc
         PNq3WKM2hI+e4FdIzN+MuHKhUhBjtuPgZsagy47w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:36 +0800
Message-Id: <20191120134336.16710-1-krzk@kernel.org>
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
 fs/Kconfig        | 4 ++--
 fs/Kconfig.binfmt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7b623e9fc1b0..4436acf5fef7 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -97,8 +97,8 @@ config FILE_LOCKING
 	default y
 	help
 	  This option enables standard file locking support, required
-          for filesystems like NFS and for the flock() system
-          call. Disabling this option saves about 11k.
+	  for filesystems like NFS and for the flock() system
+	  call. Disabling this option saves about 11k.
 
 config MANDATORY_FILE_LOCKING
 	bool "Enable Mandatory file locking"
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f577ba1..8d0d16b90039 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -191,9 +191,9 @@ config BINFMT_MISC
 	  <file:Documentation/admin-guide/binfmt-misc.rst> to learn how to use this
 	  feature, <file:Documentation/admin-guide/java.rst> for information about how
 	  to include Java support. and <file:Documentation/admin-guide/mono.rst> for
-          information about how to include Mono-based .NET support.
+	  information about how to include Mono-based .NET support.
 
-          To use binfmt_misc, you will need to mount it:
+	  To use binfmt_misc, you will need to mount it:
 		mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
 
 	  You may say M here for module support and later load the module when
-- 
2.17.1

