Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 00:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62120881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 00:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLBAHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 19:07:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727266AbfLBAHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 19:07:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB202HVf017837;
        Sun, 1 Dec 2019 19:06:23 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6s4dnbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Dec 2019 19:06:23 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xB203gXj021217;
        Sun, 1 Dec 2019 19:06:23 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6s4dnay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Dec 2019 19:06:22 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB2054Vo028893;
        Mon, 2 Dec 2019 00:06:21 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2wkg261e9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 00:06:21 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB206JH152429162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 00:06:19 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 628D16A047;
        Mon,  2 Dec 2019 00:06:19 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 826696A057;
        Mon,  2 Dec 2019 00:06:08 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.75.73])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 00:06:08 +0000 (GMT)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-1 tag
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>
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
References: <877e3hfxyq.fsf@mpe.ellerman.id.au>
 <CAHk-=wj-BW=C8mFr5mWEYyjgngLoq2N6PZ-RKtiL7X-e93poHw@mail.gmail.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <b71e214d-6578-cead-6824-852e99e0edf9@linux.vnet.ibm.com>
Date:   Sun, 1 Dec 2019 19:06:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj-BW=C8mFr5mWEYyjgngLoq2N6PZ-RKtiL7X-e93poHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-01_04:2019-11-29,2019-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=688 suspectscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912010217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/30/19 5:42 PM, Linus Torvalds wrote:
> [ Only tangentially related to the power parts ]
>
> On Sat, Nov 30, 2019 at 2:41 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> There's some changes in security/integrity as part of the secure boot work. They
>> were all either written by or acked/reviewed by Mimi.
>    -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390)
>    +#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
>    + || defined(CONFIG_PPC_SECURE_BOOT)
>
> This clearly should be its own CONFIG variable, and be generated by
> having the different architectures just select it.
>
> IOW, IMA should probably have a
>
>     config IMA_SECURE_BOOT
>
> and then s390 would just do the select unconditionally, while x86 and
> ppc would do
>
>    select IMA_SECURE_BOOT if EFI
>
> and
>
>    select IMA_SECURE_BOOT if PPC_SECURE_BOOT
>
> respectively.
>
> And then we wouldn't have random architectures adding random "me me me
> tooo!!!" type code.


Thanks Linus for your feedback. I will do the patch for Kconfig cleanup.

Thanks & Regards,

        - Nayna

