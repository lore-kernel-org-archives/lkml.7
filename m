Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37574C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C21A2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qp3zJLX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfERJLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:11:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58879 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:11:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9AvJg1737152
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:10:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9AvJg1737152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170658;
        bh=XmXTANWWOmA3HuCzlkq8Y3hjwjEzGcWz5UH2dD+7SMk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qp3zJLX5MY+aEfhOwZGTXcdgf+9Yk6kTalXE94IgHD6TfG/b5vhidp/XV68mu0K8j
         e2rbX4Q8ZXdMEDV3mGdCp/OD0b762EX4JnbZmts7yAUj6R9uHWhwB5v8X0DZwTvCAY
         MtKv9vSty8gtob9MhbRMccxr9It++91gO0NBrpjxz9mTgEk19nQ6aF9PGESJnaSjcv
         4n0GrL6qDkZGO5ZrkjcZLVTRXNsFr+KwJ6JpGFo3k7oo+gFcRonkKqEObph/KVvgJ3
         v7tpTwAbOEMUcDV57d3uRIeNyKYF5Vi/7jqjBSC7r9hbSr9RjCWV6I3OEHyJJyaErr
         duYLkABd5iTJA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9Au7p1737149;
        Sat, 18 May 2019 02:10:56 -0700
Date:   Sat, 18 May 2019 02:10:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-747e942c3925bb85e2865371664499a98fca83b0@git.kernel.org>
Cc:     mingo@kernel.org, rostedt@goodmis.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        namhyung@kernel.org, tstoyanov@vmware.com, hpa@zytor.com,
        jolsa@redhat.com, tglx@linutronix.de
Reply-To: namhyung@kernel.org, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          rostedt@goodmis.org, mingo@kernel.org, tglx@linutronix.de,
          jolsa@redhat.com, hpa@zytor.com, tstoyanov@vmware.com
In-Reply-To: <20190510200108.561088129@goodmis.org>
References: <20190510200108.561088129@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for libtraceevent
 event get APIs
Git-Commit-ID: 747e942c3925bb85e2865371664499a98fca83b0
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

Commit-ID:  747e942c3925bb85e2865371664499a98fca83b0
Gitweb:     https://git.kernel.org/tip/747e942c3925bb85e2865371664499a98fca83b0
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:23 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for libtraceevent event get APIs

Create man pages for libtraceevent APIs:

  tep_get_event(),
  tep_get_first_event(),
  tep_get_events_count()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-17-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200108.561088129@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-event_get.txt      | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-event_get.txt b/tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
new file mode 100644
index 000000000000..6525092fc417
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
@@ -0,0 +1,99 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_get_event, tep_get_first_event, tep_get_events_count - Access events.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_event pass:[*]*tep_get_event*(struct tep_handle pass:[*]_tep_, int _index_);
+struct tep_event pass:[*]*tep_get_first_event*(struct tep_handle pass:[*]_tep_);
+int *tep_get_events_count*(struct tep_handle pass:[*]_tep_);
+--
+
+DESCRIPTION
+-----------
+The _tep_get_event()_ function returns a pointer to event at the given _index_.
+The _tep_ argument is trace event parser context, the _index_ is the index of
+the requested event.
+
+The _tep_get_first_event()_ function returns a pointer to the first event.
+As events are stored in an array, this function returns the pointer to the
+beginning of the array. The _tep_ argument is trace event parser context.
+
+The _tep_get_events_count()_ function returns the number of the events
+in the array. The _tep_ argument is trace event parser context.
+
+RETURN VALUE
+------------
+The _tep_get_event()_ returns a pointer to the event located at _index_.
+NULL is returned in case of error, in case there are no events or _index_ is
+out of range.
+
+The _tep_get_first_event()_ returns a pointer to the first event. NULL is
+returned in case of error, or in case there are no events.
+
+The _tep_get_events_count()_ returns the number of the events. 0 is
+returned in case of error, or in case there are no events.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+int i,count = tep_get_events_count(tep);
+struct tep_event *event, *events = tep_get_first_event(tep);
+
+if (events == NULL) {
+	/* There are no events */
+} else {
+	for (i = 0; i < count; i++) {
+		event = (events+i);
+		/* process events[i] */
+	}
+
+	/* Get the last event */
+	event = tep_get_event(tep, count-1);
+}
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*-ltraceevent*
+	Linker switch to add when building a program that uses the library.
+--
+
+SEE ALSO
+--------
+_libtraceevent(3)_, _trace-cmd(1)_
+
+AUTHOR
+------
+[verse]
+--
+*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
+*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
+--
+REPORTING BUGS
+--------------
+Report bugs to  <linux-trace-devel@vger.kernel.org>
+
+LICENSE
+-------
+libtraceevent is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
