Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41694C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A7823407
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566472309;
	bh=/8QMT8Naawlv97tjufZGeNrT0RACGye5oJ2pdrYce3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XiXdbREg+0lofwiaaXG90HE5Iu/86/Mlq/I+FkyCeOZHb5qUjYUmmR/15e6qqsdhp
	 rPby2eGlbISHZNuOyjalkEXmd1YpBDS8rDCQbvnqRM3pNbabJCbjOIAX5aRY8SMngX
	 bt7IY60cMMw4S/cJvfac2t3EpUVKWXPfI9doC8Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbfHVLLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbfHVLLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:11:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF316300DA78;
        Thu, 22 Aug 2019 11:11:45 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25D1A1001B17;
        Thu, 22 Aug 2019 11:11:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 1/5] tools: Add missing perf_event.h include
Date:   Thu, 22 Aug 2019 13:11:37 +0200
Message-Id: <20190822111141.25823-2-jolsa@kernel.org>
In-Reply-To: <20190822111141.25823-1-jolsa@kernel.org>
References: <20190822111141.25823-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 22 Aug 2019 11:11:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need perf_event.h include for 'struct perf_event_mmap_page'.

Link: http://lkml.kernel.org/n/tip-bolqkmqajexhccjb0ib0an8w@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/linux/ring_buffer.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/ring_buffer.h b/tools/include/linux/ring_buffer.h
index 9a083ae60473..6c02617377c2 100644
--- a/tools/include/linux/ring_buffer.h
+++ b/tools/include/linux/ring_buffer.h
@@ -2,6 +2,7 @@
 #define _TOOLS_LINUX_RING_BUFFER_H_
 
 #include <asm/barrier.h>
+#include <linux/perf_event.h>
 
 /*
  * Contract with kernel for walking the perf ring buffer from
-- 
2.21.0

