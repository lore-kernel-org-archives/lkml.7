Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F8C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D70A2190F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfJBIWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:22:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbfJBIWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:22:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x928HFfr046392
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 04:22:06 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vckpcyqf2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 04:22:06 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 2 Oct 2019 09:22:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 09:22:01 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x928LxqH46006398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Oct 2019 08:21:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74E6B5204F;
        Wed,  2 Oct 2019 08:21:59 +0000 (GMT)
Received: from osiris (unknown [9.152.212.201])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 24DF152050;
        Wed,  2 Oct 2019 08:21:59 +0000 (GMT)
Date:   Wed, 2 Oct 2019 10:21:57 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
 <20191002064605.GA7405@osiris>
 <20191002070333.GE24815@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002070333.GE24815@unicorn.suse.cz>
X-TM-AS-GCONF: 00
x-cbid: 19100208-0028-0000-0000-000003A53F58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100208-0029-0000-0000-00002467419C
Message-Id: <20191002082157.GA9535@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=926 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910020079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 09:03:33AM +0200, Michal Kubecek wrote:
> On Wed, Oct 02, 2019 at 08:46:05AM +0200, Heiko Carstens wrote:
> > On Tue, Oct 01, 2019 at 10:08:01PM +0200, Jiri Kosina wrote:
> > > 
> > >    In file included from arch/s390/kvm/kvm-s390.c:44:
> > >    ./arch/s390/include/asm/cpacf.h: In function '__cpacf_query':
> > >    ./arch/s390/include/asm/cpacf.h:179:2: warning: asm operand 3 probably doesn't match constraints
> > >      179 |  asm volatile(
> > >          |  ^~~
> > >    ./arch/s390/include/asm/cpacf.h:179:2: error: impossible constraint in 'asm'
> > > 
> > > ...
> > > 
> > > I am wondering how is it possible that none of the build-testing 
> > > infrastructure we have running against linux-next caught this? Not enough 
> > > non-x86 coverage?
> > 
> > Well, there is plenty of s390 coverage with respect to daily builds
> > (also here). It doesn't fail for me with gcc 9.1; so you may either
> > have a different gcc version or different config options(?) so the
> > compiler decided to not inline the function.
> 
> I think I found the reason: we only hit the build failure with one
> special config used for zfcpdump which has
> 
>   CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> 
> When I switched to CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y (which we have
> in other s390x configs and which most people probably prefer), the build
> does not fail even without the patch.

Yes, with CONFIG_CC_OPTIMIZE_FOR_SIZE=y I can see plenty of _additional_
compile failures on s390 with "defconfig". Will fix them all...

Thanks for reporting!

