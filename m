Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9294AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E2020B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556355565;
	bh=KaFTknj2Zt+vPW6GXQZL1w2sFePpXOTHPuB4h8hy08E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gwJopMo3obzt1Q0zwcOd+CgORrbquW39maMM678d1OVkAXpaNg7xJKRNFglS5zPGn
	 moFzaXFYdlbpJQW1G3ZJjuE0qzMYUtwjEiF1sPu32ul7KnPECGRx5bkhgv75NF/YRO
	 Ck3pDMj/iRCP/bxjZDFSo7C2hEBEdsybJzwcLgVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfD0I7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfD0I7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:59:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC309208CA;
        Sat, 27 Apr 2019 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556355563;
        bh=KaFTknj2Zt+vPW6GXQZL1w2sFePpXOTHPuB4h8hy08E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIuEdtuv+MIQBTBaaj++IRkd012SvQo8peIGJwqMq0CQmXosaU8/kRrDWfykkYL6r
         RUQQrvoQcPBTD/tq2kOoP4jvsFeXApmXRqXODM9K+3LQelgvh3up6d3MZZZWMb1QJ4
         T82a5jd57hAsua1fTpF7xVncy7WENQZWD+2hUkmc=
Date:   Sat, 27 Apr 2019 10:59:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Fix type field in format string
Message-ID: <20190427085920.GA25621@kroah.com>
References: <20190427080013.GA3624@haolee.io>
 <20190427080942.GA8218@kroah.com>
 <CA+PpKPkdpkC9nqL4NzKK=5Xys0H6-ZBAUmjE91WSRg=b1LyiOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PpKPkdpkC9nqL4NzKK=5Xys0H6-ZBAUmjE91WSRg=b1LyiOQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 04:41:44PM +0800, Hao Lee wrote:
> On Sat, 27 Apr 2019 at 16:09, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Apr 27, 2019 at 04:00:15PM +0800, Hao Lee wrote:
> > > The variable type and the type field is inconsistent.
> >
> > In what way?  Please be very specific when you resend this.
> 
> The main problem is the dev_dbg statement should print the value of
> uart.port.mapbase instead of its address. Besides that, uart.port.irq
> and uart.port.iotype are all unsigned types, so using %u is more
> appropriate.

Wonderful, put all of that in the changelog text and please resend.
What you submitted is not sufficient.

thanks,

greg k-h
