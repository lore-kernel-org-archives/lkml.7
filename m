Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1189C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E8E2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="g3ip0sKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfERJPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:15:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:15:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9FKMB1738056
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:15:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9FKMB1738056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170921;
        bh=0+L8TxTol7as+YL0SAGL8LGFGG5mwanR0QXJ7p5EhA4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=g3ip0sKE2vGeM08iktzg9rXxe8g03vDemA41ZiW8CjVPMxJIUPDKri6G1qqi0HbD5
         7irtwXQw0z+Kjn2Yo4mcskKOfuHgFqDvki5jixn7MWxg1e6C3A5iWKqujkY9LzscQ2
         u2hI2hSyPT+ZFK2Bviuk50iL0UEY6maoBvGNhZ85j40xrR1HVwF99hkTc0ILJeJNgf
         RSf1skpegMl1ozPYN62e9w6rQc1082OCNkEfnh7vIhqQJmZl308xUngGEBoNo9H6iA
         lMjiY3gxBtrdkBqtgXteP6j005fN/oL9O4fD6o4pUgXiVTA0UFoH8W9PHhfEXlWAEl
         H08zwSBmowgZg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9FKEV1738053;
        Sat, 18 May 2019 02:15:20 -0700
Date:   Sat, 18 May 2019 02:15:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-854d73c6665984765f8d93dea3d6c1dcafa17154@git.kernel.org>
Cc:     jolsa@redhat.com, akpm@linux-foundation.org, tglx@linutronix.de,
        namhyung@kernel.org, tstoyanov@vmware.com, mingo@kernel.org,
        rostedt@goodmis.org, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: akpm@linux-foundation.org, tglx@linutronix.de,
          tstoyanov@vmware.com, namhyung@kernel.org, jolsa@redhat.com,
          acme@redhat.com, rostedt@goodmis.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190510200109.638838141@goodmis.org>
References: <20190510200109.638838141@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for event filter
 APIs
Git-Commit-ID: 854d73c6665984765f8d93dea3d6c1dcafa17154
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

Commit-ID:  854d73c6665984765f8d93dea3d6c1dcafa17154
Gitweb:     https://git.kernel.org/tip/854d73c6665984765f8d93dea3d6c1dcafa17154
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:29 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for event filter APIs

Added new man pages, describing libtraceevent event filter APIs:

  tep_filter_alloc()
  tep_filter_free()
  tep_filter_reset()
  tep_filter_add_filter_str()
  tep_filter_strerror()
  tep_event_filtered()
  tep_filter_remove_event()
  tep_filter_match()
  tep_filter_copy()
  tep_filter_compare()
  tep_filter_make_string()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-23-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200109.638838141@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-filter.txt         | 209 +++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-filter.txt b/tools/lib/traceevent/Documentation/libtraceevent-filter.txt
