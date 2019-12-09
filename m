Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AC5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC85205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLIISU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:18:20 -0500
Received: from regular1.263xmail.com ([211.150.70.206]:36170 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfLIIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:18:19 -0500
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 87D59296;
        Mon,  9 Dec 2019 16:18:01 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.9] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30016T140340956382976S1575879481407888_;
        Mon, 09 Dec 2019 16:18:02 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8481befb3c8f69f16db87c6b1a8b1d32>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: maxime.chevallier@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] MAINTAINERS: rockchip: Track more files
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20191204090710.11646-1-miquel.raynal@bootlin.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <e4dc0f27-6a26-3b29-11fd-231f686fce91@rock-chips.com>
Date:   Mon, 9 Dec 2019 16:18:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204090710.11646-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2019/12/4 下午5:07, Miquel Raynal wrote:
> The current list misses a lot of drivers not prefixed or suffixed by
> "rockchip". For instance, there are plenty drivers called rk808 and
> rk805 which are currently not tracked (clk, regulator, pinctrl, RTC,
> MFD, includes, bindings). Add them to the list under the Rockchip
> entry.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>
> Hi Heiko,
>
> You are right we should try to check more often your tree. Also, here
> is a patch so that you are Cc'ed for all Rockchip related patches
> because the current list is not exhaustive at all (not sure it is
> voluntary or not though).
>
> Cheers,
> Miquèl
>
>   MAINTAINERS | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cba1095547fd..a9564e6cb872 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2198,12 +2198,16 @@ L:	linux-rockchip@lists.infradead.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +F:	Documentation/devicetree/bindings/*/*rk80*
>   F:	arch/arm/boot/dts/rk3*
>   F:	arch/arm/boot/dts/rv1108*
>   F:	arch/arm/mach-rockchip/
> +F:	include/*/*/rk808.h
> +F:	include/*/*/*/rk808.h
>   F:	drivers/clk/rockchip/
>   F:	drivers/i2c/busses/i2c-rk3x.c
>   F:	drivers/*/*rockchip*
> +F:	drivers/*/*rk80*
>   F:	drivers/*/*/*rockchip*
>   F:	sound/soc/rockchip/
>   N:	rockchip
For the Rockchip PMIC, is it better to have a NEW MAINTAINER entry like 
"ROCKCHIP PMIC DRIVER"
which share the same mailing list linux-rockchip@, because there is not 
only rk808,
but also rk805, rk809, rk817, rk818, and may be more to come.

BTW, we should use 'rk8' instead of 'rk80' to match all the Rockchip PMICs.


Thanks,
- Kever



