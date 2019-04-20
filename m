Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1087C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF45208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555794252;
	bh=WwC1U2+9mMkTpSJpLbCRmXhuADuIakHezjZRIEynx6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YgNARDTOmKxbc0czbWxf6pdFXbCFKlzEi/fpaYA2O3cxePPcv7sODZr6/gjYaNSIZ
	 AdXsUDraHFYVgW8kgMfsZmp1QNstty28gbwlmCc6C9lB8ziZJ5kIibi9sLCf0gmcDv
	 TS743+9cYvyMrYgNBJPWHw4U92kDiGRuSmqHdgf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfDTVEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 17:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfDTVEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 17:04:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14313208C0;
        Sat, 20 Apr 2019 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555794250;
        bh=WwC1U2+9mMkTpSJpLbCRmXhuADuIakHezjZRIEynx6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tst6j6vubcTDN1AiS3kfSLlQSGcoSyxMizE8W3LbT7ohU+cq6zuRKm23m7G7+vmDf
         FHNjQOEamYhv7TR1tdXo9JJaFTdYsuBxIrm5OxkEAd/XwnNPncgZn98uZhYwgYlXwY
         58VjM7YC7knH+DKnuimragqJ/UJbfvCzqUEXXuiY=
Date:   Sat, 20 Apr 2019 23:04:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     MosesChristopher <moseschristopherb@gmail.com>
Cc:     david.kershner@unisys.com, sparmaintainer@unisys.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: use help instead of ---help--- in
 Kconfig
Message-ID: <20190420210408.GA26021@kroah.com>
References: <20190420114646.28817-1-moseschristopherb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420114646.28817-1-moseschristopherb@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:46:46AM +0000, MosesChristopher wrote:
> From: Moses Christopher <moseschristopherb@gmail.com>
> 
>   - Resolve the following warning from the Kconfig,
>     "WARNING: prefer 'help' over '---help---' for new help texts"
> 
> Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
> ---
>  drivers/staging/unisys/Kconfig            | 2 +-
>  drivers/staging/unisys/visorhba/Kconfig   | 2 +-
>  drivers/staging/unisys/visorinput/Kconfig | 2 +-
>  drivers/staging/unisys/visornic/Kconfig   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

This, and all of your other ---help--- conversion patches, do not apply
at all as some of these have already been done by others in my tree.
Please rebase all of your help cleanup staging patches against my
staging-next branch and resend any remaining ones that are needed, as
I'm going to drop all of these from my queue right now.

thanks,

greg k-h