new file mode 100644
index 000000000000..4a9962d8cb59
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-filter.txt
@@ -0,0 +1,209 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_filter_alloc, tep_filter_free, tep_filter_reset, tep_filter_make_string,
+tep_filter_copy, tep_filter_compare, tep_filter_match, tep_event_filtered,
+tep_filter_remove_event, tep_filter_strerror, tep_filter_add_filter_str -
+Event filter related APIs.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_event_filter pass:[*]*tep_filter_alloc*(struct tep_handle pass:[*]_tep_);
+void *tep_filter_free*(struct tep_event_filter pass:[*]_filter_);
+void *tep_filter_reset*(struct tep_event_filter pass:[*]_filter_);
+enum tep_errno *tep_filter_add_filter_str*(struct tep_event_filter pass:[*]_filter_, const char pass:[*]_filter_str_);
+int *tep_event_filtered*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
+int *tep_filter_remove_event*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
+enum tep_errno *tep_filter_match*(struct tep_event_filter pass:[*]_filter_, struct tep_record pass:[*]_record_);
+int *tep_filter_copy*(struct tep_event_filter pass:[*]_dest_, struct tep_event_filter pass:[*]_source_);
+int *tep_filter_compare*(struct tep_event_filter pass:[*]_filter1_, struct tep_event_filter pass:[*]_filter2_);
+char pass:[*]*tep_filter_make_string*(struct tep_event_filter pass:[*]_filter_, int _event_id_);
+int *tep_filter_strerror*(struct tep_event_filter pass:[*]_filter_, enum tep_errno _err_, char pass:[*]buf, size_t _buflen_);
+--
+
+DESCRIPTION
+-----------
+Filters can be attached to traced events. They can be used to filter out various
+events when outputting them. Each event can be filtered based on its parameters,
+described in the event's format file. This set of functions can be used to
+create, delete, modify and attach event filters.
+
+The _tep_filter_alloc()_ function creates a new event filter. The _tep_ argument
+is the trace event parser context.
+
+The _tep_filter_free()_ function frees an event filter and all resources that it
+had used.
+
+The _tep_filter_reset()_ function removes all rules from an event filter and
+resets it.
+
+The _tep_filter_add_filter_str()_ function adds a new rule to the _filter_. The
+_filter_str_ argument is the filter string, that contains the rule.
+
+The _tep_event_filtered()_ function checks if the event with _event_id_ has
+_filter_.
+
+The _tep_filter_remove_event()_ function removes a _filter_ for an event with
+_event_id_.
+
+The _tep_filter_match()_ function tests if a _record_ matches given _filter_.
+
+The _tep_filter_copy()_ function copies a _source_ filter into a _dest_ filter.
+
+The _tep_filter_compare()_ function compares two filers - _filter1_ and _filter2_.
+
+The _tep_filter_make_string()_ function constructs a string, displaying
+the _filter_ contents for given _event_id_.
+
+The _tep_filter_strerror()_ function copies the _filter_ error buffer into the
+given _buf_ with the size _buflen_. If the error buffer is empty, in the _buf_
+is copied a string, describing the error _err_.
+
+RETURN VALUE
+------------
+The _tep_filter_alloc()_ function returns a pointer to the newly created event
+filter, or NULL in case of an error.
+
+The _tep_filter_add_filter_str()_ function returns 0 if the rule was
+successfully added or a negative error code.  Use _tep_filter_strerror()_ to see
+actual error message in case of an error.
+
+The _tep_event_filtered()_ function returns 1 if the filter is found for given
+event, or 0 otherwise.
+
+The _tep_filter_remove_event()_ function returns 1 if the vent was removed, or
+0 if the event was not found.
+
+The _tep_filter_match()_ function returns _tep_errno_, according to the result:
+[verse]
+--
+_pass:[TEP_ERRNO__FILTER_MATCH]_	- filter found for event, the record matches.
+_pass:[TEP_ERRNO__FILTER_MISS]_		- filter found for event, the record does not match.
+_pass:[TEP_ERRNO__FILTER_NOT_FOUND]_	- no filter found for record's event.
+_pass:[TEP_ERRNO__NO_FILTER]_		- no rules in the filter.
+--
+or any other _tep_errno_, if an error occurred during the test.
+
+The _tep_filter_copy()_ function returns 0 on success or -1 if not all rules
+ were copied.
+
+The _tep_filter_compare()_ function returns 1 if the two filters hold the same
+content, or 0 if they do not.
+
+The _tep_filter_make_string()_ function returns a string, which must be freed
+with free(), or NULL in case of an error.
+
+The _tep_filter_strerror()_ function returns 0 if message was filled
+successfully, or -1 in case of an error.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+char errstr[200];
+int ret;
+
+struct tep_event_filter *filter = tep_filter_alloc(tep);
+struct tep_event_filter *filter1 = tep_filter_alloc(tep);
+ret = tep_filter_add_filter_str(filter, "sched/sched_wakeup:target_cpu==1");
+if(ret < 0) {
+	tep_filter_strerror(filter, ret, errstr, sizeof(errstr));
+	/* Failed to add a new rule to the filter, the error string is in errstr */
+}
+if (tep_filter_copy(filter1, filter) != 0) {
+	/* Failed to copy filter in filter1 */
+}
+...
+if (tep_filter_compare(filter, filter1) != 1) {
+	/* Both filters are different */
+}
+...
+void process_record(struct tep_handle *tep, struct tep_record *record)
+{
+	struct tep_event *event;
+	char *fstring;
+
+	event = tep_find_event_by_record(tep, record);
+
+	if (tep_event_filtered(filter, event->id) == 1) {
+		/* The event has filter */
+		fstring = tep_filter_make_string(filter, event->id);
+		if (fstring != NULL) {
+			/* The filter for the event is in fstring */
+			free(fstring);
+		}
+	}
+
+	switch (tep_filter_match(filter, record)) {
+	case TEP_ERRNO__FILTER_MATCH:
+		/* The filter matches the record */
+		break;
+	case TEP_ERRNO__FILTER_MISS:
+		/* The filter does not match the record */
+		break;
+	case TEP_ERRNO__FILTER_NOT_FOUND:
+		/* No filter found for record's event */
+		break;
+	case TEP_ERRNO__NO_FILTER:
+		/* There are no rules in the filter */
+		break
+	default:
+		/* An error occurred during the test */
+		break;
+	}
+
+	if (tep_filter_remove_event(filter, event->id) == 1) {
+		/* The event was removed from the filter */
+	}
+}
+
+...
+tep_filter_reset(filter);
+...
+tep_filter_free(filter);
+tep_filter_free(filter1);
+...
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
