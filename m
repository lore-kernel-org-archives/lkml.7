Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94AC2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFTTzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:55:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:47476 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFTTzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:55:46 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA6829B0;
        Thu, 20 Jun 2019 19:55:45 +0000 (UTC)
Date:   Thu, 20 Jun 2019 13:55:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: fb: Add TER16x32 to the available font names
Message-ID: <20190620135544.4a56b62a@lwn.net>
In-Reply-To: <20190619053943.6320-1-tiwai@suse.de>
References: <20190619053943.6320-1-tiwai@suse.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 07:39:43 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> The new font is available since recently.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  Documentation/fb/fbcon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index cfb9f7c38f18..1da65b9000de 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -82,7 +82,7 @@ C. Boot options
>  
>  	Select the initial font to use. The value 'name' can be any of the
>  	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
> -	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
> +	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.

Applied, thanks.

jon
