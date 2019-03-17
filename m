Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EEBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52B821738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552822075;
	bh=XmvAVos9MEK52yYxKa9EM7zIyyB5UDwPJRxUxCJdfj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dTHWGF/L1WTgbahKVaCV1oEWg2q9qyiCVnUi2HZ9a/bRLLoaegmMjhfEcq894vPrE
	 KBRaZevwDxeH+3ge2lSumAcO6wm3hIAf8XSc2rU4DjPv7fddzMYgneMYQHfTPHjynp
	 NGWMpFQGWx9bhvywgUO0nnNuD/2ZVxDpXNrtKkIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCQL1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfCQL1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:27:54 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B0F2085A;
        Sun, 17 Mar 2019 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552822073;
        bh=XmvAVos9MEK52yYxKa9EM7zIyyB5UDwPJRxUxCJdfj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KaFFExy0EB/N+eMhQjJZqCBU3J5gGMHWZ+gqCGLmxS9UGfJt7akHMDNIQvLpu0vC+
         TIluAvaSjWNsH56QBB3u/kLDni07kRrTMeTSTV9rpu6HU04Y8swGhpvUaGVUGKaGxU
         qXD/D78Bj7s9tbeAFf2T8Hq0M+ZXWexLgqeeGPAQ=
Date:   Sun, 17 Mar 2019 12:27:50 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Manuel.Rambow@protonmail.com
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staging: greybus: pwm: fixed a coding style issue
Message-ID: <20190317112750.GH4614@kroah.com>
References: <yX1rv4IPxvoQeTsr41ohU4bFOShgOXC6gB4KpD6hrnzr3YU3ZWXzsyY7s-o_Qrese52Axxd1xxOQfpMrmfDq3sN9lJ8N9owNedzmRhU4aK8=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yX1rv4IPxvoQeTsr41ohU4bFOShgOXC6gB4KpD6hrnzr3YU3ZWXzsyY7s-o_Qrese52Axxd1xxOQfpMrmfDq3sN9lJ8N9owNedzmRhU4aK8=@protonmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:09:15PM +0000, Manuel.Rambow@protonmail.com wrote:
> Hello,
> 
> this is my very first patch, very simple and check it, so it compiles properly and also go no errors on the checkpatch script.

> From c8a66a3bee14fe89ad2a03545a76953bc880b9e6 Mon Sep 17 00:00:00 2001
> From: Manuel Rambow <Manuel.Rambow@protonmail.com>
> Date: Wed, 13 Mar 2019 13:00:35 +0100
> Subject: [PATCH] Staging: greybus: pwm: fixed a coding style issue
> 
> Fixed a blank line coding style issue.
> 
> Signed-off-by: Manuel Rambow <Manuel.Rambow@protonmail.com>
> ---
>  drivers/staging/greybus/pwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> index 4a6d394b6c44..de74c37b14e9 100644
> --- a/drivers/staging/greybus/pwm.c
> +++ b/drivers/staging/greybus/pwm.c
> @@ -21,10 +21,10 @@ struct gb_pwm_chip {
>  	struct pwm_chip		chip;
>  	struct pwm_chip		*pwm;
>  };
> +
>  #define pwm_chip_to_gb_pwm_chip(chip) \
>  	container_of(chip, struct gb_pwm_chip, chip)
>  
> -
>  static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
>  {
>  	struct gb_pwm_count_response response;
> -- 
> 2.21.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
