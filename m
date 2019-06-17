Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395A5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083EE208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ki9DSDjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfFQTGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:06:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfFQTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:06:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ6Kqs3557458
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:06:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ6Kqs3557458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798381;
        bh=kFwIgSiREST7oqsbnpiUUGTnIJ5e4VL7bPFl3bJaAy0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ki9DSDjCsuVbIHMYcB1cW0tMyqyVZ/fzYLPv3RvMkSmQfb/7j9y8K9Y1Ptj/faeRq
         2beaO4zYfwlhWdSPS/Gif4jlupz6pxQ6zudl76i3k6RGGDIn/oPAbUHsOUaa30/CH9
         //UWGn3UhK/5bTVTCVnIr7+qzijQjP3As5I3kFa3Uofr7WuvNCGdrF4In9aF3dPLPa
         xAitiLMuEUxl453AoIAT5p4n2wUH68yIOtaf6ebU3LrajMz50YLrpI4KucCkGqv5Gn
         JcydjfqZRp1pkvoLYeMpAqffH+cggos8mzQ94B9PkJd716xnt/5LPgWbWACQ4mBjFC
         M8TZNsOvw71pg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ6KOQ3557455;
        Mon, 17 Jun 2019 12:06:20 -0700
Date:   Mon, 17 Jun 2019 12:06:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1159facee97fe184a434db3086604c7572fd7dfa@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com, jolsa@redhat.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, tglx@linutronix.de, mingo@kernel.org,
          jolsa@redhat.com, acme@redhat.com
In-Reply-To: <20190520113728.14389-15-adrian.hunter@intel.com>
References: <20190520113728.14389-15-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf db-export: Add brief documentation
Git-Commit-ID: 1159facee97fe184a434db3086604c7572fd7dfa
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

Commit-ID:  1159facee97fe184a434db3086604c7572fd7dfa
Gitweb:     https://git.kernel.org/tip/1159facee97fe184a434db3086604c7572fd7dfa
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:20 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:57 -0300

perf db-export: Add brief documentation

Add brief documentation to explain how the database export maintains
backward and forward compatibility.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/db-export.txt | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/Documentation/db-export.txt b/tools/perf/Documentation/db-export.txt
new file mode 100644
index 000000000000..52ffccb02d55
--- /dev/null
+++ b/tools/perf/Documentation/db-export.txt
@@ -0,0 +1,41 @@
+Database Export
+===============
+
+perf tool's python scripting engine:
+
+	tools/perf/util/scripting-engines/trace-event-python.c
+
+supports scripts:
+
+	tools/perf/scripts/python/export-to-sqlite.py
+	tools/perf/scripts/python/export-to-postgresql.py
+
+which export data to a SQLite3 or PostgreSQL database.
+
+The export process provides records with unique sequential ids which allows the
+data to be imported directly to a database and provides the relationships
+between tables.
+
+Over time it is possible to continue to expand the export while maintaining
+backward and forward compatibility, by following some simple rules:
+
+1. Because of the nature of SQL, existing tables and columns can continue to be
+used so long as the names and meanings (and to some extent data types) remain
+the same.
+
+2. New tables and columns can be added, without affecting existing SQL queries,
+so long as the new names are unique.
+
+3. Scripts that use a database (e.g. exported-sql-viewer.py) can maintain
+backward compatibility by testing for the presence of new tables and columns
+before using them. e.g. function IsSelectable() in exported-sql-viewer.py
+
+4. The export scripts themselves maintain forward compatibility (i.e. an existing
+script will continue to work with new versions of perf) by accepting a variable
+number of arguments (e.g. def call_return_table(*x)) i.e. perf can pass more
+arguments which old scripts will ignore.
+
+5. The scripting engine tests for the existence of script handler functions
+before calling them.  The scripting engine can also test for the support of new
+or optional features by checking for the existence and value of script global
+variables.
