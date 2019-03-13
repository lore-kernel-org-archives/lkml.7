Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B067C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463DA20643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCMSdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:33:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfCMSdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63F14C04AC51;
        Wed, 13 Mar 2019 18:33:38 +0000 (UTC)
Received: from redhat.com (ovpn-125-95.rdu2.redhat.com [10.10.125.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00A235C280;
        Wed, 13 Mar 2019 18:33:36 +0000 (UTC)
Date:   Wed, 13 Mar 2019 14:33:35 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-ID: <20190313183245.GA4651@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 13 Mar 2019 18:33:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:10:04AM -0700, Andrew Morton wrote:
> On Tue, 12 Mar 2019 21:27:06 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> 
> > Andrew you will not be pushing this patchset in 5.1 ?
> 
> I'd like to.  It sounds like we're converging on a plan.
> 
> It would be good to hear more from the driver developers who will be
> consuming these new features - links to patchsets, review feedback,
> etc.  Which individuals should we be asking?  Felix, Christian and
> Jason, perhaps?
> 

Adding Ben as nouveau maintainer. Note that this patchset only add
2 new function the rest is just refactoring to allow RDMA ODP. The
2 news functions will both be use by ODP and nouveau. Ben this is
the dma map function we discuss previously. If they get in 5.1 then
i will push there user in nouveau at least in 5.2. I will soon repost
ODP v2 patchset on top of RDMA tree so if this does not get in 5.1
then ODP will have to be push to 5.3 or to when this get upstream.

Cheers,
Jérôme
