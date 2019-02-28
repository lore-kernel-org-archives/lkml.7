Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F801C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A4E2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfB1HPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:15:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46893 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfB1HPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:15:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7F6qM2940217
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:15:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7F61d2940212;
        Wed, 27 Feb 2019 23:15:06 -0800
Date:   Wed, 27 Feb 2019 23:15:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-d93ac78bf7b37db36fa00225f8e9a14c7ed1b2ba@git.kernel.org>
Cc:     mingo@kernel.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, bvanassche@acm.org,
        paulmck@linux.vnet.ibm.com, longman@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        akpm@linux-foundation.org, peterz@infradead.org,
        johannes@sipsolutions.net, hpa@zytor.com
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org,
          johannes@sipsolutions.net, akpm@linux-foundation.org,
          tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          longman@redhat.com, linux-kernel@vger.kernel.org,
          will.deacon@arm.com, paulmck@linux.vnet.ibm.com,
          bvanassche@acm.org
In-Reply-To: <20190214230058.196511-23-bvanassche@acm.org>
References: <20190214230058.196511-23-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] lockdep/lib/tests: Fix run_tests.sh
Git-Commit-ID: d93ac78bf7b37db36fa00225f8e9a14c7ed1b2ba
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d93ac78bf7b37db36fa00225f8e9a14c7ed1b2ba
Gitweb:     https://git.kernel.org/tip/d93ac78bf7b37db36fa00225f8e9a14c7ed1b2ba
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:57 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:48 +0100

lockdep/lib/tests: Fix run_tests.sh

Apparently the execute bits were set for the tests/*.sh scripts on my
test setup but these are not set in the kernel tree. Fix this by adding
the interpreter path in front of the script paths.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Fixes: 5ecb8e94b494 ("tools/lib/lockdep/tests: Improve testing accuracy") # v5.0-rc1
Link: https://lkml.kernel.org/r/20190214230058.196511-23-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/lib/lockdep/run_tests.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index c8fbd0306960..11f425662b43 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -11,7 +11,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "$testname... "
 	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
-		timeout 1 "tests/$testname" 2>&1 | "tests/${testname}.sh"; then
+		timeout 1 "tests/$testname" 2>&1 | /bin/bash "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -24,7 +24,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	echo -ne "(PRELOAD) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
 		timeout 1 ./lockdep "tests/$testname" 2>&1 |
-		"tests/${testname}.sh"; then
+		/bin/bash "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -37,7 +37,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	echo -ne "(PRELOAD + Valgrind) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
 		{ timeout 10 valgrind --read-var-info=yes ./lockdep "./tests/$testname" >& "tests/${testname}.vg.out"; true; } &&
-		"tests/${testname}.sh" < "tests/${testname}.vg.out" &&
+		/bin/bash "tests/${testname}.sh" < "tests/${testname}.vg.out" &&
 		! grep -Eq '(^==[0-9]*== (Invalid |Uninitialised ))|Mismatched free|Source and destination overlap| UME ' "tests/${testname}.vg.out"; then
 		echo "PASSED!"
 	else
