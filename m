Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A325BC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4082082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c2GcINUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfERJI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:08:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfERJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:08:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9835a1736603
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:08:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9835a1736603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170484;
        bh=V45XewDJEkc0XBLLTmjs2OWxahT8+t1u6OTKJ4qqnF8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=c2GcINUt3glcI25MWHR/y4OR+4Rz26maL2ZpY0iukSxui6pLPm0H8OsFGyAdvvPLn
         nEMO29bqKxUtuFZVDRwHiHU8aA+Vb7vBuTFg/vRckZht81d2SGiAeJ5DnjnGBTo5Pz
         g76sO9270a5hXqOKkFYt92bp8j3KK4Gmq0ZGIHQDJrZvJAbtmWbBVMulr9g8quVG+J
         MStkN9E/0cwsZDBfGKgA7tecBhZuRqnD2eN4Ey7sMtrBR0WDq4fE6CbWkMpXhPX4Ak
         PSlEn6/whiCB+DrEyM40MCCd6hFYLm2OOKCPGRrpQtOioxwyM89o/JsoFgk1oyHcOi
         piG8Ijmuxi22w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9836v1736600;
        Sat, 18 May 2019 02:08:03 -0700
Date:   Sat, 18 May 2019 02:08:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-10e679751cde169434dffb6c87f9b93c02050bef@git.kernel.org>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
        acme@redhat.com, tglx@linutronix.de, tstoyanov@vmware.com,
        namhyung@kernel.org
Reply-To: jolsa@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
          namhyung@kernel.org, tstoyanov@vmware.com, tglx@linutronix.de,
          acme@redhat.com
In-Reply-To: <20190510200107.857252818@goodmis.org>
References: <20190510200107.857252818@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for registering
 print function
Git-Commit-ID: 10e679751cde169434dffb6c87f9b93c02050bef
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

Commit-ID:  10e679751cde169434dffb6c87f9b93c02050bef
Gitweb:     https://git.kernel.org/tip/10e679751cde169434dffb6c87f9b93c02050bef
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:19 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for registering print function

Create man pages for libtraceevent APIs:

  tep_register_print_function()
  tep_unregister_print_function()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20190510200107.857252818@goodmis.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-13-tstoyanov@vmware.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-reg_print_func.txt | 155 +++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt b/tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
new file mode 100644
index 000000000000..708dce91ebd8
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
@@ -0,0 +1,155 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_register_print_function,tep_unregister_print_function -
+Registers / Unregisters a helper function.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+enum *tep_func_arg_type* {
+	TEP_FUNC_ARG_VOID,
+	TEP_FUNC_ARG_INT,
+	TEP_FUNC_ARG_LONG,
+	TEP_FUNC_ARG_STRING,
+	TEP_FUNC_ARG_PTR,
+	TEP_FUNC_ARG_MAX_TYPES
+};
+
+typedef unsigned long long (*pass:[*]tep_func_handler*)(struct trace_seq pass:[*]s, unsigned long long pass:[*]args);
+
+int *tep_register_print_function*(struct tep_handle pass:[*]_tep_, tep_func_handler _func_, enum tep_func_arg_type _ret_type_, char pass:[*]_name_, _..._);
+int *tep_unregister_print_function*(struct tep_handle pass:[*]_tep_, tep_func_handler _func_, char pass:[*]_name_);
+--
+
+DESCRIPTION
+-----------
+Some events may have helper functions in the print format arguments.
+This allows a plugin to dynamically create a way to process one of
+these functions.
+
+The _tep_register_print_function()_ registers such helper function. The _tep_
+argument is the trace event parser context. The _func_ argument  is a pointer
+to the helper function. The _ret_type_ argument is  the return type of the
+helper function, value from the _tep_func_arg_type_ enum. The _name_ is the name
+of the helper function, as seen in the print format arguments. The _..._ is a
+variable list of _tep_func_arg_type_ enums, the _func_ function arguments.
+This list must end with _TEP_FUNC_ARG_VOID_. See 'EXAMPLE' section.
+
+The _tep_unregister_print_function()_ unregisters a helper function, previously
+registered with _tep_register_print_function()_. The _tep_ argument is the
+trace event parser context. The _func_ and _name_ arguments are the same, used
+when the helper function was registered.
+
+The _tep_func_handler_ is the type of the helper function. The _s_ argument is
+the trace sequence, it can be used to create a custom string.
+The _args_  is a list of arguments, defined when the helper function was
+registered.
+
+RETURN VALUE
+------------
+The _tep_register_print_function()_ function returns 0 in case of success.
+In case of an error, TEP_ERRNO_... code is returned.
+
+The _tep_unregister_print_function()_ returns 0 in case of success, or -1 in
+case of an error.
+
+EXAMPLE
+-------
+Some events have internal functions calls, that appear in the print format
+output. For example "tracefs/events/i915/g4x_wm/format" has:
+[source,c]
+--
+print fmt: "pipe %c, frame=%u, scanline=%u, wm %d/%d/%d, sr %s/%d/%d/%d, hpll %s/%d/%d/%d, fbc %s",
+	    ((REC->pipe) + 'A'), REC->frame, REC->scanline, REC->primary,
+	    REC->sprite, REC->cursor, yesno(REC->cxsr), REC->sr_plane,
+	    REC->sr_cursor, REC->sr_fbc, yesno(REC->hpll), REC->hpll_plane,
+	    REC->hpll_cursor, REC->hpll_fbc, yesno(REC->fbc)
+--
+Notice the call to function _yesno()_ in the print arguments. In the kernel
+context, this function has the following implementation:
+[source,c]
+--
+static const char *yesno(int x)
+{
+	static const char *yes = "yes";
+	static const char *no = "no";
+
+	return x ? yes : no;
+}
+--
+The user space event parser has no idea how to handle this _yesno()_ function.
+The _tep_register_print_function()_ API can be used to register a user space
+helper function, mapped to the kernel's _yesno()_:
+[source,c]
+--
+#include <event-parse.h>
+#include <trace-seq.h>
+...
+struct tep_handle *tep = tep_alloc();
+...
+static const char *yes_no_helper(int x)
+{
+	return x ? "yes" : "no";
+}
+...
+	if ( tep_register_print_function(tep,
+				    yes_no_helper,
+				    TEP_FUNC_ARG_STRING,
+				    "yesno",
+				    TEP_FUNC_ARG_INT,
+				    TEP_FUNC_ARG_VOID) != 0) {
+		/* Failed to register yes_no_helper function */
+	}
+
+/*
+   Now, when the event parser encounters this yesno() function, it will know
+   how to handle it.
+*/
+...
+	if (tep_unregister_print_function(tep, yes_no_helper, "yesno") != 0) {
+		/* Failed to unregister yes_no_helper function */
+	}
+--
+
+FILES
+-----
+[verse]
+--
+*event-parse.h*
+	Header file to include in order to have access to the library APIs.
+*trace-seq.h*
+	Header file to include in order to have access to trace sequences
+	related APIs. Trace sequences are used to allow a function to call
+	several other functions to create a string of data to use.
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
