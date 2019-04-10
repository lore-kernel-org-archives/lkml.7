Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BED320830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfDJN4W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:56:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731999AbfDJN4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:56:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ADuHuN116512
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:56:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rsgv8b9kn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:56:19 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 10 Apr 2019 14:55:19 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Apr 2019 14:55:16 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3ADtFTb52625592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 13:55:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4533D11C04A;
        Wed, 10 Apr 2019 13:55:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E963E11C050;
        Wed, 10 Apr 2019 13:55:14 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.148])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Apr 2019 13:55:14 +0000 (GMT)
Date:   Wed, 10 Apr 2019 15:55:13 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] [PROBABLY WRONG] s390: void '0' constraint in
 inline assembly
In-Reply-To: <20190408212648.2407234-12-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-12-arnd@arndb.de>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19041013-0020-0000-0000-0000032E57D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041013-0021-0000-0000-00002180831D
Message-Id: <20190410155513.1609f1a1@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Apr 2019 23:26:25 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> clang does not understand the contraint "0" in the CALL_ON_STACK()
> macro:
> 
> ../arch/s390/mm/maccess.c:117:10: error: invalid input constraint '0' in asm
>                 return CALL_ON_STACK(_memcpy_real, S390_lowcore.nodat_stack,
>                        ^
> ../arch/s390/include/asm/processor.h:292:20: note: expanded from macro 'CALL_ON_STACK'
>                   [_fn] "X" (fn) CALL_FMT_##nr : CALL_CLOBBER_##nr);    \
>                                  ^
> <scratch space>:207:1: note: expanded from here
> CALL_FMT_3
> ^
> ../arch/s390/include/asm/processor.h:267:20: note: expanded from macro 'CALL_FMT_3'
>  #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
>                    ^
> ../arch/s390/include/asm/processor.h:266:20: note: expanded from macro 'CALL_FMT_2'
>  #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
>                    ^
> ../arch/s390/include/asm/processor.h:265:32: note: expanded from macro 'CALL_FMT_1'
>  #define CALL_FMT_1 CALL_FMT_0, "0" (r2)
>                                ^
> 
> I don't know what the correct fix here would be, changing it to "d" made
> it build, since clang does understand this one.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/processor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> index 700c650ffd4f..84c59c99668a 100644
> --- a/arch/s390/include/asm/processor.h
> +++ b/arch/s390/include/asm/processor.h
> @@ -262,7 +262,7 @@ static __no_kasan_or_inline unsigned short stap(void)
>  	register unsigned long r4 asm("6") = (unsigned long)(arg5)
> 
>  #define CALL_FMT_0
> -#define CALL_FMT_1 CALL_FMT_0, "0" (r2)
> +#define CALL_FMT_1 CALL_FMT_0, "d" (r2)
>  #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
>  #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
>  #define CALL_FMT_4 CALL_FMT_3, "d" (r5)

This is (slightly) wrong. %r2 is used as the input register for the first argument
and the result value for the call. With your patch you force the compiler to load
the first argument in two registers. One solution would be to CALL_FMT1 as

	#define CALL_FMT1 CALL_FMT_0

It still is not optimal though as for CALL_FMT_0 the "+&d" (r2) indicates an
input but CALL_ARGS_0 does not initialize r2.

I am thinking about the following patch to cover all cases:
--
From 91a4abbec91a9f26f84f7386f2c0f96de669b0eb Mon Sep 17 00:00:00 2001
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 10 Apr 2019 15:48:43 +0200
Subject: [PATCH] s390: fine-tune stack switch helper

The CALL_ON_STACK helper currently does not work with clang and for
calls without arguments it does not initialize r2 although the contraint
is "+&d". Rework the CALL_FMT_x and the CALL_ON_STACK macros to work
with clang and produce optimal code in all cases.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 81038ab357ce..0ee022247580 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -261,12 +261,12 @@ static __no_kasan_or_inline unsigned short stap(void)
 	CALL_ARGS_4(arg1, arg2, arg3, arg4);				\
 	register unsigned long r4 asm("6") = (unsigned long)(arg5)
 
-#define CALL_FMT_0
-#define CALL_FMT_1 CALL_FMT_0, "0" (r2)
-#define CALL_FMT_2 CALL_FMT_1, "d" (r3)
-#define CALL_FMT_3 CALL_FMT_2, "d" (r4)
-#define CALL_FMT_4 CALL_FMT_3, "d" (r5)
-#define CALL_FMT_5 CALL_FMT_4, "d" (r6)
+#define CALL_FMT_0 "=&d" (r2) :
+#define CALL_FMT_1 "+&d" (r2) :
+#define CALL_FMT_2 CALL_FMT_1 "d" (r3),
+#define CALL_FMT_3 CALL_FMT_2 "d" (r4),
+#define CALL_FMT_4 CALL_FMT_3 "d" (r5),
+#define CALL_FMT_5 CALL_FMT_4 "d" (r6),
 
 #define CALL_CLOBBER_5 "0", "1", "14", "cc", "memory"
 #define CALL_CLOBBER_4 CALL_CLOBBER_5
@@ -286,10 +286,10 @@ static __no_kasan_or_inline unsigned short stap(void)
 		"	stg	%[_prev],%[_bc](15)\n"			\
 		"	brasl	14,%[_fn]\n"				\
 		"	la	15,0(%[_prev])\n"			\
-		: "+&d" (r2), [_prev] "=&a" (prev)			\
-		: [_stack] "a" (stack),					\
+		: [_prev] "=&a" (prev), CALL_FMT_##nr			\
+		  [_stack] "a" (stack),					\
 		  [_bc] "i" (offsetof(struct stack_frame, back_chain)),	\
-		  [_fn] "X" (fn) CALL_FMT_##nr : CALL_CLOBBER_##nr);	\
+		  [_fn] "X" (fn) : CALL_CLOBBER_##nr);			\
 	r2;								\
 })
 
-- 
2.16.4
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

