Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B178C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC86214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfFHLWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:22:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfFHLWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:22:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58BLj2I010209
        for <linux-kernel@vger.kernel.org>; Sat, 8 Jun 2019 07:21:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t090r4v66-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 07:21:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 8 Jun 2019 12:21:57 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Jun 2019 12:21:54 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x58BLllv28377402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jun 2019 11:21:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4870252050;
        Sat,  8 Jun 2019 11:21:53 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 12F055204E;
        Sat,  8 Jun 2019 11:21:53 +0000 (GMT)
Date:   Sat, 8 Jun 2019 13:21:51 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.2-rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19060811-4275-0000-0000-00000340825E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060811-4276-0000-0000-000038508C42
Message-Id: <20190608112151.GA8766@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=971 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906080088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull two bug fixes for s390.

Thanks,
Heiko

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-4

for you to fetch changes up to 0ab0d7ac2090eae30f1c0b01ae981bb7a368f598:

  s390/unwind: correct stack switching during unwind (2019-06-07 15:20:44 +0200)

----------------------------------------------------------------
s390 updates for 5.2-rc4

 - fix stack unwinder: the stack unwinder rework has on off-by-one bug
   which prevents following stack backchains over more than one
   context (e.g. irq -> process).

 - fix address space detection in exception handler: if user space
   switches to access register mode, which is not supported anymore,
   the exception handler may resolve to the wrong address space.

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/mm: fix address space detection in exception handling

Vasily Gorbik (1):
      s390/unwind: correct stack switching during unwind

 arch/s390/include/asm/stacktrace.h | 2 +-
 arch/s390/mm/fault.c               | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 49634bf..0ae4bbf7 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -30,7 +30,7 @@ static inline bool on_stack(struct stack_info *info,
 		return false;
 	if (addr + len < addr)
 		return false;
-	return addr >= info->begin && addr + len < info->end;
+	return addr >= info->begin && addr + len <= info->end;
 }
 
 static inline unsigned long get_stack_pointer(struct task_struct *task,
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 91ce03f..df75d57 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -83,7 +83,6 @@ static inline int notify_page_fault(struct pt_regs *regs)
 
 /*
  * Find out which address space caused the exception.
- * Access register mode is impossible, ignore space == 3.
  */
 static enum fault_type get_fault_type(struct pt_regs *regs)
 {
@@ -108,6 +107,10 @@ static enum fault_type get_fault_type(struct pt_regs *regs)
 		}
 		return VDSO_FAULT;
 	}
+	if (trans_exc_code == 1) {
+		/* access register mode, not used in the kernel */
+		return USER_FAULT;
+	}
 	/* home space exception -> access via kernel ASCE */
 	return KERNEL_FAULT;
 }

