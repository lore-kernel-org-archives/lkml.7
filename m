Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FDEC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EBE214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfDRIC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:02:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729497AbfDRIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:02:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I80EvK033029
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:02:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rxm5s3fcj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:02:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 18 Apr 2019 09:02:25 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Apr 2019 09:02:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3I82KMu56492212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 08:02:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22ABA11C04A;
        Thu, 18 Apr 2019 08:02:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D34BE11C06C;
        Thu, 18 Apr 2019 08:02:19 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.14.146])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Apr 2019 08:02:19 +0000 (GMT)
Date:   Thu, 18 Apr 2019 10:02:18 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
        <20190415051919.GA31481@infradead.org>
        <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
        <20190416110906.6c773aff@mschwideX1>
        <20190416140658.2cb73a3f@mschwideX1>
        <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
        <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
        <20190417094637.51ad4c67@mschwideX1>
        <20190417100244.42e29736@mschwideX1>
        <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041808-0020-0000-0000-0000033120ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041808-0021-0000-0000-000021836FBD
Message-Id: <20190418100218.0a4afd51@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=802 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904180056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 09:57:01 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Apr 17, 2019 at 1:02 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > Grumpf, that does *not* work. For gup the table entries may be read only
> > once. Now I remember why I open-coded p4d_offset, pud_offset and pmd_offset
> > in arch/s390/mm/gup.c, to avoid to read the table entries twice.
> > It will be hard to use the common gup code after all.  
> 
> Hmm. The common gup code generally should do the "read only once"
> thing too (since by definition the gup-fast case is done without
> locking), although it's probably the case that most architectures
> simply don't care.
> 
> What would it require for the generic code to work for s390?

The problematic lines in the generic gup code are these three:

1845:	pmdp = pmd_offset(&pud, addr);
1888:	pudp = pud_offset(&p4d, addr);
1916:	p4dp = p4d_offset(&pgd, addr);

Passing the pointer of a *copy* of a page table entry to pxd_offset() does
not work with the page table folding on s390. The pxd_offset() function
on s390 have to make a choice, either return the dereferenced value behind
the passed pointer (that works) or return the original page table pointer
if the table level is folded (that does not work).

To fix this we would need three new helpers pmd_offset_orig, pud_offset_orig
and p4d_offset_orig, their generic definition would look like this:

#define p4d_offset_orig(pgdp, pgd, address)    p4d_offset(&pgd, address)
#define pud_offset_orig(p4dp, p4d, address)    pud_offset(&p4d, address)
#define pmd_offset_orig(pudp, pud, address)    pmd_offset(&pud, address)

For the s390 definition see the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git generic-gup

A quick test with this branch shows everything working normally.
Keeping my fingers crossed that I did not miss anything.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

