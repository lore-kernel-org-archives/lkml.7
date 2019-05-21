Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E8EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFA02173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558444295;
	bh=PswCI7qaEh7te+WzS2oP8fteQs8KoBFwCF8/BdVQ8Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wbcoCi8+EuzTI7bEfpb0uCrV8mbof9LirqE5f2xcZabaYlIHMLPzQcvgDyEACKWqv
	 j0UEo9x2c+B6UfidOxvmZAtWqr4EQTBbbed3gvg8Ld8xJbGIASiEs2brwHPYBGZw54
	 uwl+muLDuuKkeXHCPYg6rceNIBYAzFh+VBBvWUJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfEUNLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUNLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:11:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA77620856;
        Tue, 21 May 2019 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558444293;
        bh=PswCI7qaEh7te+WzS2oP8fteQs8KoBFwCF8/BdVQ8Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzLJV1RaZC8MshHxDBTshU7//9I8vU3RdIHJuIP9aN8FzCHsfhNnYC26m/PHnsimt
         jRXq4FBdoFgvF+3kA+jnUCFEpGpAEe2wQSUoSZSAJWStyO9Fi1xMPdWt8GGBF4OmAH
         b7s+/Y2Lw6fQRDI+D7lsYUdTghpWTrC2pQRnrdiU=
Date:   Tue, 21 May 2019 15:11:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Esben Haabendal <esben@geanix.com>
Cc:     linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] serial: 8250: Add support for using
 platform_device resources
Message-ID: <20190521131131.GA19685@kroah.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190521113426.16790-1-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521113426.16790-1-esben@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
> Allow getting memory resource (mapbase or iobase) as well as irq from
> platform_device resources.
> 
> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
> resources are to be used.  When not set, driver behaves as before.

Nothing actually sets this flag in this patch, so I can't take this as
you are adding new features that no one uses :(

Where is the driver that sets this?

thanks,

greg k-h
