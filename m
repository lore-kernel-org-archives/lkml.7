Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C4C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E27217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555794172;
	bh=8G0gRqWu3gfRU9SrWKSf55FAbc0YsgcrdAorguRNJ8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mQoYjG1A9Ey6yGC79DRY+++m4/7Th6Z6rkVREOw0aeF+kqgS6nI/w/ApYX8QdlxWX
	 Oa35hJy7+2Q1sjGLpT/j9jzdpImCNt9ftqcZ67m7wiNKa2RPOYdntpps+ekQvbOXPC
	 0CWjU2YGqIa0BB1QuoIVj984pIQVqR0e24DRDu9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfDTVCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 17:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfDTVCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 17:02:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA6E208C0;
        Sat, 20 Apr 2019 21:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555794170;
        bh=8G0gRqWu3gfRU9SrWKSf55FAbc0YsgcrdAorguRNJ8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgT9CZmfh98qJKWxUQ30tcp0JWU+x2DfXL+bz7DdzIchQARTdBHDc/bnKeMb0RMNC
         JXpjRsSLfS0A+cgTPkki51Z85Nl4xTtDpRwRcU1sbh2V56qmWkz9BTWgpjmWbFgGSs
         qP7DQfc+nhqJEOgZSJLPsGr7ygJJa6YJXAWBpqic=
Date:   Sat, 20 Apr 2019 23:02:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: mt7621-mmc: Cleanup in msdc_app_cmd()
Message-ID: <20190420210248.GA25911@kroah.com>
References: <20190419211130.25284-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419211130.25284-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:11:30PM -0500, Madhumitha Prabakaran wrote:
> Remove unwanted variable and replace the respective return type.
> 
> Issue suggested by Coccinelle.
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/sd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This file is long deleted.  Always make sure you work off of the latest
development tree for the subsystem you are wanting to contribute to.  Or
on linux-next at the least.

thanks,

greg k-h
