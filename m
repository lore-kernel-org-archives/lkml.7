Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6FCC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC252064A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfDLByD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:54:03 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:42646 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfDLByD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:54:03 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.171])
        by regular1.263xmail.com (Postfix) with ESMTP id CE59F2C0;
        Fri, 12 Apr 2019 09:54:00 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P28523T140168360212224S1555034038271042_;
        Fri, 12 Apr 2019 09:53:59 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <096e577046f42c79b546a58a0e0c3eff>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 4/5] ARM: dts: rockchip: vcc33_ccd off in suspend for
 rk3288-veyron-chromebook
To:     Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dbasehore@chromium.org, amstan@chromium.org,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190411232157.55125-1-dianders@chromium.org>
 <20190411232157.55125-4-dianders@chromium.org>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <d032d8b2-3b21-03f2-ecad-fc0889f6011b@rock-chips.com>
Date:   Fri, 12 Apr 2019 09:53:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411232157.55125-4-dianders@chromium.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

ÔÚ 2019/4/12 ÉÏÎç7:21, Douglas Anderson Ð´µÀ:
> As per my comments when the device tree for rk3288-veyron-chromebook
> first landed:
>
>> Technically I think vcc33_ccd can be off since we have
>> 'needs-reset-on-resume' down in the EHCI port (this regulator is for
>> the USB webcam that's connected to the EHCI port).
>>
>>   ...but leaving it on for now seems fine until we get suspend/resume
>> more solid.
> It's probably about time to do it right.
>
> [1] https://lore.kernel.org/linux-arm-kernel/CAD=FV=U37Yx8Mqk75_x05zxonvdc3qRMhqp8TyTDPWGHqSuRqg@mail.gmail.com/
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> index b9cc90f0f25c..fbef34578100 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> @@ -176,8 +176,7 @@
>   			regulator-min-microvolt = <3300000>;
>   			regulator-max-microvolt = <3300000>;
>   			regulator-state-mem {
> -				regulator-on-in-suspend;
> -				regulator-suspend-microvolt = <3300000>;
> +				regulator-off-in-suspend;
>   			};
>   		};
>   	};

Reviewed-by: Elaine Zhang<zhangqing@rock-chips.com>



