Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319ECC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083A520881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEOKEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:04:06 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfEOKEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:04:05 -0400
Received: from [192.168.178.167] ([109.104.37.15]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mf0yy-1gkOTQ1SsU-00gZHW; Wed, 15 May 2019 12:03:54 +0200
Subject: Re: [PATCH] Staging: vc04_services: Fix kernel type 'u32' over
 'uint32_t'
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>, eric@anholt.net,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190514160207.11573-1-madhumithabiw@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <43fc8207-6b5b-1caa-3d19-f44074fffd0b@i2se.com>
Date:   Wed, 15 May 2019 12:03:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514160207.11573-1-madhumithabiw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:ZZ/Aph7ySsODYCaWcBvIhpYEYIK+oOwwTCobv8+RoU/h78qB+pX
 ZjgwxWVD58BI6VP2C47FP4oCKkw98WDnibwVSehCZ05isrEROxFXD0z/yqHJYydb0CpfZwO
 wTXQd4GwzoIsCYPEFp6LX3bg2uWkFH9AUXhlW4taQObJyPboLnEBTNUd6hfldgDSWmspJR2
 9BELG2jOY2nWHif04sEoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l/NocFB9fqM=:dgBXAKqJG7ZUkxWbz2pGBe
 MtAPLIMZA+jYGEi78sP8NJnywlwlQZEed8KaCYTIFsxiyLSuEGWy8OADJQXJNTfMjLCs69uKP
 hVoybyusQoo0FfU/wCyt9YBY+rpSw+fSmNEY65AKWYr7eoerTGY7S/YuUyAG8551iGSERxkks
 SecXVW7oMn3yNZcU+lXy6py7PQ1RdqEmUfmxZQg8qlon+e2yvyTwYqpiyjl3UPiYo/gIweji8
 qqNzn9pxCOSIq8BhBiHv42W18Fsh3+Jv572LgNgsNFKyZhbrsgRjPFs3+a3ghKkx8+zX90plw
 ZiW+h8mYUiCtGCacRqfCENa7f6rtyIKcWkbUsEkzqju+xhxeqsa+5cYqOlWQ1e3jNDS+m+K55
 sEHn3ilyeRQnCgqzMe//pIVFzM9yHkeUNbDWDGLvAiOf2BfmzxIYRH1pIenu88oGIWSD4KPWj
 XW7DGeAydV7j5f4MUfc3Ykezo9u+p//xaq9iBLO589Nas1m5SFZ/UNMBi5GAE6CCS8HEa9Z30
 2iMb7qVF0wWmExUUJAR8eKhsPsJsdIpp/1YoQx8y6mymFxsTfwdtIkOBOMJ3VKA9T5URIVM6Y
 7+voQq1cOhf9JqDsBcjMPnOCL9f3ncBSaM8stdXc8NsDH3HytjrYa8UCLoO0+9yCEoblx0SWv
 dkEHGI5ZmTPNXKMHnP1cqbYYKiG0X3IuHiWKdjIlDUocoxBpEIRXkNuzZUDszOuAoAGcM/jj1
 BcaUGXh6VAMXcf+E6/CFkXZoHLcyQCGEZnk8cufoHHWDZm6ll07UuFMN73s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Madhumitha,

On 14.05.19 18:02, Madhumitha Prabakaran wrote:
> Fix the warning issued by checkpatch
> Prefer kernel type 'u32' over 'uint32_t'

grepping the sources within vc04_services shows a lot more occurences.

I suggest to fix this style issue at least for the whole camera driver
and name the patch like

staging: bcm2835-camera: prefer kernel types

Regards
Stefan

>
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
> index d1c57edbe2b8..90793c9f9a0f 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
> +++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
> @@ -309,7 +309,7 @@ struct mmal_msg_port_parameter_set {
>  	u32 port_handle;      /* port */
>  	u32 id;     /* Parameter ID  */
>  	u32 size;      /* Parameter size */
> -	uint32_t value[MMAL_WORKER_PORT_PARAMETER_SPACE];
> +	u32 value[MMAL_WORKER_PORT_PARAMETER_SPACE];
>  };
>  
>  struct mmal_msg_port_parameter_set_reply {
> @@ -331,7 +331,7 @@ struct mmal_msg_port_parameter_get_reply {
>  	u32 status;           /* Status of mmal_port_parameter_get call */
>  	u32 id;     /* Parameter ID  */
>  	u32 size;      /* Parameter size */
> -	uint32_t value[MMAL_WORKER_PORT_PARAMETER_SPACE];
> +	u32 value[MMAL_WORKER_PORT_PARAMETER_SPACE];
>  };
>  
>  /* event messages */
