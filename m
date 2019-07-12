Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E3AC742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237A821019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfGLMbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:31:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729338AbfGLMbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:31:40 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CCRhBN111426
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 08:31:39 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpqvyp63h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 08:31:38 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 12 Jul 2019 13:31:36 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 13:31:32 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CCVIBt34800038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:31:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD4425204F;
        Fri, 12 Jul 2019 12:31:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA2D352057;
        Fri, 12 Jul 2019 12:31:30 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.ibm.com, gor@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/json: Add JSON files for s390 machine type 8561
Date:   Fri, 12 Jul 2019 14:31:13 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19071212-0008-0000-0000-000002FCB647
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071212-0009-0000-0000-0000226A2226
Message-Id: <20190712123113.100882-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Add CPU measurement counter facility event description files (json
    files) for IBM machine types 8561 and 8562.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_m8561/basic.json  |  58 +++
 .../pmu-events/arch/s390/cf_m8561/crypto.json | 114 ++++++
 .../arch/s390/cf_m8561/crypto6.json           |  30 ++
 .../arch/s390/cf_m8561/extended.json          | 373 ++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv   |   1 +
 5 files changed, 576 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/extended.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json b/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
new file mode 100644
index 000000000000..17fb5241928b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
@@ -0,0 +1,58 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "0",
+		"EventName": "CPU_CYCLES",
+		"BriefDescription": "CPU Cycles",
+		"PublicDescription": "Cycle Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "1",
+		"EventName": "INSTRUCTIONS",
+		"BriefDescription": "Instructions",
+		"PublicDescription": "Instruction Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "2",
+		"EventName": "L1I_DIR_WRITES",
+		"BriefDescription": "L1I Directory Writes",
+		"PublicDescription": "Level-1 I-Cache Directory Write Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "3",
+		"EventName": "L1I_PENALTY_CYCLES",
+		"BriefDescription": "L1I Penalty Cycles",
+		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "4",
+		"EventName": "L1D_DIR_WRITES",
+		"BriefDescription": "L1D Directory Writes",
+		"PublicDescription": "Level-1 D-Cache Directory Write Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "5",
+		"EventName": "L1D_PENALTY_CYCLES",
+		"BriefDescription": "L1D Penalty Cycles",
+		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "32",
+		"EventName": "PROBLEM_STATE_CPU_CYCLES",
+		"BriefDescription": "Problem-State CPU Cycles",
+		"PublicDescription": "Problem-State Cycle Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "33",
+		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
+		"BriefDescription": "Problem-State Instructions",
+		"PublicDescription": "Problem-State Instruction Count"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
new file mode 100644
index 000000000000..db286f19e7b6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
@@ -0,0 +1,114 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "64",
+		"EventName": "PRNG_FUNCTIONS",
+		"BriefDescription": "PRNG Functions",
+		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "65",
+		"EventName": "PRNG_CYCLES",
+		"BriefDescription": "PRNG Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "66",
+		"EventName": "PRNG_BLOCKED_FUNCTIONS",
+		"BriefDescription": "PRNG Blocked Functions",
+		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "67",
+		"EventName": "PRNG_BLOCKED_CYCLES",
+		"BriefDescription": "PRNG Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "68",
+		"EventName": "SHA_FUNCTIONS",
+		"BriefDescription": "SHA Functions",
+		"PublicDescription": "Total number of SHA functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "69",
+		"EventName": "SHA_CYCLES",
+		"BriefDescription": "SHA Cycles",
+		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "70",
+		"EventName": "SHA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "SHA Blocked Functions",
+		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "71",
+		"EventName": "SHA_BLOCKED_CYCLES",
+		"BriefDescription": "SHA Bloced Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "72",
+		"EventName": "DEA_FUNCTIONS",
+		"BriefDescription": "DEA Functions",
+		"PublicDescription": "Total number of the DEA functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "73",
+		"EventName": "DEA_CYCLES",
+		"BriefDescription": "DEA Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "74",
+		"EventName": "DEA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "DEA Blocked Functions",
+		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "75",
+		"EventName": "DEA_BLOCKED_CYCLES",
+		"BriefDescription": "DEA Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "76",
+		"EventName": "AES_FUNCTIONS",
+		"BriefDescription": "AES Functions",
+		"PublicDescription": "Total number of AES functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "77",
+		"EventName": "AES_CYCLES",
+		"BriefDescription": "AES Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "78",
+		"EventName": "AES_BLOCKED_FUNCTIONS",
+		"BriefDescription": "AES Blocked Functions",
+		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "79",
+		"EventName": "AES_BLOCKED_CYCLES",
+		"BriefDescription": "AES Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+]
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json b/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
new file mode 100644
index 000000000000..89e070727e1b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
@@ -0,0 +1,373 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "128",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "129",
+		"EventName": "DTLB2_WRITES",
+		"BriefDescription": "DTLB2 Writes",
+		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the data cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "130",
+		"EventName": "DTLB2_MISSES",
+		"BriefDescription": "DTLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "131",
+		"EventName": "DTLB2_HPAGE_WRITES",
+		"BriefDescription": "DTLB2 One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page or a Last Host Translation was done"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "132",
+		"EventName": "DTLB2_GPAGE_WRITES",
+		"BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
+		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "133",
+		"EventName": "L1D_L2D_SOURCED_WRITES",
+		"BriefDescription": "L1D L2D Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "134",
+		"EventName": "ITLB2_WRITES",
+		"BriefDescription": "ITLB2 Writes",
+		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "135",
+		"EventName": "ITLB2_MISSES",
+		"BriefDescription": "ITLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "136",
+		"EventName": "L1I_L2I_SOURCED_WRITES",
+		"BriefDescription": "L1I L2I Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "137",
+		"EventName": "TLB2_PTE_WRITES",
+		"BriefDescription": "TLB2 PTE Writes",
+		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "138",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 CRSTE Writes",
+		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "139",
+		"EventName": "TLB2_ENGINES_BUSY",
+		"BriefDescription": "TLB2 Engines Busy",
+		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "140",
+		"EventName": "TX_C_TEND",
+		"BriefDescription": "Completed TEND instructions in constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "141",
+		"EventName": "TX_NC_TEND",
+		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "143",
+		"EventName": "L1C_TLB2_MISSES",
+		"BriefDescription": "L1C TLB2 Misses",
+		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "144",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "145",
+		"EventName": "L1D_ONCHIP_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "146",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "147",
+		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Cluster Level-3 cache withountervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "148",
+		"EventName": "L1D_ONCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "149",
+		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "150",
+		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "151",
+		"EventName": "L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Cluster memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "152",
+		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "153",
+		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "154",
+		"EventName": "L1D_OFFDRAWER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "155",
+		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "156",
+		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "157",
+		"EventName": "L1D_OFFDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "158",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_RO",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes read-only",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip L3 but a read-only invalidate was done to remove other copies of the cache line"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "162",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "163",
+		"EventName": "L1I_ONCHIP_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from On-Chip memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "164",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "165",
+		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "166",
+		"EventName": "L1I_ONCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "167",
+		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Cluster Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "168",
+		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "169",
+		"EventName": "L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Cluster memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "170",
+		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "171",
+		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "172",
+		"EventName": "L1I_OFFDRAWER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "173",
+		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "174",
+		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "175",
+		"EventName": "L1I_OFFDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "224",
+		"EventName": "BCD_DFP_EXECUTION_SLOTS",
+		"BriefDescription": "BCD DFP Execution Slots",
+		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "225",
+		"EventName": "VX_BCD_EXECUTION_SLOTS",
+		"BriefDescription": "VX BCD Execution Slots",
+		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "226",
+		"EventName": "DECIMAL_INSTRUCTIONS",
+		"BriefDescription": "Decimal Instructions",
+		"PublicDescription": "Decimal instructions dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "232",
+		"EventName": "LAST_HOST_TRANSLATIONS",
+		"BriefDescription": "Last host translation done",
+		"PublicDescription": "Last Host Translation done"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "243",
+		"EventName": "TX_NC_TABORT",
+		"BriefDescription": "Aborted transactions in non-constrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "244",
+		"EventName": "TX_C_TABORT_NO_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "245",
+		"EventName": "TX_C_TABORT_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "448",
+		"EventName": "MT_DIAG_CYCLES_ONE_THR_ACTIVE",
+		"BriefDescription": "Cycle count with one thread active",
+		"PublicDescription": "Cycle count with one thread active"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "449",
+		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
+		"BriefDescription": "Cycle count with two threads active",
+		"PublicDescription": "Cycle count with two threads active"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index 78bcf7f8e206..bd3fc577139c 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -4,3 +4,4 @@ Family-model,Version,Filename,EventType
 ^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
+^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_m8561,core
-- 
2.19.1

