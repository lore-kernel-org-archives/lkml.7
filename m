Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF37DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA972073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576009201;
	bh=JJ3x1a8mkruSyckx5tJ3DK9j0EPWeio+6KT/A/Sw3UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RS908YTuleksvzb+GsGoizZ+T7PIewYS5anRnuL4bP2qfuleoeCna9styYOzMpOuF
	 +/k0H278iw4NK3oGhq2MqL1hUkgA69C3aqwUpvnJcmh3wXbPqQQRJDzyHo4yytd2LB
	 Y3twHAbWLgiogO4C21AhU5qCPJF3/HADesojn314=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLJUUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfLJUUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:20:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2385B206EC;
        Tue, 10 Dec 2019 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576009199;
        bh=JJ3x1a8mkruSyckx5tJ3DK9j0EPWeio+6KT/A/Sw3UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFt5ukAS8+sDg60hqQeLefJkJ6aQseO9KDK4vWd2EQeRg18S5AZ7CHZo+Vjna2AIY
         CYcclTI5J8bUwZ+MXLBIMJoZbuo5EkNhaleTyMjrki0vAkf5O3chbjDlc40xwseWGY
         BFebRMcF5mGMvNBju1GNLBrkGHAdLNI/3Al0U8Bs=
Date:   Tue, 10 Dec 2019 21:19:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     devel@driverdev.osuosl.org,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Sumit Pundir <pundirsumit11@gmail.com>,
        linux-kernel@vger.kernel.org, David Daney <ddaney.cavm@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Laura Lazzati <laura.lazzati.15@gmail.com>
Subject: Re: [PATCH 2/2] staging: octeon-usb: delete the octeon usb host
 controller driver
Message-ID: <20191210201957.GB4070187@kroah.com>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <20191210091509.3546251-2-gregkh@linuxfoundation.org>
 <20191210193153.GB18225@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210193153.GB18225@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:31:54PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Dec 10, 2019 at 10:15:09AM +0100, Greg Kroah-Hartman wrote:
> > This driver was merged back in 2013 and shows no progress toward every
> > being merged into the "correct" part of the kernel.
> 
> Do you mean all the patches since 2013 were "no progress"? Thanks.

I have not seen any proposals to get it out of staging at all.  If the
only thing left really is just those two simple TODO lines, then why has
it taken 6 years to do that?

> > The code doesn't even build for anyone unless you have the specific
> > hardware platform selected, so odds are it doesn't even work anymore.
> 
> I used it in production almost a decade with no issues with unpatched
> mainline kernel. All reported issues were fixed. Last kernel I ran
> was v5.3.

Then why has it not been merged out of staging?

thanks,

greg k-h
