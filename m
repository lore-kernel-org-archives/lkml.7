Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE48C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A05620823
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfCBArx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:47:53 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:46370 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCBArx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:47:53 -0500
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.179])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7058744B4;
        Sat,  2 Mar 2019 08:47:47 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31037T140264303752960S1551487664998781_;
        Sat, 02 Mar 2019 08:47:46 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9280a201efbb18850bfb393e36136203>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_3/3=5d_arm64=3a_dts=3a_rockchip=3a_Disable?=
 =?UTF-8?B?IERDTURzIG9uIFJLMzM5OSdzIGVNTUMgY29udHJvbGxlci7jgJDor7fms6jmhI8=?=
 =?UTF-8?B?77yM6YKu5Lu255SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7ow==?=
 =?UTF-8?B?5Y+R44CR?=
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        ulf.hansson@linaro.org, adrian.hunter@intel.com
References: <20190301164349.60589-1-christoph.muellner@theobroma-systems.com>
 <20190301164349.60589-3-christoph.muellner@theobroma-systems.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <185f44f1-c41d-cb67-d5c2-5878c05516ba@rock-chips.com>
Date:   Sat, 2 Mar 2019 08:47:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301164349.60589-3-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/2 0:43, Christoph Muellner wrote:
> When using direct commands (DCMDs) on an RK3399, we get spurious
> CQE completion interrupts for the DCMD transaction slot (#31):

I didn't see it. Do you try any newer code, for instance, linux-next?

> 
> [  931.196520] ------------[ cut here ]------------
> [  931.201702] mmc1: cqhci: spurious TCN for tag 31
> [  931.206906] WARNING: CPU: 0 PID: 1433 at
> /usr/src/kernel/drivers/mmc/host/cqhci.c:725 cqhci_irq+0x2e4/0x490
> [  931.206909] Modules linked in:
> [  931.206918] CPU: 0 PID: 1433 Comm: irq/29-mmc1 Not tainted
> 4.19.8-rt6-funkadelic #1
> [  931.206920] Hardware name: Theobroma Systems RK3399-Q7 SoM (DT)
> [  931.206924] pstate: 40000005 (nZcv daif -PAN -UAO)
> [  931.206927] pc : cqhci_irq+0x2e4/0x490
> [  931.206931] lr : cqhci_irq+0x2e4/0x490
> [  931.206933] sp : ffff00000e54bc80
> [  931.206934] x29: ffff00000e54bc80 x28: 0000000000000000
> [  931.206939] x27: 0000000000000001 x26: ffff000008f217e8
> [  931.206944] x25: ffff8000f02ef030 x24: ffff0000091417b0
> [  931.206948] x23: ffff0000090aa000 x22: ffff8000f008b000
> [  931.206953] x21: 0000000000000002 x20: 000000000000001f
> [  931.206957] x19: ffff8000f02ef018 x18: ffffffffffffffff
> [  931.206961] x17: 0000000000000000 x16: 0000000000000000
> [  931.206966] x15: ffff0000090aa6c8 x14: 0720072007200720
> [  931.206970] x13: 0720072007200720 x12: 0720072007200720
> [  931.206975] x11: 0720072007200720 x10: 0720072007200720
> [  931.206980] x9 : 0720072007200720 x8 : 0720072007200720
> [  931.206984] x7 : 0720073107330720 x6 : 00000000000005a0
> [  931.206988] x5 : ffff00000860d4b0 x4 : 0000000000000000
> [  931.206993] x3 : 0000000000000001 x2 : 0000000000000001
> [  931.206997] x1 : 1bde3a91b0d4d900 x0 : 0000000000000000
> [  931.207001] Call trace:
> [  931.207005]  cqhci_irq+0x2e4/0x490
> [  931.207009]  sdhci_arasan_cqhci_irq+0x5c/0x90
> [  931.207013]  sdhci_irq+0x98/0x930
> [  931.207019]  irq_forced_thread_fn+0x2c/0xa0
> [  931.207023]  irq_thread+0x114/0x1c0
> [  931.207027]  kthread+0x128/0x130
> [  931.207032]  ret_from_fork+0x10/0x20
> [  931.207035] ---[ end trace 0000000000000002 ]---
> 
> The driver shows this message only for the first spurious interrupt
> by using WARN_ONCE(). Changing this to WARN() shows, that this is
> happening quite frequently (up to once a second).
> 
> Since the eMMC 5.1 specification, where CQE and CQHCI are specified,
> does not mention that spurious TCN interrupts for DCMDs can be simply
> ignored, we must assume that using this feature is not working reliably.
> 
> The current implementation uses DCMD for REQ_OP_FLUSH only, and
> I could not see any performance/power impact when disabling
> this optional feature for RK3399.
> 
> Therefore this patch disables DCMDs for RK3399.

We need to sort out the problem, and see if it could be solved, or
we just simply remove MMC_CAP2_CQE_DCMD it from sdhci-of-arasan

> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 6cc1c9fa4ea6..1bbf0da4e01d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -333,6 +333,7 @@
>   		phys = <&emmc_phy>;
>   		phy-names = "phy_arasan";
>   		power-domains = <&power RK3399_PD_EMMC>;
> +		disable-cqe-dcmd;
>   		status = "disabled";
>   	};
>   
> 


