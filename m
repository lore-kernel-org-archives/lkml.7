Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B0CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F06520869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbfDRVHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:07:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfDRVHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:07:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76AD2307CB3B;
        Thu, 18 Apr 2019 21:07:12 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A564E60BE5;
        Thu, 18 Apr 2019 21:07:04 +0000 (UTC)
Date:   Thu, 18 Apr 2019 17:07:02 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/28] userfaultfd: write protection support
Message-ID: <20190418210702.GN3288@redhat.com>
References: <20190320020642.4000-1-peterx@redhat.com>
 <20190409060839.GE3389@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190409060839.GE3389@xz-x1>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 18 Apr 2019 21:07:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:08:39PM +0800, Peter Xu wrote:
> On Wed, Mar 20, 2019 at 10:06:14AM +0800, Peter Xu wrote:
> > This series implements initial write protection support for
> > userfaultfd.  Currently both shmem and hugetlbfs are not supported
> > yet, but only anonymous memory.  This is the 3nd version of it.
> > 
> > The latest code can also be found at:
> > 
> >   https://github.com/xzpeter/linux/tree/uffd-wp-merged
> > 
> > Note again that the first 5 patches in the series can be seen as
> > isolated work on page fault mechanism.  I would hope that they can be
> > considered to be reviewed/picked even earlier than the rest of the
> > series since it's even useful for existing userfaultfd MISSING case
> > [8].
> 
> Ping - any further comments for v3?  Is there any chance to have this
> series (or the first 5 patches) for 5.2?

Few issues left, sorry for taking so long to get to review, sometimes
it goes to the bottom of my stack.

I am guessing this should be merge through Andrew ? Unless Andrea have
a tree for userfaultfd (i am not following all that closely).

From my point of view it almost all look good. I sent review before
this email. Maybe we need some review from x86 folks on the x86 arch
changes for the feature ?

Cheers,
Jérôme
