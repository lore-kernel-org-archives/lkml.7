Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CD4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBE2207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfL3IYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 03:24:45 -0500
Received: from regular1.263xmail.com ([211.150.70.195]:55762 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfL3IYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 03:24:44 -0500
Received: from localhost (unknown [192.168.167.70])
        by regular1.263xmail.com (Postfix) with ESMTP id 263ADBED;
        Mon, 30 Dec 2019 16:24:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.9] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12477T140653199619840S1577694249238242_;
        Mon, 30 Dec 2019 16:24:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3f527ea038d99027e820b73117dc985f>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: maxime.chevallier@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2] MAINTAINERS: Track Rockchip PMIC drivers
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20191224134122.20385-1-miquel.raynal@bootlin.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <756eaff6-0ab8-7f41-2fb2-d55057ff4534@rock-chips.com>
Date:   Mon, 30 Dec 2019 16:24:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224134122.20385-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/24 下午9:41, Miquel Raynal wrote:
> The current Rockchip section misses all the PMIC related drivers. They
> are all prefixed rk8* and are as wide as clks, regulators, pinctrl,
> RTCs, audio, etc.
>
> Add a dedicated MAINTAINER's entry.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>
> Changes since v1:
> * Create a PMIC entry in MAINTAINERS.
> * Track files with rk8 and not rk80.
>
>   MAINTAINERS | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d3a5c54a41d..d3f814212ba8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13943,6 +13943,17 @@ S:	Maintained
>   F:	drivers/staging/media/hantro/
>   F:	Documentation/devicetree/bindings/media/rockchip-vpu.txt
>   
> +ROCKCHIP PMIC DRIVERS
> +M:	Heiko Stuebner <heiko@sntech.de>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-rockchip@lists.infradead.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/*/*rk8*
> +F:	include/*/*/rk8*
> +F:	include/*/*/*/rk8*
> +F:	drivers/*/*rk8*
> +
>   ROCKER DRIVER
>   M:	Jiri Pirko <jiri@resnulli.us>
>   L:	netdev@vger.kernel.org
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever


