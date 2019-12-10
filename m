Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C1C2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB91205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950206;
	bh=nizLtATKxMfubU0QaH46hEYyysH/PEGlcECCY0li6c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c+jSvAuqsbxpyKUfHEILZ/R/HP1JbZMQ/FlbTHQDt4T4SbZKrSJGkrz4fy+DsyYEZ
	 a/R0UrUdX7FG4noBf1hAe48krUDCOBEv10C4Ro93M7kqe1F7b5aSvETCS0nuwxsMvw
	 K2JQ5cSNI6a+JAzaNg5O6nBAhQ6N3FhkdBNsYg3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLJD4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJD4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:56:45 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959FF20726;
        Tue, 10 Dec 2019 03:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950204;
        bh=nizLtATKxMfubU0QaH46hEYyysH/PEGlcECCY0li6c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnnna64rIimlRThuw2+J/UJ8OQvzVeENgJVmBKxE0b8tWnLmbsmVTJuKBBth6+3kO
         H/UsVir3FlWxf+6GP5etROjLDfgIz0xx/ThlIgboGkYxHdIlC4SaOMdQ4Bb6u/xTit
         RumZqnCJgnIEK2uto8W5CqhPeXXBGzq8Jdgf/rfI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/7] doc: Convert arrayRCU.txt to arrayRCU.rst
Date:   Mon,  9 Dec 2019 19:56:35 -0800
Message-Id: <20191210035641.2226-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210035539.GA792@paulmck-ThinkPad-P72>
References: <20191210035539.GA792@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch converts arrayRCU from .txt to .rst format, and also adds
arrayRCU.rst to the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
[ paulmck: Trimmed trailing whitespace. ]
Tested-by: Phong Tran <tranmanphong@gmail.com>
Tested-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

squash! Documentation: RCU: arrayRCU: Converted arrayRCU.txt to arrayRCU.rst

Also fix subject line.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} | 30 +++++++++++++++++-------
 Documentation/RCU/index.rst                      |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)
 rename Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} (87%)

diff --git a/Documentation/RCU/arrayRCU.txt b/Documentation/RCU/arrayRCU.rst
similarity index 87%
rename from Documentation/RCU/arrayRCU.txt
rename to Documentation/RCU/arrayRCU.rst
index f05a9af..743a4ea 100644
--- a/Documentation/RCU/arrayRCU.txt
+++ b/Documentation/RCU/arrayRCU.rst
@@ -1,19 +1,21 @@
-Using RCU to Protect Read-Mostly Arrays
+.. _array_rcu_doc:
 
+Using RCU to Protect Read-Mostly Arrays
+=======================================
 
 Although RCU is more commonly used to protect linked lists, it can
 also be used to protect arrays.  Three situations are as follows:
 
-1.  Hash Tables
+1.  :ref:`Hash Tables <hash_tables>`
 
-2.  Static Arrays
+2.  :ref:`Static Arrays <static_arrays>`
 
-3.  Resizeable Arrays
+3.  :ref:`Resizeable Arrays <resizeable_arrays>`
 
 Each of these three situations involves an RCU-protected pointer to an
 array that is separately indexed.  It might be tempting to consider use
 of RCU to instead protect the index into an array, however, this use
-case is -not- supported.  The problem with RCU-protected indexes into
+case is **not** supported.  The problem with RCU-protected indexes into
 arrays is that compilers can play way too many optimization games with
 integers, which means that the rules governing handling of these indexes
 are far more trouble than they are worth.  If RCU-protected indexes into
@@ -24,16 +26,20 @@ to be safely used.
 That aside, each of the three RCU-protected pointer situations are
 described in the following sections.
 
+.. _hash_tables:
 
 Situation 1: Hash Tables
+------------------------
 
 Hash tables are often implemented as an array, where each array entry
 has a linked-list hash chain.  Each hash chain can be protected by RCU
 as described in the listRCU.txt document.  This approach also applies
 to other array-of-list situations, such as radix trees.
 
+.. _static_arrays:
 
 Situation 2: Static Arrays
+--------------------------
 
 Static arrays, where the data (rather than a pointer to the data) is
 located in each array element, and where the array is never resized,
@@ -41,11 +47,15 @@ have not been used with RCU.  Rik van Riel recommends using seqlock in
 this situation, which would also have minimal read-side overhead as long
 as updates are rare.
 
-Quick Quiz:  Why is it so important that updates be rare when
-	     using seqlock?
+Quick Quiz:
+		Why is it so important that updates be rare when using seqlock?
+
+:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
 
+.. _resizeable_arrays:
 
 Situation 3: Resizeable Arrays
+------------------------------
 
 Use of RCU for resizeable arrays is demonstrated by the grow_ary()
 function formerly used by the System V IPC code.  The array is used
@@ -60,7 +70,7 @@ the remainder of the new, updates the ids->entries pointer to point to
 the new array, and invokes ipc_rcu_putref() to free up the old array.
 Note that rcu_assign_pointer() is used to update the ids->entries pointer,
 which includes any memory barriers required on whatever architecture
-you are running on.
+you are running on::
 
 	static int grow_ary(struct ipc_ids* ids, int newsize)
 	{
@@ -112,7 +122,7 @@ a simple check suffices.  The pointer to the structure corresponding
 to the desired IPC object is placed in "out", with NULL indicating
 a non-existent entry.  After acquiring "out->lock", the "out->deleted"
 flag indicates whether the IPC object is in the process of being
-deleted, and, if not, the pointer is returned.
+deleted, and, if not, the pointer is returned::
 
 	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
 	{
@@ -144,8 +154,10 @@ deleted, and, if not, the pointer is returned.
 		return out;
 	}
 
+.. _answer_quick_quiz_seqlock:
 
 Answer to Quick Quiz:
+	Why is it so important that updates be rare when using seqlock?
 
 	The reason that it is important that updates be rare when
 	using seqlock is that frequent updates can livelock readers.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 5c99185..8d20d44 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -7,6 +7,7 @@ RCU concepts
 .. toctree::
    :maxdepth: 3
 
+   arrayRCU
    rcu
    listRCU
    UP
-- 
2.9.5

