Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33229C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068EA2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893354;
	bh=8qdfPFyeI8CDcDn7hTPSj0UTJyklhXLPF/NtekcTWV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tMayCg0Q0SgxNUKETfcIwC8450/3kgYxz6TKUMTBU4+55nBW+VIHMrbeIwtybHtQr
	 2XMCkV0edTgoIdGp0qLI2djggAzIBOOIKFtNA830T9OrGqarQXW9X84MJtkjLQ/NQK
	 2x4OfFbjwtD4Sr+7c3JNzGZihctzpqBLN5fB6mE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfH0IJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732496AbfH0IJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:09:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D64462173E;
        Tue, 27 Aug 2019 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893347;
        bh=8qdfPFyeI8CDcDn7hTPSj0UTJyklhXLPF/NtekcTWV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLmiB1p4jVrlqPMTuppgLfFPJRN08vwXl/0QU88fB50DbeozirIJaG45L7c+m+pIH
         EehN//eulODgGNOfbq2+zNueju1Y+2fLJ5Hf7Q0NpTi9Otw1/KcEqJZqbo8Cvvohu8
         yuFj99eO8kjmODZxW/JQTjwdA9lIIQyEAa9+kdsI=
Date:   Tue, 27 Aug 2019 09:58:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH 1/9] staging: greybus: fix up SPDX comment in .h files
Message-ID: <20190827075802.GA29204@kroah.com>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-2-gregkh@linuxfoundation.org>
 <20190826055119.4pbmf5ape224giwz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826055119.4pbmf5ape224giwz@vireshk-i7>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 11:21:19AM +0530, Viresh Kumar wrote:
> On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> > When these files originally got an SPDX tag, I used // instead of /* */
> > for the .h files.  Fix this up to use // properly.
> > 
> > Cc: Viresh Kumar <vireshk@kernel.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Cc: Alex Elder <elder@kernel.org>
> > Cc: greybus-dev@lists.linaro.org
> > Cc: devel@driverdev.osuosl.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/staging/greybus/firmware.h               | 2 +-
> >  drivers/staging/greybus/gb-camera.h              | 2 +-
> >  drivers/staging/greybus/gbphy.h                  | 2 +-
> >  drivers/staging/greybus/greybus.h                | 2 +-
> >  drivers/staging/greybus/greybus_authentication.h | 2 +-
> >  drivers/staging/greybus/greybus_firmware.h       | 2 +-
> >  drivers/staging/greybus/greybus_manifest.h       | 2 +-
> >  drivers/staging/greybus/greybus_protocols.h      | 2 +-
> >  drivers/staging/greybus/greybus_trace.h          | 2 +-
> >  drivers/staging/greybus/hd.h                     | 2 +-
> >  drivers/staging/greybus/interface.h              | 2 +-
> >  drivers/staging/greybus/manifest.h               | 2 +-
> >  drivers/staging/greybus/module.h                 | 2 +-
> >  drivers/staging/greybus/operation.h              | 2 +-
> >  drivers/staging/greybus/spilib.h                 | 2 +-
> >  drivers/staging/greybus/svc.h                    | 2 +-
> >  16 files changed, 16 insertions(+), 16 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for all of the acks!

greg k-h
