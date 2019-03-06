Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38B920663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551906265;
	bh=f+xrdy6jWWW1xLTTKzYJr41qoP7qmrKLxscR6QdUFCQ=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=xlyj0kWYtORAjxkhAqFKX9UHXs2ffCwLpaf9edyjeV4WpCMKw+yMloUzqAR7GHRWX
	 chG0+zh74ZiOdBQPwxZCn+FnfF8m8u4rdZRUtfaKUR+t9xD9Y8qP41Z/Y9zdmUEuP+
	 F4dY1i1ObH5XN2MoFI60VJSi6ALD7Oc+5wVMztZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCFVEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfCFVEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:04:23 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8431A20663;
        Wed,  6 Mar 2019 21:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551906261;
        bh=f+xrdy6jWWW1xLTTKzYJr41qoP7qmrKLxscR6QdUFCQ=;
        h=To:Cc:From:Subject:Date:From;
        b=X7DaaG1QniFNUeiFqOwffudgd1f0p2iA1jQPGKpDMSHQ2LJACY+TmsvN7BEsDKS4j
         cZKgrsSMtCD2MYGK7tOxYexzadVRtjCQkzP+/86k55x/S+Jnxi/wKq6/Foo3P3nANf
         LA3iflzMCYES+xuiLLi5YLDDTmfwbSlP0gc67gLk=
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   shuah <shuah@kernel.org>
Subject: [GIT PULL] Kselftest update for Linux 5.1-rc1
Message-ID: <0935afa2-ad88-0db9-ca68-1b99544b8397@kernel.org>
Date:   Wed, 6 Mar 2019 14:04:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8238CE107B14B98582879982"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8238CE107B14B98582879982
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.1-rc1

This Kselftest update for Linux 5.1-rc1 consists of

- ir test compile warnings fixes
- seccomp test fixes and improvements from Tycho Andersen and Kees Cook
- ftrace fixes to non-POSIX-compliant constructs in colored output code
   and handling absence of tput from Juerg Haefliger

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

   Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.1-rc1

for you to fetch changes up to 0e27ded1159f62ab1a4e723796246bd5b1793b93:

   selftests/ftrace: Handle the absence of tput (2019-02-25 07:48:01 -0700)

----------------------------------------------------------------
linux-kselftest-5.1-rc1

This Kselftest update for Linux 5.1-rc1 consists of

- ir test compile warnings fixes
- seccomp test fixes and improvements from Tycho Andersen and Kees Cook
- ftrace fixes to non-POSIX-compliant constructs in colored output code
   and handling absence of tput from Juerg Haefliger

----------------------------------------------------------------
Juerg Haefliger (3):
       selftests/ftrace: Replace echo -e with printf
       selftests/ftrace: Replace \e with \033
       selftests/ftrace: Handle the absence of tput

Kees Cook (2):
       selftests/harness: Update named initializer syntax
       selftests/seccomp: Actually sleep for 1/10th second

Shuah Khan (3):
       selftests: ir: fix warning: "%s" directive output may be 
truncated ’ directive output may be truncated
       selftests: ir: skip when lirc device doesn't exist.
       selftests: ir: skip when non-root user runs the test

Tycho Andersen (6):
       selftests: don't kill child immediately in get_metadata() test
       selftests: fix typo in seccomp_bpf.c
       selftest: include stdio.h in kselftest.h
       selftests: skip seccomp get_metadata test if not real root
       selftests: set NO_NEW_PRIVS bit in seccomp user tests
       selftests: unshare userns in seccomp pidns testcases

  tools/testing/selftests/ftrace/ftracetest     | 21 +++++++-----
  tools/testing/selftests/ir/ir_loopback.c      |  6 ++--
  tools/testing/selftests/ir/ir_loopback.sh     |  5 +++
  tools/testing/selftests/kselftest.h           |  1 +
  tools/testing/selftests/kselftest_harness.h   | 10 +++---
  tools/testing/selftests/seccomp/seccomp_bpf.c | 47 
+++++++++++++++++++++++----
  6 files changed, 68 insertions(+), 22 deletions(-)

----------------------------------------------------------------

--------------8238CE107B14B98582879982
Content-Type: text/x-patch;
 name="linux-kselftest-5.1-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.1-rc1.diff"

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 75244db70331..136387422b00 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -154,17 +154,17 @@ fi
 
 # Define text colors
 # Check available colors on the terminal, if any
-ncolors=`tput colors 2>/dev/null`
+ncolors=`tput colors 2>/dev/null || echo 0`
 color_reset=
 color_red=
 color_green=
 color_blue=
 # If stdout exists and number of colors is eight or more, use them
