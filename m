Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA37EC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02742067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgAIOLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:11:20 -0500
Received: from foss.arm.com ([217.140.110.172]:59870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgAIOLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:11:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E0D31FB;
        Thu,  9 Jan 2020 06:11:19 -0800 (PST)
Received: from [10.1.27.38] (unknown [10.1.27.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A9AE3F534;
        Thu,  9 Jan 2020 06:11:15 -0800 (PST)
Subject: Re: [PATCH v2 6/7, RFC] drm/panfrost: Add bifrost compatible string
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        hsinyi@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200108052337.65916-1-drinkcat@chromium.org>
 <20200108052337.65916-7-drinkcat@chromium.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <44e095c1-7860-068f-567f-249c29cdca1f@arm.com>
Date:   Thu, 9 Jan 2020 14:11:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108052337.65916-7-drinkcat@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2020 05:23, Nicolas Boichat wrote:
> For testing only, the driver doesn't really work yet, AFAICT.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

It does work (at least on the Hikey960), we just don't have any public user space driver for it... ;)

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 48e3c4165247cea..f3a4d77266ba961 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -591,6 +591,7 @@ static const struct of_device_id dt_match[] = {
>   	{ .compatible = "arm,mali-t830" },
>   	{ .compatible = "arm,mali-t860" },
>   	{ .compatible = "arm,mali-t880" },
> +	{ .compatible = "arm,mali-bifrost" },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, dt_match);
> 

