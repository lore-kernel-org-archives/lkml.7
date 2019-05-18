Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55115C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208B420657
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ngcLJ6Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfERJCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:02:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:02:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I92Eh91734093
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:02:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I92Eh91734093
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170135;
        bh=K5naHoKzJH4DWvYM+s8pWbfZwvCJr9zMaT9JvQqfSBY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ngcLJ6Xub90vlK+SWLKDXXrXRTb96Trng86xpCQtwQkezRusZGL3eCAQdB0ULULm+
         tFjecgwRq/2wAT/h+mkWRPv8hxXGhkeecg2DXsv1ouCj4R72v0b/yPtH6M+AWSXAKU
         qhGsWvjgrwV3L8+HVH4S9BEQ+7KwAmvovIVSTRz/r2r1fjG1bf23QLq7KYtgPlDXx5
         oUR9XCpBxwNKFvdHSaf6PXVBW5snV12mZSbNsDAzHLkFoK81CuPZCuqiJCHcipWpUI
         QWUFfdpn9meIojbH9/qNZjdamDIJLRl0Wq8/NkjDdr8Guvm8sqA1YRql6FBTgMkTMi
         U2+uKoasJUJsw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I92DJp1734090;
        Sat, 18 May 2019 02:02:13 -0700
Date:   Sat, 18 May 2019 02:02:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-3d2626bd1f15711711b575463befbe137ac1adc6@git.kernel.org>
Cc:     acme@redhat.com, rostedt@goodmis.org, tstoyanov@vmware.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, akpm@linux-foundation.org
Reply-To: acme@redhat.com, tstoyanov@vmware.com, tglx@linutronix.de,
          rostedt@goodmis.org, hpa@zytor.com, jolsa@redhat.com,
          namhyung@kernel.org, akpm@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190510200106.583928896@goodmis.org>
References: <20190510200106.583928896@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for header_page APIs
Git-Commit-ID: 3d2626bd1f15711711b575463befbe137ac1adc6
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

Commit-ID:  3d2626bd1f15711711b575463befbe137ac1adc6
Gitweb:     https://git.kernel.org/tip/3d2626bd1f15711711b575463befbe137ac1adc6
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:11 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

tools lib traceevent: Man page for header_page APIs

Create a man page for libtraceevent APIs:

  tep_get_header_page_size(),
  tep_get_header_timestamp_size(),
  tep_is_old_format()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-5-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200106.583928896@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-header_page.txt    | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt b/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
new file mode 100644
index 000000000000..615d117dc39f
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
@@ -0,0 +1,102 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_get_header_page_size, tep_get_header_timestamp_size, tep_is_old_format -
+Get the data stored in the header page, in kernel context.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+int *tep_get_header_page_size*(struct tep_handle pass:[*]_tep_);
+int *tep_get_header_timestamp_size*(struct tep_handle pass:[*]_tep_);
+bool *tep_is_old_format*(struct tep_handle pass:[*]_tep_);
+--
+DESCRIPTION
+-----------
+These functions retrieve information from kernel context, stored in tracefs
+events/header_page. Old kernels do not have header page info, so default values
+from user space context are used.
+
+The _tep_get_header_page_size()_ function returns the size of a long integer,
+in kernel context. The _tep_ argument is trace event parser context.
+This information is retrieved from tracefs events/header_page, "commit" field.
+
+The _tep_get_header_timestamp_size()_ function returns the size of timestamps,
+in kernel context. The _tep_ argument is trace event parser context. This
+information is retrieved from tracefs events/header_page, "timestamp" field.
+
+The _tep_is_old_format()_ function returns true if the kernel predates
+the addition of events/header_page, otherwise it returns false.
+
+RETURN VALUE
+------------
+The _tep_get_header_page_size()_ function returns the size of a long integer,
+in bytes.
+
+The _tep_get_header_timestamp_size()_ function returns the size of timestamps,
+in bytes.
+
+The _tep_is_old_format()_ function returns true, if an old kernel is used to
+generate the tracing data, which has no event/header_page. If the kernel is new,
+or _tep_ is NULL, false is returned.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+	int longsize;
+	int timesize;
+	bool old;
+
+	longsize = tep_get_header_page_size(tep);
+	timesize = tep_get_header_timestamp_size(tep);
+	old = tep_is_old_format(tep);
+
+	printf ("%s kernel is used to generate the tracing data.\n",
+		old?"Old":"New");
+	printf("The size of a long integer is %d bytes.\n", longsize);
+	printf("The timestamps size is %d bytes.\n", timesize);
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