-if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
-  color_reset="\e[0m"
-  color_red="\e[31m"
-  color_green="\e[32m"
-  color_blue="\e[34m"
+if [ -t 1 -a "$ncolors" -ge 8 ]; then
+  color_reset="\033[0m"
+  color_red="\033[31m"
+  color_green="\033[32m"
+  color_blue="\033[34m"
 fi
 
 strip_esc() {
@@ -173,8 +173,13 @@ strip_esc() {
 }
 
 prlog() { # messages
-  echo -e "$@"
-  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
+  newline="\n"
+  if [ "$1" = "-n" ] ; then
+    newline=
+    shift
+  fi
+  printf "$*$newline"
+  [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
   cat $1
diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index 858c19caf224..ff351bb7c163 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -27,6 +27,8 @@
 
 #define TEST_SCANCODES	10
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define SYSFS_PATH_MAX 256
+#define DNAME_PATH_MAX 256
 
 static const struct {
 	enum rc_proto proto;
@@ -56,7 +58,7 @@ static const struct {
 int lirc_open(const char *rc)
 {
 	struct dirent *dent;
-	char buf[100];
+	char buf[SYSFS_PATH_MAX + DNAME_PATH_MAX];
 	DIR *d;
 	int fd;
 
@@ -74,7 +76,7 @@ int lirc_open(const char *rc)
 	}
 
 	if (!dent)
-		ksft_exit_fail_msg("cannot find lirc device for %s\n", rc);
+		ksft_exit_skip("cannot find lirc device for %s\n", rc);
 
 	closedir(d);
 
diff --git a/tools/testing/selftests/ir/ir_loopback.sh b/tools/testing/selftests/ir/ir_loopback.sh
index 0a0b8dfa39be..b90dc9939f45 100755
--- a/tools/testing/selftests/ir/ir_loopback.sh
+++ b/tools/testing/selftests/ir/ir_loopback.sh
@@ -4,6 +4,11 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+if [ $UID != 0 ]; then
+	echo "Please run ir_loopback test as root [SKIP]"
+	exit $ksft_skip
+fi
+
 if ! /sbin/modprobe -q -n rc-loopback; then
         echo "ir_loopback: module rc-loopback is not found [SKIP]"
         exit $ksft_skip
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index a3edb2c8e43d..47e1d995c182 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdio.h>
 
 /* define kselftest exit codes */
 #define KSFT_PASS  0
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 76d654ef3234..2d90c98eeb67 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -168,8 +168,8 @@
 #define __TEST_IMPL(test_name, _signal) \
 	static void test_name(struct __test_metadata *_metadata); \
 	static struct __test_metadata _##test_name##_object = \
-		{ name: "global." #test_name, \
-		  fn: &test_name, termsig: _signal }; \
+		{ .name = "global." #test_name, \
+		  .fn = &test_name, .termsig = _signal }; \
 	static void __attribute__((constructor)) _register_##test_name(void) \
 	{ \
 		__register_test(&_##test_name##_object); \
@@ -304,9 +304,9 @@
 	} \
 	static struct __test_metadata \
 		      _##fixture_name##_##test_name##_object = { \
-		name: #fixture_name "." #test_name, \
-		fn: &wrapper_##fixture_name##_##test_name, \
-		termsig: signal, \
+		.name = #fixture_name "." #test_name, \
+		.fn = &wrapper_##fixture_name##_##test_name, \
+		.termsig = signal, \
 	 }; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 7e632b465ab4..f69d2ee29742 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2611,6 +2611,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 {
 	long ret, sib;
 	void *status;
+	struct timespec delay = { .tv_nsec = 100000000 };
 
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
@@ -2664,7 +2665,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 	EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
 	/* Poll for actual task death. pthread_join doesn't guarantee it. */
 	while (!kill(self->sibling[sib].system_tid, 0))
-		sleep(0.1);
+		nanosleep(&delay, NULL);
 	/* Switch to the remaining sibling */
 	sib = !sib;
 
@@ -2689,7 +2690,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
 	EXPECT_EQ(0, (long)status);
 	/* Poll for actual task death. pthread_join doesn't guarantee it. */
 	while (!kill(self->sibling[sib].system_tid, 0))
-		sleep(0.1);
+		nanosleep(&delay, NULL);
 
 	ret = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_TSYNC,
 		      &self->apply_prog);
@@ -2971,6 +2972,12 @@ TEST(get_metadata)
 	struct seccomp_metadata md;
 	long ret;
 
+	/* Only real root can get metadata. */
+	if (geteuid()) {
+		XFAIL(return, "get_metadata requires real root");
+		return;
+	}
+
 	ASSERT_EQ(0, pipe(pipefd));
 
 	pid = fork();
@@ -2985,11 +2992,11 @@ TEST(get_metadata)
 		};
 
 		/* one with log, one without */
-		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
+		EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
 				     SECCOMP_FILTER_FLAG_LOG, &prog));
-		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
+		EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
 
-		ASSERT_EQ(0, close(pipefd[0]));
+		EXPECT_EQ(0, close(pipefd[0]));
 		ASSERT_EQ(1, write(pipefd[1], "1", 1));
 		ASSERT_EQ(0, close(pipefd[1]));
 
@@ -3062,6 +3069,11 @@ TEST(user_notification_basic)
 		.filter = filter,
 	};
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	pid = fork();
 	ASSERT_GE(pid, 0);
 
@@ -3077,7 +3089,7 @@ TEST(user_notification_basic)
 	EXPECT_EQ(true, WIFEXITED(status));
 	EXPECT_EQ(0, WEXITSTATUS(status));
 
-	/* Add some no-op filters so for grins. */
+	/* Add some no-op filters for grins. */
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
@@ -3143,6 +3155,11 @@ TEST(user_notification_kill_in_middle)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
@@ -3190,6 +3207,11 @@ TEST(user_notification_signal)
 	struct seccomp_notif_resp resp = {};
 	char c;
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
 
 	listener = user_trap_syscall(__NR_gettid,
@@ -3255,6 +3277,11 @@ TEST(user_notification_closed_listener)
 	long ret;
 	int status, listener;
 
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
@@ -3287,7 +3314,7 @@ TEST(user_notification_child_pid_ns)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
-	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
+	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
 
 	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
@@ -3324,6 +3351,10 @@ TEST(user_notification_sibling_pid_ns)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
+	ASSERT_EQ(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0), 0) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
 	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
@@ -3386,6 +3417,8 @@ TEST(user_notification_fault_recv)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
+	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
+
 	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 

--------------8238CE107B14B98582879982--
