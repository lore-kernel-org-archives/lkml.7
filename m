Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995F5C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D812087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="H5lNbuof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfERJSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:18:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:18:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9IJxV1738503
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:18:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9IJxV1738503
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171100;
        bh=2biDovyWH50d4UWioit6u2e4pkiODF1QSc5xEz1t6GE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=H5lNbuofTADGGVrRwtMwqB8myrH/3/6QG8CzpviLQ14IX5XAJbGWR7IqxCigTBq4Q
         b9wkFoBtu44fN1zm8HedvOeOntY6pa2/NEXlAo4jkv6/MlG4pwvqmqkprlMJFcIwnT
         0crmrvxJYf5jzrnSQfD+LZgSvCqNvzYTZBUV40spskfQKKKaliJD92dLd1RmDU0CS+
         21YTsRixpjtwUVXs0YsiDp5Fh9sjmIZ4x5O0dfWGLBHgD1lslcfoJPo3zLiE5YQZz6
         i4nJo293isscUv+NCj7047vgEFiwFvWPiL+MmeY3uA8Z3mErrZjeiSMAD0yXp3rh65
         vBSBe4L7IFRbA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9IJNR1738500;
        Sat, 18 May 2019 02:18:19 -0700
Date:   Sat, 18 May 2019 02:18:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-1df9d75776c9813abc7f6abff3a32ee782a86c8a@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        tstoyanov@vmware.com, jolsa@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          akpm@linux-foundation.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, tstoyanov@vmware.com,
          acme@redhat.com, namhyung@kernel.org, rostedt@goodmis.org
In-Reply-To: <20190510200110.462646052@goodmis.org>
References: <20190510200110.462646052@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for trace sequences
 APIs
Git-Commit-ID: 1df9d75776c9813abc7f6abff3a32ee782a86c8a
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

Commit-ID:  1df9d75776c9813abc7f6abff3a32ee782a86c8a
Gitweb:     https://git.kernel.org/tip/1df9d75776c9813abc7f6abff3a32ee782a86c8a
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:33 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for trace sequences APIs

Create man pages for trace sequences libtraceevent APIs:

  trace_seq_init(),
  trace_seq_destroy(),
  trace_seq_reset(),
  trace_seq_terminate(),
  trace_seq_putc(),
  trace_seq_puts(),
  trace_seq_printf(),
  trace_seq_vprintf(),
  trace_seq_do_fprintf(),
  trace_seq_do_printf()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-27-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200110.462646052@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-tseq.txt           | 158 +++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-tseq.txt b/tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
new file mode 100644
index 000000000000..8ac6aa174e12
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
@@ -0,0 +1,158 @@
+libtraceevent(3)
+================
+
+NAME
+----
+trace_seq_init, trace_seq_destroy, trace_seq_reset, trace_seq_terminate,
+trace_seq_putc, trace_seq_puts, trace_seq_printf, trace_seq_vprintf,
+trace_seq_do_fprintf, trace_seq_do_printf -
+Initialize / destroy a trace sequence.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+*#include <trace-seq.h>*
+
+void *trace_seq_init*(struct trace_seq pass:[*]_s_);
+void *trace_seq_destroy*(struct trace_seq pass:[*]_s_);
+void *trace_seq_reset*(struct trace_seq pass:[*]_s_);
+void *trace_seq_terminate*(struct trace_seq pass:[*]_s_);
+int *trace_seq_putc*(struct trace_seq pass:[*]_s_, unsigned char _c_);
+int *trace_seq_puts*(struct trace_seq pass:[*]_s_, const char pass:[*]_str_);
+int *trace_seq_printf*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, _..._);
+int *trace_seq_vprintf*(struct trace_seq pass:[*]_s_, const char pass:[*]_fmt_, va_list _args_);
+int *trace_seq_do_printf*(struct trace_seq pass:[*]_s_);
+int *trace_seq_do_fprintf*(struct trace_seq pass:[*]_s_, FILE pass:[*]_fp_);
+--
+
+DESCRIPTION
+-----------
+Trace sequences are used to allow a function to call several other functions
+to create a string of data to use.
+
+The _trace_seq_init()_ function initializes the trace sequence _s_.
+
+The _trace_seq_destroy()_ function destroys the trace sequence _s_ and frees
+all its resources that it had used.
+
+The _trace_seq_reset()_ function re-initializes the trace sequence _s_. All
+characters already written in _s_ will be deleted.
+
+The _trace_seq_terminate()_ function terminates the trace sequence _s_. It puts
+the null character pass:['\0'] at the end of the buffer.
+
+The _trace_seq_putc()_ function puts a single character _c_ in the trace
+sequence _s_.
+
+The _trace_seq_puts()_ function puts a NULL terminated string _str_ in the
+trace sequence _s_.
+
+The _trace_seq_printf()_ function puts a formated string _fmt _with
+variable arguments _..._ in the trace sequence _s_.
+
+The _trace_seq_vprintf()_ function puts a formated string _fmt _with
+list of arguments _args_ in the trace sequence _s_.
+
+The _trace_seq_do_printf()_ function prints the buffer of trace sequence _s_ to
+the standard output stdout.
+
+The _trace_seq_do_fprintf()_ function prints the buffer of trace sequence _s_
+to the given file _fp_.
+
+RETURN VALUE
+------------
+Both _trace_seq_putc()_ and _trace_seq_puts()_ functions return the number of
+characters put in the trace sequence, or 0 in case of an error
+
+Both _trace_seq_printf()_ and _trace_seq_vprintf()_ functions return 0 if the
+trace oversizes the buffer's free space, the number of characters printed, or
+a negative value in case of an error.
+
+Both _trace_seq_do_printf()_ and _trace_seq_do_fprintf()_ functions return the
+number of printed characters, or -1 in case of an error.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+#include <trace-seq.h>
+...
+struct trace_seq seq;
+trace_seq_init(&seq);
+...
+void foo_seq_print(struct trace_seq *tseq, char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	if (trace_seq_vprintf(tseq, format, ap) <= 0) {
+		/* Failed to print in the trace sequence */
+	}
+	va_end(ap);
+}
+
+trace_seq_reset(&seq);
+
+char *str = " MAN page example";
+if (trace_seq_puts(&seq, str) != strlen(str)) {
+	/* Failed to put str in the trace sequence */
+}
+if (trace_seq_putc(&seq, ':') != 1) {
+	/* Failed to put ':' in the trace sequence */
+}
+if (trace_seq_printf(&seq, " trace sequence: %d", 1) <= 0) {
+	/* Failed to print in the trace sequence */
+}
+foo_seq_print( &seq, "  %d\n", 2);
+
+trace_seq_terminate(&seq);
+...
+
+if (trace_seq_do_printf(&seq) < 0 ) {
+	/* Failed to print the sequence buffer to the standard output */
+}
+FILE *fp = fopen("trace.txt", "w");
+if (trace_seq_do_fprintf(&seq, fp) < 0 ) [
+	/* Failed to print the sequence buffer to the trace.txt file */
+}
+
+trace_seq_destroy(&seq);
+...
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*trace-seq.h*
+	Header file to include in order to have access to trace sequences related APIs.
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
