Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A955C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE147217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCQHQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 03:16:06 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:36784
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbfCQHQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 03:16:06 -0400
X-IronPort-AV: E=Sophos;i="5.58,488,1544482800"; 
   d="scan'208";a="299669121"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Mar 2019 08:16:03 +0100
Date:   Sun, 17 Mar 2019 08:16:02 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jules Irenge <jbi.octave@gmail.com>
cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        gregkh@linuxfoundation.org
Subject: Re: [Outreachy kernel] [PATCH] staging: speakup: fix line over 80
 characters.
In-Reply-To: <20190317033946.12585-1-jbi.octave@gmail.com>
Message-ID: <alpine.DEB.2.21.1903170815310.2588@hadrien>
References: <20190317033946.12585-1-jbi.octave@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Mar 2019, Jules Irenge wrote:

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

It's only a few characters over 80.  Maybe you can rephrase the comment
instead.

julia

>  		index = simple_strtoul(cp, &temp, 10);
>  		if (index > 255) {
>  			rejected++;
> @@ -788,7 +788,7 @@ static ssize_t message_store_helper(const char *buf, size_t count,
>  			continue;
>  		}
>
> -		/* Do not replace with kstrtoul: here we need temp to be updated */
> +/* Do not replace with kstrtoul: here we need temp to be updated */
>  		index = simple_strtoul(cp, &temp, 10);
>
>  		while ((temp < linefeed) && (*temp == ' ' || *temp == '\t'))
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20190317033946.12585-1-jbi.octave%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
