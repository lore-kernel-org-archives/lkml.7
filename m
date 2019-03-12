Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8811C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D3E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O8gq/Rs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfCLCWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:22:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfCLCWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t0cNe1GovyGwojRM6XuvVZugMvmXJbVzAhjtLdKGn8Q=; b=O8gq/Rs5C/jwwI/el3to8Mbnp
        Pj/iFU5dBbSBlriuARyVb1JqIVEU8PImjKkXRTBU0GQYBH46WNSiW9COBbusPo48EZQjhjehKKhDN
        tlhauBd+2NdWHykJXcT/bjUNoG4MEuGICXlhTTlnbNGK0h00EaqWbLSg7G7zM9rmAx72p3R7NpYVP
        WioNBNMLQyzvZYd1Jq05dUJJkQVdbsCstnQx4aeoqSYNIC1qUIQbnLnzu/WKJ8UAYjiVO4NHwuVUW
        wHtuJZ4imrUGZjwRCLCJ0A7f9G6PgqpYhUSTeOLWCdfE1oTP7/NNkBIhfugir3SAR2Pjo1b5HoDc1
        zpcjTC/qw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3X41-0007Tt-PK; Tue, 12 Mar 2019 02:22:45 +0000
Date:   Mon, 11 Mar 2019 19:22:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] XArray updates for 5.1-rc1
Message-ID: <20190312022245.GG19508@bombadil.infradead.org>
References: <20190311182829.GE19508@bombadil.infradead.org>
 <CAHk-=wg1hqVm0rxF66MU2NkWGD8qPLmbebHV1pFNjhNuCGaGnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1hqVm0rxF66MU2NkWGD8qPLmbebHV1pFNjhNuCGaGnA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 06:39:41PM -0700, Linus Torvalds wrote:
> On Mon, Mar 11, 2019 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >   git://git.infradead.org/users/willy/linux-dax.git xarray
> 
> You forgot to tag it, and I don't pull from external untrusted sites
> without signed tags..
> 
> Please? I know you can do it, because you've done it successfully in the past...

Oops.  xarray-5.1-rc1 tag now created and pushed out.  Thanks.
