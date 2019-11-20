Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A9CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF3A22528
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257116;
	bh=t1jxGZVRUT3++psVJjlPRe6/LZ+4yNKYPY14ryaanGc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yF9yr4EtH1inMykMcLOMUxGzwIEn3xPDPVBxKuT4r6VOe7cTcohaYU0nIusjklWOj
	 9mNKiHGfe0DJc/TMdTqr0IlPVht0hkhtbIh4HDvlWEMWEXeEzu0klPl2JMewAV5uAm
	 YaKQbKTour42F2xmLASvYLAWzNl+r+K4V1FOoAgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfKTNi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbfKTNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:16 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5342251E;
        Wed, 20 Nov 2019 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257096;
        bh=t1jxGZVRUT3++psVJjlPRe6/LZ+4yNKYPY14ryaanGc=;
        h=From:To:Cc:Subject:Date:From;
        b=oMq/OonqJlBynZjelXRMQNKpuP5NdIN4qy1xotveAFBXaxrUqq9HiczOD3MIoDQid
         WUvVJACSb4pwdwpVAVGSvZj3jiVYcsR36fZCih+G+wCO4qYJECSWCqx1Vvcjd04aqD
         veRRF5Mk2B1oQP4uZitSNXnGLZ57uyjYRMGGs11o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] init: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:11 +0800
Message-Id: <20191120133811.12798-1-krzk@kernel.org>
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
 init/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index ff15a3c71176..4c06edc52f63 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -149,10 +149,10 @@ config BUILD_SALT
        string "Build ID Salt"
        default ""
        help
-          The build ID is used to link binaries and their debug info. Setting
-          this option will use the value in the calculation of the build id.
-          This is mostly useful for distributions which want to ensure the
-          build is unique between builds. It's safe to leave the default.
+	  The build ID is used to link binaries and their debug info. Setting
+	  this option will use the value in the calculation of the build id.
+	  This is mostly useful for distributions which want to ensure the
+	  build is unique between builds. It's safe to leave the default.
 
 config HAVE_KERNEL_GZIP
 	bool
@@ -1311,9 +1311,9 @@ menuconfig EXPERT
 	select DEBUG_KERNEL
 	help
 	  This option allows certain base kernel options and settings
-          to be disabled or tweaked. This is for specialized
-          environments which can tolerate a "non-standard" kernel.
-          Only use this if you really know what you are doing.
+	  to be disabled or tweaked. This is for specialized
+	  environments which can tolerate a "non-standard" kernel.
+	  Only use this if you really know what you are doing.
 
 config UID16
 	bool "Enable 16-bit UID system calls" if EXPERT
@@ -1423,11 +1423,11 @@ config BUG
 	bool "BUG() support" if EXPERT
 	default y
 	help
-          Disabling this option eliminates support for BUG and WARN, reducing
-          the size of your kernel image and potentially quietly ignoring
-          numerous fatal conditions. You should only consider disabling this
-          option for embedded systems with no facilities for reporting errors.
-          Just say Y.
+	  Disabling this option eliminates support for BUG and WARN, reducing
+	  the size of your kernel image and potentially quietly ignoring
+	  numerous fatal conditions. You should only consider disabling this
+	  option for embedded systems with no facilities for reporting errors.
+	  Just say Y.
 
 config ELF_CORE
 	depends on COREDUMP
@@ -1443,8 +1443,8 @@ config PCSPKR_PLATFORM
 	select I8253_LOCK
 	default y
 	help
-          This option allows to disable the internal PC-Speaker
-          support, saving some memory.
+	  This option allows to disable the internal PC-Speaker
+	  support, saving some memory.
 
 config BASE_FULL
 	default y
-- 
2.17.1

