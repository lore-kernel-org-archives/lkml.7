Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972E3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA482147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554341703;
	bh=XZH/Gsq1/zJT9G/6Zqu8uGYuGmyrzZCrV39sQiddvrE=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=kc/U4mPhR7wKmbaV7MdXBWgT8ghIrmtRqNntMkcxdXs/I2RfS220AnpB6DXYM5F05
	 VIZVmvbExBYCDRcMcjUP5vRUdjSp71144+F1kwViz1yuCdQ9AcNbrkfa1Qh4hOtfTj
	 WquBLKPqFlTR5X0Tu+kQfKgLMWzNZxUnCPFoxdN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDDBfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDDBfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:35:01 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4842133D;
        Thu,  4 Apr 2019 01:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554341699;
        bh=XZH/Gsq1/zJT9G/6Zqu8uGYuGmyrzZCrV39sQiddvrE=;
        h=To:Cc:From:Subject:Date:From;
        b=BpzyXF+yOkCbkDB6yeNFuxGZdGfcG/9ZAkEtel4hGW4FWW/Q52HaPaTE4FNQZN6wC
         +hGy9IydTcseal1daGLy9DM5soSsFb+Jjp8JNduc9IXkSSJucavd7+Ty97WyUTe/W5
         Y4wdE3oqZHc/Y7dLVWmWOC9uSOFGm2rcAcWSFqJY=
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   shuah <shuah@kernel.org>
Subject: [GIT PULL] Kselftest update for Linux 5.1-rc4
Message-ID: <ea18a3f7-721e-0234-11e5-f91bf3ef1415@kernel.org>
Date:   Wed, 3 Apr 2019 19:34:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------094531598E046B72F15FE4D0"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------094531598E046B72F15FE4D0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.1-rc4

This Kselftest update for Linux 5.1-rc4 consists of fixes to rseq,
cgroup, and efivarfs tests.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.1-rc4

for you to fetch changes up to 1bb208e36bc9e9f8558f8e19bcb672ac49c3a5c2:

   selftests: cgroup: fix cleanup path in test_memcg_subtree_control() 
(2019-03-28 08:07:32 -0600)

----------------------------------------------------------------
linux-kselftest-5.1-rc4

This Kselftest update for Linux 5.1-rc4 consists of fixes to rseq, 
cgroup, and efivarfs tests.

----------------------------------------------------------------
Mathieu Desnoyers (1):
       rseq/selftests: Adapt number of threads to the number of detected 
cpus

Roman Gushchin (1):
       selftests: cgroup: fix cleanup path in test_memcg_subtree_control()

ZhangXiaoxu (1):
       selftests: efivarfs: remove the test_create_read file if it was exist

  tools/testing/selftests/cgroup/test_memcontrol.c | 38 
+++++++++++++-----------
  tools/testing/selftests/efivarfs/efivarfs.sh     |  4 +++
  tools/testing/selftests/rseq/run_param_test.sh   |  7 +++--
  3 files changed, 30 insertions(+), 19 deletions(-)

----------------------------------------------------------------

--------------094531598E046B72F15FE4D0
Content-Type: text/x-patch;
 name="linux-kselftest-5.1-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.1-rc4.diff"

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 28d321ba311b..6f339882a6ca 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -26,7 +26,7 @@
  */
 static int test_memcg_subtree_control(const char *root)
 {
-	char *parent, *child, *parent2, *child2;
+	char *parent, *child, *parent2 = NULL, *child2 = NULL;
 	int ret = KSFT_FAIL;
 	char buf[PAGE_SIZE];
 
@@ -34,50 +34,54 @@ static int test_memcg_subtree_control(const char *root)
 	parent = cg_name(root, "memcg_test_0");
 	child = cg_name(root, "memcg_test_0/memcg_test_1");
 	if (!parent || !child)
-		goto cleanup;
+		goto cleanup_free;
 
 	if (cg_create(parent))
-		goto cleanup;
+		goto cleanup_free;
 
 	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
-		goto cleanup;
+		goto cleanup_parent;
 
 	if (cg_create(child))
-		goto cleanup;
+		goto cleanup_parent;
 
 	if (cg_read_strstr(child, "cgroup.controllers", "memory"))
-		goto cleanup;
+		goto cleanup_child;
 
 	/* Create two nested cgroups without enabling memory controller */
 	parent2 = cg_name(root, "memcg_test_1");
 	child2 = cg_name(root, "memcg_test_1/memcg_test_1");
 	if (!parent2 || !child2)
-		goto cleanup;
+		goto cleanup_free2;
 
 	if (cg_create(parent2))
-		goto cleanup;
+		goto cleanup_free2;
 
 	if (cg_create(child2))
-		goto cleanup;
+		goto cleanup_parent2;
 
 	if (cg_read(child2, "cgroup.controllers", buf, sizeof(buf)))
-		goto cleanup;
+		goto cleanup_all;
 
 	if (!cg_read_strstr(child2, "cgroup.controllers", "memory"))
-		goto cleanup;
+		goto cleanup_all;
 
 	ret = KSFT_PASS;
 
-cleanup:
-	cg_destroy(child);
-	cg_destroy(parent);
-	free(parent);
-	free(child);
-
+cleanup_all:
 	cg_destroy(child2);
+cleanup_parent2:
 	cg_destroy(parent2);
+cleanup_free2:
 	free(parent2);
 	free(child2);
+cleanup_child:
+	cg_destroy(child);
+cleanup_parent:
+	cg_destroy(parent);
+cleanup_free:
+	free(parent);
+	free(child);
 
 	return ret;
 }
diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index a47029a799d2..d3866100e884 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -77,6 +77,10 @@ test_create_empty()
 test_create_read()
 {
 	local file=$efivarfs_mount/$FUNCNAME-$test_guid
+	if [ -f $file]; then
+		chattr -i $file
+		rm -rf $file
+	fi
 	./create-read $file
 }
 
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 3acd6d75ff9f..e426304fd4a0 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+ or MIT
 
+NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
+
 EXTRA_ARGS=${@}
 
 OLDIFS="$IFS"
@@ -28,15 +30,16 @@ IFS="$OLDIFS"
 
 REPS=1000
 SLOW_REPS=100
+NR_THREADS=$((6*${NR_CPUS}))
 
 function do_tests()
 {
 	local i=0
 	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
 		echo "Running test ${TEST_NAME[$i]}"
-		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running compare-twice test ${TEST_NAME[$i]}"
-		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }

--------------094531598E046B72F15FE4D0--
