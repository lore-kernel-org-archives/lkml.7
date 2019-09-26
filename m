Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B0DC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43D3222C1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458160;
	bh=O7LmWFNLfQiJMLjwb6OqowL/JkyS2+bMJd8JRq4y3Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZBRL0YABt6aXFbtoaGbLaTuUT4na4AwXVMILcbVBRbLhY2DF6qeG0426Swk/HwcLN
	 v3GOWnp/MYy9SHKa0XZcK9SwXN7/ei7WgyZWseog+kPw+s55+KXxZOTX/PAtZz/bxK
	 zQH2OfVuivT7FzVaAyJhb9JQ7EZmntpaEAjH1e9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390175AbfIZAf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390002AbfIZAf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:56 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D453222D1;
        Thu, 26 Sep 2019 00:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458155;
        bh=O7LmWFNLfQiJMLjwb6OqowL/JkyS2+bMJd8JRq4y3Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJ6GCbfRJQIQprWExNagN7i+kBHQEZUWbMx/zxAsakwQsAcCF1RQc1MjLDwZvb3/d
         EvpEjz+q6zU9O1Mu/sJklU6/oX6vltjk6BtyMtnuezX3Z66v4h/lHdkfb9HO6MqJMe
         t9uMVHVd/1x8EF6vxB7nLdD1KktpJard1oa+Ye5Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 49/66] libperf: Add libperf dependency for tests targets
Date:   Wed, 25 Sep 2019 21:32:27 -0300
Message-Id: <20190926003244.13962-50-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add libperf dependency for tests targets.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-36-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 54466cc84544..85ccb8c439a4 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -138,7 +138,7 @@ clean: $(LIBAPI)-clean
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
 	$(Q)$(MAKE) -C tests clean
 
-tests:
+tests: libs
 	$(Q)$(MAKE) -C tests
 	$(Q)$(MAKE) -C tests run
 
-- 
2.21.0

