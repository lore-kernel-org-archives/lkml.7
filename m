Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E6C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C42222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfJEPi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 11:38:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbfJEPi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 11:38:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x95FajBL024940
        for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2019 11:38:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2veq5r85n3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 11:38:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 5 Oct 2019 16:38:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 5 Oct 2019 16:38:51 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x95FcnkA52101342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Oct 2019 15:38:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3FE04C052;
        Sat,  5 Oct 2019 15:38:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A4064C044;
        Sat,  5 Oct 2019 15:38:49 +0000 (GMT)
Received: from localhost (unknown [9.145.65.39])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Oct 2019 15:38:49 +0000 (GMT)
Date:   Sat, 5 Oct 2019 17:38:47 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.4-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19100515-0020-0000-0000-0000037551BB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100515-0021-0000-0000-000021CB643D
Message-Id: <your-ad-here.call-01570289927-ext-8803@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=690 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910050156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.4-rc2.

Thank you,
Vasily

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-3

for you to fetch changes up to d0dea733f60efe94257d08ae6eba81d0b511d0a9:

  KVM: s390: mark __insn32_query() as __always_inline (2019-10-05 13:51:22 +0200)

----------------------------------------------------------------
s390 updates for 5.4-rc2

- Default configs updates.

- Fix build errors with CC_OPTIMIZE_FOR_SIZE due to usage of "i" constraint
  for function arguments. Two kvm changes acked-by Christian Borntraeger.

- Fix -Wunused-but-set-variable warnings in mm code.

- Avoid a constant misuse in qdio.

- Handle a case when cpumf is temporarily unavailable.

----------------------------------------------------------------
Heiko Carstens (8):
      s390/atomic,bitops: mark function(s) __always_inline
      s390/cpu_mf: mark function(s) __always_inline
      s390/jump_label: mark function(s) __always_inline
      s390/mm: mark function(s) __always_inline
      s390/pci: mark function(s) __always_inline
      s390: update defconfigs
      KVM: s390: fix __insn32_query() inline assembly
      KVM: s390: mark __insn32_query() as __always_inline

Jiri Kosina (1):
      s390: mark __cpacf_query() as __always_inline

Julian Wiedmann (1):
      s390/qdio: clarify size of the QIB parm area

Qian Cai (1):
      s390/mm: fix -Wunused-but-set-variable warnings

Thomas Richter (3):
      s390/cpumf: Use consistant debug print format
      s390/cpumsf: Check for CPU Measurement sampling
      s390/cpumf: Fix indentation in sampling device driver

 arch/s390/configs/debug_defconfig    | 24 ++++++++++++++++--------
 arch/s390/configs/defconfig          | 25 ++++++++++++++++---------
 arch/s390/configs/zfcpdump_defconfig |  2 +-
 arch/s390/include/asm/atomic_ops.h   |  2 +-
 arch/s390/include/asm/bitops.h       |  8 ++++----
 arch/s390/include/asm/cpacf.h        |  2 +-
 arch/s390/include/asm/cpu_mf.h       |  8 ++++++--
 arch/s390/include/asm/hugetlb.h      |  9 +++++++--
 arch/s390/include/asm/jump_label.h   |  4 ++--
 arch/s390/include/asm/pgtable.h      | 25 +++++++++++++------------
 arch/s390/include/asm/qdio.h         |  2 +-
 arch/s390/kernel/perf_cpum_cf_diag.c |  4 ++--
 arch/s390/kernel/perf_cpum_sf.c      |  8 +++++++-
 arch/s390/kvm/kvm-s390.c             |  6 +++---
 arch/s390/pci/pci_clp.c              |  2 +-
 drivers/s390/cio/qdio_setup.c        |  2 +-
 drivers/s390/net/qeth_core_main.c    |  3 +--
 17 files changed, 83 insertions(+), 53 deletions(-)

