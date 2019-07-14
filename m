Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACB5C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B042063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfGNOfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 10:35:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728146AbfGNOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:35:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6EEWdKC185230
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 10:35:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tqvnpqpw0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 10:35:42 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sun, 14 Jul 2019 15:35:40 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 14 Jul 2019 15:35:37 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6EEZaQ035389884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Jul 2019 14:35:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AF71AE04D;
        Sun, 14 Jul 2019 14:35:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C0E6AE045;
        Sun, 14 Jul 2019 14:35:35 +0000 (GMT)
Received: from localhost (unknown [9.145.65.183])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 14 Jul 2019 14:35:35 +0000 (GMT)
Date:   Sun, 14 Jul 2019 16:35:33 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Petr Tesarik <ptesarik@suse.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] s390: add Linux banner to the compressed image
References: <cover.1562950641.git.ptesarik@suse.com>
 <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
X-TM-AS-GCONF: 00
x-cbid: 19071414-0020-0000-0000-000003537F01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071414-0021-0000-0000-000021A741FD
Message-Id: <your-ad-here.call-01563114933-ext-9422@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907140180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 07:21:01PM +0200, Petr Tesarik wrote:
> Various tools determine the kernel version from a given binary by
> scanning for the Linux banner string. This does not work if the
> banner string is compressed, but we can link it once more into the
> uncompressed portion of bzImage.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  arch/s390/boot/compressed/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
> index fa529c5b4486..9bc4685477c5 100644
> --- a/arch/s390/boot/compressed/Makefile
> +++ b/arch/s390/boot/compressed/Makefile
> @@ -11,6 +11,7 @@ UBSAN_SANITIZE := n
>  KASAN_SANITIZE := n
>  
>  obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) piggy.o info.o
> +obj-y   += ../../../../init/banner.o

We don't reuse objects from another build stage, we rebuild them with
distinct decompressor's build flags.
$ git grep "ctype.[oc]" -- arch/s390/boot
arch/s390/boot/Makefile:obj-y   += ctype.o text_dma.o
arch/s390/boot/ctype.c:#include "../../../lib/ctype.c"

Besides that, there is a special CONFIG_KERNEL_UNCOMPRESSED mode, with
which "strings vmlinuz | grep 'Linux version'" I assume you are using
would still yield result. Adding the second version of banner would
produce duplicated result in this case.

But even before discussing solutions I would like to understand the
problem first. Which specific tools are you referring to? What are they
good for? And how do they get the kernel version from other architectures
compressed images?

