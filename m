Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322AFC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB782064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kjSbHtMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfDSTGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfDSTDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JHH2X0358887
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 10:17:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JHH2X0358887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555694223;
        bh=55gvKkxVHJu6DmhCoSVZ/UCqSQ4xZ2Qu3R21YVEQWnI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=kjSbHtMod4Q5QeSCCqNILH897WktA4LslNlAhXHamjqQAn9M3GoTQl9eDb7v2XG9X
         B11Ldgk7Ze13guIN+YMmca7W9GtGlHnJaj1IXWa2933rbyjy6LMJ3Pr9tlk6QIwx9t
         /J8CNR5pU2lvAfFy73QqPoK9vxKz4+QeZhQLi4m8k+tlkAmfAa3Q8lqA+IgidTQ3RO
         U0E9pWEW7qqBCe00NgJ2P+HwmKE+AqsrYrS5MILQQ0y9fDaYtFhmoub4SdBQrP0yUI
         2USxs5UopBh+N8GezaCE3epZlBn6PzspiXAL5MCUxPnYFvXpuOd9o0u079Rbc/xRj/
         0D2su7hWW9eEQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JHH1Oe358884;
        Fri, 19 Apr 2019 10:17:01 -0700
Date:   Fri, 19 Apr 2019 10:17:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-15o4twfkbn6nny9aus90dyzx@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, jolsa@kernel.org,
        tiwai@suse.de, namhyung@kernel.org, acme@redhat.com,
        danielmentz@google.com
Reply-To: adrian.hunter@intel.com, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          danielmentz@google.com, jolsa@kernel.org, tiwai@suse.de,
          acme@redhat.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Sync sound/asound.h copy
Git-Commit-ID: 30e4c574969ccb624940f1f2f7886596f8fc60ad
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

Commit-ID:  30e4c574969ccb624940f1f2f7886596f8fc60ad
Gitweb:     https://git.kernel.org/tip/30e4c574969ccb624940f1f2f7886596f8fc60ad
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Apr 2019 11:30:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Apr 2019 12:36:20 -0300

tools include uapi: Sync sound/asound.h copy

Picking the changes from:

  Fixes: b5bdbb6ccd11 ("ALSA: uapi: #include <time.h> in asound.h")

Which entails no changes in the tooling side.

To silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Link: https://lkml.kernel.org/n/tip-15o4twfkbn6nny9aus90dyzx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index 404d4b9ffe76..df1153cea0b7 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -32,6 +32,7 @@
 
 #ifndef __KERNEL__
 #include <stdlib.h>
+#include <time.h>
 #endif
 
 /*
