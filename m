Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813BAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402F02087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709784;
	bh=rEv3uEDX/9eDVE6ijmR3wJxVK9HSSrqxfjradNw4TW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gtafZmDZMGbcS9lnTaYdTm1VtpCFfZkPecDpYF5GD8XV1sOMGV+K1eZ2ER4MZPfd0
	 +JywB1NFFQZsxHQ949cMVpNtDXYYsrnIwvZFEzpsF251ZnsiBhEvJXRDPPWO9CPCrk
	 5akG1/9PdUzQEl3zN0094SDLZvMdZRl+B47FRal8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfC0SDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbfC0SDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 001B72177E;
        Wed, 27 Mar 2019 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709779;
        bh=rEv3uEDX/9eDVE6ijmR3wJxVK9HSSrqxfjradNw4TW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wj9yvsU2u42IAoK1JymRKKsJy7QnB3+gD7bRqx/p3RSxJrCN5fhoUW7wtvTQg1+2J
         bJ/m8v3tG9kOgmIxi2fPY1Se9qrv7iS1V46BvxH73aZ9/6ZvSpdA7G2ZQgvLGKfR7I
         QoCo28tGIzhkG07VQTIWTrtD2y3qPgM8yR8zT4gU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 034/262] docs/core-api/mm: fix user memory accessors formatting
Date:   Wed, 27 Mar 2019 13:58:09 -0400
Message-Id: <20190327180158.10245-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

[ Upstream commit bc8ff3ca6589d63c6d10f5ee8bed38f74851b469 ]

The descriptions of userspace memory access functions had minor issues
with formatting that made kernel-doc unable to properly detect the
function/macro names and the return value sections:

./arch/x86/include/asm/uaccess.h:80: info: Scanning doc for
./arch/x86/include/asm/uaccess.h:139: info: Scanning doc for
./arch/x86/include/asm/uaccess.h:231: info: Scanning doc for
./arch/x86/include/asm/uaccess.h:505: info: Scanning doc for
./arch/x86/include/asm/uaccess.h:530: info: Scanning doc for
./arch/x86/lib/usercopy_32.c:58: info: Scanning doc for
./arch/x86/lib/usercopy_32.c:69: warning: No description found for return
value of 'clear_user'
./arch/x86/lib/usercopy_32.c:78: info: Scanning doc for
./arch/x86/lib/usercopy_32.c:90: warning: No description found for return
value of '__clear_user'

Fix the formatting.

Link: http://lkml.kernel.org/r/1549549644-4903-3-git-send-email-rppt@linux.ibm.com
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 24 ++++++++++++------------
 arch/x86/lib/usercopy_32.c     |  8 ++++----
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c1334aaaa78d..f3aed639dccd 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -76,7 +76,7 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 #endif
 
 /**
- * access_ok: - Checks if a user space pointer is valid
+ * access_ok - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
  * @size: Size of block to check
  *
@@ -85,12 +85,12 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
  *
  * Checks if a pointer to a block of memory in user space is valid.
  *
- * Returns true (nonzero) if the memory block may be valid, false (zero)
- * if it is definitely invalid.
- *
  * Note that, depending on architecture, this function probably just
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
+ *
+ * Return: true (nonzero) if the memory block may be valid, false (zero)
+ * if it is definitely invalid.
  */
 #define access_ok(addr, size)					\
 ({									\
@@ -135,7 +135,7 @@ extern int __get_user_bad(void);
 __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 
 /**
- * get_user: - Get a simple variable from user space.
+ * get_user - Get a simple variable from user space.
  * @x:   Variable to store result.
  * @ptr: Source address, in user space.
  *
@@ -149,7 +149,7 @@ __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
  * @ptr must have pointer-to-simple-variable type, and the result of
  * dereferencing @ptr must be assignable to @x without a cast.
  *
- * Returns zero on success, or -EFAULT on error.
+ * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
 /*
@@ -227,7 +227,7 @@ extern void __put_user_4(void);
 extern void __put_user_8(void);
 
 /**
- * put_user: - Write a simple value into user space.
+ * put_user - Write a simple value into user space.
  * @x:   Value to copy to user space.
  * @ptr: Destination address, in user space.
  *
@@ -241,7 +241,7 @@ extern void __put_user_8(void);
  * @ptr must have pointer-to-simple-variable type, and @x must be assignable
  * to the result of dereferencing @ptr.
  *
- * Returns zero on success, or -EFAULT on error.
+ * Return: zero on success, or -EFAULT on error.
  */
 #define put_user(x, ptr)					\
 ({								\
@@ -503,7 +503,7 @@ struct __large_struct { unsigned long buf[100]; };
 } while (0)
 
 /**
- * __get_user: - Get a simple variable from user space, with less checking.
+ * __get_user - Get a simple variable from user space, with less checking.
  * @x:   Variable to store result.
  * @ptr: Source address, in user space.
  *
@@ -520,7 +520,7 @@ struct __large_struct { unsigned long buf[100]; };
  * Caller must check the pointer with access_ok() before calling this
  * function.
  *
- * Returns zero on success, or -EFAULT on error.
+ * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
 
@@ -528,7 +528,7 @@ struct __large_struct { unsigned long buf[100]; };
 	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
 
 /**
- * __put_user: - Write a simple value into user space, with less checking.
+ * __put_user - Write a simple value into user space, with less checking.
  * @x:   Value to copy to user space.
  * @ptr: Destination address, in user space.
  *
@@ -545,7 +545,7 @@ struct __large_struct { unsigned long buf[100]; };
  * Caller must check the pointer with access_ok() before calling this
  * function.
  *
- * Returns zero on success, or -EFAULT on error.
+ * Return: zero on success, or -EFAULT on error.
  */
 
 #define __put_user(x, ptr)						\
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index bfd94e7812fc..7d290777246d 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -54,13 +54,13 @@ do {									\
 } while (0)
 
 /**
- * clear_user: - Zero a block of memory in user space.
+ * clear_user - Zero a block of memory in user space.
  * @to:   Destination address, in user space.
  * @n:    Number of bytes to zero.
  *
  * Zero a block of memory in user space.
  *
- * Returns number of bytes that could not be cleared.
+ * Return: number of bytes that could not be cleared.
  * On success, this will be zero.
  */
 unsigned long
@@ -74,14 +74,14 @@ clear_user(void __user *to, unsigned long n)
 EXPORT_SYMBOL(clear_user);
 
 /**
- * __clear_user: - Zero a block of memory in user space, with less checking.
+ * __clear_user - Zero a block of memory in user space, with less checking.
  * @to:   Destination address, in user space.
  * @n:    Number of bytes to zero.
  *
  * Zero a block of memory in user space.  Caller must check
  * the specified block with access_ok() before calling this function.
  *
- * Returns number of bytes that could not be cleared.
+ * Return: number of bytes that could not be cleared.
  * On success, this will be zero.
  */
 unsigned long
-- 
2.19.1

