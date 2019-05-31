Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18524C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E75262F7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559261518;
	bh=BkaAkAYsINjPVicGtwZ4jKcRDAQKYbJITXtawe8Ms1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSXzajfr+S3lTBOaMwTWEvD7fqeQEb32A/P3s9wSD7dXLCiN8E0wh0arhHFGmeyaN
	 ANTKGAoeuTiUPzLkcEzoP54Rb2IX7fPRRyIt4A4kTqQ8QQTMc3AQEVxSHBtrHaXKPj
	 Jq7fXBKAXzcWvDpoyVp9b4nR7UiOQUfIbraVO5MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEaAL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 20:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfEaAL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:11:57 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7230262F7;
        Fri, 31 May 2019 00:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559261516;
        bh=BkaAkAYsINjPVicGtwZ4jKcRDAQKYbJITXtawe8Ms1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVN6SLSzV1E834OCk47mM45jcIm9bLRoI24rvMu01vyyCnjkWaiHvED1NnjdAwXxC
         VuQr4GqaR8Ia9HoR7Kw2/j6UFGentX1Yr3PK1MkGLQcsu9pK/jUgxbHtrL40TABbaf
         ClQTV4i08DGeKAEbxLpn13N7I1R4k27yuY9ME9iQ=
Date:   Thu, 30 May 2019 17:11:56 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matt Sickler <Matt.Sickler@daktronics.com>
Cc:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] staging: kpc2000: add spaces around operators in
 core.c
Message-ID: <20190531001156.GA25210@kroah.com>
References: <20190524110802.2953-1-simon@nikanor.nu>
 <20190524110802.2953-2-simon@nikanor.nu>
 <20190530210558.GA21455@kroah.com>
 <SN6PR02MB4016139989144F6C08CD4BDAEE180@SN6PR02MB4016.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4016139989144F6C08CD4BDAEE180@SN6PR02MB4016.namprd02.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:57:09PM +0000, Matt Sickler wrote:
> >From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> >Greg KH
> >On Fri, May 24, 2019 at 01:07:59PM +0200, Simon Sandström wrote:
> >> --- a/drivers/staging/kpc2000/kpc2000/core.c
> >> +++ b/drivers/staging/kpc2000/kpc2000/core.c
> >> @@ -276,18 +276,18 @@ static ssize_t kp2000_cdev_read(struct file *filp,
> >
> >This whole function just needs to be deleted, it's a horrible hack.
> 
> >From the outside, I would definitely agree with you.  On the inside though, we
> rely on this function to quickly identify what kind and version is running on
> a given piece of hardware.  Since that same information is provided by an ioctl,
> I could be convinced to remove this API and write a userspace application that
> uses the ioctl to get the information and pretty prints it.

The ioctl needs to die as well, just use the sysfs entries instead, as
you already have them :)

> I'd be more inclined to agree with the deletion if it means the whole char dev
> interface can be removed from the kpc2000 driver.  That won't be straightforward
> as the ioctl is exposed through this interface.  We could remove the ioctl, but
> we'd need to ensure that all the same information is exposed via sysfs.

I think you are there already, what is missing?

> Our userspace side is all funneled through a single class, so changing
> it to use sysfs wouldn't be too difficult.  I'd support that change if
> someone wants to make it.

I will be glad to do that, it's always nice to delete code :)

thanks,

greg k-h
