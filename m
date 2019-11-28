Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23639C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37F221787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948479;
	bh=7ebZxlQeK3i6HO6kyJkH5U3sX6wGAES1gtF55or1/4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZcXr/xQHHXryODPFWc+ZvBZlZA1DrIvsnYLNJ+OKGaB8na/Ex/GWeFROgaQq4DfF
	 SE20LPb5S/dZ4MvyN++jtDFqHT7DYD1I9lTxro8nGapw1bGX3dme/K2f8Ab2Xf0dcG
	 PVcXkdt0EBsm1167LQjio8R/Yeg/jjrOop05Skc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfK1NlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfK1NlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:14 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047D2217BA;
        Thu, 28 Nov 2019 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948473;
        bh=7ebZxlQeK3i6HO6kyJkH5U3sX6wGAES1gtF55or1/4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRKXoKB8jQ8lcUuaE+m6WLCaJi3BZ23+gDK/V0XByGFfaIz7WrbashVOxca/omUul
         AQVc64eiHehnbLm6t3Hu04cVUJoUY+LMo20A2ABJflJauR22s6hRAIwNc32md6OMyn
         TYqm061SQY3NnbfF+WxouoiIO4ZTiQ0JrZXRkOx0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 12/22] perf maps: Rename map_groups.h to maps.h
Date:   Thu, 28 Nov 2019 10:40:17 -0300
Message-Id: <20191128134027.23726-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step in the merge of 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9ibtn3vua76f934t7woyf26w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     | 2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c   | 2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c     | 2 +-
 tools/perf/tests/map_groups.c                | 2 +-
 tools/perf/ui/stdio/hist.c                   | 2 +-
 tools/perf/util/annotate.c                   | 2 +-
 tools/perf/util/machine.h                    | 2 +-
 tools/perf/util/{map_groups.h => maps.h}     | 6 +++---
 tools/perf/util/probe-event.c                | 2 +-
 tools/perf/util/symbol-elf.c                 | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)
 rename tools/perf/util/{map_groups.h => maps.h} (96%)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index ff0bea660cf9..ccfa87055c4a 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -3,7 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index 85108437b3af..46147a483049 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -3,7 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 30658e3b32b2..8efd9ed9e9db 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -3,7 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 418969cd64e9..ef43be9b6ec2 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -3,7 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index 9df1d14db40e..7febd02069ae 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -3,7 +3,7 @@
 #include <linux/kernel.h>
 #include "tests.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "dso.h"
 #include "debug.h"
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 161d8342ce05..2ab2af4d4849 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -8,7 +8,7 @@
 #include "../../util/event.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
-#include "../../util/map_groups.h"
+#include "../../util/maps.h"
 #include "../../util/symbol.h"
 #include "../../util/sort.h"
 #include "../../util/evsel.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 14f3edc3c261..f5e77ed237e8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -23,7 +23,7 @@
 #include "dso.h"
 #include "env.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "symbol.h"
 #include "srcline.h"
 #include "units.h"
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index fe602cfc2163..be0a930eca89 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -4,7 +4,7 @@
 
 #include <sys/types.h>
 #include <linux/rbtree.h>
-#include "map_groups.h"
+#include "maps.h"
 #include "dsos.h"
 #include "rwsem.h"
 
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/maps.h
similarity index 96%
rename from tools/perf/util/map_groups.h
rename to tools/perf/util/maps.h
index ada2f401ebab..3dd000ddf925 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/maps.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_MAP_GROUPS_H
-#define __PERF_MAP_GROUPS_H
+#ifndef __PERF_MAPS_H
+#define __PERF_MAPS_H
 
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
@@ -84,4 +84,4 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
 void __maps__sort_by_name(struct maps *maps);
 
-#endif // __PERF_MAP_GROUPS_H
+#endif // __PERF_MAPS_H
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c06cc9764c3b..eea132f512b0 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -28,7 +28,7 @@
 #include "dso.h"
 #include "color.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "symbol.h"
 #include <api/fs/fs.h>
 #include "trace-event.h"	/* For __maybe_unused */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index fac3f585e9b4..6658fbf196e6 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -9,7 +9,7 @@
 
 #include "dso.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "symbol.h"
 #include "symsrc.h"
 #include "demangle-java.h"
-- 
2.21.0

