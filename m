Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00051C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C092084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554098549;
	bh=QN31HYH6tlF2rdKrrnwsFYQQSpZPn+aCEhD/ZJFAJ58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s2wIOK6OtwFmjJvDNFkTZ3Jyb/+RM9XSkkl8voVuoOL7At8DgcN/hrua/7jLbqix8
	 z0KsPpb6ipzg9Lh2ZKExyJ7vn9gMKY/hNit2ZuP+8epOcwYD/blT3wrV3iKSdpcHKS
	 9ATKw3u9xWuAqAUp/YbnqhzEoTjAwZqKIfmKwijQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfDAGC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbfDAGC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:02:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BCF2084B;
        Mon,  1 Apr 2019 06:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554098547;
        bh=QN31HYH6tlF2rdKrrnwsFYQQSpZPn+aCEhD/ZJFAJ58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tb+oiS7FbQCz7AjFCJy6D+lgNA499JURJA2zVQeWxduP+kch2Q6yL/45DhTqeTG8S
         TxKRC0ZZguIChHyeQjOdVIoM068tODDfOVeivBkngsVsW5IlU50avCguniRIJWrnl2
         OwX2REx5lzr410MjPvOjdsqDOe47G6ASpUqkggYQ=
Date:   Mon, 1 Apr 2019 08:02:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Cunningham <wjcunningham7@gmail.com>
Cc:     abbotti@mev.co.uk, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: comedi: drivers: pcl818: Fixed a coding style
 error.
Message-ID: <20190401060216.GA5286@kroah.com>
References: <20190331225336.GA26547@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331225336.GA26547@titus.pi.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 06:53:36PM -0400, Will Cunningham wrote:
> Removed unnecessary parentheses.`

Odd trailing character :(

> 
> Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
> ---
>  drivers/staging/comedi/drivers/pcl818.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/pcl818.c b/drivers/staging/comedi/drivers/pcl818.c
> index 0af5315d4357..da5d53a288f7 100644
> --- a/drivers/staging/comedi/drivers/pcl818.c
> +++ b/drivers/staging/comedi/drivers/pcl818.c
> @@ -1012,7 +1012,7 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>  		pcl818_alloc_dma(dev, it->options[2]);
>  
>  	/* use 1MHz or 10MHz oscilator */
> -	if ((it->options[3] == 0) || (it->options[3] == 10))
> +	if (it->options[3] == 0 || it->options[3] == 10)

No, please leave as-is.  () are there for humans to read, and having to
always remember the order of operations is not something you ever want
to do.

I _REALLY_ hate this option of checkpatch :(

greg k-h
