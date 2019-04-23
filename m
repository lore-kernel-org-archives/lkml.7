Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05481C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65BD21841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfDWN4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:56:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52100 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfDWN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:56:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id BC878278760
Subject: Re: [PATCH v5 3/3] power_supply: Add missing documentation for
 CHARGE_CONTROL_* properties
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        sre@kernel.org, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org
References: <20190417214022.7jk3usygcpnls3pr@earth.universe>
 <20190418164314.161065-1-ncrews@chromium.org>
 <20190418164314.161065-3-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ee812804-05f5-145a-801d-72990e520edc@collabora.com>
Date:   Tue, 23 Apr 2019 15:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418164314.161065-3-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/4/19 18:43, Nick Crews wrote:
> The existing POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT and
> POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX properties
> don't have documentation. I add that documentation here.
> 
> v5 changes:
> - Split this commit out from the previous two commits.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  Documentation/ABI/testing/sysfs-class-power | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index a5b144f61de8..b77e30b9014e 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -114,6 +114,25 @@ Description:
>  		Access: Read
>  		Valid values: Represented in microamps
>  
> +What:		/sys/class/power_supply/<supply_name>/charge_control_limit
> +Date:		Oct 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Maximum allowable charging current. Used for charge rate
> +		throttling for thermal cooling or improving battery health.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/charge_control_limit_max
> +Date:		Oct 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Maximum legal value for the charge_control_limit property.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
>  What:		/sys/class/power_supply/<supply_name>/charge_control_start_threshold
>  Date:		April 2019
>  Contact:	linux-pm@vger.kernel.org
> 
