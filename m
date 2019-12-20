Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E637C2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576836903;
	bh=DxzAhHie1jM2AMgKqihWMBSP8hR6Xu6a9XQRUYb4ekk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kYjpXuiKKE/qjY3hrFEh/5+4ytAI4ZKBNe+0k29TC6oxnoMAzsg3YKZ+XscX9OeGr
	 nR7OBXt0QCTiKSDiDd4ZqdcjPtmMJJQ9sFtauDgSl4i5tQF3nnUAZqWjUvFgxNXUB1
	 7TVx+11zw2FbOoaZzgBRsUxy1vRE0aYHiB5rzEg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfLTKPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfLTKPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:15:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5B9206EF;
        Fri, 20 Dec 2019 10:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576836901;
        bh=DxzAhHie1jM2AMgKqihWMBSP8hR6Xu6a9XQRUYb4ekk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xAD0JmwRWwZoljeVkCxWJdQoMNzvxRyMztCgFcrrEqR1G6nUVR0pa8QGKLoWzGHkw
         TpJZwTR/A1Yp2xvBuysVBsQ5S2fhYgyfQ3xpzy1Ceo5f3Dz8sZz1tizoD1aSQmwQSY
         mYNPYS+VDZgs+UW08ZtoolTHq30KC33Ln4zaT/i4=
Date:   Fri, 20 Dec 2019 11:14:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: EHCI: ehci-mv: drop pxa_ehci_type and unused device
 IDs
Message-ID: <20191220101458.GA2259298@kroah.com>
References: <20191220070202.239870-1-lkundrak@v3.sk>
 <20191220073537.GA2193408@kroah.com>
 <1fdbe2d493b71ed2105a8976ebbccbba28adfe26.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fdbe2d493b71ed2105a8976ebbccbba28adfe26.camel@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 09:55:07AM +0100, Lubomir Rintel wrote:
> On Fri, 2019-12-20 at 08:35 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Dec 20, 2019 at 08:02:02AM +0100, Lubomir Rintel wrote:
> > > A trivial cleanup.
> > 
> > How is dropping device ids a "trivial cleanup"?
> > 
> > Please be more descriptive as to why you are making a change.
> 
> Thanks for the response. I'll post a v2 with a hopefully better
> description.
> 
> > Also, you sent a number of patches here and I do not know what order
> > they should be applied in.  Please resend them all as a numbered patch
> > series so that I have a clue what to do.
> 
> I did that because the patches are completely independent of each other
> -- they don't conflict and don't need to be applied any particular
> order. Would you still prefer a numbered series?

A numbered series is always easier.

thanks,

greg k-h
