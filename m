Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2041C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 12:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983FE214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 12:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfLNMK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 07:10:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbfLNMK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 07:10:27 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBEC7PiX063339
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 07:10:26 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wvvg5mje7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 07:10:25 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 14 Dec 2019 12:10:24 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 14 Dec 2019 12:10:23 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBECALUV23724126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Dec 2019 12:10:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81B1811C5FA;
        Sat, 14 Dec 2019 12:10:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0488911C5F9;
        Sat, 14 Dec 2019 12:10:21 +0000 (GMT)
Received: from localhost (unknown [9.145.79.243])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 14 Dec 2019 12:10:20 +0000 (GMT)
Date:   Sat, 14 Dec 2019 13:10:19 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.5-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19121412-0012-0000-0000-00000374C1A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121412-0013-0000-0000-000021B0A325
Message-Id: <your-ad-here.call-01576325419-ext-4863@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-14_02:2019-12-13,2019-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=3 phishscore=0
 mlxlogscore=704 clxscore=1015 suspectscore=2 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=3 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912140082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.5-rc2.

Thank you,
Vasily

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-3

for you to fetch changes up to 3e39ce266a273e5751e5792aee248cb8d9630c8b:

  s390/kasan: add KASAN_VMALLOC support (2019-12-11 19:56:59 +0100)

----------------------------------------------------------------
s390 updates for 5.5-rc2

- Add support for KASAN_VMALLOC feature.

- Remove the last user of problematic diag 0x44 call.

- Adjust sampling interval and avoid sample data block overflow condition
  on pressure in perf code.

- Prefer EOPNOTSUPP over ENOTSUPP and comments fixes.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/uv: use EOPNOTSUPP instead of ENOTSUPP

Colin Ian King (1):
      s390/test_unwind: fix spelling mistake "reqister" -> "register"

Heiko Carstens (1):
      s390: remove last diag 0x44 caller

Thomas Richter (2):
      s390/cpum_sf: Adjust sampling interval to avoid hitting sample limits
      s390/cpum_sf: Avoid SBD overflow condition in irq handler

Vasily Gorbik (2):
      s390/spinlock: remove confusing comment in arch_spin_lock_wait
      s390/kasan: add KASAN_VMALLOC support

 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/setup.h   |  2 --
 arch/s390/include/asm/uv.h      |  2 +-
 arch/s390/kernel/early.c        | 16 ----------
 arch/s390/kernel/perf_cpum_sf.c | 22 +++++++++----
 arch/s390/kernel/smp.c          | 13 +++-----
 arch/s390/lib/spinlock.c        |  1 -
 arch/s390/lib/test_unwind.c     |  2 +-
 arch/s390/mm/kasan_init.c       | 68 +++++++++++++++++++++++++++++++++--------
 9 files changed, 80 insertions(+), 47 deletions(-)

