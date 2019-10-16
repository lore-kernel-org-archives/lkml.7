Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581BFFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2302D2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571230303;
	bh=etiIa3GUWBTn7yU7UGrNpVYkKX96S4NSFCKUU1IEccc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ptYN5bnqLqhvjVNxQvzsIws1YGLvdSsmlgUci+kYlk4bnfnBzwGrfyJ0X95oju9Q3
	 xs8MCyQgLtnHIKvEbhemecn0Nrh4/qOnaCrsqLgwDPSsJiiUQppzTEzBnBnwplr8XI
	 obkgxTupkXPO/IjllHLWeEufFTR54TutffHrOfRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405270AbfJPMvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfJPMvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:51:41 -0400
Received: from localhost (unknown [209.136.236.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9732168B;
        Wed, 16 Oct 2019 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571230301;
        bh=etiIa3GUWBTn7yU7UGrNpVYkKX96S4NSFCKUU1IEccc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVAl4E+7TXtgpbka24HuYlnml/dXtCGDS3cNnZfD+f6+7ReKou9hFdiC/hIE2yjrA
         5uPsa4p02F/n6hJ13iX6qr5zhPKGj2vf/nPABW/K7vTdwC1ewLvsueCpjD32GSlmKh
         wMEs82IPfnw1UAzBi4HvoSYAYTEFhvsHqKLQRCQ0=
Date:   Wed, 16 Oct 2019 05:51:39 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Michael Moese <mmoese@suse.de>, Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] drivers: mcb: use symbol namespaces
Message-ID: <20191016125139.GA26497@kroah.com>
References: <20191016100158.1400-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016100158.1400-1-jthumshirn@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 12:01:58PM +0200, Johannes Thumshirn wrote:
> Now that we have symbol namespaces, use them in MCB to not pollute the
> default namespace with MCB internals.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/gpio/gpio-menz127.c            |  1 +
>  drivers/iio/adc/men_z188_adc.c         |  1 +
>  drivers/mcb/mcb-core.c                 | 28 ++++++++++++++--------------
>  drivers/mcb/mcb-lpc.c                  |  1 +
>  drivers/mcb/mcb-parse.c                |  2 +-
>  drivers/mcb/mcb-pci.c                  |  1 +
>  drivers/tty/serial/8250/8250_men_mcb.c |  1 +
>  drivers/tty/serial/men_z135_uart.c     |  1 +
>  drivers/watchdog/menz69_wdt.c          |  1 +
>  9 files changed, 22 insertions(+), 15 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
