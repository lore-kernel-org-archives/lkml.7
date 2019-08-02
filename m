Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C71C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331922087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564773154;
	bh=a+qnNPOY+3mRl8ZB1wFsMiiGQrc4e7YPY52MpcY/9ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bJ9XRnWcohx88Pm/xTzwd99/bmBoT9+EP/u+sJ0N0kel5CjD+XhXnMByehJyOdlJq
	 3Fa94hsLtJPfZCg0rc5iYmjwpmr9FnlRFBX+M9WSvMfsBvSuMsDuoGGWkh+EDIBhtW
	 pYmZhiuQ4XRjb4fgMbOJbtuM6tni/e6WmB8kpibA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391893AbfHBTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:12:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHBTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:12:32 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76EF1167C;
        Fri,  2 Aug 2019 19:12:27 +0000 (UTC)
Date:   Fri, 2 Aug 2019 12:11:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v3 2/3] mm/hmm: fix ZONE_DEVICE anon page mapping reuse
Message-Id: <20190802121147.d7e6a5eb57966b98118abb97@linux-foundation.org>
In-Reply-To: <20190802083141.GA11000@lst.de>
References: <20190724232700.23327-1-rcampbell@nvidia.com>
        <20190724232700.23327-3-rcampbell@nvidia.com>
        <20190802083141.GA11000@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 10:31:41 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Andrew,
> 
> Any reason the fixes haven't made it to mainline yet?

I generally let fixes bake in -next for a week or two, unless they
appear to be impeding ongoing test&devel.

[3/3] shows no sign of having been reviewed, btw.
