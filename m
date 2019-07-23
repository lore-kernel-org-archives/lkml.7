Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2757DC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F113220644
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rKpO/nri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbfGWL2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:28:09 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:60391 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbfGWL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:28:08 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6NBQnvI029674;
        Tue, 23 Jul 2019 20:26:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6NBQnvI029674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563881210;
        bh=3lce18p30EVbzN2Od3dU003VSnCw95GOlTmNeM4rzHo=;
        h=From:To:Cc:Subject:Date:From;
        b=rKpO/nrixQwf62Bd1Ttes+I2TQ7C9/mZ/vBuffZejUq2aIT03WCwK3LKcv0nhrczR
         8fLwiGhRBiGhVAaF9o3LMOD4AGw444YI4QqgD6pkxaL7j2BH/wvaHdGYMrA0plOlYd
         8BXfF3QquJmo3HLKD3N3QSSvygbhs1H88JMLyjHQoBmCWTLdAO7ZiTy4YKDwzRZ/VR
         72mtFtR0MfdlKa6kCR7ZeikXOyzuE5tQnBv0REUtvhhE8E4D1JKCzr3PVlpKQNkgBC
         HwCqu+0LbACcasMn4LRT8BXeC/LsyBd4ZFhWgeJoFEmTlnnWOs1YAacQuAJDmKV4xb
         aeh2cOpma/Geg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: remove unneeded uapi asm-generic wrappers
Date:   Tue, 23 Jul 2019 20:26:45 +0900
Message-Id: <20190723112646.14046-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/uapi/asm/errno.h    | 1 -
 arch/x86/include/uapi/asm/fcntl.h    | 1 -
 arch/x86/include/uapi/asm/ioctl.h    | 1 -
 arch/x86/include/uapi/asm/ioctls.h   | 1 -
 arch/x86/include/uapi/asm/ipcbuf.h   | 1 -
 arch/x86/include/uapi/asm/param.h    | 1 -
 arch/x86/include/uapi/asm/resource.h | 1 -
 arch/x86/include/uapi/asm/termbits.h | 1 -
 arch/x86/include/uapi/asm/termios.h  | 1 -
 arch/x86/include/uapi/asm/types.h    | 7 -------
 10 files changed, 16 deletions(-)
 delete mode 100644 arch/x86/include/uapi/asm/errno.h
 delete mode 100644 arch/x86/include/uapi/asm/fcntl.h
 delete mode 100644 arch/x86/include/uapi/asm/ioctl.h
 delete mode 100644 arch/x86/include/uapi/asm/ioctls.h
 delete mode 100644 arch/x86/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/x86/include/uapi/asm/param.h
 delete mode 100644 arch/x86/include/uapi/asm/resource.h
 delete mode 100644 arch/x86/include/uapi/asm/termbits.h
 delete mode 100644 arch/x86/include/uapi/asm/termios.h
 delete mode 100644 arch/x86/include/uapi/asm/types.h

diff --git a/arch/x86/include/uapi/asm/errno.h b/arch/x86/include/uapi/asm/errno.h
deleted file mode 100644
index 4c82b503d92f..000000000000
--- a/arch/x86/include/uapi/asm/errno.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/errno.h>
diff --git a/arch/x86/include/uapi/asm/fcntl.h b/arch/x86/include/uapi/asm/fcntl.h
deleted file mode 100644
index 46ab12db5739..000000000000
--- a/arch/x86/include/uapi/asm/fcntl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/fcntl.h>
diff --git a/arch/x86/include/uapi/asm/ioctl.h b/arch/x86/include/uapi/asm/ioctl.h
deleted file mode 100644
index b279fe06dfe5..000000000000
--- a/arch/x86/include/uapi/asm/ioctl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ioctl.h>
diff --git a/arch/x86/include/uapi/asm/ioctls.h b/arch/x86/include/uapi/asm/ioctls.h
deleted file mode 100644
index ec34c760665e..000000000000
--- a/arch/x86/include/uapi/asm/ioctls.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ioctls.h>
diff --git a/arch/x86/include/uapi/asm/ipcbuf.h b/arch/x86/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 84c7e51cb6d0..000000000000
--- a/arch/x86/include/uapi/asm/ipcbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/x86/include/uapi/asm/param.h b/arch/x86/include/uapi/asm/param.h
deleted file mode 100644
index 965d45427975..000000000000
--- a/arch/x86/include/uapi/asm/param.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/param.h>
diff --git a/arch/x86/include/uapi/asm/resource.h b/arch/x86/include/uapi/asm/resource.h
deleted file mode 100644
index 04bc4db8921b..000000000000
--- a/arch/x86/include/uapi/asm/resource.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/resource.h>
diff --git a/arch/x86/include/uapi/asm/termbits.h b/arch/x86/include/uapi/asm/termbits.h
deleted file mode 100644
index 3935b106de79..000000000000
--- a/arch/x86/include/uapi/asm/termbits.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/termbits.h>
diff --git a/arch/x86/include/uapi/asm/termios.h b/arch/x86/include/uapi/asm/termios.h
deleted file mode 100644
index 280d78a9d966..000000000000
--- a/arch/x86/include/uapi/asm/termios.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/termios.h>
diff --git a/arch/x86/include/uapi/asm/types.h b/arch/x86/include/uapi/asm/types.h
deleted file mode 100644
index 9d5c11a24279..000000000000
--- a/arch/x86/include/uapi/asm/types.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_TYPES_H
-#define _ASM_X86_TYPES_H
-
-#include <asm-generic/types.h>
-
-#endif /* _ASM_X86_TYPES_H */
-- 
2.17.1

