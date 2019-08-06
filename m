Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89CEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF34218A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565128781;
	bh=1RMsskiZ8XVMBQDTVxtlNFNMusXQHddlOkDSsewP6+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tx46+jHR6k68KGd62SiczLEJRU3NsstoNYzRHZp/VWUgReyDEbtqqBlGS1o3n+fFj
	 hQBn7ZjlTK32/xx+2VzraZ7PCG3i0IVaHqWQUHrazLSNX3GGQZtlah/982tQML4QXX
	 hOSyWvjCATrzzE+68dp37QYRALw0TJJ8qnN5SAwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfHFV7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfHFV7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:59:40 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0619121880;
        Tue,  6 Aug 2019 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565128779;
        bh=1RMsskiZ8XVMBQDTVxtlNFNMusXQHddlOkDSsewP6+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j6NOly9ET/FlzEE+ReFef3quZD7dSpaM+K0YBXtz8VA+vS7c/LWFxUf7A6bBL8CV9
         8lFAYSwzFCE9PoeQHnP/wrsJ9gdeQqyp6VATDTbxOZ7DIQcrH/evgl1FraCbvtbHiC
         DcJ4axHUto1TLm98VHwM3J4vnkw7n0A1bzc0FGqw=
Date:   Tue, 6 Aug 2019 14:59:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     john.hubbard@gmail.com
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/3] mm/: 3 more put_user_page() conversions
Message-Id: <20190806145938.3c136b6c4eb4f758c1b1a0ae@linux-foundation.org>
In-Reply-To: <20190805222019.28592-1-jhubbard@nvidia.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Aug 2019 15:20:16 -0700 john.hubbard@gmail.com wrote:

> Here are a few more mm/ files that I wasn't ready to send with the
> larger 34-patch set.

Seems that a v3 of "put_user_pages(): miscellaneous call sites" is in
the works, so can we make that a 37 patch series?

