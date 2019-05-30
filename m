Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A25125BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfE3Ozf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:55:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbfE3Ozb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:55:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEpsZw163880
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:55:29 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stgm12dce-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:55:29 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:55:29 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:55:23 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEtMGQ26083360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:55:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1404FB2067;
        Thu, 30 May 2019 14:55:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E72A3B2068;
        Thu, 30 May 2019 14:55:21 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:55:21 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B23B716C5D84; Thu, 30 May 2019 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/2] doc: Fixup definition of rcupdate.rcu_task_stall_timeout
Date:   Thu, 30 May 2019 07:55:22 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145504.GA29820@linux.ibm.com>
References: <20190530145504.GA29820@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0052-0000-0000-000003C91313
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210784; UDB=6.00636157; IPR=6.00991818;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:55:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0053-0000-0000-0000611A11CF
Message-Id: <20190530145522.30122-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@oracle.com>

A positive value of rcupdate.rcu_task_stall_timeout is an interval
in seconds rather than jiffies.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/stallwarn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index 1ab70c37921f..13e88fc00f01 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -153,7 +153,7 @@ rcupdate.rcu_task_stall_timeout
 	This boot/sysfs parameter controls the RCU-tasks stall warning
 	interval.  A value of zero or less suppresses RCU-tasks stall
 	warnings.  A positive value sets the stall-warning interval
-	in jiffies.  An RCU-tasks stall warning starts with the line:
+	in seconds.  An RCU-tasks stall warning starts with the line:
 
 		INFO: rcu_tasks detected stalls on tasks:
 
-- 
2.17.1

