Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994D1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6B922D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567496093;
	bh=YKoeEEldfy/WYhAHKQYbBaFLYZrzr3muEwT7qxKfo4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IOXwY1mcukE0/dwHTTjdCdrBb99pH2BZX3vyrwdvepz3iK4ucQEW/RFO5plPEiPlh
	 MU83RNC6bZUj1cv7GEWnVh5VexBkfS4Ywzb6tBCptIuUtP023ZXSyJjgDOFLSncgzc
	 gTS7qnZ9C5r+RH0quXx2kcAzUSfxjPOsexeWGRa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfICHew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfICHew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:34:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF58722CF8;
        Tue,  3 Sep 2019 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567496091;
        bh=YKoeEEldfy/WYhAHKQYbBaFLYZrzr3muEwT7qxKfo4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daGXqrRoZZFLbKzMOXTlOA2v36wpdw2e9uw/eV4JdWhEzwjM2IdzKe6ufFOeOvCk0
         2vvQGhtbSFY6+i/12QbhfoTGIbMgEG88HS1PnwmfEAwsJ4d/63GiGiYieIqoNFb5aT
         IlTl5UUKfd45slTW7aWrWW9dpfwfiSywUM9dqjRY=
Date:   Tue, 3 Sep 2019 09:34:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     P SAI PRASANTH <saip2823@gmail.com>
Cc:     sabrina-gaube@web.de, qader.aymen@gmail.com,
        tobias.niessen@stud.uni-hannover.de, kim.jamie.bradley@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Fix checkpath warning
Message-ID: <20190903073448.GA21543@kroah.com>
References: <20190831073224.GA6197@dell-inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831073224.GA6197@dell-inspiron>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 01:02:24PM +0530, P SAI PRASANTH wrote:
> This patch fixes the following checkpath warning
> in file drivers/staging/rts5208/xd.c:1754
> 
> WARNING: line over 80 characters
> +                                           index, offset, DMA_TO_DEVICE,
> chip->xd_timeout);
> 
> Signed-off-by: P SAI PRASANTH <saip2823@gmail.com>
> ---
>  drivers/staging/rts5208/xd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This had the same subject line as your previous patch, but did different
things.  Please make the subjects unique.

thanks,

greg k-h
