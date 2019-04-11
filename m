Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE3C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9604206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDKCrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:47:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbfDKCrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:47:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3B2e110113884
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 22:47:31 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsstmy3dj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 22:47:30 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sukadev@linux.vnet.ibm.com>;
        Thu, 11 Apr 2019 03:47:30 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 03:47:27 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3B2lRjT33947888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 02:47:27 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9079124052;
        Thu, 11 Apr 2019 02:47:26 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD1FD124053;
        Thu, 11 Apr 2019 02:47:26 +0000 (GMT)
Received: from suka-w540.localdomain (unknown [9.70.94.45])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 02:47:26 +0000 (GMT)
Received: by suka-w540.localdomain (Postfix, from userid 1000)
        id 40B6D2E14E4; Wed, 10 Apr 2019 18:38:47 -0700 (PDT)
Date:   Wed, 10 Apr 2019 18:38:46 -0700
From:   Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: MAINTAINERS: Remove non-existent VAS file
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19041102-0064-0000-0000-000003C95B27
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010906; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187337; UDB=6.00621927; IPR=6.00968102;
 MB=3.00026384; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 02:47:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041102-0065-0000-0000-00003D054CF8
Message-Id: <20190411013846.GA5628@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=704 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The file arch/powerpc/include/uapi/asm/vas.h was considered but
never merged and should be removed from the MAINTAINERS file.

While here, add missing email address.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3671fde..e3bf3d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7386,13 +7386,12 @@ S:	Supported
 F:	drivers/net/ethernet/ibm/ibmvnic.*
 
 IBM Power Virtual Accelerator Switchboard
-M:	Sukadev Bhattiprolu
+M:	Sukadev Bhattiprolu <sukadev@linux.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/vas*
 F:	arch/powerpc/platforms/powernv/copy-paste.h
 F:	arch/powerpc/include/asm/vas.h
-F:	arch/powerpc/include/uapi/asm/vas.h
 
 IBM Power Virtual Ethernet Device Driver
 M:	Thomas Falcon <tlfalcon@linux.ibm.com>
-- 
1.8.3.1

