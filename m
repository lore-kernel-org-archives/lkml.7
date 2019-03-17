Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B18CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184F421019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552817681;
	bh=j/CVYloCWztagwFFR3aAr4bU2twa07TPsKT/AmYkjHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eyY3r7Xd1fZC+bAnFJNbdTpWuldVCHt+NkeqVB1IXJ/5LOlX/FayG/tSBcHy6fY9C
	 Qx0/Y16DsPTl2yE1heERgojedDgO53tDC+bCIrBhg1kyI5iAs3bkq8cMdxlz4bBxR1
	 ftPQaEUOqmfbOjPqQBw6DfEFRVb7Ybm3Ty/orLrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCQKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbfCQKOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 06:14:39 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 617B521019;
        Sun, 17 Mar 2019 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552817678;
        bh=j/CVYloCWztagwFFR3aAr4bU2twa07TPsKT/AmYkjHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wcAblW4L2aeI9fIfvYEJYV4E5jPfaxTNrSvwEA35GHjcskF9PRjxToDFIKK/rW0Jt
         dDiXesQoT4SfL1bWkDq2L5vWu4/1nEufLc3kA1xSFTeAcvPwr6U65N2YUgasqpCW+r
         d8jtCVu4N5bxwgwUqlLUtN5Q/VSnUttBZ3lh4IS8=
Date:   Sun, 17 Mar 2019 11:14:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: speakup: fix line over 80 characters.
Message-ID: <20190317101435.GA20773@kroah.com>
References: <20190317033946.12585-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317033946.12585-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 03:39:46AM +0000, Jules Irenge wrote:
> Fix coding style issues, which solves checkpatch.pl warning:
>     "WARNING: line over 80 characters".
> ---
>  drivers/staging/speakup/kobjects.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
> index 2eb5af3debb3..abeab64899db 100644
> --- a/drivers/staging/speakup/kobjects.c
> +++ b/drivers/staging/speakup/kobjects.c
> @@ -154,7 +154,7 @@ static ssize_t chars_chartab_store(struct kobject *kobj,
>  			continue;
>  		}
>  
> -		/* Do not replace with kstrtoul: here we need temp to be updated */
> +/* Do not replace with kstrtoul: here we need temp to be updated */

No, never put code or comments this far to the left.  Instead, properly
line-wrap them.

thanks,

greg k-h
