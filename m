Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6381C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3762084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfDYKfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:35:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730384AbfDYKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:35:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PAJQGx109726
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 06:35:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3ach2ag4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 06:35:42 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 25 Apr 2019 11:35:40 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 11:35:37 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PAZahC49676394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 10:35:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05C94A4059;
        Thu, 25 Apr 2019 10:35:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85E66A4053;
        Thu, 25 Apr 2019 10:35:34 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.17])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Apr 2019 10:35:34 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 25 Apr 2019 13:35:33 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm/Kconfig: update "Memory Model" help text
Date:   Thu, 25 Apr 2019 13:35:31 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19042510-0012-0000-0000-000003146FF6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042510-0013-0000-0000-0000214CC968
Message-Id: <1556188531-20728-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help describing the memory model selection is outdated. It still says
that SPARSEMEM is experimental and DISCONTIGMEM is a preferred over
SPARSEMEM.

Update the help text for the relevant options:
* add a generic help for the "Memory Model" prompt
* add description for FLATMEM
* reduce the description of DISCONTIGMEM and add a deprecation note
* prefer SPARSEMEM over DISCONTIGMEM

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/Kconfig | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 25c71eb8a7db..8f7ae4d71b77 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -11,23 +11,24 @@ choice
 	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
 	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT
 	default FLATMEM_MANUAL
+	help
+	  This option allows you to change some of the ways that
+	  Linux manages its memory internally. Most users will
+	  only have one option here selected by the architecture
+	  configuration. This is normal.
 
 config FLATMEM_MANUAL
 	bool "Flat Memory"
 	depends on !(ARCH_DISCONTIGMEM_ENABLE || ARCH_SPARSEMEM_ENABLE) || ARCH_FLATMEM_ENABLE
 	help
-	  This option allows you to change some of the ways that
-	  Linux manages its memory internally.  Most users will
-	  only have one option here: FLATMEM.  This is normal
-	  and a correct option.
-
-	  Some users of more advanced features like NUMA and
-	  memory hotplug may have different options here.
-	  DISCONTIGMEM is a more mature, better tested system,
-	  but is incompatible with memory hotplug and may suffer
-	  decreased performance over SPARSEMEM.  If unsure between
-	  "Sparse Memory" and "Discontiguous Memory", choose
-	  "Discontiguous Memory".
+	  This option is best suited for non-NUMA systems with
+	  flat address space. The FLATMEM is the most efficient
+	  system in terms of performance and resource consumption
+	  and it is the best option for smaller systems.
+
+	  For systems that have holes in their physical address
+	  spaces and for features like NUMA and memory hotplug,
+	  choose "Sparse Memory"
 
 	  If unsure, choose this option (Flat Memory) over any other.
 
@@ -38,29 +39,26 @@ config DISCONTIGMEM_MANUAL
 	  This option provides enhanced support for discontiguous
 	  memory systems, over FLATMEM.  These systems have holes
 	  in their physical address spaces, and this option provides
-	  more efficient handling of these holes.  However, the vast
-	  majority of hardware has quite flat address spaces, and
-	  can have degraded performance from the extra overhead that
-	  this option imposes.
+	  more efficient handling of these holes.
 
-	  Many NUMA configurations will have this as the only option.
+	  Although "Discontiguous Memory" is still used by several
+	  architectures, it is considered deprecated in favor of
+	  "Sparse Memory".
 
-	  If unsure, choose "Flat Memory" over this option.
+	  If unsure, choose "Sparse Memory" over this option.
 
 config SPARSEMEM_MANUAL
 	bool "Sparse Memory"
 	depends on ARCH_SPARSEMEM_ENABLE
 	help
 	  This will be the only option for some systems, including
-	  memory hotplug systems.  This is normal.
+	  memory hot-plug systems.  This is normal.
 
-	  For many other systems, this will be an alternative to
-	  "Discontiguous Memory".  This option provides some potential
-	  performance benefits, along with decreased code complexity,
-	  but it is newer, and more experimental.
+	  This option provides efficient support for systems with
+	  holes is their physical address space and allows memory
+	  hot-plug and hot-remove.
 
-	  If unsure, choose "Discontiguous Memory" or "Flat Memory"
-	  over this option.
+	  If unsure, choose "Flat Memory" over this option.
 
 endchoice
 
-- 
2.7.4

