Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6C6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E86C20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfDJKdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:33:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730501AbfDJKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:33:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AATmmT140209
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:33:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsdyd2hg5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:33:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 10 Apr 2019 11:33:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Apr 2019 11:33:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3AAX0hs55705774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 10:33:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A0D1A404D;
        Wed, 10 Apr 2019 10:33:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB310A4040;
        Wed, 10 Apr 2019 10:32:59 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.148])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Apr 2019 10:32:59 +0000 (GMT)
Date:   Wed, 10 Apr 2019 12:32:58 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>, libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: Re: rseq/s390: choosing code signature
In-Reply-To: <1779981820.2626.1554838342731.JavaMail.zimbra@efficios.com>
References: <1779981820.2626.1554838342731.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041010-0028-0000-0000-0000035F450D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041010-0029-0000-0000-0000241E66E3
Message-Id: <20190410123258.37f182cf@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 15:32:22 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Hi,
> 
> We are about to include the code signature required prior to restartable
> sequences abort handlers into glibc, which will make this ABI choice final.
> We need architecture maintainer input on that signature value.
> 
> That code signature is placed before each abort handler, so the kernel can
> validate that it is indeed jumping to an abort handler (and not some
> arbitrary attacker-chosen code). The signature is never executed.
> 
> The current discussion thread on the glibc mailing list leads us towards
> using a trap with uncommon immediate operand, which simplifies integration
> with disassemblers, emulators, makes it easier to debug if the control
> flow gets redirected there by mistake, and is nicer for some architecture's
> speculative execution.
> 
> We can have different signatures for each sub-architecture, as long as they
> don't have to co-exist within the same process. We can special-case with
> #ifdef for each sub-architecture and endianness if need be. If the architecture
> has instruction set extensions that can co-exist with the architecture
> instruction set within the same process, we need to take into account to which
> instruction the chosen signature value would map (and possibly decide if we
> need to extend rseq to support many signatures).
> 
> Here is an example of rseq signature definition template:
> 
> /*
>  * TODO: document trap instruction objdump output on each sub-architecture
>  * instruction sets, as well as instruction set extensions.
>  */
> #define RSEQ_SIG 0x########
> 
> Ideally we'd need a patch on top of the Linux kernel
> tools/testing/selftests/rseq/rseq-s390.h file that updates
> the signature value, so I can then pick it up for the glibc
> patchset.

The trap4 instruction is a suitable one. The patch would look like this
--
commit 2ee28f6d1de968a71f074ab150384b90b4121216
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Wed Apr 10 12:28:41 2019 +0200

    s390/rseq: use trap4 for RSEQ_SIG
    
    Use trap4 as the guard instruction for the restartable sequence abort
    handler.
    
    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 1069e85258ce..d4c8e1147d86 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
+ * access-register mode nor the linkage stack this instruction will always
+ * cause a special-operation exception (the trap-enabled bit in the DUCT
+ * is and will stay 0). The instruction pattern is
+ *	b2 ff 0f ff	trap4   4095(%r0)
+ */
+#define RSEQ_SIG	0xB2FF0FFF
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("bcr 15,0" ::: "memory")
 #define rseq_smp_rmb()	rseq_smp_mb()
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

