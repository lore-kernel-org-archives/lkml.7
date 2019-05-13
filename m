Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6246C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B822086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfEMIEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:04:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbfEMIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:04:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4D84Fli008939
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:04:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sf2cmnh5r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:04:24 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 13 May 2019 09:02:25 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 May 2019 09:02:23 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4D82MFX46399508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 08:02:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D9C9AE051;
        Mon, 13 May 2019 08:02:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9CBFAE065;
        Mon, 13 May 2019 08:02:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 May 2019 08:02:21 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf docu: Add description for stderr
Date:   Mon, 13 May 2019 10:02:20 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 19051308-0020-0000-0000-0000033C05A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051308-0021-0000-0000-0000218EB8F8
Message-Id: <20190513080220.91966-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf report displays recorded data on the screen and emits
warnings and debug messages in the status line (last one on screen).
Perf also supports the possibility to write all debug messages
to stderr (instead of writing them to the status line).
This is achieved with the following command:

 # ./perf --debug stderr=1 report -vvvvv -i ~/fast.data 2>/tmp/2
 # ll /tmp/2
 -rw-rw-r-- 1 tmricht tmricht 5420835 May  7 13:46 /tmp/2
 #

The usage of variable stderr=1 is not documented, so add it
to the perf man page.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Documentation/perf.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 864e37597252..401f0ed67439 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -22,6 +22,8 @@ OPTIONS
 	  verbose          - general debug messages
 	  ordered-events   - ordered events object debug messages
 	  data-convert     - data convert command debug messages
+	  stderr           - write debug output (option -v) to stderr
+	                     in browser mode
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
-- 
2.19.1

