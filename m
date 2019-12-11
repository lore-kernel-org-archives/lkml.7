Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D848DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA281214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576050142;
	bh=hjwHRYg8sPYAGDfSGrnlcMrFRv1F4fdjjCVCcQ5+a1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MvHRnsKdT70DkvLKTgvHZrQILHb8XrS4k7x3p+vdmqqGTOC4631ayLK5d+cu7qrBu
	 H3OgI8Bb2h6/O6F8MoGPRO8Z+WmczGPxHwRXRzo91BtMSe6sJboRg8QFDcTFXaWPZP
	 kWDWdxiubIlg/ncfKD6KvJlW4C/4iPLcFlRSgzvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfLKHmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLKHmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:42:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 881EB208C3;
        Wed, 11 Dec 2019 07:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576050141;
        bh=hjwHRYg8sPYAGDfSGrnlcMrFRv1F4fdjjCVCcQ5+a1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpRaJ89jUMVRa6IpaYcn6qin1ZSI494HkfhCJYBls/yNzHmpiJLg3eXHWeFjPbnY9
         OJSUt1Jtbeb0q26EcErkVu4DdetqYR8EyYmWfXug6VBVUCwtCPmiAG6d5Yr8S+MjaZ
         qTBEnr/Bc6Y7eCmruD2bDi8IpyP/w+/ELamaV/hU=
Date:   Wed, 11 Dec 2019 08:42:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     devel@driverdev.osuosl.org, Sumit Pundir <pundirsumit11@gmail.com>,
        linux-kernel@vger.kernel.org, David Daney <ddaney.cavm@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Laura Lazzati <laura.lazzati.15@gmail.com>
Subject: Re: [PATCH 2/2] staging: octeon-usb: delete the octeon usb host
 controller driver
Message-ID: <20191211074218.GB398293@kroah.com>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <20191210091509.3546251-2-gregkh@linuxfoundation.org>
 <20191210193153.GB18225@darkstar.musicnaut.iki.fi>
 <20191210201957.GB4070187@kroah.com>
 <20191210212744.GD18225@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210212744.GD18225@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:27:44PM +0200, Aaro Koskinen wrote:
> On Tue, Dec 10, 2019 at 09:19:57PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 10, 2019 at 09:31:54PM +0200, Aaro Koskinen wrote:
> > > Hi,
> > > 
> > > On Tue, Dec 10, 2019 at 10:15:09AM +0100, Greg Kroah-Hartman wrote:
> > > > This driver was merged back in 2013 and shows no progress toward every
> > > > being merged into the "correct" part of the kernel.
> > > 
> > > Do you mean all the patches since 2013 were "no progress"? Thanks.
> > 
> > I have not seen any proposals to get it out of staging at all.  If the
> > only thing left really is just those two simple TODO lines, then why has
> > it taken 6 years to do that?
> 
> Do you mean you did not see the below thread when I asked for help;
> it was a kind of propsal, no? Also things take time when you are just a
> hobbyist reverse engineering undocumented hardware that you also run in
> production. Yes, I'm slow, but the starting point wasn't also a very good.
> 
> https://marc.info/?t=155839354700002&r=1&w=2

I have the short-term memory of a squirrel, remember I get 1000 emails a
day to deal with.

That thread was from back in May, the instructions on what was needed to
be done is quite simple, so there should not have been a multi-month
delay from then until now.  What happened?

> I don't mind you deleting the driver, and if you think that "no progress"
> is true then I'm very sorry for all those commits/noise.

Don't be sorry, you have fixed it up to make it ready to be merged
properly.  But yes, there is no progress being made now, so it should
either be dropped or merged properly.

If you don't have the time now to do it, that's fine, the revert to get
the code back just takes one single git command when you, or someone
else, can get the chance to do it.

Don't take it personally, this is about to happen to almost all of the
staging drivers that have been languishing around :)

thanks,

greg k-h
