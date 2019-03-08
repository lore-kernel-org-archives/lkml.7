Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F998C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69DB20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="apA2AZpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCHDkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:40:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCHDkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A05y72QMPKbKHa4csRtpOBZKFYrNMQQIg8Wv6kmGa4k=; b=apA2AZpJm2QJZySN3GtbLZQyV
        SBdPq/XerCJThdZYrWevEGMHo0Hj4k4n8MmxcQP5X8JM9DWdclw+3lbG2YqnMevj9s0perKT/jY5L
        1FmLYEugUW+bx2T6OsgmQ5UngDjn5lV28oxG2Z8mUEBHy1mevX3nrRjxVO6NVRYdnp6LIFSxJZc3I
        cwf1b+6uQIKeRnMxxsww0UyW1ZQGrmMkmgelG8K4OD60yYDUMvS03UuQSqmz5u+Adm3llZrKoW6vS
        IqGEPrbysqLaBBC6ijYp0KJQvkxCabb8Npckvp6kynvBEAmjzADi3YJq9Q5bHtCmoe5iLjjJbbG5x
        xEAsqXqGw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h26Mo-0006BU-Tr; Fri, 08 Mar 2019 03:40:15 +0000
Subject: Re: [PATCH 6/9] docs: Use correct list markup character
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190307211153.28400-7-tobin@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f5d4469a-ab32-46cb-c1e9-16712043465b@infradead.org>
Date:   Thu, 7 Mar 2019 19:40:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307211153.28400-7-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/19 1:11 PM, Tobin C. Harding wrote:
> Sphinx uses a star not a hyphen for lists.
> 
> Use correct list markup character.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Hi Tobin,

The blank line insertions are all that is needed.
And I have already sent a patch for that.

Also, a list can begin with any of:
"A text block which begins with a "*", "+", "-", "•", "‣", or "⁃", followed by whitespace, is a bullet list item (a.k.a. "unordered" list item)."

from http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#bullet-lists


> ---
>  Documentation/driver-api/gpio/board.rst |  5 +++--
>  Documentation/laptops/lg-laptop.rst     | 12 ++++++------
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
> index a0f294e2e250..a5d5c22ab610 100644
> --- a/Documentation/driver-api/gpio/board.rst
> +++ b/Documentation/driver-api/gpio/board.rst
> @@ -204,8 +204,9 @@ between a caller and a respective .get/set_multiple() callback of a GPIO chip.
>  
>  In order to qualify for fast bitmap processing, the array must meet the
>  following requirements:
> -- pin hardware number of array member 0 must also be 0,
> -- pin hardware numbers of consecutive array members which belong to the same
> +
> +* pin hardware number of array member 0 must also be 0.
> +* pin hardware numbers of consecutive array members which belong to the same
>    chip as member 0 does must also match their array indexes.
>  
>  Otherwise fast bitmap processing path is not used in order to avoid consecutive
> diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/laptops/lg-laptop.rst
> index e486fe7ddc35..d9e560dfd045 100644
> --- a/Documentation/laptops/lg-laptop.rst
> +++ b/Documentation/laptops/lg-laptop.rst
> @@ -9,12 +9,12 @@ Hotkeys
>  -------
>  
>  The following FN keys are ignored by the kernel without this driver:
> -- FN-F1 (LG control panel)   - Generates F15
> -- FN-F5 (Touchpad toggle)    - Generates F13
> -- FN-F6 (Airplane mode)      - Generates RFKILL
> -- FN-F8 (Keyboard backlight) - Generates F16.
> -  This key also changes keyboard backlight mode.
> -- FN-F9 (Reader mode)        - Generates F14
> +
> +* FN-F1 (LG control panel)   - Generates F15
> +* FN-F5 (Touchpad toggle)    - Generates F13
> +* FN-F6 (Airplane mode)      - Generates RFKILL
> +* FN-F8 (Keyboard backlight) - Generates F16 (This key also changes keyboard backlight mode)
> +* FN-F9 (Reader mode)        - Generates F14
>  
>  The rest of the FN key work without a need for a special driver.
>  
> 


-- 
~Randy
