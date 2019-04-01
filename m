Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E433C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7E820850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oeia54Qd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OPcR80Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDAKXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:23:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDAKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:23:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B317361156; Mon,  1 Apr 2019 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554114182;
        bh=xrfDHV2ZDwZ3fGmcMUjhrakJHU3C0nmeLhjD97l/13g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oeia54QdCRjSxwkTpgeH102hYapxnApFhq6HeoQWSDjTzSoD3JY2bb7wZU0py2OBe
         HGZ36tbRWSYgtLKimGbQsb/dLzkWRfQhmwxtFOBx1C4VqGYgkQk6VhtjX4bcNYJI9z
         UsaeTBt2TfwQuKJ/8IY1w1hVZCXQfMEV8HRPnjq4=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5ED236037C;
        Mon,  1 Apr 2019 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554114180;
        bh=xrfDHV2ZDwZ3fGmcMUjhrakJHU3C0nmeLhjD97l/13g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OPcR80SdxHygTIXswxVZQm0NwMw1AvZ+K53sz5x6bFmKEVSd+gs5CXdGLe/oe5Km6
         iJAuS9+hZ51Ej08AmYhNjVpoXVGl3F6Vbqgbt5OaglzXMhKp/iPzZOE7SOwUlaeBXl
         gXIOJH142ZoOe4bFiYfRd41l4v20JKhT/KA6f87c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5ED236037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drivers: fix a typo in the kernel doc for
 devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190401081635.18673-1-brgl@bgdev.pl>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <29cb0f74-672a-56f3-6e85-82f7e2a99ddf@codeaurora.org>
Date:   Mon, 1 Apr 2019 15:52:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401081635.18673-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 1:46 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> It should have been 'management' not 'managemend'.
>
> Fixes: 7945f929f1a7 ("drivers: provide devm_platform_ioremap_resource()")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/base/platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dab0a5abc391..09c00d91094c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
>    *				    device
>    *
>    * @pdev: platform device to use both for memory resource lookup as well as
> - *        resource managemend
> + *        resource management


:-)

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>    * @index: resource index
>    */
>   #ifdef CONFIG_HAS_IOMEM
