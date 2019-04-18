Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B0C282E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FCD21907
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610854;
	bh=wqUT1HyOQa0HCnp+cr4TycNn11BocePAzTewT4fllpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FD8xmCT8/39KiT2QV5U2GO4YqtZQTcXqMRjbCKZcvz0dzai/fDhwxq9LlByJunaKO
	 uWfRgpMYxIDnjJtBwwXTOPbKrSOdOeUblbXXWjYzZ6pijG7AFt5SOFWjG4zDezN9CQ
	 Gv+hC0mUbFnMFrOOfrqzucL4FJ1ZZXX5nZ6SiMY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389960AbfDRSHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403777AbfDRSHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09DCD2186A;
        Thu, 18 Apr 2019 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610844;
        bh=wqUT1HyOQa0HCnp+cr4TycNn11BocePAzTewT4fllpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBputtFZ+DW0oJgI/WP49HkUZ5SNGs54hrj3sID81h8ko7P+jB+Vlpoeo3lx+Xa+P
         QeIuCus4eH7n3VbIezjyvQ7ABpaZ2kdySxlWomQ0Qg4rOyzOJEXczHCOyQfYQ3NwmR
         2WuRkTvJBf6nGOXnFZoAf5bzDDuWtzKhaZqvUDOE=
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
Subject: [PATCH 4.9 13/50] perf config: Fix an error in the config template documentation
Date:   Thu, 18 Apr 2019 19:57:24 +0200
Message-Id: <20190418160424.415303886@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
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
index cb081ac59fd1..bd359a04cb94 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -112,7 +112,7 @@ Given a $HOME/.perfconfig like this:
 
 	[report]
 		# Defaults
-		sort-order = comm,dso,symbol
+		sort_order = comm,dso,symbol
 		percent-limit = 0
 		queue-size = 0
 		children = true
-- 
2.19.1



