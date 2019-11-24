Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE35C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 12:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137C220706
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 12:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfKXMAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 07:00:38 -0500
Received: from pindarots.xs4all.nl ([82.161.210.87]:53088 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfKXMAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 07:00:38 -0500
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id xAOC0aHh014008
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 13:00:37 +0100
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.3.12: BUG at fs/buffer.c:3382!
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <bb82d3ea-2cff-9c03-8535-dd2fca51b82b@xs4all.nl>
Date:   Sun, 24 Nov 2019 13:00:36 +0100
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

A new issue?
Please advise.

Nov 24 11:24:10 box3 kernel: [146269.049106] ------------[ cut here
]------------
Nov 24 11:24:10 box3 kernel: [146269.049110] kernel BUG at fs/buffer.c:3382!
Nov 24 11:24:10 box3 kernel: [146269.049118] invalid opcode: 0000 [#1]
PREEMPT SMP NOPTI
Nov 24 11:24:10 box3 kernel: [146269.049122] CPU: 6 PID: 231 Comm:
kswapd0 Tainted: G        W         5.3.11 #18
Nov 24 11:24:10 box3 kernel: [146269.049125] Hardware name: Gigabyte
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F10c 11/08/2019
Nov 24 11:24:10 box3 kernel: [146269.049131] RIP:
0010:free_buffer_head+0x5a/0x60
Nov 24 11:24:10 box3 kernel: [146269.049134] Code: 11 00 65 ff 0d b7 5a
e6 5b e8 c2 fe ff ff bf 01 00 00 00 e8 f8 cd ed ff 65 8b 05 09 ee e5 5b
85 c0 74 01 c3 e8 57 a6 e4 ff c3 <0f> 0b 0f 1f 40 00 0f b6 d2 41 57 41
56 66 83 fa 01 41 55 41 bd 00
Nov 24 11:24:10 box3 kernel: [146269.049136] RSP: 0018:ffffbca300343ab8
EFLAGS: 00010202
Nov 24 11:24:10 box3 kernel: [146269.049139] RAX: ffff9c097d4ebd90 RBX:
ffff9c097d4ebd68 RCX: 0000000000000000
Nov 24 11:24:10 box3 kernel: [146269.049141] RDX: ffff9c097d4ebdb0 RSI:
ffff9c097d4ebd68 RDI: ffff9c097d4ebd68
Nov 24 11:24:10 box3 kernel: [146269.049142] RBP: ffffe770070c8fd8 R08:
ffff9c0a4603c000 R09: 0000000000000002
Nov 24 11:24:10 box3 kernel: [146269.049143] R10: ffff9c0a48f656a0 R11:
ffff9c08646153a8 R12: ffff9c0a48f65724
Nov 24 11:24:10 box3 kernel: [146269.049144] R13: 0000000000000001 R14:
ffffe770070c8fd8 R15: ffffe770070c8fe0
Nov 24 11:24:10 box3 kernel: [146269.049145] FS:  0000000000000000(0000)
GS:ffff9c0a5f180000(0000) knlGS:0000000000000000
Nov 24 11:24:10 box3 kernel: [146269.049146] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 24 11:24:10 box3 kernel: [146269.049147] CR2: 0000096d455fe000 CR3:
0000000167346000 CR4: 00000000003406e0
Nov 24 11:24:10 box3 kernel: [146269.049148] Call Trace:
Nov 24 11:24:10 box3 kernel: [146269.049150]  try_to_free_buffers+0xb6/0x100
Nov 24 11:24:10 box3 kernel: [146269.049153]  shrink_page_list+0xbec/0xe60
Nov 24 11:24:10 box3 kernel: [146269.049155]
shrink_inactive_list+0x1ad/0x350
Nov 24 11:24:10 box3 kernel: [146269.049157]
shrink_node_memcg.isra.0+0x46e/0x7b0
Nov 24 11:24:10 box3 kernel: [146269.049159]  ? 0xffffffffa4000000
Nov 24 11:24:10 box3 kernel: [146269.049161]  ? __switch_to_asm+0x34/0x70
Nov 24 11:24:10 box3 kernel: [146269.049163]  shrink_node+0x80/0x2e0
Nov 24 11:24:10 box3 kernel: [146269.049164]  balance_pgdat+0x239/0x4a0
Nov 24 11:24:10 box3 kernel: [146269.049166]  kswapd+0x165/0x2f0
Nov 24 11:24:10 box3 kernel: [146269.049168]  ? wait_woken+0x70/0x70
Nov 24 11:24:10 box3 kernel: [146269.049170]  kthread+0xfb/0x130
Nov 24 11:24:10 box3 kernel: [146269.049171]  ? balance_pgdat+0x4a0/0x4a0
Nov 24 11:24:10 box3 kernel: [146269.049173]  ? kthread_park+0x70/0x70
Nov 24 11:24:10 box3 kernel: [146269.049174]  ret_from_fork+0x22/0x40
Nov 24 11:24:10 box3 kernel: [146269.049176] Modules linked in:
usb_storage fuse mq_deadline ip6t_REJECT nf_reject_ipv6 xt_state
ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_MASQUERADE iptable_nat nf_nat ipt_REJECT
nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp xt_conntrack it87 hwmon_vid
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter msr uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev snd_usb_audio
videobuf2_common snd_hwdep snd_usbmidi_lib snd_rawmidi cdc_acm
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec
snd_hda_core snd_seq snd_seq_device snd_pcm k10temp i2c_piix4 snd_timer
snd bfq evdev acpi_cpufreq binfmt_misc ip_tables x_tables hid_generic
aesni_intel amdgpu backlight gpu_sched ttm sr_mod cdrom usbhid i2c_dev
autofs4
Nov 24 11:24:10 box3 kernel: [146269.049199] ---[ end trace
927d9ba4cbacd793 ]---


Kind regards,
Udo
