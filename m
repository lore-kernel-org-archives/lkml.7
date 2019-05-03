Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BBDC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE902075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ye5+CNEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfECFy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:54:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECFy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:54:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435sJR12618335
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:54:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435sJR12618335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556862860;
        bh=VN9xXD1VcpiQpbfSlDRzNBzvMhmcj0N6KBYlV5zfyV4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ye5+CNEdOL2mU59L7ZVYuYTUWTWQZ75lKUzLDhcHAJou4XLMgDSc6N+NRQ5ZmdOls
         exT8zsqdHjh7Nlc38vvzKKYoTyCc2V1EgUe8Pl7HIpXbvl5N/QpBYjzJvTbim9rPev
         IJcVhQHRlw6nvilcq7hqLMaffTFMUEh9VcgT8BUCK/Wnp6x2dnT3hyt1q8lpayWFf/
         35SnkV9VDvy+UByvj0ayOeX+WgGVmPU3jf5nprqC/DEEBMkFRmS0D6Bk4KvK9Opuf6
         KQoUWa+h8CHd5MC3msmh1V7pyP5+A6/s71sg1l2B62+kxauldhZjAGesRXxLfYldeX
         Bktt3+xVI1hTA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435sIZh2618332;
        Thu, 2 May 2019 22:54:18 -0700
Date:   Thu, 2 May 2019 22:54:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-5f05182fab9a29fea6c4ab8113be45adf0c11bf0@git.kernel.org>
Cc:     mingo@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        tglx@linutronix.de, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          leo.yan@linaro.org, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, rostedt@goodmis.org
In-Reply-To: <20190424013802.27569-1-leo.yan@linaro.org>
References: <20190424013802.27569-1-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Change tag string for error
Git-Commit-ID: 5f05182fab9a29fea6c4ab8113be45adf0c11bf0
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

Commit-ID:  5f05182fab9a29fea6c4ab8113be45adf0c11bf0
Gitweb:     https://git.kernel.org/tip/5f05182fab9a29fea6c4ab8113be45adf0c11bf0
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Wed, 24 Apr 2019 09:38:02 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:19 -0400

tools lib traceevent: Change tag string for error

The traceevent lib is used by the perf tool, and when executing

  perf test -v 6

it outputs error log on the ARM64 platform:

  running test 33 '*:*'trace-cmd: No such file or directory

  [...]

  trace-cmd: Invalid argument

The trace event parsing code originally came from trace-cmd so it keeps
the tag string "trace-cmd" for errors, this easily introduces the
impression that the perf tool launches trace-cmd command for trace event
parsing, but in fact the related parsing is accomplished by the
traceevent lib.

This patch changes the tag string to "libtraceevent" so that we can
avoid confusion and let users to more easily connect the error with
traceevent lib.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190424013802.27569-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-utils.c b/tools/lib/traceevent/parse-utils.c
index 77e4ec6402dd..e99867111387 100644
--- a/tools/lib/traceevent/parse-utils.c
+++ b/tools/lib/traceevent/parse-utils.c
@@ -14,7 +14,7 @@
 void __vwarning(const char *fmt, va_list ap)
 {
 	if (errno)
-		perror("trace-cmd");
+		perror("libtraceevent");
 	errno = 0;
 
 	fprintf(stderr, "  ");
