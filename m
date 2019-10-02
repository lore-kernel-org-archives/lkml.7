Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A70C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24472070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfJBGqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 02:46:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726150AbfJBGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 02:46:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x926gxjx026617
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 02:46:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vckptmywa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:46:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 2 Oct 2019 07:46:13 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 07:46:09 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x926k7io55902332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Oct 2019 06:46:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 739E752050;
        Wed,  2 Oct 2019 06:46:07 +0000 (GMT)
Received: from osiris (unknown [9.152.212.201])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 257275204E;
        Wed,  2 Oct 2019 06:46:07 +0000 (GMT)
Date:   Wed, 2 Oct 2019 08:46:05 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
X-TM-AS-GCONF: 00
x-cbid: 19100206-4275-0000-0000-0000036D3BA5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100206-4276-0000-0000-000038803D26
Message-Id: <20191002064605.GA7405@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910020062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 10:08:01PM +0200, Jiri Kosina wrote:
> arch/s390/kvm/kvm-s390.c calls on several places __cpacf_query() directly, 
> which makes it impossible to meet the "i" constraint for the asm operands 
> (opcode in this case).
> 
> As we are now force-enabling CONFIG_OPTIMIZE_INLINING on all 
> architectures, this causes a build failure on s390:
> 
>    In file included from arch/s390/kvm/kvm-s390.c:44:
>    ./arch/s390/include/asm/cpacf.h: In function '__cpacf_query':
>    ./arch/s390/include/asm/cpacf.h:179:2: warning: asm operand 3 probably doesn't match constraints
>      179 |  asm volatile(
>          |  ^~~
>    ./arch/s390/include/asm/cpacf.h:179:2: error: impossible constraint in 'asm'
> 
> Mark __cpacf_query() as __always_inline in order to fix that, analogically 
> how we fixes __cpacf_check_opcode(), cpacf_query_func() and scpacf_query() 
> already.
> 
> Reported-and-tested-by: Michal Kubecek <mkubecek@suse.cz>
> Fixes: d83623c5eab2 ("s390: mark __cpacf_check_opcode() and cpacf_query_func() as __always_inline")
> Fixes: e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> Fixes: ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
> I am wondering how is it possible that none of the build-testing 
> infrastructure we have running against linux-next caught this? Not enough 
> non-x86 coverage?

Well, there is plenty of s390 coverage with respect to daily builds
(also here). It doesn't fail for me with gcc 9.1; so you may either
have a different gcc version or different config options(?) so the
compiler decided to not inline the function. I'll apply this in any
case, since your patch is obviously fine.

Thanks!

>  arch/s390/include/asm/cpacf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index a092f63aac6a..c0f3bfeddcbe 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
> @@ -171,7 +171,7 @@ typedef struct { unsigned char bytes[16]; } cpacf_mask_t;
>   *
>   * Returns 1 if @func is available for @opcode, 0 otherwise
>   */
> -static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
> +static __always_inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
>  {
>  	register unsigned long r0 asm("0") = 0;	/* query function */
>  	register unsigned long r1 asm("1") = (unsigned long) mask;
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

