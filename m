Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D71DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E4026BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559319649;
	bh=gFNYe2CdPDPl1JVBgUiEfmTwW5vX2jrrcDEhzr47Pl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WWhGI4vwHI0ELHBSvI3d57yDuy3LU8GoSPhAYyhNYPx7JGYZJGFrjj9R8TNpauuoC
	 TYtaKR5WKxNJ2bupjQv1DV7ETFfy4UvLOh5k8hbIAhuAQgO+GFaRqs2/gcBVrDqO1D
	 OqnPNk7UoRvAkF3N6vS2HlaOwnVTzDJm53HmhkKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfEaQUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfEaQUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:20:47 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 036CC26BE0;
        Fri, 31 May 2019 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559319647;
        bh=gFNYe2CdPDPl1JVBgUiEfmTwW5vX2jrrcDEhzr47Pl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hyywx4ITH8dxGS8nqfbOuAzHsHUFceDZn0AXOPPS5GHGhj+eKItcvvuPjl/vdT9qS
         ZhVWbCQv1A7vGcSzYajFF/PbcbWezATcNe9cH4KNiUsynpKCuPmOR0Ge4CDKSXY9UQ
         Iw09sZaDT57SvH1nqIJLzs1pQ8ZCzU101NWU4yY4=
Date:   Fri, 31 May 2019 09:20:46 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [git pull v2] habanalabs fixes for 5.2-rc2/3
Message-ID: <20190531162046.GA15130@kroah.com>
References: <20190524194930.GA13219@ogabbay-VM>
 <CAFCwf12PN29ax1zK2sV3NjzR7N76CvJ3jN51xXqr8y9vHMBatw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12PN29ax1zK2sV3NjzR7N76CvJ3jN51xXqr8y9vHMBatw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 07:08:31PM +0300, Oded Gabbay wrote:
> On Fri, May 24, 2019 at 10:49 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > Hi Greg,
> >
> > This is the pull request containing fixes for 5.2-rc2/3. It is now
> > correctly rebased on your char-misc-linux branch.
> >
> > It supersedes the pull request from 12/5, so you can discard that pull
> > request, as I see you didn't merge it anyway.
> >
> > It contains 3 fixes and 1 change to a new IOCTL that was introduced to
> > kernel 5.2 in the previous pull requests.
> >
> > See the tag comment for more details.
> >
> > Thanks,
> > Oded
> >
> Hi Greg,
> Pinging you in case this got lost in the mail.

Not lost, just delayed, am traveling at the moment.  Will go do this now
so I don't forget...

thanks,

greg k-h
