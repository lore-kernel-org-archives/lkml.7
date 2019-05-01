Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9873D205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556720657;
	bh=AGc2ptjXjYLZEV3rzOzVcRBQBKEK0MXhlz7kc4XHY7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sGVnK+yg41+6Uu+T3fwTXFkfR8S5nMwNrpqWz6LCSL0jmpgKDfYCblbYAFgu8X64g
	 yJM4PUV60MXdPgYTf4T3mDNf4zwHKhfF+IF3nebA9WPOojJn7sMvPo1dGjgepRHdz3
	 QjzWszqKbgza9E5VQoAN9exz7iB9ZZLI37HOMlv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfEAOYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfEAOYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:24:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A188205F4;
        Wed,  1 May 2019 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556720655;
        bh=AGc2ptjXjYLZEV3rzOzVcRBQBKEK0MXhlz7kc4XHY7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPwhl0FFgZVk8m+Vk0fdJro7BdQKrfy+5hzPYgcXFug6dSV4e6ce2pFKwYy0GbQ64
         Fu+hcBJHw9sW89kCXX57F+9Eky/fpGClfOll42faX79+aEyxZCcGPHzyF2tdBCTG5J
         Ojf0KFUGUyGrqktgM9SVl01iwN6O/Iu65HOImm6s=
Date:   Wed, 1 May 2019 16:24:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] staging/fieldbus-dev for 5.2
Message-ID: <20190501142412.GB13008@kroah.com>
References: <20190501140624.6931-1-TheSven73@gmail.com>
 <20190501142332.GA13008@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501142332.GA13008@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 04:23:32PM +0200, Greg KH wrote:
> On Wed, May 01, 2019 at 10:06:24AM -0400, Sven Van Asbroeck wrote:
> > The following changes since commit a4965d98b4d1ffa5b22f2039bc9e87898aff4976:
> > 
> >   staging: comedi: comedi_isadma: Use a non-NULL device for DMA API (2019-04-27 15:00:35 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git@gitlab.com:TheSven73/linux.git tags/fieldbus-dev-for-5.2
> 
> I don't "trust" the gitlab infrastructure, sorry, and I don't think I
> have a valid gpg signature from you anywhere :(
> 
> Can you just send these as patches?  I can easily queue them up that
> way.

And as this is just a single patch, handling them as patches is much
easier anyway.  Only when you get into the 20+ at a time does pull
requests help.

thanks,

greg k-h
