Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D92C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72F3218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610358;
	bh=t84mk2uvm9CYBHnqAqMRgWYXWoa1fE1pfCmitohWuzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WNcJeQIck0vHWwl4rKEMMkeUw2mWJo/S/Gy2h/VXi/UDmJYZQT9QzLSJ29rC5aw6r
	 9AnRkWRgWY/jTT5VqxUWIG2Wc6y8uTgrfO3Npi7odFa+EZyKEiCkr/Ytp431bLZIKg
	 cd+aydpTBzHZXXIXaKzSaWptbwbhuyJ4MlOQ6lC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbfDRR7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390073AbfDRR7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:59:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E8B218A6;
        Thu, 18 Apr 2019 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610354;
        bh=t84mk2uvm9CYBHnqAqMRgWYXWoa1fE1pfCmitohWuzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLOwwn6HkYjaSkQnOTslTDcEH1ibjLz/OozTZD9WZPvWoc0WaYdr5UfRqMV8xkD/5
         RKa38VunKAZUXIVoSyzrpcnOZagC7meO8UUBsjWBLYCBuSpprqcvD4PUU8v/MxqzRQ
         Xu+sBO01kmF6g1U8VmmBYD6IF2PcdSxt48vu41YY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/110] perf config: Fix an error in the config template documentation
Date:   Thu, 18 Apr 2019 19:56:18 +0200
Message-Id: <20190418160441.050947189@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9b40dff7ba3caaf0d1919f98e136fa3400bd34aa ]

The option 'sort-order' should be 'sort_order'.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 893c5c798be9 ("perf config: Show default report configuration in example and docs")
Link: http://lkml.kernel.org/r/20190316080556.3075-5-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Documentation/perf-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 32f4a898e3f2..05c10eb56a0c 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -114,7 +114,7 @@ Given a $HOME/.perfconfig like this:
 
 	[report]
 		# Defaults
-		sort-order = comm,dso,symbol
+		sort_order = comm,dso,symbol
 		percent-limit = 0
 		queue-size = 0
 		children = true
-- 
2.19.1



