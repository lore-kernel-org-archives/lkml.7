Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A7CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3946B21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194482;
	bh=nqXX0UyM2b1XJUNFn9BGxilshMPfWaX1KAsPAP4MBfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1cVKsFcuHdlxgk4caafx6BHa1OmIfVVIA7Y0rj8wFG7BJoaOaefQkPGEPncOyjSdX
	 UCmVi3UksVaXIh/c420RJ7UXY+6ksgQAWvWiMAzPdo6+IOEIRJZwQGXjNOU3wYHulK
	 WblJ8fmRK2JdPSXtQaer7REK29cmASmbQWeI/ogI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfCUSyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfCUSyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159B121873;
        Thu, 21 Mar 2019 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194475;
        bh=nqXX0UyM2b1XJUNFn9BGxilshMPfWaX1KAsPAP4MBfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUhGpUTd5ie2ntgXNTZlaJgruz08W5zMWiLeJxVtN51hLSjnE0BJlMZqfxiI67w5q
         /oAqCdMtEzrauGP+JTpgFm8k0Fi44UUMkGtCTuyne47qvqf3FlIw+zoQB7V/pbst7U
         lthcDZKMxLyo/LVB2xAzfp3L5Ju8qhqvZiwiNiNU=
Date:   Thu, 21 Mar 2019 19:54:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     devel@driverdev.osuosl.org, christian@lkamp.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Prefer u32 over uint32_t
Message-ID: <20190321185432.GA18568@kroah.com>
References: <20190321183710.GA8472@bharath12345-Inspiron-5559>
 <20190321184609.GB16785@kroah.com>
 <20190321184858.GA9217@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321184858.GA9217@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 12:18:58AM +0530, Bharath Vedartham wrote:
> On Thu, Mar 21, 2019 at 07:46:09PM +0100, Greg KH wrote:
> > On Fri, Mar 22, 2019 at 12:07:10AM +0530, Bharath Vedartham wrote:
> > > Change uint32_t to u32
> > 
> > That says _what_ you did, but _why_ are you doing this?  That's the main
> > content a changelog text should have in it.
> > 
> > thanks,
> > 
> > greg k-h
> That was a checkpatch.pl warning! I forgot to mention that! It fixed a
> checkpatch.pl warning. I ll write better changelogs from my next commit
> on. Thanks for the feedback!

Please fix this up and resend as a "v2" patch, if you wish to have it
accepted.

thanks,

greg k-h
