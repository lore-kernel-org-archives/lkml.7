Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78594C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5619122B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgADPCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:02:30 -0500
Received: from pindarots.xs4all.nl ([82.161.210.87]:34642 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgADPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:02:30 -0500
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id 004F2SeW040032
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sat, 4 Jan 2020 16:02:28 +0100
Subject: Re: 5.4.7: WARNING: CPU: 4 PID: 30 at kernel/rcu/tree.c:2211
 rcu_core+0x3f7/0x450
From:   Udo van den Heuvel <udovdh@xs4all.nl>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3d77ca55-9da5-6cfe-ba88-f76e10213e62@xs4all.nl>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <1c1fe83d-4173-f4a0-71d2-8b07a718f5f6@xs4all.nl>
Date:   Sat, 4 Jan 2020 16:02:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <3d77ca55-9da5-6cfe-ba88-f76e10213e62@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-01-2020 18:01, Udo van den Heuvel wrote:
(...)
> 
> What happend here?
> Is it a bug?

It appears to happen more than once:

[  246.911694] ------------[ cut here ]------------
[  246.911705] WARNING: CPU: 3 PID: 25 at kernel/rcu/tree.c:2211
rcu_core+0x3f7/0x450
[  246.911706] Modules linked in: fuse mq_deadline ip6t_REJECT
nf_reject_ipv6 xt_state ip6table_filter ip6_tables
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_MASQUERADE iptable_nat
nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 msr it87
hwmon_vid iptable_filter uvcvideo videobuf2_vmalloc snd_usb_audio
videobuf2_memops videobuf2_v4l2 snd_hwdep videodev snd_usbmidi_lib
videobuf2_common snd_rawmidi cdc_acm snd_hda_codec_realtek
snd_hda_codec_generic snd_hda_intel snd_intel_nhlt snd_hda_codec
snd_hda_core snd_seq k10temp snd_seq_device snd_pcm i2c_piix4 snd_timer
snd bfq evdev acpi_cpufreq binfmt_misc ip_tables x_tables hid_generic
sr_mod cdrom usbhid aesni_intel amdgpu gpu_sched ttm i2c_dev autofs4
[  246.911746] CPU: 3 PID: 25 Comm: ksoftirqd/3 Tainted: G        W
    5.4.7 #9
[  246.911748] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
[  246.911750] RIP: 0010:rcu_core+0x3f7/0x450
[  246.911754] Code: fd ff ff 48 2b 15 49 13 f6 00 48 39 c2 7e 07 48 89
83 b0 00 00 00 48 8b 43 50 48 85 c0 75 c7 0f 0b eb c3 0f 0b e9 59 fc ff
ff <0f> 0b eb b8 48 8b 15 26 13 f6 00 48 89 93 c0 00 00 00 e9 72 ff ff
[  246.911756] RSP: 0018:ffff9df7801d7e18 EFLAGS: 00010006
[  246.911758] RAX: 000000397e6650ca RBX: ffff8ba4df0dee80 RCX:
ffff8ba4a056d590
[  246.911759] RDX: 0000000000000000 RSI: ffff9df7801d7e18 RDI:
ffff8ba4df0deed0
[  246.911761] RBP: ffff8ba4df0deed0 R08: 0000000000000000 R09:
0000000000000100
[  246.911762] R10: 0000000000000002 R11: 0000000000000000 R12:
0000000000000246
[  246.911763] R13: ffff8ba4ddf410c0 R14: 0000000000000000 R15:
0000000000000000
[  246.911765] FS:  0000000000000000(0000) GS:ffff8ba4df0c0000(0000)
knlGS:0000000000000000
[  246.911766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  246.911768] CR2: 00007ff60f06ffe0 CR3: 00000003d179c000 CR4:
00000000003406e0
[  246.911769] Call Trace:
[  246.911777]  __do_softirq+0xfc/0x247
[  246.911783]  run_ksoftirqd+0x21/0x30
[  246.911787]  smpboot_thread_fn+0x195/0x230
[  246.911789]  ? sort_range+0x20/0x20
[  246.911792]  kthread+0x118/0x130
[  246.911795]  ? kthread_create_worker_on_cpu+0x60/0x60
[  246.911797]  ret_from_fork+0x22/0x40
[  246.911800] ---[ end trace 6f223c45fc8e7e99 ]---

Kind regards,
Udo
