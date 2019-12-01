Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFDCC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 07:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248F020833
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 07:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLAHGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 02:06:40 -0500
Received: from pindarots.xs4all.nl ([82.161.210.87]:52976 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfLAHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 02:06:39 -0500
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id xB176bvK1290453
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sun, 1 Dec 2019 08:06:37 +0100
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.4.1 WARNINGs
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <46e7dcf9-3c89-25c1-ccb8-336450047bec@xs4all.nl>
Date:   Sun, 1 Dec 2019 08:06:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While booting into 5.4.1 I noticed these.
Any advice please?


Dec  1 07:59:28 vuurmuur named[1318]: resolver priming query complete
Dec  1 07:59:34 vuurmuur kernel: ------------[ cut here ]------------
Dec  1 07:59:34 vuurmuur kernel: NETDEV WATCHDOG: eth0 (r8169): transmit
queue 0 timed out
Dec  1 07:59:34 vuurmuur kernel: WARNING: CPU: 0 PID: 9 at
net/sched/sch_generic.c:447 dev_watchdog+0x208/0x210
Dec  1 07:59:34 vuurmuur kernel: Modules linked in: act_police
sch_ingress cls_u32 sch_sfq sch_cbq pppoe pppox ip6table_raw nf_log_ipv6
ip6table_mangle xt_u32 xt_CT xt_nat nf_log_ipv4 nf_log_common
xt_statistic nf_nat_sip nf_conntrack_sip xt_recent xt_string xt_lscan(O)
xt_TARPIT(O) iptable_raw nf_nat_h323 nf_conntrack_h323 xt_TCPMSS
xt_length xt_hl xt_tcpmss xt_owner xt_mac xt_mark xt_multiport xt_limit
nf_nat_irc nf_conntrack_irc xt_LOG xt_DSCP xt_REDIRECT xt_MASQUERADE
xt_dscp nf_nat_ftp nf_conntrack_ftp iptable_mangle iptable_nat
mq_deadline 8021q ipt_REJECT nf_reject_ipv4 iptable_filter ip6t_REJECT
nf_reject_ipv6 xt_state xt_conntrack ip6table_filter nct6775 ip6_tables
sunrpc amdgpu mfd_core gpu_sched drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops ttm snd_hda_codec_realtek snd_hda_codec_generic
drm snd_hda_codec_hdmi snd_hda_intel drm_panel_orientation_quirks
cfbfillrect snd_intel_nhlt amd_freq_sensitivity cfbimgblt snd_hda_codec
aesni_intel cfbcopyarea i2c_algo_bit fb glue_helper
Dec  1 07:59:34 vuurmuur kernel: snd_hda_core crypto_simd fbdev snd_pcm
cryptd pl2303 backlight snd_timer snd i2c_piix4 acpi_cpufreq sr_mod
cdrom sd_mod autofs4
Dec  1 07:59:34 vuurmuur kernel: CPU: 0 PID: 9 Comm: ksoftirqd/0
Tainted: G           O      5.4.1 #2
Dec  1 07:59:34 vuurmuur kernel: Hardware name: To Be Filled By O.E.M.
To Be Filled By O.E.M./QC5000M-ITX/PH, BIOS P1.10 05/06/2015
Dec  1 07:59:34 vuurmuur kernel: RIP: 0010:dev_watchdog+0x208/0x210
Dec  1 07:59:34 vuurmuur kernel: Code: 63 54 24 e0 eb 8d 4c 89 f7 c6 05
fc a0 b9 00 01 e8 6d fa fc ff 44 89 e9 48 89 c2 4c 89 f6 48 c7 c7 48 79
dd 81 e8 98 5a b5 ff <0f> 0b eb bd 0f 1f 40 00 48 c7 47 08 00 00 00 00
48 c7 07 00 00 00
Dec  1 07:59:34 vuurmuur kernel: RSP: 0018:ffffc9000006fd68 EFLAGS: 00010286
Dec  1 07:59:34 vuurmuur kernel: RAX: 0000000000000000 RBX:
ffff88813a1d6400 RCX: 0000000000000006
Dec  1 07:59:34 vuurmuur kernel: RDX: 0000000000000007 RSI:
ffffffff8203aa58 RDI: ffff88813b216250
Dec  1 07:59:34 vuurmuur kernel: RBP: ffff8881394ee460 R08:
0000000000080001 R09: 0000000000000002
Dec  1 07:59:34 vuurmuur kernel: R10: 0000000000000001 R11:
0000000000000001 R12: ffff8881394ee4b8
Dec  1 07:59:34 vuurmuur kernel: R13: 0000000000000000 R14:
ffff8881394ee000 R15: ffff88813a1d6480
Dec  1 07:59:34 vuurmuur kernel: FS:  0000000000000000(0000)
GS:ffff88813b200000(0000) knlGS:0000000000000000
Dec  1 07:59:34 vuurmuur kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Dec  1 07:59:34 vuurmuur kernel: CR2: 00007f09b9c20a78 CR3:
00000001385d4000 CR4: 00000000000406b0
Dec  1 07:59:34 vuurmuur kernel: Call Trace:
Dec  1 07:59:34 vuurmuur kernel: ? qdisc_put_unlocked+0x30/0x30
Dec  1 07:59:34 vuurmuur kernel: ? qdisc_put_unlocked+0x30/0x30
Dec  1 07:59:34 vuurmuur kernel: call_timer_fn.isra.0+0x78/0x110
Dec  1 07:59:34 vuurmuur kernel: ? add_timer_on+0xd0/0xd0
Dec  1 07:59:34 vuurmuur kernel: run_timer_softirq+0x19d/0x1c0
Dec  1 07:59:34 vuurmuur kernel: ? _raw_spin_unlock_irq+0x1f/0x40
Dec  1 07:59:34 vuurmuur kernel: ? finish_task_switch+0xb2/0x250
Dec  1 07:59:34 vuurmuur kernel: ? finish_task_switch+0x81/0x250
Dec  1 07:59:34 vuurmuur kernel: __do_softirq+0xcf/0x210
Dec  1 07:59:34 vuurmuur kernel: run_ksoftirqd+0x15/0x20
Dec  1 07:59:34 vuurmuur kernel: smpboot_thread_fn+0xe9/0x1f0
Dec  1 07:59:34 vuurmuur kernel: kthread+0xf1/0x130
Dec  1 07:59:34 vuurmuur kernel: ? sort_range+0x20/0x20
Dec  1 07:59:34 vuurmuur kernel: ? kthread_park+0x80/0x80
Dec  1 07:59:34 vuurmuur kernel: ret_from_fork+0x22/0x40
Dec  1 07:59:34 vuurmuur kernel: ---[ end trace e771bca3c459d7f9 ]---
Dec  1 07:59:34 vuurmuur kernel: ------------[ cut here ]------------
Dec  1 07:59:34 vuurmuur kernel: WARNING: CPU: 0 PID: 9 at
net/sched/sch_generic.c:447 dev_watchdog+0x208/0x210
Dec  1 07:59:34 vuurmuur kernel: Modules linked in: act_police
sch_ingress cls_u32 sch_sfq sch_cbq pppoe pppox ip6table_raw nf_log_ipv6
ip6table_mangle xt_u32 xt_CT xt_nat nf_log_ipv4 nf_log_common
xt_statistic nf_nat_sip nf_conntrack_sip xt_recent xt_string xt_lscan(O)
xt_TARPIT(O) iptable_raw nf_nat_h323 nf_conntrack_h323 xt_TCPMSS
xt_length xt_hl xt_tcpmss xt_owner xt_mac xt_mark xt_multiport xt_limit
nf_nat_irc nf_conntrack_irc xt_LOG xt_DSCP xt_REDIRECT xt_MASQUERADE
xt_dscp nf_nat_ftp nf_conntrack_ftp iptable_mangle iptable_nat
mq_deadline 8021q ipt_REJECT nf_reject_ipv4 iptable_filter ip6t_REJECT
nf_reject_ipv6 xt_state xt_conntrack ip6table_filter nct6775 ip6_tables
sunrpc amdgpu mfd_core gpu_sched drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops ttm snd_hda_codec_realtek snd_hda_codec_generic
drm snd_hda_codec_hdmi snd_hda_intel drm_panel_orientation_quirks
cfbfillrect snd_intel_nhlt amd_freq_sensitivity cfbimgblt snd_hda_codec
aesni_intel cfbcopyarea i2c_algo_bit fb glue_helper
Dec  1 07:59:34 vuurmuur kernel: snd_hda_core crypto_simd fbdev snd_pcm
cryptd pl2303 backlight snd_timer snd i2c_piix4 acpi_cpufreq sr_mod
cdrom sd_mod autofs4
Dec  1 07:59:34 vuurmuur kernel: CPU: 0 PID: 9 Comm: ksoftirqd/0
Tainted: G           O      5.4.1 #2
Dec  1 07:59:34 vuurmuur kernel: Hardware name: To Be Filled By O.E.M.
To Be Filled By O.E.M./QC5000M-ITX/PH, BIOS P1.10 05/06/2015
Dec  1 07:59:34 vuurmuur kernel: RIP: 0010:dev_watchdog+0x208/0x210
Dec  1 07:59:34 vuurmuur kernel: Code: 63 54 24 e0 eb 8d 4c 89 f7 c6 05
fc a0 b9 00 01 e8 6d fa fc ff 44 89 e9 48 89 c2 4c 89 f6 48 c7 c7 48 79
dd 81 e8 98 5a b5 ff <0f> 0b eb bd 0f 1f 40 00 48 c7 47 08 00 00 00 00
48 c7 07 00 00 00
Dec  1 07:59:34 vuurmuur kernel: RSP: 0018:ffffc9000006fd68 EFLAGS: 00010286
Dec  1 07:59:34 vuurmuur kernel: RAX: 0000000000000000 RBX:
ffff88813a1d6400 RCX: 0000000000000006
Dec  1 07:59:34 vuurmuur kernel: RDX: 0000000000000007 RSI:
ffffffff8203aa58 RDI: ffff88813b216250
Dec  1 07:59:34 vuurmuur kernel: RBP: ffff8881394ee460 R08:
0000000000080001 R09: 0000000000000002
Dec  1 07:59:34 vuurmuur kernel: R10: 0000000000000001 R11:
0000000000000001 R12: ffff8881394ee4b8
Dec  1 07:59:34 vuurmuur kernel: R13: 0000000000000000 R14:
ffff8881394ee000 R15: ffff88813a1d6480
Dec  1 07:59:34 vuurmuur kernel: FS:  0000000000000000(0000)
GS:ffff88813b200000(0000) knlGS:0000000000000000
Dec  1 07:59:34 vuurmuur kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Dec  1 07:59:34 vuurmuur kernel: CR2: 00007f09b9c20a78 CR3:
00000001385d4000 CR4: 00000000000406b0
Dec  1 07:59:34 vuurmuur kernel: Call Trace:
Dec  1 07:59:34 vuurmuur kernel: ? qdisc_put_unlocked+0x30/0x30
Dec  1 07:59:34 vuurmuur kernel: ? qdisc_put_unlocked+0x30/0x30
Dec  1 07:59:34 vuurmuur kernel: call_timer_fn.isra.0+0x78/0x110
Dec  1 07:59:34 vuurmuur kernel: ? add_timer_on+0xd0/0xd0
Dec  1 07:59:34 vuurmuur kernel: run_timer_softirq+0x19d/0x1c0
Dec  1 07:59:34 vuurmuur kernel: ? _raw_spin_unlock_irq+0x1f/0x40
Dec  1 07:59:34 vuurmuur kernel: ? finish_task_switch+0xb2/0x250
Dec  1 07:59:34 vuurmuur kernel: ? finish_task_switch+0x81/0x250
Dec  1 07:59:34 vuurmuur kernel: __do_softirq+0xcf/0x210
Dec  1 07:59:34 vuurmuur kernel: run_ksoftirqd+0x15/0x20
Dec  1 07:59:34 vuurmuur kernel: smpboot_thread_fn+0xe9/0x1f0
Dec  1 07:59:34 vuurmuur kernel: kthread+0xf1/0x130
Dec  1 07:59:34 vuurmuur kernel: ? sort_range+0x20/0x20
Dec  1 07:59:34 vuurmuur kernel: ? kthread_park+0x80/0x80
Dec  1 07:59:34 vuurmuur kernel: ret_from_fork+0x22/0x40
Dec  1 07:59:34 vuurmuur kernel: ---[ end trace e771bca3c459d7f9 ]---


Kind regards,
Udo
