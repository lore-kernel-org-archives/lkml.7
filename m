Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD06EC341BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2CE246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLMMTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:19:21 -0500
Received: from comms.puri.sm ([159.203.221.185]:39646 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfLMMTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:19:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2DD12DFFA3;
        Fri, 13 Dec 2019 04:19:19 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nOpD2ZPraf31; Fri, 13 Dec 2019 04:19:18 -0800 (PST)
Subject: Re: suspend problem with dwc3 gadget / g_multi when usb disconnected
To:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     kernel@puri.sm, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
References: <38edc05e-680b-d881-49fc-e8230a93b2c8@puri.sm>
 <87blsgl88s.fsf@gmail.com> <df4060e1-5ef6-3d2b-5dd4-5a0cb577bb68@puri.sm>
 <87fthpwwdk.fsf@kernel.org>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Autocrypt: addr=martin.kepplinger@puri.sm; keydata=
 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
 ekMtxgNYb/8oDry09UFHbGHLsWn6oBo=
Message-ID: <62b00952-e7c8-6fae-d7bd-8d2b3e0626e9@puri.sm>
Date:   Fri, 13 Dec 2019 13:19:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <87fthpwwdk.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.19 13:39, Felipe Balbi wrote:
> 
> Hi,
> 
> Martin Kepplinger <martin.kepplinger@puri.sm> writes:


>> [   64.405226] Modules linked in: rfkill st_magn_spi st_sensors_spi
>> mousedev qmi_wwan caam_jr caamhash_desc caamalg_desc cdc_wdm option
>> usbnet usb_wwan mii usbserial st_magn_i2c st_magn st_sensors_i2c
>> st_sensors industrialio_triggered_buffer goodix kfifo_buf tcpci tcpm
>> roles imx2_wdt watchdog aes_ce_blk crypto_simd typec bq25890_charger
>> caam imx_sdma virt_dma error crct10dif_ce ghash_ce sha2_ce sha1_ce
>> gpio_vibra usb_f_acm u_serial usb_f_rndis g_multi usb_f_mass_storage
>> u_ether libcomposite ip_tables x_tables ipv6 nf_defrag_ipv6
>> xhci_plat_hcd xhci_hcd usbcore dwc3 snvs_pwrkey ulpi udc_core
>> phy_fsl_imx8mq_usb usb_common
>> [   64.462126] CPU: 3 PID: 884 Comm: ip Not tainted
>> 5.5.0-rc1-next-20191212-librem5-00019-g4fb81fdd9c7d #1
>> [   64.471909] Hardware name: Purism Librem 5 devkit (DT)
>> [   64.477264] pstate: 60000085 (nZCv daIf -PAN -UAO)
>> [   64.482268] pc : dwc3_stop_active_transfer.constprop.38+0xe8/0x100 [dwc3]
>> [   64.489351] lr : dwc3_stop_active_transfer.constprop.38+0x64/0x100 [dwc3]
>> [   64.496421] sp : ffff00009f213240
>> [   64.499874] x29: ffff00009f213240 x28: 0000000000000000
>> [   64.505410] x27: ffff00009f2137b0 x26: ffff0000a4e0cc10
>> [   64.510946] x25: 0000000000000001 x24: ffff0000a324518c
>> [   64.516482] x23: ffff0000a3245193 x22: ffff0000a41f0080
>> [   64.522018] x21: 0000000000000000 x20: ffff0000a4176600
>> [   64.527553] x19: ffff800010ee87c8 x18: 0000000000000000
>> [   64.533089] x17: 0000000000000000 x16: 0000000000000000
>> [   64.538625] x15: 0000000000000000 x14: 0000000000000000
>> [   64.544160] x13: ffff0000a4176868 x12: ffff0000a4176868
>> [   64.549696] x11: ffffffffffff3f08 x10: 0000000000000008
>> [   64.555232] x9 : ffffffffffff3f04 x8 : 0000000000000811
>> [   64.560767] x7 : ffffffffffff3f00 x6 : ffffffffffff3f0c
>> [   64.566303] x5 : 0000000000000000 x4 : ffff80001007483c
>> [   64.571839] x3 : 0000000000000808 x2 : ffff00009f21327c
>> [   64.577375] x1 : 0000000000000040 x0 : 00000000ffffff92
>> [   64.582911] Call trace:
>> [   64.585474]  dwc3_stop_active_transfer.constprop.38+0xe8/0x100 [dwc3]
>> [   64.592194]  __dwc3_gadget_ep_disable+0x34/0x380 [dwc3]
>> [   64.597649]  dwc3_gadget_ep_disable+0x44/0xf8 [dwc3]
>> [   64.602841]  usb_ep_disable+0x34/0x100 [udc_core]
>> [   64.607749]  eth_stop+0xb4/0x130 [u_ether]
>> [   64.612026]  __dev_close_many+0xb4/0x138
>> [   64.616116]  __dev_change_flags+0xb8/0x1d0
>> [   64.620385]  dev_change_flags+0x28/0x68
>> [   64.624384]  do_setlink+0x30c/0xc90
>> [   64.628021]  __rtnl_newlink+0x3f8/0x788
>> [   64.632018]  rtnl_newlink+0x54/0x80
>> [   64.635654]  rtnetlink_rcv_msg+0x128/0x370
>> [   64.639926]  netlink_rcv_skb+0x60/0x120
>> [   64.643924]  rtnetlink_rcv+0x1c/0x28
>> [   64.647650]  netlink_unicast+0x1b8/0x278
>> [   64.651739]  netlink_sendmsg+0x1ac/0x3b0
>> [   64.655829]  ____sys_sendmsg+0x250/0x298
>> [   64.659918]  ___sys_sendmsg+0x88/0xc8
>> [   64.663735]  __sys_sendmsg+0x70/0xc0
>> [   64.667463]  __arm64_sys_sendmsg+0x28/0x30
>> [   64.671736]  el0_svc_common.constprop.3+0x98/0x170
>> [   64.676729]  el0_svc_handler+0x20/0x28
>> [   64.680638]  el0_sync_handler+0x134/0x1a0
>> [   64.684817]  el0_sync+0x140/0x180
>> [   64.688271] ---[ end trace 4f6aa846a9c6f20c ]---
>>
>> ... again. at every shutdown or rmmod.
>>
>> I hope that this might be already helpful.
> 
> I need to see the trace events for this failure case too. You could add
> ftrace_dump_on_oops to your cmdline and change the WARN_ONCE() to a
> BUG_ON() or something.
> 

doing that and having "ftrace=function ftrace_dump_on_oops" dumps way
too much to handle and somehow my board resets while printing...

I found I can avoid the above error during shutdown though by keeping a
few regulators enabled for now. I'm not entirely sure if that's a dwc3
problem now, so let's leave the above for now.

Back to my first issue: disconnected USB and suspend:

I disable all gadget configs now.

"echo mem > /sys/power/state" still only hangs the system - again: all
that's in the logs is:

[   97.405251] PM: suspend entry (deep)

and on the console then:

[  118.608738] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  118.615093] rcu: 	1-...0: (0 ticks this GP)
idle=e86/1/0x4000000000000000 softirq=16109/16109 fqs=2626
[  181.628739] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  181.635088] rcu: 	1-...0: (0 ticks this GP)
idle=e86/1/0x4000000000000000 softirq=16109/16109 fqs=10503
[  244.648738] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  244.655087] rcu: 	1-...0: (0 ticks this GP)
idle=e86/1/0x4000000000000000 softirq=16109/16109 fqs=17402

... not sure how to further debug that.
