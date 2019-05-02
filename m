Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2974BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0117A2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEBPLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:11:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbfEBPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:11:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42F7WYO067791
        for <linux-kernel@vger.kernel.org>; Thu, 2 May 2019 11:11:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s81j5vk94-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:11:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 2 May 2019 16:11:00 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 16:10:57 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42FAuLs21954804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 15:10:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C94CFA4053;
        Thu,  2 May 2019 15:10:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F9A0A4051;
        Thu,  2 May 2019 15:10:56 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.60])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 15:10:56 +0000 (GMT)
Date:   Thu, 2 May 2019 17:10:55 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190502143110.GC17577@kroah.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
        <20190415051919.GA31481@infradead.org>
        <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
        <20190502122128.GA2670@kroah.com>
        <20190502161758.26972bb2@mschwideX1>
        <20190502143110.GC17577@kroah.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050215-0020-0000-0000-0000033897C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050215-0021-0000-0000-0000218B205B
Message-Id: <20190502171055.132f023c@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=931 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2019 16:31:10 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, May 02, 2019 at 04:17:58PM +0200, Martin Schwidefsky wrote:
> > On Thu, 2 May 2019 14:21:28 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Mon, Apr 15, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:  
> > > > On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:    
> > > > >
> > > > > Can we please have the page refcount overflow fixes out on the list
> > > > > for review, even if it is after the fact?    
> > > > 
> > > > They were actually on a list for review long before the fact, but it
> > > > was the security mailing list. The issue actually got discussed back
> > > > in January along with early versions of the patches, but then we
> > > > dropped the ball because it just wasn't on anybody's radar and it got
> > > > resurrected late March. Willy wrote a rather bigger patch-series, and
> > > > review of that is what then resulted in those commits. So they may
> > > > look recent, but that's just because the original patches got
> > > > seriously edited down and rewritten.
> > > > 
> > > > That said, powerpc and s390 should at least look at maybe adding a
> > > > check for the page ref in their gup paths too. Powerpc has the special
> > > > gup_hugepte() case, and s390 has its own version of gup entirely. I
> > > > was actually hoping the s390 guys would look at using the generic gup
> > > > code.
> > > > 
> > > > I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
> > > > largely irrelevant, partly since even theoretically this whole issue
> > > > needs a _lot_ of memory.
> > > > 
> > > > Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
> > > > (page ref overflow)"). You may or may not really care.    
> > > 
> > > I've now queued these patches up for the next round of stable releases,
> > > as some people seem to care about these.
> > > 
> > > I didn't see any follow-on patches for s390 or ppc64 hit the tree for
> > > these changes, am I just missing them and should also queue up a few
> > > more to handle this issue on those platforms?  
> > 
> > I fixed that with a different approach. The following two patches are
> > queued for the next merge window:
> > 
> > d1874a0c2805 "s390/mm: make the pxd_offset functions more robust"
> > 1a42010cdc26 "s390/mm: convert to the generic get_user_pages_fast code"
> > 
> > With these two s390 now uses the generic gup code in mm/gup.c  
> 
> Nice!  Do you want me to queue those up for the stable backports once
> they hit a public -rc release?

Yes please!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

