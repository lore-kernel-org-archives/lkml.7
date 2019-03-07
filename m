Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E89FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FEC20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980887;
	bh=k81k8pJN0QhYbWoT4O9814n7hxYVrGWqh2Xqg6P3qnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAlxaKV0qrs2VOJ+ArtRfcD042oYnwsCSTPh4Fe7NRHvhEymJ8F1Gbd5PjeOj40vw
	 +GfQ80hPMtYw7UoKlySLBuSCI8M2pe2/3RrQ9Y8xhiH+mhGcW0c+K8i/crkCU0L3fW
	 bZLSF/VMBNnE2uHgsfh595yMMHk5Qwp/cfLODb3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCGRsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCGRqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:03 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA0620661;
        Thu,  7 Mar 2019 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980763;
        bh=k81k8pJN0QhYbWoT4O9814n7hxYVrGWqh2Xqg6P3qnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5dlRwVzjcuKpVdYj36A7Wax39Vs7ENti9y1xSyGy0SbK7bJ2dKvy68QihWw+gAlv
         7MxpifOOO04knxSSFK0624S3Md9APzFIhWEYibn9aTSWvfjPIJYj16QDjgHNNQiScD
         jXFY5oke0ZM/j4BU4BqcwpW/H9JIDQx14g8n89DA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Yang Wei <yang.wei9@zte.com.cn>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Wei <albin_yang@163.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/35] perf clang: Remove needless extra semicolon
Date:   Thu,  7 Mar 2019 14:44:16 -0300
Message-Id: <20190307174433.28819-19-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Wei <yang.wei9@zte.com.cn>

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
 
-- 
2.20.1

