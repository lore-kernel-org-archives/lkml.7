Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE33DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DF0213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfCTMhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:37:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727612AbfCTMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:37:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KCRtmK101173
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:37:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbkgcfb9d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:37:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 20 Mar 2019 12:37:00 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 12:36:57 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2KCb17843581486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 12:37:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 368A4A4055;
        Wed, 20 Mar 2019 12:37:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C66A404D;
        Wed, 20 Mar 2019 12:37:00 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Mar 2019 12:37:00 +0000 (GMT)
Date:   Wed, 20 Mar 2019 14:36:58 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320111959.GV19508@bombadil.infradead.org>
 <20190320122011.stuoqugpjdt3d7cd@d104.suse.de>
 <20190320122243.GX19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320122243.GX19508@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032012-0008-0000-0000-000002CF88EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032012-0009-0000-0000-0000223BA054
Message-Id: <20190320123658.GF13626@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 05:22:43AM -0700, Matthew Wilcox wrote:
> On Wed, Mar 20, 2019 at 01:20:15PM +0100, Oscar Salvador wrote:
> > On Wed, Mar 20, 2019 at 04:19:59AM -0700, Matthew Wilcox wrote:
> > > On Wed, Mar 20, 2019 at 03:35:38PM +0800, Baoquan He wrote:
> > > >  /*
> > > > - * returns the number of sections whose mem_maps were properly
> > > > - * set.  If this is <=0, then that means that the passed-in
> > > > - * map was not consumed and must be freed.
> > > > + * sparse_add_one_section - add a memory section
> > > > + * @nid:	The node to add section on
> > > > + * @start_pfn:	start pfn of the memory range
> > > > + * @altmap:	device page map
> > > > + *
> > > > + * Return 0 on success and an appropriate error code otherwise.
> > > >   */
> > > 
> > > I think it's worth documenting what those error codes are.  Seems to be
> > > just -ENOMEM and -EEXIST, but it'd be nice for users to know what they
> > > can expect under which circumstances.
> > > 
> > > Also, -EEXIST is a bad errno to return here:
> > > 
> > > $ errno EEXIST
> > > EEXIST 17 File exists
> > > 
> > > What file?  I think we should be using -EBUSY instead in case this errno
> > > makes it back to userspace:
> > > 
> > > $ errno EBUSY
> > > EBUSY 16 Device or resource busy
> > 
> > We return -EEXIST in case the section we are trying to add is already
> > there, and that error is being caught by __add_pages(), which ignores the
> > error in case is -EXIST and keeps going with further sections.
> > 
> > Sure we can change that for -EBUSY, but I think -EEXIST makes more sense,
> > plus that kind of error is never handed back to userspace.
> 
> Not returned to userspace today.  It's also bad precedent for other parts
> of the kernel where errnos do get returned to userspace.

There are more than a thousand -EEXIST in the kernel, I really doubt all of
them mean "File exists" ;-)

-- 
Sincerely yours,
Mike.

