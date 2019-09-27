Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1ED21906
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfI0IML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:12:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfI0IMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:12:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKt-0005bB-Jf; Fri, 27 Sep 2019 10:10:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 29BF91C073C;
        Fri, 27 Sep 2019 10:10:43 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:43 -0000
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] selftests, sched/membarrier: Add multi-threaded test
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <tkhai@yandex.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190919173705.2181-6-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-6-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <156957184306.9866.10459210030485538128.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     19a4ff534bb09686f53800564cb977bad2177c00
Gitweb:        https://git.kernel.org/tip/19a4ff534bb09686f53800564cb977bad2177c00
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Thu, 19 Sep 2019 13:37:03 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:31 +02:00

selftests, sched/membarrier: Add multi-threaded test

membarrier commands cover very different code paths if they are in
a single-threaded vs multi-threaded process. Therefore, exercise both
scenarios in the kernel selftests to increase coverage of this selftest.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190919173705.2181-6-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/membarrier/.gitignore                      |   3 +-
 tools/testing/selftests/membarrier/Makefile                        |   5 +-
 tools/testing/selftests/membarrier/membarrier_test.c               | 313 +---------------------------------------------------------------------
 tools/testing/selftests/membarrier/membarrier_test_impl.h          | 317 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/membarrier/membarrier_test_multi_thread.c  |  73 ++++++++++++++++-
 tools/testing/selftests/membarrier/membarrier_test_single_thread.c |  24 +++++-
 6 files changed, 419 insertions(+), 316 deletions(-)
 delete mode 100644 tools/testing/selftests/membarrier/membarrier_test.c
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_impl.h
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_single_thread.c

diff --git a/tools/testing/selftests/membarrier/.gitignore b/tools/testing/selftests/membarrier/.gitignore
index 020c44f..f2f7ec0 100644
--- a/tools/testing/selftests/membarrier/.gitignore
+++ b/tools/testing/selftests/membarrier/.gitignore
@@ -1 +1,2 @@
-membarrier_test
+membarrier_test_multi_thread
+membarrier_test_single_thread
diff --git a/tools/testing/selftests/membarrier/Makefile b/tools/testing/selftests/membarrier/Makefile
index 97e3bdf..34d1c81 100644
--- a/tools/testing/selftests/membarrier/Makefile
+++ b/tools/testing/selftests/membarrier/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g -I../../../../usr/include/
+LDLIBS += -lpthread
 
-TEST_GEN_PROGS := membarrier_test
+TEST_GEN_PROGS := membarrier_test_single_thread \
+		membarrier_test_multi_thread
 
 include ../lib.mk
