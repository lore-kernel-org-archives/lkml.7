Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15E7C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DA621D71
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928396;
	bh=9t6oeWgYnnW/7DYNEH0+tSPvcQ+UL6RMI+GO7JqfbLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TV8HMQF4nk1I2lMJqiawSsNV3WJ7d48o6lNo8d0yS7lTYhkUNsyPTzNYH+lc9R0hp
	 BzvC7TG5z0lsq1m+7T/8zsFd9h3ksgRxNar3ZC5vZQ8TVFE0pqbIdRx09XRNGi4WUb
	 5RfkoZtuIS32nyrPm6pjMQ7eQPbFhjSgludpX2Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfJALNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbfJALNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:13 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CE721924;
        Tue,  1 Oct 2019 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928392;
        bh=9t6oeWgYnnW/7DYNEH0+tSPvcQ+UL6RMI+GO7JqfbLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mwpb+4Qb8KqJthjSOQlRh6ggPEBce6zxuTBNnocSS/M3/F+HI3buRijJvR5iANzAR
         yLuu/+rp/Vx7s2gvdvCsfa7M24HcTozW2LSyU7IfQ/C771W2jO9vsK+N5NaZUlo1pc
         DM/fJLnSzlugMBKPZj6AXQVoQZVVeD6OlhWnNfkQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/24] perf vendor events s390: Use s390 machine name instead of type 8561
Date:   Tue,  1 Oct 2019 08:12:03 -0300
Message-Id: <20191001111216.7208-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

In the pmu-events directory for JSON file definitions use the
official machine name IBM z15 instead of machine type number
8561. This is consistent with previous machines.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20190927081147.18345-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json | 0
 .../perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json  | 0
 .../perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json | 0
 .../pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json     | 0
 .../pmu-events/arch/s390/{cf_m8561 => cf_z15}/transaction.json  | 0
 tools/perf/pmu-events/arch/s390/mapfile.csv                     | 2 +-
 6 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json (100%)
 rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/transaction.json (100%)

diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/basic.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/extended.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
similarity index 100%
rename from tools/perf/pmu-events/arch/s390/cf_m8561/transaction.json
rename to tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index bd3fc577139c..61641a3480e0 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -4,4 +4,4 @@ Family-model,Version,Filename,EventType
 ^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
-^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_m8561,core
+^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
-- 
2.21.0

