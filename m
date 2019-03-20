Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961BEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F0F217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YIJXGBHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCTBJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:09:40 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:43648 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfCTBJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553044179;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=2byeS3WCr+btrSUwYqnvKhC8fnHDpT8ZecHD+X/26GU=;
        b=YIJXGBHET20uNbnGy0egbHo5NK5RPHfpoU6AfPZ8VR/bYpninCGqgP5TH2S2ePwO
        ufNsxU89P74S/v2CgrI2CILsOLvA2lpgaBD241/1GXfOwWWYbH0WjTAe/46HZv8KGoS
        QVjhQNEuZqupqrQxvqeQM0YQxZ+TrbawGkH1sabQ=
Date:   Wed, 20 Mar 2019 01:09:38 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     John Hubbard <jhubbard@nvidia.com>
cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/1] mm: introduce put_user_page*(), placeholder
 versions
In-Reply-To: <dc2499a6-4475-bea3-605a-7778ffcf76fc@nvidia.com>
Message-ID: <0100016998a587a1-c6df93d4-223b-4e66-9d8c-2bb38fae28ac-000000@email.amazonses.com>
References: <20190308213633.28978-1-jhubbard@nvidia.com> <01000169972802f7-2d72ffed-b3a6-4829-8d50-cd92cda6d267-000000@email.amazonses.com> <dc2499a6-4475-bea3-605a-7778ffcf76fc@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.20-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019, John Hubbard wrote:

> >
> > My concerns do not affect this patchset which just marks the get/put for
> > the pagecache. The problem was that the description was making claims that
> > were a bit misleading and seemed to prescribe a solution.
> >
> > So lets get this merged. Whatever the solution will be, we will need this
> > markup.
> >
>
> Sounds good. Do you care to promote that thought into a formal ACK for me? :)

Reviewed-by: Christoph Lameter <cl@linux.com>

