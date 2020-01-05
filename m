Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6595C00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 05:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAEF218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 05:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgAEF0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 00:26:21 -0500
Received: from pindarots.xs4all.nl ([82.161.210.87]:43478 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAEF0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 00:26:21 -0500
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id 0055QJ0K276716
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sun, 5 Jan 2020 06:26:19 +0100
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.4.x: WARNING: CPU: 1 PID: 562 at
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1464
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <618356a9-7a63-f7c3-7a6a-5a14080d380c@xs4all.nl>
Date:   Sun, 5 Jan 2020 06:26:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The WARNING below has been present in the kernel for quiet a while.
This WARNING happens every time a kernel is booted.
What is causing the delay to fix this?



[    2.567111] WARNING: CPU: 1 PID: 562 at
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1464
dcn_bw_update_from_pplib+0xa5/0x2e0 [amdgpu]
[    2.567115] Modules linked in: hid_generic sr_mod cdrom usbhid
aesni_intel amdgpu(+) gpu_sched ttm i2c_dev autofs4
[    2.567123] CPU: 1 PID: 562 Comm: systemd-udevd Not tainted 5.4.7 #9
[    2.567126] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
[    2.567204] RIP: 0010:dcn_bw_update_from_pplib+0xa5/0x2e0 [amdgpu]
[    2.567208] Code: 0c 24 85 c9 74 24 8d 71 ff 48 8d 44 24 04 48 8d 54
f4 0c eb 0d 48 83 c0 08 48 39 d0 0f 84 2a 01 00 00 44 8b 00 45 85 c0 75
eb <0f> 0b e8 04 c0 b2 e6 4c 89 e2 be 04 00 00 00 4c 89 ef e8 94 59 fe
[    2.567213] RSP: 0018:ffff9df7804b36c0 EFLAGS: 00010246
[    2.567216] RAX: ffff9df7804b36c4 RBX: ffff8ba4c7c70000 RCX:
0000000000000004
[    2.567218] RDX: ffff9df7804b36e4 RSI: 0000000000000003 RDI:
ffffffffa7deab49
[    2.567221] RBP: ffff9df7804b3800 R08: 0000000000000000 R09:
00000000000003b8
[    2.567223] R10: 0720072007200720 R11: 0720072007200720 R12:
ffff9df7804b3750
[    2.567226] R13: ffff8ba4c71b1b80 R14: 0000000000000001 R15:
000000000000000a
[    2.567229] FS:  00007fa073a28940(0000) GS:ffff8ba4df040000(0000)
knlGS:0000000000000000
[    2.567232] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.567234] CR2: 000055db7a7fae98 CR3: 00000004099a6000 CR4:
00000000003406e0
[    2.567236] Call Trace:
[    2.567299]  ? amdgpu_atom_execute_table_locked+0x12c/0x210 [amdgpu]
[    2.567376]  dcn10_create_resource_pool+0x82d/0xb30 [amdgpu]
[    2.567382]  ? __kmalloc+0xeb/0xf0
[    2.567454]  dc_create_resource_pool+0xbe/0x130 [amdgpu]
[    2.567527]  dc_create+0x213/0x6b0 [amdgpu]
[    2.567602]  amdgpu_dm_init+0x138/0x1c0 [amdgpu]
[    2.567674]  ? phm_wait_for_register_unequal.part.0+0x4a/0x80 [amdgpu]
[    2.567748]  dm_hw_init+0x9/0x20 [amdgpu]
[    2.567820]  amdgpu_device_init.cold+0x119b/0x1344 [amdgpu]
[    2.567880]  amdgpu_driver_load_kms+0x41/0xc0 [amdgpu]
[    2.567886]  drm_dev_register+0x10c/0x150
[    2.567945]  amdgpu_pci_probe+0xcd/0x130 [amdgpu]
[    2.567950]  ? pci_match_device+0xd2/0x100
[    2.567953]  pci_device_probe+0xc9/0x140
[    2.567957]  really_probe+0x142/0x3b0
[    2.567960]  device_driver_attach+0x4e/0x60
[    2.567963]  __driver_attach+0x85/0x140
[    2.567966]  ? device_driver_attach+0x60/0x60
[    2.567969]  bus_for_each_dev+0x73/0xb0
[    2.567971]  bus_add_driver+0x13f/0x1e0
[    2.567974]  driver_register+0x67/0xb0
[    2.567976]  ? 0xffffffffc07a6000
[    2.567979]  do_one_initcall+0x47/0x16f
[    2.567982]  ? ___cache_free+0x2c/0x1f0
[    2.567986]  do_init_module+0x51/0x200
[    2.567989]  load_module+0x24b6/0x26e0
[    2.567993]  ? vfs_read+0xee/0x120
[    2.567996]  ? __do_sys_finit_module+0xaa/0x110
[    2.567999]  __do_sys_finit_module+0xaa/0x110
[    2.568002]  do_syscall_64+0x63/0x410
[    2.568005]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.568008] RIP: 0033:0x7fa0749ce1ad
[    2.568012] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab 5c 0c 00 f7 d8 64 89 01 48
[    2.568016] RSP: 002b:00007ffccbd4f658 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    2.568020] RAX: ffffffffffffffda RBX: 000055db7a8092f0 RCX:
00007fa0749ce1ad
[    2.568022] RDX: 0000000000000000 RSI: 000055db7a812fa0 RDI:
000000000000000f
[    2.568025] RBP: 0000000000020000 R08: 0000000000000000 R09:
0000000000000007
[    2.568027] R10: 000000000000000f R11: 0000000000000246 R12:
000055db7a812fa0
[    2.568029] R13: 0000000000000000 R14: 000055db7a7fb160 R15:
000055db7a8092f0
[    2.568033] ---[ end trace 6f223c45fc8e7e98 ]---



Kind regards,
Udo
