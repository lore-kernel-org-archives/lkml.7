Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FD122CF7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567342107;
	bh=OK4elTGw/KytxIJfpfREzJz26BWzdre0pPKcaUpVmwc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=n/6YHMM9j0K39Ok4Ajx6noRnmty0TtGr25BdzovLXPBsQk0zbNEVVTTHOCIqnYOFN
	 gru3/+SL31dEd8FlfhB+hdnFdqytWNY6KboV+P0v2lPcgNovFat+iq+pG/M+bLMwYX
	 gCjqJ1o74sjz28/NTZYC5AjN5VsX4rAW15KgHMKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfIAMs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfIAMsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:48:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88B928666C;
        Sun,  1 Sep 2019 12:48:25 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0F1600CE;
        Sun,  1 Sep 2019 12:48:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 0/4] perf tools: libperf related fixes
Date:   Sun,  1 Sep 2019 14:48:18 +0200
Message-Id: <20190901124822.10132-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 01 Sep 2019 12:48:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending some libperf related fixes.

thanks,
jirka


---
Jiri Olsa (4):
      perf tools: Fix python/perf.so compilation
      perf tests: Fix static build test
      perf tests: Add libperf automated test
      libperf: Add missing event.h into install rule

 tools/perf/Makefile.perf | 2 +-
 tools/perf/lib/Makefile  | 1 +
 tools/perf/tests/make    | 8 ++++++--
 3 files changed, 8 insertions(+), 3 deletions(-)
