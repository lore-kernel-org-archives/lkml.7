Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9693C20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfDPPoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:44:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbfDPPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:44:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GFdTX0043909
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:44:17 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rwgc6cwey-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:44:17 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 16 Apr 2019 16:44:15 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 16:44:12 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3GFiBfD30081082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 15:44:11 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FB786E04C;
        Tue, 16 Apr 2019 15:44:11 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B05346E04E;
        Tue, 16 Apr 2019 15:44:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.3.116.186])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Apr 2019 15:44:10 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        andrew@aj.id.au, mine260309@gmail.com,
        Eddie James <eajames@us.ibm.com>
Subject: [PATCH 3/3] hwmon (occ): Add more details to Kconfig help text
Date:   Tue, 16 Apr 2019 15:43:50 +0000
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
References: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041615-0016-0000-0000-000009A15DE2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010938; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189952; UDB=6.00623517; IPR=6.00970747;
 MB=3.00026468; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-16 15:44:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041615-0017-0000-0000-000042D63D4A
Message-Id: <1555429430-23118-3-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=965 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@us.ibm.com>

The help text needs to spell out how the driver runs on a BMC, as it
previously seemed to indicate it ran on a POWER processor.

Signed-off-by: Eddie James <eajames@us.ibm.com>
---
 drivers/hwmon/occ/Kconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/occ/Kconfig b/drivers/hwmon/occ/Kconfig
index 2a3869f..1658634 100644
--- a/drivers/hwmon/occ/Kconfig
+++ b/drivers/hwmon/occ/Kconfig
@@ -9,8 +9,10 @@ config SENSORS_OCC_P8_I2C
 	select SENSORS_OCC
 	help
 	 This option enables support for monitoring sensors provided by the
-	 On-Chip Controller (OCC) on a POWER8 processor. Communications with
-	 the OCC are established through I2C bus.
+	 On-Chip Controller (OCC) on a POWER8 processor. However, this driver
+	 can only run on a baseboard management controller (BMC) connected to
+	 the P8, not the POWER processor itself. Communications with the OCC are
+	 established through I2C bus.
 
 	 This driver can also be built as a module. If so, the module will be
 	 called occ-p8-hwmon.
@@ -22,8 +24,10 @@ config SENSORS_OCC_P9_SBE
 	select SENSORS_OCC
 	help
 	 This option enables support for monitoring sensors provided by the
-	 On-Chip Controller (OCC) on a POWER9 processor. Communications with
-	 the OCC are established through SBE fifo on an FSI bus.
+	 On-Chip Controller (OCC) on a POWER9 processor. However, this driver
+	 can only run on a baseboard management controller (BMC) connected to
+	 the P9, not the POWER processor itself. Communications with the OCC are
+	 established through SBE fifo on an FSI bus.
 
 	 This driver can also be built as a module. If so, the module will be
 	 called occ-p9-hwmon.
-- 
2.7.4

