Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C29C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4511D214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbfDRSlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:41:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389775AbfDRSly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:41:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3IIdxFB064985
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:41:53 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rxws3trfu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:41:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 18 Apr 2019 19:41:51 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Apr 2019 19:41:47 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3IIfkDX17105016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 18:41:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9400F4C046;
        Thu, 18 Apr 2019 18:41:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 487104C044;
        Thu, 18 Apr 2019 18:41:46 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.14.175])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Apr 2019 18:41:46 +0000 (GMT)
Date:   Thu, 18 Apr 2019 20:41:44 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
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
        <20190418100218.0a4afd51@mschwideX1>
        <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041818-4275-0000-0000-000003295EA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041818-4276-0000-0000-0000383898F1
Message-Id: <20190418204144.16adf2a0@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=722 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904180115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 08:49:32 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Apr 18, 2019 at 1:02 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > The problematic lines in the generic gup code are these three:
> >
> > 1845:   pmdp = pmd_offset(&pud, addr);
> > 1888:   pudp = pud_offset(&p4d, addr);
> > 1916:   p4dp = p4d_offset(&pgd, addr);
> >
> > Passing the pointer of a *copy* of a page table entry to pxd_offset() does
> > not work with the page table folding on s390.  
> 
> Hmm. I wonder why. x86 too does the folding thing for the p4d and pud case.
> 
> The folding works with the local copy just the same way it works with
> the orignal value.

The difference is that with the static page table folding pgd_offset()
does the index calculation of the actual hardware top-level table. With
dynamic page table folding as s390 is doing it, if the task does not use
a 5-level page table pgd_offset() will see a pgd_index() of 0, the indexing
of the actual top-level table is done later with p4d_offset(), pud_offset()
or pmd_offset(). 

As an example, with a three level page table we have three indexes x/y/z.
The common code "thinks" 5 indexing steps, with static folding the index
sequence is x 0 0 y z. With dynamic folding the sequence is 0 0 x y z.
By moving the first indexing operation to pgd_offset the static sequence
does not add an index to a non-dereferenced pointer to a stack variable,
the dynamic sequence does.

> But I see that s390 does some other kind of folding and does that
> addition of the p*d_index() unconditionally.
> 
> I guess that does mean that s390 will just have to have its own walker.
> 
> For the issue of the page refcount overflow it really isn't a huge
> deal. Adding the refcount checking is simple (see the example patch I
> gave for powerpc - you'll just have a couple of extra cases since you
> do it all, rather than just the special hugetlb cases).
> 
> Obviously in general it would have been nicer to share as much code as
> possible, but let's not make things unnecessarily complex if s390 is
> just fundamentally different..

It would have been nice to use the generic code (less bugs) but not at
the price of over-complicating things. And that page table folding thing
always makes my head hurt.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

