Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143D1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11F92084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDLKsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:48:46 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:53505 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfDLKsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:48:46 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Etjch0Hk1NG8zEtjdhCQ2y; Fri, 12 Apr 2019 12:48:44 +0200
Subject: Re: [PATCH] Fixed coding style: do not initialise statics to NULL
To:     Tiago Macedo <tiagohenrique.macedo@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, lkcamp@lists.libreplanetbr.org,
        Tiago Macedo <tiagohenrique.macedo@gmai.com>
References: <20190412024520.26835-1-tiagohenrique.macedo@gmai.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c26613c6-1212-8ccd-e762-c7280509844e@xs4all.nl>
Date:   Fri, 12 Apr 2019 12:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412024520.26835-1-tiagohenrique.macedo@gmai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIFrXwkTMi4t9No60l1k8PQdFIF6vmKEbv+qm+XaqFQMazI8t4xOiMffSRGFlrYagAY8C+QvFF+X42mHbg7wWFm/sXqW5RS84VWgOAlnAcBMmyNJtKNN
 +fP7vATd77iAwdKtMGbfIFenwLg2NDlUb4NjgKMmVmbrdaEHvQ7MAbqMN/PtnVt5B7B9V4Z7fT94Xh5M+IHA+RLei+5R5HxRipNWiYN9d/pzDeGJb3IT0OLX
 x/W7wqwGPAexOf8hHm1zs82WbWaMv27I2MBOdktoC7A3FVATqd9Tci53G2QoxUw+dtk/0mZZmL3yGkZGtW6Gf/aqZfXYzdEA85B/aYis/fSjY9mY90Mb0r+c
 7t53yRM5U92DfsgWZQRl5mx5m973hyLIevc9sRgAxMESxoGo2jV7AvZ/bNI4ajmLOQiSR5smboLMMf9CCQs5sHNfyW9RJrJT+FVaeyP3Up5CvWR8/F9gUkBo
 RfkDtA7i40jlCvI8+D5CFENWR8WnDWF4on4FDDwW9Dv692FDHTEiAAhhKj0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiago,

On 4/12/19 4:45 AM, Tiago Macedo wrote:
> The standard guarantees that a pointer with static storage duration
> and no other initializer will be initialized to be a null pointer.
> 
> Signed-off-by: Tiago Macedo <tiagohenrique.macedo@gmai.com>
> ---
>  drivers/staging/media/zoran/videocodec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
> index c1ee5cb7e66b..cc6e0f1cd7b4 100644
> --- a/drivers/staging/media/zoran/videocodec.c
> +++ b/drivers/staging/media/zoran/videocodec.c
> @@ -51,7 +51,7 @@ struct codec_list {
>  	struct codec_list *next;
>  };
>  
> -static struct codec_list *codeclist_top = NULL;
> +static struct codec_list *codeclist_top;
>  
>  /* ================================================= */
>  /* function prototypes of the master/slave interface */
> 

I dropped this patch since the zoran driver will be removed for 5.2,
so there is no point in applying this patch.

Also, for future reference, please provide the name of the driver that
you are patching in the subject. I.e. something like this:

[PATCH] zoran: fixed coding style: do not initialise statics to NULL

That helps triage for maintainers.

Regards,

	Hans
