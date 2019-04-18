Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E79C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A663021872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611506;
	bh=5G1ZGJeZ2BzndWeea4YW5M7W1RxUHqGsUaEGk3HXDhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WP2170jzMpI3sSzrAhSDzB3W19/DvSJ0VlTG6bVTemtEyCivLmxb2e9zNfu+ytpjl
	 CPUZsYCJxlzdQIia9sK9DUt3Vcc5IVMtxCnMq/CEnUlAkz3Qf5SHOiz0qAHSIWWq5+
	 SQdub62BER5SkQd/xjOTIHyWg9o6iplBp8m/7Bbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404342AbfDRSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404142AbfDRSKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4872186A;
        Thu, 18 Apr 2019 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611039;
        bh=5G1ZGJeZ2BzndWeea4YW5M7W1RxUHqGsUaEGk3HXDhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAKYQIYz6/o4QqCPQcthJcqyS9vxq0u5elsc5Ave7JcScigRRf5R9U6FA3ffte0Oy
         ohq/HI1HiQKA4qWGXGidLRjB9p986m9Cc70O6wdpUgG/d5RN0cktkK5IjbBD21B2qn
         1cps8B40ENSeZQrbXu1y3J9TuUNgy52wE8abakkc=
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
Subject: [PATCH 5.0 36/93] perf config: Fix an error in the config template documentation
Date:   Thu, 18 Apr 2019 19:57:14 +0200
Message-Id: <20190418160440.830447135@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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
index 4ac7775fbc11..4851285ba00c 100644
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



