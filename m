Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B5C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2902053B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556371939;
	bh=F/Ri3rbRNbdBS8CeJ3YkqZ5ALE9RaYzYV4i/TX+VbhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sH/LqrSXNZIEdaGStlx1hyrs0tHsftJE/gA5UdmEUqyp0oqjrOW2NQKqBvaX6gExM
	 b2DdqC2RTDGcb7dB7HY5oSpTPJUf8emEsuJX3fFbfzG/xOtyAz88touUASYhB2GOuZ
	 x0zzcsJdAEEWqtvxw73ueHG5crMJZaWKqNGCAri8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfD0NcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfD0NcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:32:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E433F2087F;
        Sat, 27 Apr 2019 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556371937;
        bh=F/Ri3rbRNbdBS8CeJ3YkqZ5ALE9RaYzYV4i/TX+VbhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nexBWa1sKOnsIU/+eE/Arr0X7crav6ldqrhFgjM7W8ztYCtpv+iiTXftfvQTPlJG3
         Z8PjosvAL9baHK8g4HVoOep4odQGPEL6uE1Db+W4FngO8Erm7fuwx70sU6Qt1CWHRh
         QbmdhCLabzZBpyFVy53w/oRoRA4SbXzVCZ0vDS90=
Date:   Sat, 27 Apr 2019 15:32:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 10/41] drivers: tty: serial: sb1250-duart: fix missing
 parentheses
Message-ID: <20190427133215.GD11368@kroah.com>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-11-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556369542-13247-11-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 02:51:51PM +0200, Enrico Weigelt, metux IT consult wrote:
> Fix checkpatch warning:
> 
>     ERROR: Macros with complex values should be enclosed in parentheses
>     #911: FILE: drivers/tty/serial/sb1250-duart.c:911:
>     +#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/tty/serial/sb1250-duart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
> index 1184226..ec74f09 100644
> --- a/drivers/tty/serial/sb1250-duart.c
> +++ b/drivers/tty/serial/sb1250-duart.c
> @@ -908,7 +908,7 @@ static int __init sbd_serial_console_init(void)
>  
>  console_initcall(sbd_serial_console_init);
>  
> -#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console
> +#define SERIAL_SB1250_DUART_CONSOLE	(&sbd_console)

No, that's foolish.

checkpatch is a hint, it's not always right.

Also, checkpatch cleanups for really old drivers is not generally a good
idea, especially if you do not have the hardware for them.  Please don't
cause unneeded churn for this type of thing in this subsystem, unless
you have the hardware.

thanks,

greg k-h
