Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83638C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449B32467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576822807;
	bh=v9ILot23daJ7rPOYHq9Zm727Nt33IBlYozS2RKD16XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tp8dB2EOWqPdysveuq5UiMuaMp2/a8yscoDdoNtj46bNQsE5c4dSkXih9JoiOKaqD
	 zTS6xiNvoErqIqzhDUJ+1ipbdtxTLNp44YbLjkrw0RH4LYfjYcCVpyXf5NUnfdK7Si
	 qE88yAoyCZyL9MLjmSVO/bWYlJ0h+2LFPkT9kymA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfLTGUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfLTGUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:20:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBF5B2465E;
        Fri, 20 Dec 2019 06:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576822805;
        bh=v9ILot23daJ7rPOYHq9Zm727Nt33IBlYozS2RKD16XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pd4Ab08D8JT1mUVlvsnKCYN58TmiBIRhxItpjz7RrKbV2i1JzG9nx79licIl7Ht0k
         y8S42U7bllNuEcYFc9+/fflwaz5Y/kgqCXQM0zkY4OE31cqMLZBlxCxaKCF7KoBkZ2
         5PiUB9R0UbCG5WSIvYCAGdySMvEM/RJVXrabcuBo=
Date:   Fri, 20 Dec 2019 07:20:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
Cc:     nsaenzjulienne@suse.de, devel@driverdev.osuosl.org,
        f.fainelli@gmail.com, sbranden@broadcom.com, tiwai@suse.de,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        rjui@broadcom.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] Staging: vc04_services: Fix checkpatch.pl error
Message-ID: <20191220062003.GA2183431@kroah.com>
References: <20191220051414.6484-1-f20171454@hyderabad.bits-pilani.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220051414.6484-1-f20171454@hyderabad.bits-pilani.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:44:14AM +0530, Simran Sandhu wrote:
> CHECKPATH ERROR: Alignment should match open parenthesis was fixed by entroducing tabs and spaces on the location
> drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:349

That is a list of a checkpatch error, but does not say what you did.  Or
if it does, it is not properly linewrapped :(

> 
> Signed-off-by: Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

And where are patches 1-3 of this series?

Please fix up and resend the whole series.

thanks,

greg k-h
