Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93021C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562312175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558680763;
	bh=zGkuxttrw1UmSJWca23xUWI1IwnUSwaGUvRQAcheqzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=giEhUKQbpS2plE4yMChCGpkZwSsIHqhzTKci6bZDgGM16Jpo9w/CF+O7738o9j6qY
	 70FbTQn8IPYIBfKFaUKtKhovdvGMKVxtFVEM8v3dMoIxUPx0QZCUbrqserv/0JMQvo
	 ZN3tjCRknitvInznu4fxL5dIKSeQK0iTOxPBVC/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbfEXGwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388359AbfEXGwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:52:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 754302133D;
        Fri, 24 May 2019 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558680761;
        bh=zGkuxttrw1UmSJWca23xUWI1IwnUSwaGUvRQAcheqzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JD/ztmv9msJLFWmTf6QO8wZ2Qb2gDH1dgnGfwglonS9IHZdQ4430o5Onyrn8uY5yr
         U+vgoyJ+igk/ETXjvC7b4U4pf07bDJcSSMLSLiHqY3RdEeHKydgXDmcP6udh9dI0Fu
         JPln1PZiMUYRKaehLJ7MrhOfNHmtG1v7+lN/NxmU=
Date:   Fri, 24 May 2019 08:52:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: Remove initialisation
Message-ID: <20190524065238.GA3600@kroah.com>
References: <20190524055602.3694-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524055602.3694-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:26:02AM +0530, Nishka Dasgupta wrote:
> As the initial value of the return variable result is never used, it can
> be removed.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/ks7010/ks7010_sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Didn't you already send this?

And please run a spell-checker on your subject line when you resend
this :)

thanks,

greg k-h
