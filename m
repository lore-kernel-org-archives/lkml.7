Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0336CC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BEB2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCVVqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:46:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbfCVVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:46:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MLdQe2044098
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 17:46:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rd7dsgwpr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 17:46:32 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 22 Mar 2019 21:46:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 21:46:14 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MLkOpg6226152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 21:46:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BC394C04A;
        Fri, 22 Mar 2019 21:46:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DBD64C040;
        Fri, 22 Mar 2019 21:46:22 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.23])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Mar 2019 21:46:22 +0000 (GMT)
Date:   Fri, 22 Mar 2019 23:46:20 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
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
Subject: Re: [PATCH v3 24/28] userfaultfd: wp: UFFDIO_REGISTER_MODE_WP
 documentation update
References: <20190320020642.4000-1-peterx@redhat.com>
 <20190320020642.4000-25-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320020642.4000-25-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032221-0020-0000-0000-000003268745
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032221-0021-0000-0000-00002178B58C
Message-Id: <20190322214620.GD9303@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:06:38AM +0800, Peter Xu wrote:
> From: Martin Cracauer <cracauer@cons.org>
> 
> Adds documentation about the write protection support.
> 
> Signed-off-by: Martin Cracauer <cracauer@cons.org>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> [peterx: rewrite in rst format; fixups here and there]
> Reviewed-by: Jerome Glisse <jglisse@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 51 ++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 5048cf661a8a..c30176e67900 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -108,6 +108,57 @@ UFFDIO_COPY. They're atomic as in guaranteeing that nothing can see an
>  half copied page since it'll keep userfaulting until the copy has
>  finished.
> 
> +Notes:
> +
> +- If you requested UFFDIO_REGISTER_MODE_MISSING when registering then
> +  you must provide some kind of page in your thread after reading from
> +  the uffd.  You must provide either UFFDIO_COPY or UFFDIO_ZEROPAGE.
> +  The normal behavior of the OS automatically providing a zero page on
> +  an annonymous mmaping is not in place.
> +
> +- None of the page-delivering ioctls default to the range that you
> +  registered with.  You must fill in all fields for the appropriate
> +  ioctl struct including the range.
> +
> +- You get the address of the access that triggered the missing page
> +  event out of a struct uffd_msg that you read in the thread from the
> +  uffd.  You can supply as many pages as you want with UFFDIO_COPY or
> +  UFFDIO_ZEROPAGE.  Keep in mind that unless you used DONTWAKE then
> +  the first of any of those IOCTLs wakes up the faulting thread.
> +
> +- Be sure to test for all errors including (pollfd[0].revents &
> +  POLLERR).  This can happen, e.g. when ranges supplied were
> +  incorrect.
> +
> +Write Protect Notifications
> +---------------------------
> +
> +This is equivalent to (but faster than) using mprotect and a SIGSEGV
> +signal handler.
> +
> +Firstly you need to register a range with UFFDIO_REGISTER_MODE_WP.
> +Instead of using mprotect(2) you use ioctl(uffd, UFFDIO_WRITEPROTECT,
> +struct *uffdio_writeprotect) while mode = UFFDIO_WRITEPROTECT_MODE_WP
> +in the struct passed in.  The range does not default to and does not
> +have to be identical to the range you registered with.  You can write
> +protect as many ranges as you like (inside the registered range).
> +Then, in the thread reading from uffd the struct will have
> +msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP set. Now you send
> +ioctl(uffd, UFFDIO_WRITEPROTECT, struct *uffdio_writeprotect) again
> +while pagefault.mode does not have UFFDIO_WRITEPROTECT_MODE_WP set.
> +This wakes up the thread which will continue to run with writes. This
> +allows you to do the bookkeeping about the write in the uffd reading
> +thread before the ioctl.
> +
> +If you registered with both UFFDIO_REGISTER_MODE_MISSING and
> +UFFDIO_REGISTER_MODE_WP then you need to think about the sequence in
> +which you supply a page and undo write protect.  Note that there is a
> +difference between writes into a WP area and into a !WP area.  The
> +former will have UFFD_PAGEFAULT_FLAG_WP set, the latter
> +UFFD_PAGEFAULT_FLAG_WRITE.  The latter did not fail on protection but
> +you still need to supply a page when UFFDIO_REGISTER_MODE_MISSING was
> +used.
> +
>  QEMU/KVM
>  ========
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

