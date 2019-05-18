Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B84C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3629120882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Zt04CyEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfERJED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:04:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:04:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I93cAO1734419
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:03:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I93cAO1734419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170219;
        bh=MR3ArlAWHYmPlNV2ZhToMD8oV8Ug6PEMrGdBpZUR6RI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Zt04CyEvWS6T1Fgg7qdDg/+GQXT5prbRRg6IAeJs56FYoW2zQMoH24YkCn3qzUIEv
         C8HTeqODz2s7nxM/xxVV7KMfY5Y2py1Jlm8jF3qbnmIwgDoSXyXifA5NpPNjIuNrky
         juT7OUGFnH3NicLLIs9AJ8GGcF/SYVw2DvwB8M77bqCAOgRiQjvzMbnWmYlGYcqgYP
         tS+u8GdMv1mKY+OVPKQ1iXdZWMDv9pTJAEw5yCmh86FBlVqIF/UHSEbh/ip6mXNVGy
         tduzMA8gWLNdQ1nqDDlnq5vUY0wik9232qMnYbQUAba2LAuwb+ENfE3qyohfz+X1jL
         hw6XP8/HHwNWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I93b261734416;
        Sat, 18 May 2019 02:03:37 -0700
Date:   Sat, 18 May 2019 02:03:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-9571f7371f143cfb7a324b531aac2814cb9044c7@git.kernel.org>
Cc:     jolsa@redhat.com, akpm@linux-foundation.org, tstoyanov@vmware.com,
        hpa@zytor.com, rostedt@goodmis.org, mingo@kernel.org,
        acme@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        namhyung@kernel.org
Reply-To: hpa@zytor.com, tstoyanov@vmware.com, jolsa@redhat.com,
          akpm@linux-foundation.org, mingo@kernel.org, rostedt@goodmis.org,
          acme@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190510200106.895177252@goodmis.org>
References: <20190510200106.895177252@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man page for file endian APIs
Git-Commit-ID: 9571f7371f143cfb7a324b531aac2814cb9044c7
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

Commit-ID:  9571f7371f143cfb7a324b531aac2814cb9044c7
Gitweb:     https://git.kernel.org/tip/9571f7371f143cfb7a324b531aac2814cb9044c7
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:13 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

tools lib traceevent: Man page for file endian APIs

Create man pages for libtraceevent APIs:

  tep_is_file_bigendian(),
  tep_set_file_bigendian()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-7-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200106.895177252@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-file_endian.txt    | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt b/tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
new file mode 100644
index 000000000000..f401ad311047
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
@@ -0,0 +1,91 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_is_file_bigendian, tep_set_file_bigendian - Get / set the endianness of the
+raw data being accessed by the tep handler.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *tep_endian* {
+	TEP_LITTLE_ENDIAN = 0,
+	TEP_BIG_ENDIAN
+};
+
+bool *tep_is_file_bigendian*(struct tep_handle pass:[*]_tep_);
+void *tep_set_file_bigendian*(struct tep_handle pass:[*]_tep_, enum tep_endian _endian_);
+
+--
+DESCRIPTION
+-----------
+The _tep_is_file_bigendian()_ function gets the endianness of the raw data,
+being accessed by the tep handler. The _tep_ argument is trace event parser
+context.
+
+The _tep_set_file_bigendian()_ function sets the endianness of raw data being
+accessed by the tep handler. The _tep_ argument is trace event parser context.
+[verse]
+--
+The _endian_ argument is the endianness:
+	_TEP_LITTLE_ENDIAN_ - the raw data is in little endian format,
+	_TEP_BIG_ENDIAN_ - the raw data is in big endian format.
+--
+RETURN VALUE
+------------
+The _tep_is_file_bigendian()_ function returns true if the data is in bigendian
+format, false otherwise.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+	tep_set_file_bigendian(tep, TEP_LITTLE_ENDIAN);
+...
+	if (tep_is_file_bigendian(tep)) {
+		/* The raw data is in big endian */
+	} else {
+		/* The raw data is in little endian */
+	}
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
