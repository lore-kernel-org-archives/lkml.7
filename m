Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD50C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79FF2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FR8OwxRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfERJGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:06:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:06:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I95mVd1736205
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:05:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I95mVd1736205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170349;
        bh=3u3tiTqGO2mv2r9IqVrFsldWVx5qboKs1+/5zKZKU2k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FR8OwxRXa4oTuK8i5vf5EUxiqK9v1hmpqaVxC6L83gENMhE43VlwAemHZUWAmn/eh
         V1GV3DUVZX8uOkqfX8JOHVDShE0BuI6CTLdI5pa4kL+lrb17/ReWn6gM8JWUvJaBp9
         BftiewdKPr1tTWum37AhpwJvDAGJHDsg9T1P2vSAbFuI3mtkAFIyjySrK8QX/kmH1O
         DT73OES/w5p9dj+1tJmkKGUUpVDizneLf+dQN8tUsvMeiod5/XjA2hIF/e0TSndtKJ
         YlPOFBwJfDTCbYciQpNzAnVHqelQgWSTgIxSo1VSeIpJNhdU9GnMdLhWBmW9c7xYZA
         mQouTcHrTTR7A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I95mSL1736202;
        Sat, 18 May 2019 02:05:48 -0700
Date:   Sat, 18 May 2019 02:05:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-c127ef56761e41ad3eb4cb6eaaf1805e04c9a46e@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@redhat.com, acme@redhat.com,
        akpm@linux-foundation.org, tstoyanov@vmware.com,
        tglx@linutronix.de, hpa@zytor.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: rostedt@goodmis.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org,
          tstoyanov@vmware.com, acme@redhat.com
In-Reply-To: <20190510200107.371692630@goodmis.org>
References: <20190510200107.371692630@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for tep_strerror()
Git-Commit-ID: c127ef56761e41ad3eb4cb6eaaf1805e04c9a46e
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

Commit-ID:  c127ef56761e41ad3eb4cb6eaaf1805e04c9a46e
Gitweb:     https://git.kernel.org/tip/c127ef56761e41ad3eb4cb6eaaf1805e04c9a46e
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:16 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man page for tep_strerror()

Create man page for tep_strerror() libtraceevent API.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-10-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200107.371692630@goodmis.org
[ Added "always" to state it doesn't matter if it is POSIX or GNU ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-strerror.txt       | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt b/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
new file mode 100644
index 000000000000..ee4062a00c9f
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
@@ -0,0 +1,85 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_strerror - Returns a string describing regular errno and tep error number.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+int *tep_strerror*(struct tep_handle pass:[*]_tep_, enum tep_errno _errnum_, char pass:[*]_buf_, size_t _buflen_);
+
+--
+DESCRIPTION
+-----------
+The _tep_strerror()_ function converts tep error number into a human
+readable string.
+The _tep_ argument is trace event parser context. The _errnum_ is a regular
+errno, defined in errno.h, or a tep error number. The string, describing this
+error number is copied in the _buf_ argument. The _buflen_ argument is
+the size of the _buf_.
+
+It as a thread safe wrapper around strerror_r(). The library function has two
+different behaviors - POSIX and GNU specific. The _tep_strerror()_ API always
+behaves as the POSIX version - the error string is copied in the user supplied
+buffer.
+
+RETURN VALUE
+------------
+The _tep_strerror()_ function returns 0, if a valid _errnum_ is passed and the
+string is copied into _buf_. If _errnum_ is not a valid error number,
+-1 is returned and _buf_ is not modified.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+char buf[32];
+char *pool = calloc(1, 128);
+if (tep == NULL) {
+	tep_strerror(tep, TEP_ERRNO__MEM_ALLOC_FAILED, buf, 32);
+	printf ("The pool is not initialized, %s", buf);
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
