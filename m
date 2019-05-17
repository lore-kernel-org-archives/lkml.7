Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C1C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F341E21726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121947;
	bh=d3wvFqIZOIztWUag2jB8xc4NK0ROIuKLnzDGZYCuM9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BYORaUFJj34FcFC1z4eLm4PlpS+FdvJcT3SPyhSY46ZvtGiEE3MD9elAi005aGlgx
	 e/6v+DYF/ahTmE0sMFyh+Yqs33x632UVtmjTSQ0uKJ7Hd0Vm9zPmL5ZXRb+L0kkbPR
	 oIsyZqTPOUpmAU6WXPaseyo2Lu6PjDaSOcj/ec+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfEQTjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfEQTjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:39:04 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759B92087B;
        Fri, 17 May 2019 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121944;
        bh=d3wvFqIZOIztWUag2jB8xc4NK0ROIuKLnzDGZYCuM9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGmwxVlKKzDQ4LVOKMxHkYGrjIsSo0VifghffNl0pHVobECwzgQhNPSqbJOOYRYgD
         aQV3SjbdtnqovjiN+6MxJWVh5Q1MSFygEQx0wUOmoPcUWrM83hB5HJGy6TSHWUVt9X
         bnkkhFUFz88cc0q5wEZKc8GrcBAl6NFcFR8xuzIE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/73] tools lib traceevent: Man pages for find field APIs
Date:   Fri, 17 May 2019 16:35:35 -0300
Message-Id: <20190517193611.4974-38-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

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
 .../libtraceevent-field_find.txt              | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_find.txt

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
-- 
2.20.1

