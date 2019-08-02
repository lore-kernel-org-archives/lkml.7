Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C50C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4511120B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436624AbfHBOIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:08:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436601AbfHBOIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:08:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72E7UsL069532
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 10:08:17 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4pjqga0r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 10:08:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Fri, 2 Aug 2019 15:08:14 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 15:08:11 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72E89pE22348106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 14:08:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90E9352057;
        Fri,  2 Aug 2019 14:08:09 +0000 (GMT)
Received: from localhost (unknown [9.152.212.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 605505205F;
        Fri,  2 Aug 2019 14:08:09 +0000 (GMT)
Date:   Fri, 2 Aug 2019 16:08:08 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.3-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19080214-0016-0000-0000-0000029907EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080214-0017-0000-0000-000032F80835
Message-Id: <your-ad-here.call-01564754888-ext-1592@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=381 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.3-rc3.

Thank you,
Vasily

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-4

for you to fetch changes up to 3cdd98606750a5a1d1c8bcda5b481cb86ed67b3b:

  s390/zcrypt: adjust switch fall through comments for -Wimplicit-fallthrough (2019-08-02 13:58:23 +0200)

----------------------------------------------------------------
s390 updates for 5.3-rc3

 - Default configs updates.

 - Minor qdio cleanup.

 - Sparse warnings fixes.

 - Implicit-fallthrough warnings fixes.

----------------------------------------------------------------
Heiko Carstens (3):
      s390: update configs
      s390/mm: add fallthrough annotations
      s390/tape: add fallthrough annotations

Julian Wiedmann (1):
      s390: clean up qdio.h

Vasily Gorbik (8):
      s390/boot: add missing declarations and includes
      s390/lib: add missing include
      s390/perf: make cf_diag_csd static
      s390/kexec: add missing include to machine_kexec_reloc.c
      s390/mm: make gmap_test_and_clear_dirty_pmd static
      s390/3215: add switch fall through comment for -Wimplicit-fallthrough
      vfio-ccw: make vfio_ccw_async_region_ops static
      s390/zcrypt: adjust switch fall through comments for -Wimplicit-fallthrough

 arch/s390/boot/boot.h                  |   1 +
 arch/s390/boot/kaslr.c                 |   1 +
 arch/s390/configs/debug_defconfig      | 330 ++++++++++++++++++++-------------
 arch/s390/configs/defconfig            | 233 ++++++++++++++---------
 arch/s390/configs/zfcpdump_defconfig   |  31 ++--
 arch/s390/include/asm/qdio.h           |  10 +-
 arch/s390/include/asm/setup.h          |   1 +
 arch/s390/kernel/machine_kexec_reloc.c |   1 +
 arch/s390/kernel/perf_cpum_cf_diag.c   |   2 +-
 arch/s390/lib/xor.c                    |   1 +
 arch/s390/mm/fault.c                   |   3 +
 arch/s390/mm/gmap.c                    |   4 +-
 drivers/s390/char/con3215.c            |   1 +
 drivers/s390/char/tape_core.c          |   3 +
 drivers/s390/cio/vfio_ccw_async.c      |   2 +-
 drivers/s390/crypto/ap_queue.c         |   1 +
 drivers/s390/crypto/zcrypt_msgtype6.c  |  17 +-
 17 files changed, 392 insertions(+), 250 deletions(-)

