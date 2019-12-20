Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B78CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE08A24679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfLTIzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:55:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58240 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:55:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id BBB88283BD6
Subject: Re: [PATCH 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
To:     Prashant Malani <pmalani@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20191219201340.196259-1-pmalani@chromium.org>
 <20191219201340.196259-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f3d6267e-2429-e5a0-2a0e-60cab5bb1bb9@collabora.com>
Date:   Fri, 20 Dec 2019 09:55:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219201340.196259-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

This should be [PATCH v3 2/2]. All the patches in the series should have the
same version otherwise makes difficult to follow.

Thanks,
 Enric

On 19/12/19 21:13, Prashant Malani wrote:
> Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
> subdevice on non-ACPI platforms.
> 
> This driver allows other cros-ec devices to receive PD event
> notifications from the Chrome OS Embedded Controller (EC) via a
> notification chain.
> 
> Change-Id: I4c062d261fa1a504b43b0a0c0a98a661829593b9
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index c4b977a5dd966..1dde480f35b93 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
>  static const struct mfd_cell cros_usbpd_charger_cells[] = {
>  	{ .name = "cros-usbpd-charger", },
>  	{ .name = "cros-usbpd-logger", },
> +#ifndef CONFIG_ACPI
> +	{ .name = "cros-usbpd-notify", },
> +#endif
>  };
>  
>  static const struct cros_feature_to_cells cros_subdevices[] = {
> 
