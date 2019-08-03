Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6862EC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0A62087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564813971;
	bh=5uFzZfIoEwQBrWrcs4j9f2dtR+4Xisp4P+uNFPPnC6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F5Qu87flhITIild10+rhV4RN69ewreGEwdJpToAcpmHgdWDQWZ7K7YyBTzVwJ+Xwe
	 +IjnnYMbJdFupCNyA1PjwlouwestzLN/P1YWPQPBL0EhC/AJ2He3o2dKzCKvIZwwoM
	 78RJ+/aRenAZhxl9OsrPHUyXZOmtOg5uG2TsHYzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfHCGcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHCGct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:32:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 664302087C;
        Sat,  3 Aug 2019 06:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564813968;
        bh=5uFzZfIoEwQBrWrcs4j9f2dtR+4Xisp4P+uNFPPnC6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lh1FEk9/Jhz2/FN/OK8/GklDYDO8dc7O27K+G/TM8SPQnlKeRzAsGlwtG6uVw+qtN
         3tICWpwn5LR5OKXCOUHPFxPOnmUYdg0imvF3gHaOrzXYryouxEkoLrhMfwau/m7b2p
         x7AmU1cHO6IqPw1+USVh/Dzh7aeHb5sEG5N9pInk=
Date:   Sat, 3 Aug 2019 08:32:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
Cc:     isdn@linux-pingi.de, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: hysdn: Fix error spaces around '*'
Message-ID: <20190803063246.GA10186@kroah.com>
References: <20190802195602.28414-1-joseespiriki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802195602.28414-1-joseespiriki@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 07:56:02PM +0000, Jose Carlos Cazarin Filho wrote:
> Fix checkpath error:
> CHECK: spaces preferred around that '*' (ctx:WxV)
> +extern hysdn_card *card_root;        /* pointer to first card */
> 
> Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
> ---
>  Hello all!
>  This is my first commit to the Linux Kernel, I'm doing this to learn and be able
>  to contribute more in the future
>  Peace all! 
> 
>  drivers/staging/isdn/hysdn/hysdn_defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/isdn/hysdn/hysdn_defs.h b/drivers/staging/isdn/hysdn/hysdn_defs.h
> index cdac46a21..f20150d62 100644
> --- a/drivers/staging/isdn/hysdn/hysdn_defs.h
> +++ b/drivers/staging/isdn/hysdn/hysdn_defs.h
> @@ -220,7 +220,7 @@ typedef struct hycapictrl_info hycapictrl_info;
>  /*****************/
>  /* exported vars */
>  /*****************/
> -extern hysdn_card *card_root;	/* pointer to first card */
> +extern hysdn_card * card_root;	/* pointer to first card */

The original code here is correct, checkpatch must be reporting this
incorrectly.

thanks,

greg k-h
