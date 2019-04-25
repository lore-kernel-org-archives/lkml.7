Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7963C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC5A218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfDYIuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:50:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:50:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9C452281AC2
Subject: Re: [PATCH 24/30] mfd: cros_ec: Update I2S API
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20190424232918.243308-1-gwendal@chromium.org>
 <20190424232918.243308-25-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f04768c8-c87c-a076-c279-e6de63fd41e3@collabora.com>
Date:   Thu, 25 Apr 2019 10:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424232918.243308-25-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

On 25/4/19 1:29, Gwendal Grignou wrote:
> Improve I2S API.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 44 +++++++++++++---------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 

[snip]

>  
> -/*
> - * For subcommand EC_CODEC_GET_GAIN.
> - */
> -struct ec_response_codec_gain {
> -	uint8_t left;
> -	uint8_t right;
> -} __ec_align1;

You should probably also update sound/soc/codecs/cros_ec_codec.c to the new
struct name in this patch, otherwise we'll get a compiler error.


>  
>  /*****************************************************************************/
>  /* System commands */
> 

Thanks,
 Enric
