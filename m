Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B19C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106972176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfK2GDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48076 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfK2GDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMn-0008IW-17; Fri, 29 Nov 2019 07:02:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BDC881C2101;
        Fri, 29 Nov 2019 07:02:51 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf maps: Rename map_groups.h to maps.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-9ibtn3vua76f934t7woyf26w@git.kernel.org>
References: <tip-9ibtn3vua76f934t7woyf26w@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737165.21853.11927330774804634932.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c54d241b35c57d19e798e0381dc4838d7447214b
Gitweb:        https://git.kernel.org/tip/c54d241b35c57d19e798e0381dc4838d7447214b
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 25 Nov 2019 22:24:10 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

perf maps: Rename map_groups.h to maps.h

One more step in the merge of 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9ibtn3vua76f934t7woyf26w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     |  2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c   |  2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c |  2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c     |  2 +-
 tools/perf/tests/map_groups.c                |  2 +-
 tools/perf/ui/stdio/hist.c                   |  2 +-
 tools/perf/util/annotate.c                   |  2 +-
 tools/perf/util/machine.h                    |  2 +-
 tools/perf/util/map_groups.h                 | 87 +-------------------
 tools/perf/util/maps.h                       | 87 +++++++++++++++++++-
 tools/perf/util/probe-event.c                |  2 +-
 tools/perf/util/symbol-elf.c                 |  2 +-
 12 files changed, 97 insertions(+), 97 deletions(-)
 delete mode 100644 tools/perf/util/map_groups.h
 create mode 100644 tools/perf/util/maps.h

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index ff0bea6..ccfa870 100644
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
index 8510843..46147a4 100644
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
index 30658e3..8efd9ed 100644
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
index 418969c..ef43be9 100644
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
index 9df1d14..7febd02 100644
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
index 161d834..2ab2af4 100644
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
index 14f3edc..f5e77ed 100644
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
index fe602cf..be0a930 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -4,7 +4,7 @@
 
 #include <sys/types.h>
 #include <linux/rbtree.h>
-#include "map_groups.h"
+#include "maps.h"
 #include "dsos.h"
 #include "rwsem.h"
 
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
deleted file mode 100644
index ada2f40..0000000
--- a/tools/perf/util/map_groups.h
+++ /dev/null
@@ -1,87 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_MAP_GROUPS_H
-#define __PERF_MAP_GROUPS_H
-
-#include <linux/refcount.h>
-#include <linux/rbtree.h>
-#include <stdio.h>
-#include <stdbool.h>
-#include <linux/types.h>
-#include "rwsem.h"
-
-struct ref_reloc_sym;
-struct machine;
-struct map;
-struct maps;
-struct thread;
-
-struct map *maps__find(struct maps *maps, u64 addr);
-struct map *maps__first(struct maps *maps);
-struct map *map__next(struct map *map);
-
-#define maps__for_each_entry(maps, map) \
-	for (map = maps__first(maps); map; map = map__next(map))
-
-#define maps__for_each_entry_safe(maps, map, next) \
-	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
-
-struct maps {
-	struct rb_root      entries;
-	struct rw_semaphore lock;
-	struct machine	 *machine;
-	struct map	 *last_search_by_name;
-	struct map	 **maps_by_name;
-	refcount_t	 refcnt;
-	unsigned int	 nr_maps;
-	unsigned int	 nr_maps_allocated;
-#ifdef HAVE_LIBUNWIND_SUPPORT
-	void				*addr_space;
-	struct unwind_libunwind_ops	*unwind_libunwind_ops;
-#endif
-};
-
-#define KMAP_NAME_LEN 256
-
-struct kmap {
-	struct ref_reloc_sym *ref_reloc_sym;
-	struct maps	     *kmaps;
-	char		     name[KMAP_NAME_LEN];
-};
-
-struct maps *maps__new(struct machine *machine);
-void maps__delete(struct maps *maps);
-bool maps__empty(struct maps *maps);
-
-static inline struct maps *maps__get(struct maps *maps)
-{
-	if (maps)
-		refcount_inc(&maps->refcnt);
-	return maps;
-}
-
-void maps__put(struct maps *maps);
-void maps__init(struct maps *maps, struct machine *machine);
-void maps__exit(struct maps *maps);
-int maps__clone(struct thread *thread, struct maps *parent);
-size_t maps__fprintf(struct maps *maps, FILE *fp);
-
-void maps__insert(struct maps *maps, struct map *map);
-
-void maps__remove(struct maps *maps, struct map *map);
-
-struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp);
-struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
-
-struct addr_map_symbol;
-
-int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
-
-int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp);
-
-struct map *maps__find_by_name(struct maps *maps, const char *name);
-
-int maps__merge_in(struct maps *kmaps, struct map *new_map);
-
-void __maps__sort_by_name(struct maps *maps);
-
-#endif // __PERF_MAP_GROUPS_H
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
new file mode 100644
index 0000000..3dd000d
--- /dev/null
+++ b/tools/perf/util/maps.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_MAPS_H
+#define __PERF_MAPS_H
+
+#include <linux/refcount.h>
+#include <linux/rbtree.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <linux/types.h>
+#include "rwsem.h"
+
+struct ref_reloc_sym;
+struct machine;
+struct map;
+struct maps;
+struct thread;
+
+struct map *maps__find(struct maps *maps, u64 addr);
+struct map *maps__first(struct maps *maps);
+struct map *map__next(struct map *map);
+
+#define maps__for_each_entry(maps, map) \
+	for (map = maps__first(maps); map; map = map__next(map))
+
+#define maps__for_each_entry_safe(maps, map, next) \
+	for (map = maps__first(maps), next = map__next(map); map; map = next, next = map__next(map))
+
+struct maps {
+	struct rb_root      entries;
+	struct rw_semaphore lock;
+	struct machine	 *machine;
+	struct map	 *last_search_by_name;
+	struct map	 **maps_by_name;
+	refcount_t	 refcnt;
+	unsigned int	 nr_maps;
+	unsigned int	 nr_maps_allocated;
+#ifdef HAVE_LIBUNWIND_SUPPORT
+	void				*addr_space;
+	struct unwind_libunwind_ops	*unwind_libunwind_ops;
+#endif
+};
+
+#define KMAP_NAME_LEN 256
+
+struct kmap {
+	struct ref_reloc_sym *ref_reloc_sym;
+	struct maps	     *kmaps;
+	char		     name[KMAP_NAME_LEN];
+};
+
+struct maps *maps__new(struct machine *machine);
+void maps__delete(struct maps *maps);
+bool maps__empty(struct maps *maps);
+
+static inline struct maps *maps__get(struct maps *maps)
+{
+	if (maps)
+		refcount_inc(&maps->refcnt);
+	return maps;
+}
+
+void maps__put(struct maps *maps);
+void maps__init(struct maps *maps, struct machine *machine);
+void maps__exit(struct maps *maps);
+int maps__clone(struct thread *thread, struct maps *parent);
+size_t maps__fprintf(struct maps *maps, FILE *fp);
+
+void maps__insert(struct maps *maps, struct map *map);
+
+void maps__remove(struct maps *maps, struct map *map);
+
+struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp);
+struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, struct map **mapp);
+
+struct addr_map_symbol;
+
+int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
+
+int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp);
+
+struct map *maps__find_by_name(struct maps *maps, const char *name);
+
+int maps__merge_in(struct maps *kmaps, struct map *new_map);
+
+void __maps__sort_by_name(struct maps *maps);
+
+#endif // __PERF_MAPS_H
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c06cc97..eea132f 100644
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
index fac3f58..6658fbf 100644
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
