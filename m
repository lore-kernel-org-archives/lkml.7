Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F9FC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B7C216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEOFv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 01:51:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfEOFv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:51:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4F5mdke063644
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:51:28 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgcmu0t0m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:51:27 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 15 May 2019 06:51:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 06:51:22 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4F5pL5p59441168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 05:51:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3038811C058;
        Wed, 15 May 2019 05:51:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF67A11C05E;
        Wed, 15 May 2019 05:51:19 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 15 May 2019 05:51:19 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 15 May 2019 08:51:19 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Helge Deller <deller@gmx.de>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] parisc: Kconfig: remove ARCH_DISCARD_MEMBLOCK
Date:   Wed, 15 May 2019 08:41:22 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19051505-0008-0000-0000-000002E6C9AF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051505-0009-0000-0000-0000225366EE
Message-Id: <1557898882-28507-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 350e88bad496 ("mm: memblock: make keeping memblock memory
opt-in rather than opt-out") the default behaviour is to discard memblock
data after init and the ARCH_DISCARD_MEMBLOCK is obsolete.

Remove it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/parisc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 09407ed..13b95125 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -36,7 +36,6 @@ config PARISC
 	select GENERIC_STRNCPY_FROM_USER
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_EXCEPTION_TRACE
-	select ARCH_DISCARD_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC
 	select VIRT_TO_BUS
 	select MODULES_USE_ELF_RELA
-- 
2.7.4

