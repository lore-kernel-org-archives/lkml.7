Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3780C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5E52073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfLBMyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 07:54:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727381AbfLBMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 07:54:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2CnOXa123092
        for <linux-kernel@vger.kernel.org>; Mon, 2 Dec 2019 07:54:44 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6cxc701-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 07:54:44 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Dec 2019 12:54:41 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Dec 2019 12:54:33 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB2CsWXc47251894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 12:54:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E074AE045;
        Mon,  2 Dec 2019 12:54:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4401FAE051;
        Mon,  2 Dec 2019 12:54:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.147.107])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 12:54:28 +0000 (GMT)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-1 tag
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     ajd@linux.ibm.com, alastair@d-silva.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        asteinhauser@google.com, Bjorn Helgaas <bhelgaas@google.com>,
        Qian Cai <cai@lca.pw>, chris.packham@alliedtelesis.co.nz,
        chris.smart@humanservices.gov.au,
        Christophe Leroy <christophe.leroy@c-s.fr>, clg@kaod.org,
        cmr@informatik.wtf, David Hildenbrand <david@redhat.com>,
        debmc@linux.vnet.ibm.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        gwalbon@linux.ibm.com, harish@linux.ibm.com,
        hbathini@linux.ibm.com, Christoph Hellwig <hch@lst.de>,
        krzk@kernel.org, leonardo@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
        madalin.bucur@nxp.com, Mathieu Malaterre <malat@debian.org>,
        msuchanek@suse.de, Nathan Chancellor <natechancellor@gmail.com>,
        nathanl@linux.ibm.com, Nayna Jain <nayna@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, oss@buserror.net,
        ravi.bangoria@linux.ibm.com, Russell Currey <ruscur@russell.cc>,
        sbobroff@linux.ibm.com, thuth@redhat.com, tyreld@linux.ibm.com,
        vaibhav@linux.ibm.com, valentin@longchamp.me, yanaijie@huawei.com,
        YueHaibing <yuehaibing@huawei.com>
Date:   Mon, 02 Dec 2019 07:54:27 -0500
In-Reply-To: <CAHk-=wj-BW=C8mFr5mWEYyjgngLoq2N6PZ-RKtiL7X-e93poHw@mail.gmail.com>
References: <877e3hfxyq.fsf@mpe.ellerman.id.au>
         <CAHk-=wj-BW=C8mFr5mWEYyjgngLoq2N6PZ-RKtiL7X-e93poHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120212-0028-0000-0000-000003C36428
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120212-0029-0000-0000-00002486796C
Message-Id: <1575291267.4793.371.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=865 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-11-30 at 14:42 -0800, Linus Torvalds wrote:
> [ Only tangentially related to the power parts ]
> 
> On Sat, Nov 30, 2019 at 2:41 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > There's some changes in security/integrity as part of the secure boot work. They
> > were all either written by or acked/reviewed by Mimi.
> 
>   -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390)
>   +#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
>   + || defined(CONFIG_PPC_SECURE_BOOT)
> 
> This clearly should be its own CONFIG variable, and be generated by
> having the different architectures just select it.
> 
> IOW, IMA should probably have a
> 
>    config IMA_SECURE_BOOT
> 
> and then s390 would just do the select unconditionally, while x86 and
> ppc would do
> 
>   select IMA_SECURE_BOOT if EFI
> 
> and
> 
>   select IMA_SECURE_BOOT if PPC_SECURE_BOOT
> 
> respectively.
> 
> And then we wouldn't have random architectures adding random "me me me
> tooo!!!" type code.

Agreed, but the naming is a bit off.  The flag somehow needs to take
into account "trusted boot" as well.  On s390, only secure boot is
enabled, at least for the time being.  On x86, both secure and trusted
boot are enabled.  On powerpc, the architecture properly enables
secure and/or trusted boot based on OPAL flags.

It's a bit long, but could the flag be named
IMA_SECURE_AND_OR_TRUSTED_BOOT?

thanks,

Mimi

