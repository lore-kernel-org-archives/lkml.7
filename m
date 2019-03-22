Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5908C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCCE21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfCVWMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:12:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfCVWMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:12:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMBlXE748578
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:11:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMBkXd748573;
        Fri, 22 Mar 2019 15:11:46 -0700
Date:   Fri, 22 Mar 2019 15:11:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ifpl634035266ho6wxuqgo81@git.kernel.org>
Cc:     hpa@zytor.com, linus.luessing@c0d3.blue, tglx@linutronix.de,
        jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org, acme@redhat.com,
        namhyung@kernel.org
Reply-To: acme@redhat.com, namhyung@kernel.org, davem@davemloft.net,
          mingo@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, linus.luessing@c0d3.blue, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update linux/in.h copy
Git-Commit-ID: 2fb71043e8894ca78258f7458a2db2eb3a142a22
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

Commit-ID:  2fb71043e8894ca78258f7458a2db2eb3a142a22
Gitweb:     https://git.kernel.org/tip/2fb71043e8894ca78258f7458a2db2eb3a142a22
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 11 Mar 2019 13:39:48 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:13:05 -0300

tools headers uapi: Update linux/in.h copy

To get the changes in:

  4effd28c1245 ("bridge: join all-snoopers multicast address")

That do not generate any changes in tools/ use of this file.

Silences this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Lüssing <linus.luessing@c0d3.blue>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ifpl634035266ho6wxuqgo81@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index a55cb8b10165..e7ad9d350a28 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -292,10 +292,11 @@ struct sockaddr_in {
 #define	IN_LOOPBACK(a)		((((long int) (a)) & 0xff000000) == 0x7f000000)
 
 /* Defines for Multicast INADDR */
-#define INADDR_UNSPEC_GROUP   	0xe0000000U	/* 224.0.0.0   */
-#define INADDR_ALLHOSTS_GROUP 	0xe0000001U	/* 224.0.0.1   */
-#define INADDR_ALLRTRS_GROUP    0xe0000002U	/* 224.0.0.2 */
-#define INADDR_MAX_LOCAL_GROUP  0xe00000ffU	/* 224.0.0.255 */
+#define INADDR_UNSPEC_GROUP		0xe0000000U	/* 224.0.0.0   */
+#define INADDR_ALLHOSTS_GROUP		0xe0000001U	/* 224.0.0.1   */
+#define INADDR_ALLRTRS_GROUP		0xe0000002U	/* 224.0.0.2 */
+#define INADDR_ALLSNOOPERS_GROUP	0xe000006aU	/* 224.0.0.106 */
+#define INADDR_MAX_LOCAL_GROUP		0xe00000ffU	/* 224.0.0.255 */
 #endif
 
 /* <asm/byteorder.h> contains the htonl type stuff.. */
