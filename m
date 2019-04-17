Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DFFC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE0620693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfDQHr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:47:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbfDQHr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:47:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3H7lJ0G021524
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 03:47:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rwxmnujjx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 03:47:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 17 Apr 2019 08:46:44 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Apr 2019 08:46:40 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3H7kdIP61669394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 07:46:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D338A405C;
        Wed, 17 Apr 2019 07:46:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34B77A4054;
        Wed, 17 Apr 2019 07:46:39 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.37.72])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Apr 2019 07:46:39 +0000 (GMT)
Date:   Wed, 17 Apr 2019 09:46:37 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
        <20190415051919.GA31481@infradead.org>
        <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
        <20190416110906.6c773aff@mschwideX1>
        <20190416140658.2cb73a3f@mschwideX1>
        <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
        <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041707-4275-0000-0000-00000328C1CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041707-4276-0000-0000-00003837F61B
Message-Id: <20190417094637.51ad4c67@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=683 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 09:49:46 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Apr 16, 2019 at 9:16 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > We actually already *have* this function.
> >
> > It's called "gup_fast_permitted()" and it's used by x86-64 to verify
> > the proper address range. Exactly like s390 needs..
> >
> > Could you please use that instead?  
> 
> IOW, something like the attached.
> 
> Obviously untested. And maybe 'current' isn't declared in
> <asm/pgtable.h>, in which case you'd need to modify it to instead make
> the inline function be "s390_gup_fast_permitted()" that takes a
> pointer to the mm, and do something like
> 
>   #define gup_fast_permitted(start, pages) \
>          s390_gup_fast_permitted(current->mm, start, pages)
> 
> instead.
> 
> But I think you get the idea..

Nice, I did not realize that gup_fast_permitted is a platform
override-able function. So that part is doable in arch/s390. But I
spoke to soon, I got my first crash and realized that the common gup code
is not usable as it is. The reason is this e.g. this sequence:

	pgdp = pgd_offset(current->mm, addr);
	pgd_t pgd = READ_ONCE(*pgdp);
	/* some checking on pgd */
	gup_p4d_range(pgd, addr, next, write, pages, nr);

	p4dp = p4d_offset(&pgd, addr);
	p4d_t p4d = READ_ONCE(*p4dp);
	/* some checking on p4d */
	gup_pud_range(p4d, addr, next, write, pages, nr);

	pudp = pud_offset(&p4d, addr);
	pud_t pud = READ_ONCE(*pudp);
	/* some checking on pud */
	gup_pmd_range(pud, addr, next, write, pages, nr;

Each step along the way will read the page table entry and pass the
table entry to the next function. This clashes with the page table
folding on s390. The s390 gup code looks more like this:

	pgdp = pgd_offset(current->mm, addr);
	/* some checking on pgd */
	pgd_t pgd = READ_ONCE(*pgdp);
	gup_p4d_range(pgdp, pgd, addr, next, write, pages, &nr);

	p4dp = p4d_offset(pgdp, addr);
	p4d_t p4d = READ_ONCE(*p4dp);
	/* some checking on p4d */
	gup_pud_range(p4dp, p4d, addr, next, write, pages, nr);

	pudp = pud_offset(p4dp, addr);
	pud_t pud = READ_ONCE(*pudp);
	/* some checking on pud */
	gup_pmd_range(pudp, pud, addr, next, write, pages, nr;

There are magic dereferences in the s390 versions of p4d_offset,
pud_offset and pmd_offset functions. To make this work the pointer
passed to these functions may not be the local copy of the already
dereferenced table entry. I'll cook up a patch for the common code.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

