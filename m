Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942EFC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59647218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552752859;
	bh=dK+Mv7pdA4B5XXulFzFduS2I/jK9tP/uk17/w9GV5Yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZPHS8IRRMWwE+oekdonzlV2J61N5vrfTTm5h68jkAa9oGj87/SLOo52I/YwdJTkkI
	 6RQEZ+bpc/ofrAlsBGhcbeMy7BmelzjR2em0HfjprN+10bmDmBr9B+bgpxMjZ8+bT+
	 gghxE82A4jxPIWXFNvyhVYeQLbzkPdmpos//FBb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfCPQOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPQOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:14:18 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E493821905;
        Sat, 16 Mar 2019 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552752856;
        bh=dK+Mv7pdA4B5XXulFzFduS2I/jK9tP/uk17/w9GV5Yg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bfmih9CJ6NU2xAyn0jJPn/Qv9cAivDvPcIGfwQlnChQuWfMEYM0kXT3CpLN+bVrNW
         kVYyRUr7A68PgAhhVotfO3nLiezccV/vY3Osja5orVB/Wk6Oxetk15YXYPUVpxisyj
         nPNVwRESIKOxLCSh5C3WkEUyM03GbWhZgw/sheCo=
Date:   Sat, 16 Mar 2019 16:14:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] iio: cros_ec: Switch to SPDX identifier.
Message-ID: <20190316161410.3f106c7e@archlinux>
In-Reply-To: <20190313114120.11878-1-enric.balletbo@collabora.com>
References: <20190313114120.11878-1-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 12:41:20 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Adopt the SPDX license identifier headers to ease license compliance
> management. Also fix MODULE_LICENSE for cros_ec_accel_legacy to match
> the SPDX and boiler plate license.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Applied.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c             | 12 ++----------
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 10 +---------
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c    | 10 +---------
>  drivers/iio/light/cros_ec_light_prox.c               | 10 +---------
>  drivers/iio/pressure/cros_ec_baro.c                  | 10 +---------
>  5 files changed, 6 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 3be10b121a28..46bb2e421bb9 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for older Chrome OS EC accelerometer
>   *
>   * Copyright 2017 Google, Inc
>   *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   * This driver uses the memory mapper cros-ec interface to communicate
>   * with the Chrome OS EC about accelerometer data.
>   * Accelerometer access is presented through iio sysfs.
> @@ -415,5 +407,5 @@ module_platform_driver(cros_ec_accel_platform_driver);
>  
>  MODULE_DESCRIPTION("ChromeOS EC legacy accelerometer driver");
>  MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 7d3950952ae6..17af4e0fd5f8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * cros_ec_sensors - Driver for Chrome OS Embedded Controller sensors.
>   *
>   * Copyright (C) 2016 Google, Inc
>   *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   * This driver uses the cros-ec interface to communicate with the Chrome OS
>   * EC about sensors data. Data access is presented through iio sysfs.
>   */
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index eb7b0edd5da4..719a0df5aeeb 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -1,16 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * cros_ec_sensors_core - Common function for Chrome OS EC sensor driver.
>   *
>   * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/delay.h>
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 7bb3078217b3..308ee6ff2e22 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -1,16 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * cros_ec_light_prox - Driver for light and prox sensors behing CrosEC.
>   *
>   * Copyright (C) 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/device.h>
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 886690785047..034ce98d6e97 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -1,16 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * cros_ec_baro - Driver for barometer sensor behind CrosEC.
>   *
>   * Copyright (C) 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/device.h>

