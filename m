Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17FA208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vug504LS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfGQXH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:07:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60261 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfGQXH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:07:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN7kxZ1726022
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:07:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN7kxZ1726022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404867;
        bh=UnaH6g2tkvPcWPqL0mvgI6QMu4mEzJT1U0EWB4bMM2M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vug504LSdu9fhlHRJXfgVZBt+RzvsGLNIR2ZHF3zErHGdYVjA/g4xNliqxvH6mqbs
         YdEuwrdGUYcUbBvehr1GtzdSWlTcdCimSqTxf4Vtlab4g4UPkQf7WbximiwFHSH4hN
         +OxLu32zbYD7zu2jkO9TcSzB1wyjYZAUUlK8s6zxoWDUX8wUWmt+28M2C+9Z6/L5cL
         l3Rmew1tp7JipkMgUdFZ5T05dfWUoG/DSzKa+3q1dMMw+8JSNHZB2dL0hmdQFGG4ai
         pqCK145jfzpLz2e0QDuNFsBpZnoA7bvWjv6Ek4nqfhFM4kiWGGUaUlAtl972i186V6
         /NBBuHK1R5G1A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN7jCh1726016;
        Wed, 17 Jul 2019 16:07:45 -0700
Date:   Wed, 17 Jul 2019 16:07:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-6e67d77d673d785631b0c52314b60d3c68ebe809@git.kernel.org>
Cc:     heiko.carstens@de.ibm.com, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, brueckner@linux.ibm.com,
        linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
        gor@linux.ibm.com
Reply-To: mingo@kernel.org, heiko.carstens@de.ibm.com, acme@redhat.com,
          hpa@zytor.com, brueckner@linux.ibm.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
          gor@linux.ibm.com
In-Reply-To: <20190712123113.100882-1-tmricht@linux.ibm.com>
References: <20190712123113.100882-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf vendor events s390: Add JSON files for
 machine type 8561
Git-Commit-ID: 6e67d77d673d785631b0c52314b60d3c68ebe809
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

Commit-ID:  6e67d77d673d785631b0c52314b60d3c68ebe809
Gitweb:     https://git.kernel.org/tip/6e67d77d673d785631b0c52314b60d3c68ebe809
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Fri, 12 Jul 2019 14:31:13 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 12 Jul 2019 13:51:59 -0300

perf vendor events s390: Add JSON files for machine type 8561

Add CPU measurement counter facility event description files (JSON) for
IBM machine types 8561 and 8562.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190712123113.100882-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/s390/{cf_z14 => cf_m8561}/basic.json      |  0
 .../arch/s390/{cf_z10 => cf_m8561}/crypto.json     |  0
 .../pmu-events/arch/s390/cf_m8561/crypto6.json     | 30 ++++++++++++++++++++++
 .../arch/s390/{cf_z14 => cf_m8561}/extended.json   |  2 +-
 tools/perf/pmu-events/arch/s390/mapfile.csv        |  1 +
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json b/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z14/basic.json
copy to tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
copy to tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
new file mode 100644
index 000000000000..5e36bc2468d0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
@@ -0,0 +1,30 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "80",
+		"EventName": "ECC_FUNCTION_COUNT",
+		"BriefDescription": "ECC Function Count",
+		"PublicDescription": "Long ECC function Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "81",
+		"EventName": "ECC_CYCLES_COUNT",
+		"BriefDescription": "ECC Cycles Count",
+		"PublicDescription": "Long ECC Function cycles count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "82",
+		"EventName": "ECC_BLOCKED_FUNCTION_COUNT",
+		"BriefDescription": "Ecc Blocked Function Count",
+		"PublicDescription": "Long ECC blocked function count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "83",
+		"EventName": "ECC_BLOCKED_CYCLES_COUNT",
+		"BriefDescription": "ECC Blocked Cycles Count",
+		"PublicDescription": "Long ECC blocked cycles count"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
similarity index 98%
copy from tools/perf/pmu-events/arch/s390/cf_z14/extended.json
copy to tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
index 68618152ea2c..89e070727e1b 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
@@ -4,7 +4,7 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
 		"Unit": "CPU-M-CF",
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index 78bcf7f8e206..bd3fc577139c 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -4,3 +4,4 @@ Family-model,Version,Filename,EventType
 ^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
+^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_m8561,core
