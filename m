Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ED7C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6BF2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Jt9aEX/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfERJMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:12:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39749 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:12:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9Bgjx1737192
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:11:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9Bgjx1737192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170703;
        bh=X1hzjFXAQM+lwwyhqR/HZTwxT3CkS1LXT7LCaTbRqrs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Jt9aEX/Y4sJFFRI8NgIaFo9x3tm8G1emey43Fgfpx6MXElXBwMnoDe25J1VreELPr
         ykgia25MXdezFQOsAhdGWPrGLDUKgy7p5j6XUQ739s1aS3Fu+mky4vZZZa90/VooGH
         OvTREi0Vebv1YwcylMsry23hE1kmP+cKy5psA/NayBkMYX3AQJFBFMm6Qt+3hiuXQ3
         qpVWbV+tiqr6aBvUpcJPb10Tm+4UE7sKsO8HZAENZnS3ZGnis7LJi/NC71cIbY7JuC
         f/nXGf5fn5jreaNvzX1CUMF5yQOycokpAtb1jGCvxceeQrGIG/GE8S1rsNryM7zHLl
         QLce7qWQ4HA+A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9BfFb1737189;
        Sat, 18 May 2019 02:11:41 -0700
Date:   Sat, 18 May 2019 02:11:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-0b51220ee0c3f6634b9fcf9208cc0764d5861163@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, tstoyanov@vmware.com, jolsa@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, namhyung@kernel.org,
        hpa@zytor.com, acme@redhat.com
Reply-To: acme@redhat.com, hpa@zytor.com, namhyung@kernel.org,
          rostedt@goodmis.org, jolsa@redhat.com, tglx@linutronix.de,
          tstoyanov@vmware.com, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190510200108.721589427@goodmis.org>
References: <20190510200108.721589427@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Man pages for find field APIs
Git-Commit-ID: 0b51220ee0c3f6634b9fcf9208cc0764d5861163
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

Commit-ID:  0b51220ee0c3f6634b9fcf9208cc0764d5861163
Gitweb:     https://git.kernel.org/tip/0b51220ee0c3f6634b9fcf9208cc0764d5861163
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:24 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:48 -0300

tools lib traceevent: Man pages for find field APIs

Create man pages for libtraceevent APIs:

  tep_find_common_field(),
  tep_find_field()
  tep_find_any_field()

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-18-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200108.721589427@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/libtraceevent-field_find.txt     | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt b/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
new file mode 100644
index 000000000000..0896af5b9eff
--- /dev/null
+++ b/tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
@@ -0,0 +1,118 @@
+libtraceevent(3)
+================
+
+NAME
+----
+tep_find_common_field, tep_find_field, tep_find_any_field -
+Search for a field in an event.
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <event-parse.h>*
+
+struct tep_format_field pass:[*]*tep_find_common_field*(struct tep_event pass:[*]_event_, const char pass:[*]_name_);
+struct tep_format_field pass:[*]*tep_find_field*(struct tep_event_ormat pass:[*]_event_, const char pass:[*]_name_);
+struct tep_format_field pass:[*]*tep_find_any_field*(struct tep_event pass:[*]_event_, const char pass:[*]_name_);
+--
+
+DESCRIPTION
+-----------
+These functions search for a field with given name in an event. The field
+returned can be used to find the field content from within a data record.
+
+The _tep_find_common_field()_ function searches for a common field with _name_
+in the _event_.
+
+The _tep_find_field()_ function searches for an event specific field with
+_name_ in the _event_.
+
+The _tep_find_any_field()_ function searches for any field with _name_ in the
+_event_.
+
+RETURN VALUE
+------------
+The _tep_find_common_field(), _tep_find_field()_ and _tep_find_any_field()_
+functions return a pointer to the found field, or NULL in case there is no field
+with the requested name.
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <event-parse.h>
+...
+void get_htimer_info(struct tep_handle *tep, struct tep_record *record)
+{
+	struct tep_format_field *field;
+	struct tep_event *event;
+	long long softexpires;
+	int mode;
+	int pid;
+
+	event = tep_find_event_by_name(tep, "timer", "hrtimer_start");
+
+	field = tep_find_common_field(event, "common_pid");
+	if (field == NULL) {
+		/* Cannot find "common_pid" field in the event */
+	} else {
+		/* Get pid from the data record */
+		pid = tep_read_number(tep, record->data + field->offset,
+				      field->size);
+	}
+
+	field = tep_find_field(event, "softexpires");
+	if (field == NULL) {
+		/* Cannot find "softexpires" event specific field in the event */
+	} else {
+		/* Get softexpires parameter from the data record */
+		softexpires = tep_read_number(tep, record->data + field->offset,
+					      field->size);
+	}
+
+	field = tep_find_any_field(event, "mode");
+	if (field == NULL) {
+		/* Cannot find "mode" field in the event */
+	} else
+	{
+		/* Get mode parameter from the data record */
+		mode = tep_read_number(tep, record->data + field->offset,
+				       field->size);
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
