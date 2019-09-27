Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4439FC352AB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261A621850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfI0IMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:12:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbfI0IMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:12:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8R8BwKQ134188
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 04:12:04 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9cwc3kj0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 04:12:03 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 27 Sep 2019 09:12:01 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 09:11:59 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8R8BvxP46006636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 08:11:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76DAC11C04C;
        Fri, 27 Sep 2019 08:11:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D5DB11C04A;
        Fri, 27 Sep 2019 08:11:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 08:11:57 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     gor@linux.ibm.com, heiko.carstens@de.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] perf/pmu_events: Use s390 machine name instead of type 8561
Date:   Fri, 27 Sep 2019 10:11:47 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927081147.18345-1-tmricht@linux.ibm.com>
References: <20190927081147.18345-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19092708-0020-0000-0000-0000037238EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092708-0021-0000-0000-000021C8084C
Message-Id: <20190927081147.18345-2-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the pmu-events directory for JSON file definitions use the
official machine name IBM z15 instead of machine type number
8561. This is consistent with previous machines.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
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
2.19.1

