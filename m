Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3327C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65DE2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tOOkrZ28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfERJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:15:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfERJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:15:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9EcT91737753
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:14:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9EcT91737753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170879;
        bh=7lvYqWPi4kigoxBzYA8V+z7ghwkIeFHBd+d6ZmzjyMM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tOOkrZ28RIgNq/hB7jEx/iDbBqqClx/JyvcMqu7hXPgqMz+EiB8i488CAsFTL7+U5
         FLJU7g3lDiuvGA4hhdWUlulN7u+BSTj4eYr60rvNFc0UmBpanD7WQzqZRR1rWMR1Kl
         6mMrQFSIlL38eei4opSyKj8w3djCN1CyVd7AdUGwE2NbUnIK8tDXsK/rCrChaEK8RO
         h3qkHFlHrHcM+YYNgFgxB+cpo8KgdeZYaaD82B8HYB1uSQOqJlHLLIDFpyFd2Hr0Rw
         WBkwGI6os8C3qei/5c3u9Gjbg7R9BsRIZSyShb/XTYlPiC+82s5OF6m2KCxZ6zSB/O
         NgXqu1gNZMtIg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9EbOr1737750;
        Sat, 18 May 2019 02:14:37 -0700
Date:   Sat, 18 May 2019 02:14:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-e64392019c0537829ef1d555451c513f1046ae2a@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, akpm@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, acme@redhat.com, namhyung@kernel.org,
        tstoyanov@vmware.com, jolsa@redhat.com
Reply-To: jolsa@redhat.com, tstoyanov@vmware.com, namhyung@kernel.org,
          acme@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190510200109.421670142@goodmis.org>
References: <20190510200109.421670142@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for event fields
 APIs
Git-Commit-ID: e64392019c0537829ef1d555451c513f1046ae2a
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

Commit-ID:  e64392019c0537829ef1d555451c513f1046ae2a
Gitweb:     https://git.kernel.org/tip/e64392019c0537829ef1d555451c513f1046ae2a
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:28 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for event fields APIs

Create man pages for libtraceevent APIs:

  tep_event_common_fields(),
  tep_event_fields()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-22-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200109.421670142@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-fields.txt         | 105 +++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-fields.txt b/tools/lib/traceevent/Documentation/libtraceevent-fields.txt
new file mode 100644
index 000000000000..1ccb531d5114
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-fields.txt
@@ -0,0 +1,105 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_event_common_fields, tep_event_fields - Get a list of fields for an event.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_format_field pass:[*]pass:[*]*tep_event_common_fields*(struct tep_event pass:[*]_event_);
+struct tep_format_field pass:[*]pass:[*]*tep_event_fields*(struct tep_event pass:[*]_event_);
+--
+
+DESCRIPTION
+-----------
+The _tep_event_common_fields()_ function returns an array of pointers to common
+fields for the _event_. The array is allocated in the function and must be freed
+by free(). The last element of the array is NULL.
+
+The _tep_event_fields()_ function returns an array of pointers to event specific
+fields for the _event_. The array is allocated in the function and must be freed
+by free(). The last element of the array is NULL.
+
+RETURN VALUE
+------------
+Both _tep_event_common_fields()_ and _tep_event_fields()_ functions return
+an array of pointers to tep_format_field structures in case of success, or
+NULL in case of an error.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+int i;
+struct tep_format_field **fields;
+struct tep_event *event = tep_find_event_by_name(tep, "kvm", "kvm_exit");
+if (event != NULL) {
+	fields = tep_event_common_fields(event);
+	if (fields != NULL) {
+		i = 0;
+		while (fields[i]) {
+			/*
+			  walk through the list of the common fields
+			  of the kvm_exit event
+			*/
+			i++;
+		}
+		free(fields);
+	}
+	fields = tep_event_fields(event);
+	if (fields != NULL) {
+		i = 0;
+		while (fields[i]) {
+			/*
+			  walk through the list of the event specific
+			  fields of the kvm_exit event
+			*/
+			i++;
+		}
+		free(fields);
+	}
+}
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
