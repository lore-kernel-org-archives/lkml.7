Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE44C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AE4222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578066781;
	bh=+E9PkxoJKq1S6MJhQi4es2qjbhoNdQasRF0kTAzJv5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cpuH59Z9x5PhCeLHeVvPBG/FjtfNiqb7ofgfewelyfcTXA/DpFsY2BqPe5TaLcdpa
	 FTi1PgrhaNWb9XbWaqVG7k5Zkk+/pOitMgUsnC/zK1ls7gHCx77dix4myjvARO1ZiA
	 78FfEwI7XYfEEuFjauZlD20TR9SHyuUrS0BvqnDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgACPxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:53:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbgACPw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:52:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E853217F4;
        Fri,  3 Jan 2020 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578066779;
        bh=+E9PkxoJKq1S6MJhQi4es2qjbhoNdQasRF0kTAzJv5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOxsPXy0JLVlmwbiheLkZQfh42G4U1Co8ziWP24CAPzUbLVewk0b0hadWbiz+QvpY
         /Fr/4SMQzngYXueAKxQFU0Zs+ceDEMyl8XT/RtnBPxHogsFEy/WdA9JbZtr3ccxxgR
         Au9tYwCwMQFsorLALfsBhCisQ6+RxlA8gClI8UAw=
Date:   Fri, 3 Jan 2020 16:52:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gary R Hook <gary.hook@amd.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        kbuild test robot <lkp@intel.com>, dan.j.williams@intel.com,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        davem@davemloft.net, mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: ptdma: Initial driver for the AMD
 PassThru DMA engine
Message-ID: <20200103155256.GC1064304@kroah.com>
References: <1577458047-109654-1-git-send-email-Sanju.Mehta@amd.com>
 <201912280738.zotyIgEi%lkp@intel.com>
 <20200103062630.GD2818@vkoul-mobl>
 <de0bf6de-5c44-bb81-f3ac-2db1c1c4595d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0bf6de-5c44-bb81-f3ac-2db1c1c4595d@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 09:12:18AM -0600, Gary R Hook wrote:
> On 1/3/20 12:26 AM, Vinod Koul wrote:
> > On 28-12-19, 07:56, kbuild test robot wrote:
> > > Hi Sanjay,
> > > 
> > > I love your patch! Perhaps something to improve:
> > 
> > Please fix the issues reported and also make sure the patches sent are
> > threaded, right now they are not and the series is all over my inbox :(
> > 
> 
> What does this mean? The patches showed up in my inbox as a set of 3,
> properly indexed, just like they should when sent with "git send-email".
> 
> We've not had any reports from other lists/maintainers of similar problems.
> So you'll understand how we might be a bit confused.
> 
> Would you please elaborate on the problem you are seeing?

There was no email threading of the patches, they all looked like
individual emails.  In other words, the "In-Reply-To:" value was not
set.

thanks,

greg k-h
