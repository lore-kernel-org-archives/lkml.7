Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F9C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5C72175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558680884;
	bh=Ezg9FUrfLeM//MLsFdIYPV8vMpcnJ48Y6b961b6QwKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mDItZ4P/QUEiOIXtOt+3yoRrYUT+j/gRkuXaZlUpyrUWp/APwzUbGX9vCLh7XRzDW
	 MkW6ajv74VdFY+anZ2aW0O37x3WQ9k/N6j6NiOXCZrxAFoiH+2a0+9YD//N/Hl9jdF
	 XtvjRXZrob56sZ72hvqUlZ+I0DC5lcp94h9kvx20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbfEXGyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388260AbfEXGyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:54:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007792175B;
        Fri, 24 May 2019 06:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558680882;
        bh=Ezg9FUrfLeM//MLsFdIYPV8vMpcnJ48Y6b961b6QwKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kqwg+br5U5Y5KtG2xNnZQUCt3B/lwvt1j5mh0WJMOpSggBsm7cvHnKMChFOf0yZF+
         3CPurzDwbS32BX3q8CCsmAhe63OBSLsPZvh9knt8Y8Vgc0FCH2a1RrEzp6rQ+hiwaW
         WdlJ5x+K9ULhh6fTOQZJY4080ISX4FmfPtAvvDLg=
Date:   Fri, 24 May 2019 08:54:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: gdm724x: Remove initialisation
Message-ID: <20190524065440.GC3600@kroah.com>
References: <20190524060026.3763-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524060026.3763-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:30:25AM +0530, Nishka Dasgupta wrote:
> The initial value of return variable ret, -1, is never used and hence
> can be removed.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Again, fix up the subject line.

thanks,

greg k-h
