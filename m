Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B237C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70912083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfDLBz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:55:27 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:51732 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLBz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:55:26 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.129])
        by regular1.263xmail.com (Postfix) with ESMTP id 2503B246;
        Fri, 12 Apr 2019 09:55:21 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P6496T140042209052416S1555034118987997_;
        Fri, 12 Apr 2019 09:55:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <79770d4504433393c369bbd11632b8eb>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 5/5] ARM: dts: rockchip: vdd_gpu off in suspend for
 rk3288-veyron
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
 <20190411232157.55125-5-dianders@chromium.org>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <70a7fea1-3818-b386-d951-013f94110f73@rock-chips.com>
Date:   Fri, 12 Apr 2019 09:55:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411232157.55125-5-dianders@chromium.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

ÔÚ 2019/4/12 ÉÏÎç7:21, Douglas Anderson Ð´µÀ:
> At some point long long ago the downstream GPU driver would crash if
> we turned the GPU off during suspend.  For some context you can see:
>
> https://chromium-review.googlesource.com/#/c/215780/5..6/arch/arm/boot/dts/rk3288-pinky-rev2.dts
>
> At some point in time not too long after that got fixed.
>
> It's unclear why the GPU is left enabled during suspend on the
> mainline kernel.  Everything seems fine if I turn this off, so let's
> do it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   arch/arm/boot/dts/rk3288-veyron.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 279d7f4ecce0..1252522392c7 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -217,8 +217,7 @@
>   				regulator-max-microvolt = <1250000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1000000>;
> +					regulator-off-in-suspend;
>   				};
>   			};
>   

Reviewed-by: Elaine Zhang<zhangqing@rock-chips.com>