-
diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
deleted file mode 100644
index 70b4ddb..0000000
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ /dev/null
@@ -1,313 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#include <linux/membarrier.h>
-#include <syscall.h>
-#include <stdio.h>
-#include <errno.h>
-#include <string.h>
-
-#include "../kselftest.h"
-
-static int sys_membarrier(int cmd, int flags)
-{
-	return syscall(__NR_membarrier, cmd, flags);
-}
-
-static int test_membarrier_cmd_fail(void)
-{
-	int cmd = -1, flags = 0;
-	const char *test_name = "sys membarrier invalid command";
-
-	if (sys_membarrier(cmd, flags) != -1) {
-		ksft_exit_fail_msg(
-			"%s test: command = %d, flags = %d. Should fail, but passed\n",
-			test_name, cmd, flags);
-	}
-	if (errno != EINVAL) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
-			test_name, flags, EINVAL, strerror(EINVAL),
-			errno, strerror(errno));
-	}
-
-	ksft_test_result_pass(
-		"%s test: command = %d, flags = %d, errno = %d. Failed as expected\n",
-		test_name, cmd, flags, errno);
-	return 0;
-}
-
-static int test_membarrier_flags_fail(void)
-{
-	int cmd = MEMBARRIER_CMD_QUERY, flags = 1;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_QUERY invalid flags";
-
-	if (sys_membarrier(cmd, flags) != -1) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should fail, but passed\n",
-			test_name, flags);
-	}
-	if (errno != EINVAL) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
-			test_name, flags, EINVAL, strerror(EINVAL),
-			errno, strerror(errno));
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d, errno = %d. Failed as expected\n",
-		test_name, flags, errno);
-	return 0;
-}
-
-static int test_membarrier_global_success(void)
-{
-	int cmd = MEMBARRIER_CMD_GLOBAL, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n", test_name, flags);
-	return 0;
-}
-
-static int test_membarrier_private_expedited_fail(void)
-{
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure";
-
-	if (sys_membarrier(cmd, flags) != -1) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should fail, but passed\n",
-			test_name, flags);
-	}
-	if (errno != EPERM) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
-			test_name, flags, EPERM, strerror(EPERM),
-			errno, strerror(errno));
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d, errno = %d\n",
-		test_name, flags, errno);
-	return 0;
-}
-
-static int test_membarrier_register_private_expedited_success(void)
-{
-	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
-
-static int test_membarrier_private_expedited_success(void)
-{
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
-
-static int test_membarrier_private_expedited_sync_core_fail(void)
-{
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not registered failure";
-
-	if (sys_membarrier(cmd, flags) != -1) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should fail, but passed\n",
-			test_name, flags);
-	}
-	if (errno != EPERM) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
-			test_name, flags, EPERM, strerror(EPERM),
-			errno, strerror(errno));
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d, errno = %d\n",
-		test_name, flags, errno);
-	return 0;
-}
-
-static int test_membarrier_register_private_expedited_sync_core_success(void)
-{
-	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
-
-static int test_membarrier_private_expedited_sync_core_success(void)
-{
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
-
-static int test_membarrier_register_global_expedited_success(void)
-{
-	int cmd = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
-
-static int test_membarrier_global_expedited_success(void)
-{
-	int cmd = MEMBARRIER_CMD_GLOBAL_EXPEDITED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED";
-
-	if (sys_membarrier(cmd, flags) != 0) {
-		ksft_exit_fail_msg(
-			"%s test: flags = %d, errno = %d\n",
-			test_name, flags, errno);
-	}
-
-	ksft_test_result_pass(
-		"%s test: flags = %d\n",
-		test_name, flags);
-	return 0;
-}
-
-static int test_membarrier(void)
-{
-	int status;
-
-	status = test_membarrier_cmd_fail();
-	if (status)
-		return status;
-	status = test_membarrier_flags_fail();
-	if (status)
-		return status;
-	status = test_membarrier_global_success();
-	if (status)
-		return status;
-	status = test_membarrier_private_expedited_fail();
-	if (status)
-		return status;
-	status = test_membarrier_register_private_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_private_expedited_success();
-	if (status)
-		return status;
-	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
-	if (status < 0) {
-		ksft_test_result_fail("sys_membarrier() failed\n");
-		return status;
-	}
-	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
-		status = test_membarrier_private_expedited_sync_core_fail();
-		if (status)
-			return status;
-		status = test_membarrier_register_private_expedited_sync_core_success();
-		if (status)
-			return status;
-		status = test_membarrier_private_expedited_sync_core_success();
-		if (status)
-			return status;
-	}
-	/*
-	 * It is valid to send a global membarrier from a non-registered
-	 * process.
-	 */
-	status = test_membarrier_global_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_register_global_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_global_expedited_success();
-	if (status)
-		return status;
-	return 0;
-}
-
-static int test_membarrier_query(void)
-{
-	int flags = 0, ret;
-
-	ret = sys_membarrier(MEMBARRIER_CMD_QUERY, flags);
-	if (ret < 0) {
-		if (errno == ENOSYS) {
-			/*
-			 * It is valid to build a kernel with
-			 * CONFIG_MEMBARRIER=n. However, this skips the tests.
-			 */
-			ksft_exit_skip(
-				"sys membarrier (CONFIG_MEMBARRIER) is disabled.\n");
-		}
-		ksft_exit_fail_msg("sys_membarrier() failed\n");
-	}
-	if (!(ret & MEMBARRIER_CMD_GLOBAL))
-		ksft_exit_skip(
-			"sys_membarrier unsupported: CMD_GLOBAL not found.\n");
-
-	ksft_test_result_pass("sys_membarrier available\n");
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	ksft_print_header();
-	ksft_set_plan(13);
-
-	test_membarrier_query();
-	test_membarrier();
-
-	return ksft_exit_pass();
-}
diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
new file mode 100644
index 0000000..186be69
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -0,0 +1,317 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <syscall.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <pthread.h>
+
+#include "../kselftest.h"
+
+static int sys_membarrier(int cmd, int flags)
+{
+	return syscall(__NR_membarrier, cmd, flags);
+}
+
+static int test_membarrier_cmd_fail(void)
+{
+	int cmd = -1, flags = 0;
+	const char *test_name = "sys membarrier invalid command";
+
+	if (sys_membarrier(cmd, flags) != -1) {
+		ksft_exit_fail_msg(
+			"%s test: command = %d, flags = %d. Should fail, but passed\n",
+			test_name, cmd, flags);
+	}
+	if (errno != EINVAL) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EINVAL, strerror(EINVAL),
+			errno, strerror(errno));
+	}
+
+	ksft_test_result_pass(
+		"%s test: command = %d, flags = %d, errno = %d. Failed as expected\n",
+		test_name, cmd, flags, errno);
+	return 0;
+}
+
+static int test_membarrier_flags_fail(void)
+{
+	int cmd = MEMBARRIER_CMD_QUERY, flags = 1;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_QUERY invalid flags";
+
+	if (sys_membarrier(cmd, flags) != -1) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should fail, but passed\n",
+			test_name, flags);
+	}
+	if (errno != EINVAL) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EINVAL, strerror(EINVAL),
+			errno, strerror(errno));
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d, errno = %d. Failed as expected\n",
+		test_name, flags, errno);
+	return 0;
+}
+
+static int test_membarrier_global_success(void)
+{
+	int cmd = MEMBARRIER_CMD_GLOBAL, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n", test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_private_expedited_fail(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure";
+
+	if (sys_membarrier(cmd, flags) != -1) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should fail, but passed\n",
+			test_name, flags);
+	}
+	if (errno != EPERM) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EPERM, strerror(EPERM),
+			errno, strerror(errno));
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d, errno = %d\n",
+		test_name, flags, errno);
+	return 0;
+}
+
+static int test_membarrier_register_private_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_private_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_private_expedited_sync_core_fail(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not registered failure";
+
+	if (sys_membarrier(cmd, flags) != -1) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should fail, but passed\n",
+			test_name, flags);
+	}
+	if (errno != EPERM) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EPERM, strerror(EPERM),
+			errno, strerror(errno));
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d, errno = %d\n",
+		test_name, flags, errno);
+	return 0;
+}
+
+static int test_membarrier_register_private_expedited_sync_core_success(void)
+{
+	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_private_expedited_sync_core_success(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_register_global_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_global_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_GLOBAL_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_fail(void)
+{
+	int status;
+
+	status = test_membarrier_cmd_fail();
+	if (status)
+		return status;
+	status = test_membarrier_flags_fail();
+	if (status)
+		return status;
+	status = test_membarrier_private_expedited_fail();
+	if (status)
+		return status;
+	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
+	if (status < 0) {
+		ksft_test_result_fail("sys_membarrier() failed\n");
+		return status;
+	}
+	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
+		status = test_membarrier_private_expedited_sync_core_fail();
+		if (status)
+			return status;
+	}
+	return 0;
+}
+
+static int test_membarrier_success(void)
+{
+	int status;
+
+	status = test_membarrier_global_success();
+	if (status)
+		return status;
+	status = test_membarrier_register_private_expedited_success();
+	if (status)
+		return status;
+	status = test_membarrier_private_expedited_success();
+	if (status)
+		return status;
+	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
+	if (status < 0) {
+		ksft_test_result_fail("sys_membarrier() failed\n");
+		return status;
+	}
+	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
+		status = test_membarrier_register_private_expedited_sync_core_success();
+		if (status)
+			return status;
+		status = test_membarrier_private_expedited_sync_core_success();
+		if (status)
+			return status;
+	}
+	/*
+	 * It is valid to send a global membarrier from a non-registered
+	 * process.
+	 */
+	status = test_membarrier_global_expedited_success();
+	if (status)
+		return status;
+	status = test_membarrier_register_global_expedited_success();
+	if (status)
+		return status;
+	status = test_membarrier_global_expedited_success();
+	if (status)
+		return status;
+	return 0;
+}
+
+static int test_membarrier_query(void)
+{
+	int flags = 0, ret;
+
+	ret = sys_membarrier(MEMBARRIER_CMD_QUERY, flags);
+	if (ret < 0) {
+		if (errno == ENOSYS) {
+			/*
+			 * It is valid to build a kernel with
+			 * CONFIG_MEMBARRIER=n. However, this skips the tests.
+			 */
+			ksft_exit_skip(
+				"sys membarrier (CONFIG_MEMBARRIER) is disabled.\n");
+		}
+		ksft_exit_fail_msg("sys_membarrier() failed\n");
+	}
+	if (!(ret & MEMBARRIER_CMD_GLOBAL))
+		ksft_exit_skip(
+			"sys_membarrier unsupported: CMD_GLOBAL not found.\n");
+
+	ksft_test_result_pass("sys_membarrier available\n");
+	return 0;
+}
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
new file mode 100644
index 0000000..ac5613e
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <syscall.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <pthread.h>
+
+#include "membarrier_test_impl.h"
+
+static int thread_ready, thread_quit;
+static pthread_mutex_t test_membarrier_thread_mutex =
+	PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t test_membarrier_thread_cond =
+	PTHREAD_COND_INITIALIZER;
+
+void *test_membarrier_thread(void *arg)
+{
+	pthread_mutex_lock(&test_membarrier_thread_mutex);
+	thread_ready = 1;
+	pthread_cond_broadcast(&test_membarrier_thread_cond);
+	pthread_mutex_unlock(&test_membarrier_thread_mutex);
+
+	pthread_mutex_lock(&test_membarrier_thread_mutex);
+	while (!thread_quit)
+		pthread_cond_wait(&test_membarrier_thread_cond,
+				  &test_membarrier_thread_mutex);
+	pthread_mutex_unlock(&test_membarrier_thread_mutex);
+
+	return NULL;
+}
+
+static int test_mt_membarrier(void)
+{
+	int i;
+	pthread_t test_thread;
+
+	pthread_create(&test_thread, NULL,
+		       test_membarrier_thread, NULL);
+
+	pthread_mutex_lock(&test_membarrier_thread_mutex);
+	while (!thread_ready)
+		pthread_cond_wait(&test_membarrier_thread_cond,
+				  &test_membarrier_thread_mutex);
+	pthread_mutex_unlock(&test_membarrier_thread_mutex);
+
+	test_membarrier_fail();
+
+	test_membarrier_success();
+
+	pthread_mutex_lock(&test_membarrier_thread_mutex);
+	thread_quit = 1;
+	pthread_cond_broadcast(&test_membarrier_thread_cond);
+	pthread_mutex_unlock(&test_membarrier_thread_mutex);
+
+	pthread_join(test_thread, NULL);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(13);
+
+	test_membarrier_query();
+
+	/* Multi-threaded */
+	test_mt_membarrier();
+
+	return ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
new file mode 100644
index 0000000..c1c9639
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <syscall.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <pthread.h>
+
+#include "membarrier_test_impl.h"
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(13);
+
+	test_membarrier_query();
+
+	test_membarrier_fail();
+
+	test_membarrier_success();
+
+	return ksft_exit_pass();
+}
