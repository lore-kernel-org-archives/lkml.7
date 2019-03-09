Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E04C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE97207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCIT6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:58:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIT6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:58:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JwHgV3203130
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:58:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JwF4S3203124;
        Sat, 9 Mar 2019 11:58:15 -0800
Date:   Sat, 9 Mar 2019 11:58:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yang Wei <tipbot@zytor.com>
Message-ID: <tip-a53837a5458c5b84588dfa3fa510c6a29b7bd4d7@git.kernel.org>
Cc:     yang.wei9@zte.com.cn, namhyung@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org, jolsa@redhat.com,
        acme@redhat.com, albin_yang@163.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org
Reply-To: peterz@infradead.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org,
          albin_yang@163.com, yang.wei9@zte.com.cn, acme@redhat.com,
          jolsa@redhat.com
In-Reply-To: <1551710174-3349-1-git-send-email-albin_yang@163.com>
References: <1551710174-3349-1-git-send-email-albin_yang@163.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf clang: Remove needless extra semicolon
Git-Commit-ID: a53837a5458c5b84588dfa3fa510c6a29b7bd4d7
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

Commit-ID:  a53837a5458c5b84588dfa3fa510c6a29b7bd4d7
Gitweb:     https://git.kernel.org/tip/a53837a5458c5b84588dfa3fa510c6a29b7bd4d7
Author:     Yang Wei <yang.wei9@zte.com.cn>
AuthorDate: Mon, 4 Mar 2019 22:36:14 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 09:47:48 -0300

perf clang: Remove needless extra semicolon

Delete a superfluous semicolon in getBPFObjectFromModule().

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yang Wei <albin_yang@163.com>
Link: http://lkml.kernel.org/r/1551710174-3349-1-git-send-email-albin_yang@163.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/c++/clang.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index 39c0004f2886..fc361c3f8570 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -156,7 +156,7 @@ getBPFObjectFromModule(llvm::Module *Module)
 #endif
 	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
-		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
+		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
 	}
 	PM.run(*Module);
 
