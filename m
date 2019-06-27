Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B21C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E64214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561653941;
	bh=geHfnday87zNNky0QEbADc/hTpwmSuzIZW5jJZ3ablM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zwtHHBlg8jd1FWw05OmTkIhq+MHTKSrReH2dhfdHjs40hBTbGQtzdutq4tqL5MrQD
	 E1r3zA+TdYxl+PsIJ9MB1MFM5vI7kaKGNryRCGATW3bUadx+JUEE+vJIJbb45ItkPp
	 Sam3nQCjqUmeZtYp6XOEkeNTIn2EFx+td1GUUpjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF0Qpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF0Qpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:45:38 -0400
Received: from localhost (unknown [89.205.136.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F7AF208E3;
        Thu, 27 Jun 2019 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561653938;
        bh=geHfnday87zNNky0QEbADc/hTpwmSuzIZW5jJZ3ablM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1/2TT0Op2kmdJV+PC4+qVKjpkcv+gw4l0jowUzihDbjl05OnzBWvOuUp0KlknhqY
         WEhHTLWUDU3goqzljCcPkHCd0cjCwyC6+kOR9i8NpaUVTqh41WW9tMmqbpBk0oOZyX
         WuLXo9ut2pCJgvOW1FI4fIrGM66vw3tAbgyPV95s=
Date:   Fri, 28 Jun 2019 00:45:30 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?M=FCller?= <muellerch-privat@web.de>
Cc:     devel@driverdev.osuosl.org,
        Felix Trommer <felix.trommer@hotmail.de>,
        linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org,
        johnfwhitmore@gmail.com
Subject: Re: [PATCH v2 1/2] drivers/staging/rtl8192u: drop first comment line
Message-ID: <20190627164530.GD9692@kroah.com>
References: <20190626015301.GA30966@kroah.com>
 <20190627083336.3897-1-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627083336.3897-1-muellerch-privat@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 10:33:35AM +0200, Christian Müller wrote:
> As stated in coding-styles.rst multiline comments should be structured in a way,
> that the actual comment starts on the second line of the commented portion. E.g:
> 
> /*
>  * Multiline comments
>  * should look like
>  * this.
>  */
> 
> However, there is an exception to files in drivers/net/ and net/, where
> multiline comments are prefered to look like this:
> 
> /* Mutliline comments for
>  * drivers/net/ should look
>  * like this.
>  */
> 
> The comments in this file initially looked like the first example.
> But since this file is part of a networking driver and thus should
> be moved to drivers/net/ one day, this patch adjusts the comments
> such that they are fitting to the style imposed for drivers/net/.
> 
> Signed-off-by: Christian Müller <muellerch-privat@web.de>
> Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
> ---
>  drivers/staging/rtl8192u/r8192U_dm.c | 69 ++++++++++------------------
>  1 file changed, 23 insertions(+), 46 deletions(-)

What changed from v1?  That always goes below the --- line.

Please fix up and send v3.

thanks,

greg k-h
