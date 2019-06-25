Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CBC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B581A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfFYJt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:49:26 -0400
Received: from elvis.franken.de ([193.175.24.41]:43924 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfFYJtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:49:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1hfhQI-00035W-00; Tue, 25 Jun 2019 11:07:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 01082C0E40; Tue, 25 Jun 2019 11:04:51 +0200 (CEST)
Date:   Tue, 25 Jun 2019 11:04:51 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] mfd: ioc3: Add driver for SGI IOC3 chip
Message-ID: <20190625090451.GA9794@alpha.franken.de>
References: <20190613170636.6647-1-tbogendoerfer@suse.de>
 <20190613170636.6647-6-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613170636.6647-6-tbogendoerfer@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 07:06:31PM +0200, Thomas Bogendoerfer wrote:
> SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> It also supports connecting a SuperIO chip for serial and parallel
> interfaces. IOC3 is used inside various SGI systemboards and add-on
> cards with different equipped external interfaces.
> 
> Support for ethernet and serial interfaces were implemented inside
> the network driver. This patchset moves out the not network related
> parts to a new MFD driver, which takes care of card detection,
> setup of platform devices and interrupt distribution for the subdevices.
> 
> Serial portion: Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  arch/mips/include/asm/sn/ioc3.h     |  345 +++----
>  arch/mips/sgi-ip27/ip27-timer.c     |   20 -
>  drivers/mfd/Kconfig                 |   13 +
>  drivers/mfd/Makefile                |    1 +
>  drivers/mfd/ioc3.c                  |  683 +++++++++++++

Lee,

can you give me an indication, if the MFD changes are ok now
or if I need to improve it further.

Thanks,
Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
