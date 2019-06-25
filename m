Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E958C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC3215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfFYJtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:49:22 -0400
Received: from elvis.franken.de ([193.175.24.41]:43923 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfFYJtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:49:22 -0400
X-Greylist: delayed 2510 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 05:49:21 EDT
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1hfhQI-00035W-01; Tue, 25 Jun 2019 11:07:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id F1125C0E44; Tue, 25 Jun 2019 11:07:13 +0200 (CEST)
Date:   Tue, 25 Jun 2019 11:07:13 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] w1: add 1-wire master driver for IP block found in
 SGI ASICs
Message-ID: <20190625090713.GB9794@alpha.franken.de>
References: <20190531102749.18183-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531102749.18183-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 12:27:47PM +0200, Thomas Bogendoerfer wrote:
> Starting with SGI Origin machines nearly every new SGI ASIC contains
> an 1-Wire master. They are used for attaching One-Wire prom devices,
> which contain information about part numbers, revision numbers,
> serial number etc. and MAC addresses for ethernet interfaces.
> This patch adds a master driver to support this IP block.
> It also adds an extra field dev_id to struct w1_bus_master, which
> could be in used in slave drivers for creating unique device names.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/w1/masters/Kconfig           |   9 +++
>  drivers/w1/masters/Makefile          |   1 +
>  drivers/w1/masters/sgi_w1.c          | 130 +++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/sgi-w1.h |  15 ++++
>  include/linux/w1.h                   |   2 +
>  5 files changed, 157 insertions(+)
>  create mode 100644 drivers/w1/masters/sgi_w1.c
>  create mode 100644 include/linux/platform_data/sgi-w1.h

Evgeniy,

are the patches ok for you or is there something to improve ? It would
be good, if they could get upstream during the next merge window, as
there are other patches from me depedning on them.

Thanks,
Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
