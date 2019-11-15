Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE10C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4B2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKOKiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:38:12 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:46926 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbfKOKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:38:11 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iVYzM-0006WU-0U; Fri, 15 Nov 2019 11:38:04 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xAFAbwL4024948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 15 Nov 2019 11:37:59 +0100
Subject: Re: arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        shawn.lin@rock-chips.com, Jeffy Chen <jeffy.chen@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
 <20190301153348.29870-2-christoph.muellner@theobroma-systems.com>
 <367bf78a-f079-f0b4-68fe-52c86823c174@fivetechno.de>
 <2766673.iMURPl8gB5@phil>
From:   Markus Reichl <m.reichl@fivetechno.de>
Autocrypt: addr=m.reichl@fivetechno.de; prefer-encrypt=mutual; keydata=
 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
 eD/Xv4SsK2JTO4nkQYw8
Organization: five technologies GmbH
Message-ID: <69472c06-8b21-c3d8-acad-1a0a292c0fa2@fivetechno.de>
Date:   Fri, 15 Nov 2019 11:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <2766673.iMURPl8gB5@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1573814289;92e4bc9a;
X-HE-SMSGID: 1iVYzM-0006WU-0U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Am 14.11.19 um 14:10 schrieb Heiko Stuebner:
> Hi Markus,
> 
> $subject is missing the [PATCH] prefix
will fix.
> 
> Am Montag, 11. November 2019, 10:51:04 CET schrieb Markus Reichl:
>> Working with rootfs on two 128GB mmcs on rk3399-roc-pc.
>> 
>> One (mmc name 128G72, one screw hole) works fine in HS400 mode.
>> Other (mmc name DJNB4R, firefly on pcb, two screw holes) gets lots of
>> mmc1: "running CQE recovery", even hangs with damaged fs,
>> when running under heavy load, e.g. compiling kernel.
>> Both run fine with HS200.
>> 
>> Disabling CQ with patch mmc: core: Add MMC Command Queue Support kernel parameter [0] did not help.
>> [0] https://gitlab.com/ayufan-repos/rock64/linux-mainline-kernel/commit/54e264154b87dfe32a8359b2726e2d5611adbaf3
> 
> I'm hoping for some input from other people in Cc but your mail headers
> also referenced the drive-impendance series from Christoph [0], which
> it seems we need to poke the phy maintainer again.
> 
> Did you check if changing the impedance helped (like the signal dampening
> Philipp described in one of the replies there).

checked with

