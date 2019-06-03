Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49738C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E2F26679
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559564429;
	bh=y1TILt/ffTUz1M9+mg0l1iL1FFJ1tJ7setoQfWG0gvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xunaikBUJ0u5INkhKgKTFoZe0S5Pa/hzcjreo9zqIy8kp4FTyHPNQh+UfaZmxqhdT
	 xtVWSNxIAWMX7HjFR2hkGiK2aiNp/b4deP0WFR0qsQ7NgzSwGj9ScjXWGZ91WJ48+p
	 uUt4cYorp/h2MbB3v8FmMq7PIpM5jK18FQ3lb4lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfFCMU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfFCMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:20:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0205F25F14;
        Mon,  3 Jun 2019 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559564427;
        bh=y1TILt/ffTUz1M9+mg0l1iL1FFJ1tJ7setoQfWG0gvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WynB5YHHwyNsvoYa11HNktiCpQXWJdscE3gqCnOHo81W7TiPNIo7ok5i1D1AhQxSR
         YNlnvPzsk+9VJTNDepe7PYDt4frz6rEEDpf1JjSdzUwahehbw3MPDX7VPXL7v5mPKW
         ZL6ts49z76fWUSCexyzdcEtpfFH96GdR4vnqAsdA=
Date:   Mon, 3 Jun 2019 14:20:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, colin.king@canonical.com,
        straube.linux@gmail.com, yangx92@hotmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Remove function alloc_network
Message-ID: <20190603122025.GA23379@kroah.com>
References: <20190530210141.30221-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530210141.30221-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:31:41AM +0530, Nishka Dasgupta wrote:
> Remove function alloc_network as it does nothing except call
> _r8712_alloc_network. Further, to maintain consistency with
> the names of other functions, rename _r8712_alloc_network as
> r8712_alloc_network.
> Also change the corresponding calls to either function
> accordingly.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_cmd.c  | 2 +-
>  drivers/staging/rtl8712/rtl871x_mlme.c | 9 ++-------
>  drivers/staging/rtl8712/rtl871x_mlme.h | 2 +-
>  3 files changed, 4 insertions(+), 9 deletions(-)

Does not apply to my tree :(

When sending multiple patches for the same driver/file, always make a
patch series so I know what order to apply them in.  Otherwise I guess
and usually guess wrong, like I did here...

Please fix up and resend.

thanks,

greg k-h
