Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC83DC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9238271D9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFAKVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 06:21:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbfFAKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 06:21:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x51AHFmL075049
        for <linux-kernel@vger.kernel.org>; Sat, 1 Jun 2019 06:21:43 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sundnk89y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 06:21:43 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 1 Jun 2019 11:21:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 1 Jun 2019 11:21:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x51ALcqd47317076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Jun 2019 10:21:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E27EA4040;
        Sat,  1 Jun 2019 10:21:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73F6DA404D;
        Sat,  1 Jun 2019 10:21:38 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  1 Jun 2019 10:21:38 +0000 (GMT)
Date:   Sat, 1 Jun 2019 12:21:37 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] s390: drop unneeded -Wall addition from tools
 Makefile
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
 <20190517075428.13496-2-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517075428.13496-2-yamada.masahiro@socionext.com>
X-TM-AS-GCONF: 00
x-cbid: 19060110-4275-0000-0000-0000033ADF71
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060110-4276-0000-0000-0000384AE671
Message-Id: <20190601102137.GC3600@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906010076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 04:54:25PM +0900, Masahiro Yamada wrote:
> The top level Makefile adds -Wall globally for all host tools:
> 
>   KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
> 
> I see two "-Wall" added for compiling these tools.
> 
> Of course, it is allowed to pass the same option multiple times, but
> we do not need to do so.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/tools/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
> index 4ff6a2124522..8fb66c99840a 100644
> --- a/arch/s390/tools/Makefile
> +++ b/arch/s390/tools/Makefile
> @@ -14,8 +14,7 @@ kapi:	$(kapi-hdrs-y)
>  hostprogs-y		    += gen_facilities
>  hostprogs-y		    += gen_opcode_table
> 
> -HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
> -HOSTCFLAGS_gen_opcode_table.o += -Wall
> +HOSTCFLAGS_gen_facilities.o += $(LINUXINCLUDE)

Applied, thanks.