&emmc_phy {
+       drive-impedance-ohm = <33>;

gives no improvement:
[    1.688590] mmc1: CQHCI version 5.10
[    1.714157] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
[    1.797822] mmc1: Command Queue Engine enabled
[    1.798259] mmc1: new HS400 Enhanced strobe MMC card at address 0001
[    1.800034] mmcblk1: mmc1:0001 DJNB4R 116 GiB 
[    1.800643] mmcblk1boot0: mmc1:0001 DJNB4R partition 1 4.00 MiB
[    1.801408] mmcblk1boot1: mmc1:0001 DJNB4R partition 2 4.00 MiB
[    1.802886] mmcblk1rpmb: mmc1:0001 DJNB4R partition 3 4.00 MiB, chardev (246:0)
...
[  100.118020] mmc1: running CQE recovery
[  100.120890] ------------[ cut here ]------------
[  100.121310] mmc1: cqhci: spurious TCN for tag 2
[  100.121802] WARNING: CPU: 0 PID: 232 at drivers/mmc/host/cqhci.c:729 cqhci_irq+0x30c/0x480
[  100.122530] Modules linked in: rfkill snd_soc_hdmi_codec dw_hdmi_i2s_audio dw_hdmi_cec rockchipdrm crct10dif_ce analogix_dp dw_mipi_dsi snd_soc_simple_card dw_hdmi cec snd_soc_rockchip_i2s snd_soc_simple_card_utils panfrost snd_soc_rockchip_pcm drm_kms_helper snd_soc_core gpu_sched snd_pcm_dmaengine syscopyarea sysfillrect sysimgblt snd_pcm fb_sys_fops snd_timer snd drm soundcore fusb302 tcpm typec rockchip_saradc drm_panel_orientation_quirks ipv6
[  100.126097] CPU: 0 PID: 232 Comm: kworker/0:2H Not tainted 5.4.0-rc7-next-20191112-00007-g2ad177c77749 #44
[  100.126946] Hardware name: Firefly ROC-RK3399-PC Board (DT)
[  100.127454] Workqueue: kblockd blk_mq_run_work_fn
[  100.127885] pstate: 20000085 (nzCv daIf -PAN -UAO)
[  100.128318] pc : cqhci_irq+0x30c/0x480
[  100.128660] lr : cqhci_irq+0x30c/0x480
[  100.128997] sp : ffff800010003d10
[  100.129298] x29: ffff800010003d10 x28: 0000000000000000 
[  100.129777] x27: 0000000000000001 x26: ffff8000108e0fe8 
[  100.130257] x25: ffff0000f5ae5c98 x24: ffff800010b7e1a8 
[  100.130737] x23: ffff800010b198c8 x22: ffff0000f5a80000 
[  100.131216] x21: 0000000000000002 x20: 0000000000000002 
[  100.131694] x19: ffff0000f5ae5c80 x18: 0000000000000010 
[  100.132173] x17: 0000000000000000 x16: 0000000000000000 
[  100.132653] x15: ffffffffffffffff x14: ffff800010b198c8 
[  100.133132] x13: ffff800090003a77 x12: ffff800010003a7f 
[  100.133612] x11: ffff800010b30000 x10: ffff800010003a00 
[  100.134092] x9 : 00000000ffffffd0 x8 : ffff80001045a060 
[  100.134571] x7 : 000000000000025f x6 : ffff800010b979e2 
[  100.135050] x5 : 0000000000000001 x4 : 0000000000000000 
[  100.135529] x3 : 0000000000000000 x2 : 0000000000000000 
[  100.136007] x1 : e005989da46f2500 x0 : 0000000000000000 
[  100.136486] Call trace:
[  100.136719]  cqhci_irq+0x30c/0x480
[  100.137033]  sdhci_arasan_cqhci_irq+0x58/0x80
[  100.137430]  sdhci_irq+0xb8/0xbb8
[  100.137742]  __handle_irq_event_percpu+0x6c/0x170
[  100.138169]  handle_irq_event_percpu+0x34/0x88
[  100.138575]  handle_irq_event+0x44/0xc8
[  100.138927]  handle_fasteoi_irq+0xb4/0x160
[  100.139302]  generic_handle_irq+0x24/0x38
[  100.139670]  __handle_domain_irq+0x60/0xb8
[  100.140045]  gic_handle_irq+0xc0/0x158
[  100.140389]  el1_irq+0xb8/0x180
[  100.140684]  _raw_spin_unlock_irqrestore+0x20/0x48
[  100.141119]  sdhci_cqe_enable+0xec/0x108
[  100.141478]  sdhci_arasan_cqe_enable+0x4c/0x58
[  100.141880]  cqhci_request+0x2d0/0x500
[  100.142226]  mmc_cqe_start_req+0x50/0x60
[  100.142585]  mmc_blk_mq_issue_rq+0x430/0x794
[  100.142974]  mmc_mq_queue_rq+0x104/0x270
[  100.143332]  blk_mq_dispatch_rq_list+0xa8/0x580
[  100.143746]  blk_mq_sched_dispatch_requests+0xf4/0x1d8
[  100.144210]  __blk_mq_run_hw_queue+0xac/0x120
[  100.144605]  blk_mq_run_work_fn+0x1c/0x28
[  100.144974]  process_one_work+0x1e0/0x358
[  100.145340]  worker_thread+0x40/0x488
[  100.145679]  kthread+0x118/0x120
[  100.145977]  ret_from_fork+0x10/0x18
[  100.146302] ---[ end trace 6277099ad751ed64 ]---
[  100.213815] mmc1: running CQE recovery
[  100.413933] mmc1: running CQE recovery

> 
> [0] https://patchwork.kernel.org/patch/10835567/
> most current v2 it seems is https://patchwork.kernel.org/patch/10842421/
> 
>> Therefore I propose to disable HS400 mode on roc-pc for now.
> 
> Hoping for more input :-)

Hoping, too.


Gruß,
-- 
Markus Reichl
> 
> 
> Heiko
> 
> 
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> index 29a50a083c42..33df95e384b4 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> @@ -660,8 +660,6 @@
>>  
>>  &sdhci {
>>  	bus-width = <8>;
>> -	mmc-hs400-1_8v;
>> -	mmc-hs400-enhanced-strobe;
>>  	non-removable;
>>  	status = "okay";
>>  };
>> 
> 

