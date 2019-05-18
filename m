Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD6C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A07206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F6TDf6pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfERI4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:56:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfERI4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:56:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8tuLu1733048
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:55:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8tuLu1733048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169756;
        bh=TCarjDzIcBjh4hAaaL54iOuEOOV2rcIsXh2VF2nz28Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=F6TDf6pFLFVeQl3+CB8vp/0WyPWRL0RGDbs7H4kiqfM9X0KxC/x5ZobBVo4xa9IyZ
         duo2HvPRLI2YfAvaNSvem5yvihRDYcaWhhqrYzZheCgZdaHWzBt2OEoCEYLuPpS/Br
         +ppGipBZaeYHv7TT9pfFeFm5cWYgbRsGNvORAYi4VDMqLVDfga0hRujW3RBOTSypOS
         lvRKr67gg+qnvyTdO5rWoihZYyY2GmoZM0CmbNjcWfxeJWCRPmKzLv0/boFUbjyGXC
         VQKHBFKh5p1Y65VeQ1HZzG8qsY2RNmUQr+q+iEO5ZZeM2UsMWDGEyXBRU72rQhkhA2
         geF1rGplV1mRw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8ttxP1733045;
        Sat, 18 May 2019 01:55:55 -0700
Date:   Sat, 18 May 2019 01:55:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-3ac641f4acd66c109b74f108f8a61f2905702b10@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        jolsa@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: mingo@kernel.org, acme@redhat.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com
In-Reply-To: <20190503120828.25326-4-adrian.hunter@intel.com>
References: <20190503120828.25326-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Add
 tree level
Git-Commit-ID: 3ac641f4acd66c109b74f108f8a61f2905702b10
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

Commit-ID:  3ac641f4acd66c109b74f108f8a61f2905702b10
Gitweb:     https://git.kernel.org/tip/3ac641f4acd66c109b74f108f8a61f2905702b10
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 3 May 2019 15:08:25 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf scripts python: exported-sql-viewer.py: Add tree level

As preparation for adding support for copying to clipboard, keep track of
what level each item is in tree items.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index fd073e4af8da..48953257a1f0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -456,6 +456,10 @@ class CallGraphLevelItemBase(object):
 		self.query_done = False;
 		self.child_count = 0
 		self.child_items = []
+		if parent_item:
+			self.level = parent_item.level + 1
+		else:
+			self.level = 0
 
 	def getChildItem(self, row):
 		return self.child_items[row]
