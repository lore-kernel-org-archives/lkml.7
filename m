Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A72C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A8A2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfC1JGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:06:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbfC1JGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:06:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2S8xdva122346
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:06:05 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rgs9n56fw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:06:05 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 28 Mar 2019 08:55:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 08:55:47 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2S8tk4J42270858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 08:55:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6852A405C;
        Thu, 28 Mar 2019 08:55:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC7AA4062;
        Thu, 28 Mar 2019 08:55:46 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.176.227])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 08:55:46 +0000 (GMT)
Date:   Thu, 28 Mar 2019 09:55:44 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for 5.1 #2
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032808-4275-0000-0000-000003206D28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032808-4276-0000-0000-0000382F09F1
Message-Id: <20190328095544.1930d8c7@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=473 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3717f613f48df0222311f974cf8a06c8a6c97bae:

  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-03-05 14:49:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.1-2

for you to fetch changes up to b6ffdf27f3d4f1e9af56effe6f86989170d71e95:

  s390/cpumf: Fix warning from check_processor_id (2019-03-28 09:28:42 +0100)

----------------------------------------------------------------
s390 update with improvements and bug fixes for 5.1-rc2

 - Fix early free of the channel program in vfio

 - On AP device removal make sure that all messages are flushed
   with the driver still attached that queued the message

 - Limit brk randomization to 32MB to reduce the chance that the
   heap of ld.so is placed after the main stack

 - Add a rolling average for the steal time of a CPU, this will be
   needed for KVM to decide when to do busy waiting

 - Fix a warning in the CPU-MF code

 - Add a notification handler for AP configuration change to react
   faster to new AP devices

----------------------------------------------------------------
Cornelia Huck (1):
      vfio: ccw: only free cp on final interrupt

Harald Freudenberger (1):
      s390/zcrypt: revisit ap device remove procedure

Martin Schwidefsky (3):
      s390: limit brk randomization to 32MB
      s390/vtime: steal time exponential moving average
      Merge tag 'vfio-ccw-20190311' of git://git.kernel.org/.../kvms390/vfio-ccw into fixes

Thomas Richter (1):
      s390/cpumf: Fix warning from check_processor_id

Tony Krowiak (1):
      zcrypt: handle AP Info notification from CHSC SEI command

 arch/s390/include/asm/ap.h           | 11 +++++++
 arch/s390/include/asm/elf.h          | 11 ++++---
 arch/s390/include/asm/lowcore.h      | 61 ++++++++++++++++++------------------
 arch/s390/kernel/perf_cpum_cf_diag.c | 19 +++++++----
 arch/s390/kernel/smp.c               |  3 +-
 arch/s390/kernel/vtime.c             | 19 ++++++-----
 drivers/s390/cio/chsc.c              | 13 ++++++++
 drivers/s390/cio/vfio_ccw_drv.c      |  8 +++--
 drivers/s390/crypto/ap_bus.c         | 19 ++++++++++-
 drivers/s390/crypto/ap_bus.h         |  2 ++
 drivers/s390/crypto/ap_queue.c       | 26 ++++++++++++---
 drivers/s390/crypto/zcrypt_api.c     | 30 +++++++++++-------
 12 files changed, 154 insertions(+), 68 deletions(-)

