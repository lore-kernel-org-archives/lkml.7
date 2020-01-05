Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A847C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B474222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 13:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAENUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:20:22 -0500
Received: from pindarots.xs4all.nl ([82.161.210.87]:47036 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgAENUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 08:20:22 -0500
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id 005DKKD7006317
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sun, 5 Jan 2020 14:20:20 +0100
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.4.8: WARNING: CPU: 7 PID: 5905 at mm/slab.h:473 kfree+0x9c/0xb0
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <21f9ac35-494b-decf-d595-5e1f59c30346@xs4all.nl>
Date:   Sun, 5 Jan 2020 14:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Under some 'heavy' I/O the screen froze, but the mouse  pointer could
still be moved.
Harddisk LED went out and only an occasional flash could be observed.
Ctrl-Fx did not work.
ssh did not work.

So I shut the PC down, rebooted with Ctrl-Alt-SysRq-whatver.

The I/O consisted of the RAID-10 resyncing, some filed being moved to
SD-card via USB3, some downloads going on at slowish speed.

This is AMD Ryzen 5 3400G with Radeon Vega Graphics on Gigabyte X570
AORUS PRO running fedora 31 with kernel.org, git mesa, etc.

Log below.

Kind regards,
Udo



Jan  5 13:30:41 crashbox kernel: [  672.689897] [EXFAT] mounted successfully
Jan  5 13:59:50 crashbox kernel: [ 2421.579766] ------------[ cut here
]------------
Jan  5 13:59:50 crashbox kernel: [ 2421.579776] virt_to_cache: Object is
not a Slab page!
Jan  5 13:59:50 crashbox kernel: [ 2421.579795] WARNING: CPU: 7 PID:
5905 at mm/slab.h:473 kfree+0x9c/0xb0
Jan  5 13:59:50 crashbox kernel: [ 2421.579797] Modules linked in:
nls_utf8 exfat(C) usb_storage fuse mq_deadline xt_MASQUERADE iptable_nat
nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport iptable_filter
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT
nf_reject_ipv6 it87 hwmon_vi
d xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip6table_filter ip6_tables msr uvcvideo videobuf2_vmalloc
cdc_acm videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hwdep
snd_usbmidi_lib videodev videobuf2_common snd_rawmidi
snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_intel snd_intel_nhlt snd_hda_codec snd_hda_core snd_seq
snd_seq_device bfq snd_pcm snd_timer snd k10temp i2c_piix4 acpi_cpufreq
evdev binfmt_misc ip_tables x_tables hid_generic aesni_intel amdgpu
gpu_sched ttm sr_mod cdrom usbhid i2c_dev autofs4
Jan  5 13:59:50 crashbox kernel: [ 2421.579841] CPU: 7 PID: 5905 Comm:
kworker/u16:3 Tainted: G        WC        5.4.8 #10
Jan  5 13:59:50 crashbox kernel: [ 2421.579843] Hardware name: Gigabyte
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F11 12/06/2019
Jan  5 13:59:50 crashbox kernel: [ 2421.579849] Workqueue:
events_unbound commit_work
Jan  5 13:59:50 crashbox kernel: [ 2421.579855] RIP: 0010:kfree+0x9c/0xb0
Jan  5 13:59:50 crashbox kernel: [ 2421.579859] Code: ff ff 53 9d 5b c3
c3 80 3d e9 21 ef 00 00 75 f2 48 c7 c6 88 51 c1 ac 48 c7 c7 40 ba d8 ac
c6 05 d2 21 ef 00 01 e8 da 0f f0 ff <0f> 0b eb d4 48 8b 15 e9 f1 e9 00
eb 80 0f 1f 80 00 00 00 00 55 53
Jan  5 13:59:50 crashbox kernel: [ 2421.579862] RSP:
0018:ffffa08f8312be50 EFLAGS: 00010082
Jan  5 13:59:50 crashbox kernel: [ 2421.579864] RAX: 0000000000000000
RBX: 0000000000000286 RCX: 0000000000000000
Jan  5 13:59:50 crashbox kernel: [ 2421.579866] RDX: 0000000000000001
RSI: 0000000000000082 RDI: 00000000ffffffff
Jan  5 13:59:50 crashbox kernel: [ 2421.579869] RBP: ffff99089cb22480
R08: 00000000fffffffe R09: 000000000000048c
Jan  5 13:59:50 crashbox kernel: [ 2421.579871] R10: ffffa08f8312bd10
R11: ffffa08f8312bd0f R12: ffff9908ddc0e400
Jan  5 13:59:50 crashbox kernel: [ 2421.579872] R13: 0000000000000000
R14: ffff9908ddc0fc00 R15: 0000000000000000
Jan  5 13:59:50 crashbox kernel: [ 2421.579875] FS:
0000000000000000(0000) GS:ffff9908df1c0000(0000) knlGS:0000000000000000
Jan  5 13:59:50 crashbox kernel: [ 2421.579877] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Jan  5 13:59:50 crashbox kernel: [ 2421.579879] CR2: 00007fc968845000
CR3: 00000001e93ac000 CR4: 00000000003406e0
Jan  5 13:59:50 crashbox kernel: [ 2421.579881] Call Trace:
Jan  5 13:59:50 crashbox kernel: [ 2421.579888]
drm_atomic_state_default_release+0x1f/0x30
Jan  5 13:59:50 crashbox kernel: [ 2421.579892]
__drm_atomic_state_free+0x41/0x50
Jan  5 13:59:50 crashbox kernel: [ 2421.579897]
process_one_work+0x1b2/0x2f0
Jan  5 13:59:50 crashbox kernel: [ 2421.579901]  worker_thread+0x45/0x3c0
Jan  5 13:59:50 crashbox kernel: [ 2421.579905]  ? current_work+0x30/0x30
Jan  5 13:59:50 crashbox kernel: [ 2421.579908]  kthread+0x118/0x130
Jan  5 13:59:50 crashbox kernel: [ 2421.579912]  ?
kthread_create_worker_on_cpu+0x60/0x60
Jan  5 13:59:50 crashbox kernel: [ 2421.579916]  ret_from_fork+0x22/0x40
Jan  5 13:59:50 crashbox kernel: [ 2421.579920] ---[ end trace
cd4a3c28406f7c5d ]---
Jan  5 14:01:46 crashbox kernel: [ 2538.325826] sysrq: Emergency Sync
Jan  5 14:01:46 crashbox kernel: [ 2538.356174] INFO: task
kworker/u16:12:272 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.356182]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.356185] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.356188] kworker/u16:12  D    0
272      2 0x80004000
Jan  5 14:01:46 crashbox kernel: [ 2538.356199] Workqueue: writeback
wb_workfn (flush-253:8)
Jan  5 14:01:46 crashbox kernel: [ 2538.356202] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.356211]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356216]  ?
bit_wait_timeout+0x90/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.356220]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356224]  io_schedule+0xd/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356227]  bit_wait_io+0x8/0x50
Jan  5 14:01:46 crashbox kernel: [ 2538.356231]  __wait_on_bit+0x25/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.356235]
out_of_line_wait_on_bit+0x8d/0xb0
Jan  5 14:01:46 crashbox kernel: [ 2538.356241]  ?
var_wake_function+0x20/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.356245]
do_get_write_access+0x2d2/0x4d0
Jan  5 14:01:46 crashbox kernel: [ 2538.356250]
jbd2_journal_get_write_access+0x28/0x50
Jan  5 14:01:46 crashbox kernel: [ 2538.356254]
__ext4_journal_get_write_access+0x28/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356257]  ?
ext4_read_block_bitmap+0x29/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.356261]
ext4_mb_mark_diskspace_used+0x75/0x410
Jan  5 14:01:46 crashbox kernel: [ 2538.356266]
ext4_mb_new_blocks+0x1d3/0x890
Jan  5 14:01:46 crashbox kernel: [ 2538.356269]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356274]  ? __kmalloc+0xeb/0xf0
Jan  5 14:01:46 crashbox kernel: [ 2538.356277]  ?
ext4_find_extent+0x280/0x2f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356281]
ext4_ext_map_blocks+0xa27/0x1000
Jan  5 14:01:46 crashbox kernel: [ 2538.356285]  ?
generic_fadvise+0x40/0x2b0
Jan  5 14:01:46 crashbox kernel: [ 2538.356288]  ext4_map_blocks+0xe7/0x5e0
Jan  5 14:01:46 crashbox kernel: [ 2538.356292]  ext4_writepages+0x736/0xd30
Jan  5 14:01:46 crashbox kernel: [ 2538.356298]  ? do_writepages+0x3e/0xd0
Jan  5 14:01:46 crashbox kernel: [ 2538.356301]  do_writepages+0x3e/0xd0
Jan  5 14:01:46 crashbox kernel: [ 2538.356305]
__writeback_single_inode+0x30/0x1a0
Jan  5 14:01:46 crashbox kernel: [ 2538.356309]
writeback_sb_inodes+0x1fb/0x3d0
Jan  5 14:01:46 crashbox kernel: [ 2538.356313]
__writeback_inodes_wb+0x47/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356316]  wb_writeback+0x1db/0x1f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356320]  wb_workfn+0x21d/0x2d0
Jan  5 14:01:46 crashbox kernel: [ 2538.356326]
process_one_work+0x1b2/0x2f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356330]  worker_thread+0x45/0x3c0
Jan  5 14:01:46 crashbox kernel: [ 2538.356334]  ? current_work+0x30/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356338]  kthread+0x118/0x130
Jan  5 14:01:46 crashbox kernel: [ 2538.356342]  ?
kthread_create_worker_on_cpu+0x60/0x60
Jan  5 14:01:46 crashbox kernel: [ 2538.356345]  ret_from_fork+0x22/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.356367] INFO: task
md1_resync:880 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.356369]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.356370] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.356372] md1_resync      D    0
880      2 0x80004000
Jan  5 14:01:46 crashbox kernel: [ 2538.356376] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.356380]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356384]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356389]  raise_barrier+0x10c/0x170
Jan  5 14:01:46 crashbox kernel: [ 2538.356393]  ? wait_woken+0x70/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356397]
raid10_sync_request+0x202/0x1e40
Jan  5 14:01:46 crashbox kernel: [ 2538.356401]  ?
_raw_spin_unlock_irq+0xe/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.356405]  ? is_mddev_idle+0x10f/0x11e
Jan  5 14:01:46 crashbox kernel: [ 2538.356408]  md_do_sync.cold+0x3ea/0x952
Jan  5 14:01:46 crashbox kernel: [ 2538.356414]  ?
pt_buffer_reset_offsets+0x50/0xa0
Jan  5 14:01:46 crashbox kernel: [ 2538.356416]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356419]  ? wait_woken+0x70/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356424]  md_thread+0x86/0x150
Jan  5 14:01:46 crashbox kernel: [ 2538.356429]  ?
preempt_count_add+0x63/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.356431]  ?
_raw_spin_lock_irqsave+0x14/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.356435]  ? md_rdev_init+0xb0/0xb0
Jan  5 14:01:46 crashbox kernel: [ 2538.356438]  kthread+0x118/0x130
Jan  5 14:01:46 crashbox kernel: [ 2538.356441]  ?
kthread_create_worker_on_cpu+0x60/0x60
Jan  5 14:01:46 crashbox kernel: [ 2538.356444]  ret_from_fork+0x22/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.356450] INFO: task
dmcrypt_write/2:988 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.356452]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.356453] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.356455] dmcrypt_write/2 D    0
988      2 0x80004000
Jan  5 14:01:46 crashbox kernel: [ 2538.356458] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.356462]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356465]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356468]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356471]  wait_barrier+0x105/0x170
Jan  5 14:01:46 crashbox kernel: [ 2538.356474]  ? wait_woken+0x70/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356478]
regular_request_wait.isra.0+0x30/0x110
Jan  5 14:01:46 crashbox kernel: [ 2538.356481]
raid10_write_request+0x115/0x780
Jan  5 14:01:46 crashbox kernel: [ 2538.356484]  ? mempool_alloc+0x5b/0x160
Jan  5 14:01:46 crashbox kernel: [ 2538.356487]  ?
_raw_spin_unlock_irqrestore+0xf/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356490]  ?
md_write_start+0x116/0x2b0
Jan  5 14:01:46 crashbox kernel: [ 2538.356492]  ? wait_woken+0x70/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356496]
raid10_make_request+0xd2/0x140
Jan  5 14:01:46 crashbox kernel: [ 2538.356499]
md_handle_request+0x131/0x1a0
Jan  5 14:01:46 crashbox kernel: [ 2538.356504]  md_make_request+0x8b/0x1c0
Jan  5 14:01:46 crashbox kernel: [ 2538.356508]
generic_make_request+0xca/0x340
Jan  5 14:01:46 crashbox kernel: [ 2538.356514]  dmcrypt_write+0x126/0x150
Jan  5 14:01:46 crashbox kernel: [ 2538.356518]  ?
crypt_iv_lmk_dtr+0x50/0x50
Jan  5 14:01:46 crashbox kernel: [ 2538.356521]  kthread+0x118/0x130
Jan  5 14:01:46 crashbox kernel: [ 2538.356524]  ?
kthread_create_worker_on_cpu+0x60/0x60
Jan  5 14:01:46 crashbox kernel: [ 2538.356526]  ret_from_fork+0x22/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.356535] INFO: task
jbd2/dm-1-8:1369 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.356536]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.356538] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.356539] jbd2/dm-1-8     D    0
1369      2 0x80004000
Jan  5 14:01:46 crashbox kernel: [ 2538.356542] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.356546]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356549]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356552]  io_schedule+0xd/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356556]
wait_on_page_bit+0x10a/0x1d0
Jan  5 14:01:46 crashbox kernel: [ 2538.356560]  ?
file_fdatawait_range+0x20/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.356564]
__filemap_fdatawait_range+0x7c/0xd0
Jan  5 14:01:46 crashbox kernel: [ 2538.356568]  ? submit_bio+0x3e/0x120
Jan  5 14:01:46 crashbox kernel: [ 2538.356571]  ? guard_bio_eod+0x3e/0x180
Jan  5 14:01:46 crashbox kernel: [ 2538.356575]
filemap_fdatawait_range_keep_errors+0x9/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356579]
jbd2_journal_commit_transaction+0xc86/0x199e
Jan  5 14:01:46 crashbox kernel: [ 2538.356581]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356585]  ?
_raw_spin_unlock_irq+0xe/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.356590]  ?
try_to_del_timer_sync+0x4a/0x80
Jan  5 14:01:46 crashbox kernel: [ 2538.356593]  kjournald2+0xb3/0x280
Jan  5 14:01:46 crashbox kernel: [ 2538.356596]  ? wait_woken+0x70/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356600]  ? commit_timeout+0x10/0x10
Jan  5 14:01:46 crashbox kernel: [ 2538.356603]  kthread+0x118/0x130
Jan  5 14:01:46 crashbox kernel: [ 2538.356606]  ?
kthread_create_worker_on_cpu+0x60/0x60
Jan  5 14:01:46 crashbox kernel: [ 2538.356608]  ret_from_fork+0x22/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.356616] INFO: task
jbd2/dm-8-8:2025 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.356618]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.356619] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.356621] jbd2/dm-8-8     D    0
2025      2 0x80004000
Jan  5 14:01:46 crashbox kernel: [ 2538.356624] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.356627]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356631]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356634]  io_schedule+0xd/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356637]
wait_on_page_bit+0x10a/0x1d0
Jan  5 14:01:46 crashbox kernel: [ 2538.356641]  ?
file_fdatawait_range+0x20/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.356644]
__filemap_fdatawait_range+0x7c/0xd0
Jan  5 14:01:46 crashbox kernel: [ 2538.356649]
filemap_fdatawait_range_keep_errors+0x9/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356652]
jbd2_journal_commit_transaction+0xc86/0x199e
Jan  5 14:01:46 crashbox kernel: [ 2538.356655]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356658]  ?
_raw_spin_unlock_irq+0xe/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.356662]  ?
try_to_del_timer_sync+0x4a/0x80
Jan  5 14:01:46 crashbox kernel: [ 2538.356666]  kjournald2+0xb3/0x280
Jan  5 14:01:46 crashbox kernel: [ 2538.356668]  ? wait_woken+0x70/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356672]  ? commit_timeout+0x10/0x10
Jan  5 14:01:46 crashbox kernel: [ 2538.356675]  kthread+0x118/0x130
Jan  5 14:01:46 crashbox kernel: [ 2538.356678]  ?
kthread_create_worker_on_cpu+0x60/0x60
Jan  5 14:01:46 crashbox kernel: [ 2538.356680]  ret_from_fork+0x22/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.356690] INFO: task monit:2494
blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.356691]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.356692] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.356694] monit           D    0
2494      1 0x00004000
Jan  5 14:01:46 crashbox kernel: [ 2538.356697] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.356700]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356704]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356707]  io_schedule+0xd/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356710]
wait_on_page_bit+0x10a/0x1d0
Jan  5 14:01:46 crashbox kernel: [ 2538.356713]  ?
file_fdatawait_range+0x20/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.356717]
__filemap_fdatawait_range+0x7c/0xd0
Jan  5 14:01:46 crashbox kernel: [ 2538.356720]  ? do_writepages+0x3e/0xd0
Jan  5 14:01:46 crashbox kernel: [ 2538.356724]  ?
__filemap_fdatawrite_range+0x91/0xb0
Jan  5 14:01:46 crashbox kernel: [ 2538.356728]
file_write_and_wait_range+0x66/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.356731]  ext4_sync_file+0x69/0x310
Jan  5 14:01:46 crashbox kernel: [ 2538.356735]  do_fsync+0x33/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356738]  __x64_sys_fsync+0xb/0x10
Jan  5 14:01:46 crashbox kernel: [ 2538.356741]  do_syscall_64+0x63/0x410
Jan  5 14:01:46 crashbox kernel: [ 2538.356745]  ?
switch_fpu_return+0x24/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356749]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan  5 14:01:46 crashbox kernel: [ 2538.356752] RIP: 0033:0x7fa912764deb
Jan  5 14:01:46 crashbox kernel: [ 2538.356759] Code: Bad RIP value.
Jan  5 14:01:46 crashbox kernel: [ 2538.356761] RSP:
002b:00007fffd9344710 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
Jan  5 14:01:46 crashbox kernel: [ 2538.356764] RAX: ffffffffffffffda
RBX: 0000000000000000 RCX: 00007fa912764deb
Jan  5 14:01:46 crashbox kernel: [ 2538.356766] RDX: 0000000000000188
RSI: 00007fffd9344740 RDI: 0000000000000003
Jan  5 14:01:46 crashbox kernel: [ 2538.356768] RBP: 00007fffd9344740
R08: 0000000000000000 R09: 00007fffd93445c0
Jan  5 14:01:46 crashbox kernel: [ 2538.356770] R10: 0000563697ea75a0
R11: 0000000000000293 R12: 00005636970440a8
Jan  5 14:01:46 crashbox kernel: [ 2538.356771] R13: 0000000000000000
R14: 00007fffd9344884 R15: 0000000000000000
Jan  5 14:01:46 crashbox kernel: [ 2538.356871] INFO: task
pulseaudio:3766 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.356873]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.356874] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.356876] pulseaudio      D    0
3766   3410 0x00000120
Jan  5 14:01:46 crashbox kernel: [ 2538.356878] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.356882]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356886]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356889]  wait_barrier+0x105/0x170
Jan  5 14:01:46 crashbox kernel: [ 2538.356891]  ? wait_woken+0x70/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356895]
regular_request_wait.isra.0+0x30/0x110
Jan  5 14:01:46 crashbox kernel: [ 2538.356898]
raid10_read_request+0x1f9/0x340
Jan  5 14:01:46 crashbox kernel: [ 2538.356902]  ?
__split_and_process_bio+0xb7/0x220
Jan  5 14:01:46 crashbox kernel: [ 2538.356905]
raid10_make_request+0x101/0x140
Jan  5 14:01:46 crashbox kernel: [ 2538.356909]
md_handle_request+0x131/0x1a0
Jan  5 14:01:46 crashbox kernel: [ 2538.356913]  md_make_request+0x8b/0x1c0
Jan  5 14:01:46 crashbox kernel: [ 2538.356917]
generic_make_request+0xca/0x340
Jan  5 14:01:46 crashbox kernel: [ 2538.356920]  submit_bio+0x3e/0x120
Jan  5 14:01:46 crashbox kernel: [ 2538.356924]  ? bio_add_page+0x4c/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.356927]
ext4_mpage_readpages+0x393/0x8f0
Jan  5 14:01:46 crashbox kernel: [ 2538.356932]  ?
cpufreq_this_cpu_can_update+0x9/0x50
Jan  5 14:01:46 crashbox kernel: [ 2538.356935]  read_pages+0x6d/0x160
Jan  5 14:01:46 crashbox kernel: [ 2538.356939]
__do_page_cache_readahead+0x138/0x1b0
Jan  5 14:01:46 crashbox kernel: [ 2538.356943]  filemap_fault+0x568/0x7b0
Jan  5 14:01:46 crashbox kernel: [ 2538.356946]  ? _raw_spin_lock+0xe/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.356950]  ? alloc_set_pte+0x321/0x5a0
Jan  5 14:01:46 crashbox kernel: [ 2538.356953]  ?
filemap_map_pages+0x253/0x340
Jan  5 14:01:46 crashbox kernel: [ 2538.356956]
ext4_filemap_fault+0x28/0x3a
Jan  5 14:01:46 crashbox kernel: [ 2538.356959]  __do_fault+0x33/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.356963]
__handle_mm_fault+0xb41/0xed0
Jan  5 14:01:46 crashbox kernel: [ 2538.356967]  handle_mm_fault+0x4b/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.356970]  __do_page_fault+0x1a3/0x420
Jan  5 14:01:46 crashbox kernel: [ 2538.356974]  page_fault+0x2f/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.356976] RIP: 0033:0x7f02a6c13d72
Jan  5 14:01:46 crashbox kernel: [ 2538.356980] Code: Bad RIP value.
Jan  5 14:01:46 crashbox kernel: [ 2538.356981] RSP:
002b:00007ffca10643f8 EFLAGS: 00010202
Jan  5 14:01:46 crashbox kernel: [ 2538.356984] RAX: 00007ffca1064530
RBX: 00007ffca1064530 RCX: 0000000000000018
Jan  5 14:01:46 crashbox kernel: [ 2538.356985] RDX: 0000000000000018
RSI: 00007f029523cc58 RDI: 00007ffca1064530
Jan  5 14:01:46 crashbox kernel: [ 2538.356987] RBP: 000055fc64bc5e10
R08: 0000000000000000 R09: 00007ffca1064530
Jan  5 14:01:46 crashbox kernel: [ 2538.356989] R10: 000055fc64dde990
R11: 0000000000000000 R12: 0000000000003c58
Jan  5 14:01:46 crashbox kernel: [ 2538.356990] R13: 0000000000000018
R14: 0000000000000018 R15: 000055fc64dde990
Jan  5 14:01:46 crashbox kernel: [ 2538.357020] INFO: task
pool-org.gnome.:6959 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.357022]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.357023] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.357025] pool-org.gnome. D    0
6959   3768 0x00004000
Jan  5 14:01:46 crashbox kernel: [ 2538.357027] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.357031]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.357034]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.357037]  wait_barrier+0x105/0x170
Jan  5 14:01:46 crashbox kernel: [ 2538.357040]  ? wait_woken+0x70/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357043]
regular_request_wait.isra.0+0x30/0x110
Jan  5 14:01:46 crashbox kernel: [ 2538.357046]
raid10_read_request+0x1f9/0x340
Jan  5 14:01:46 crashbox kernel: [ 2538.357050]  ?
__split_and_process_bio+0xb7/0x220
Jan  5 14:01:46 crashbox kernel: [ 2538.357053]
raid10_make_request+0x101/0x140
Jan  5 14:01:46 crashbox kernel: [ 2538.357056]
md_handle_request+0x131/0x1a0
Jan  5 14:01:46 crashbox kernel: [ 2538.357060]  md_make_request+0x8b/0x1c0
Jan  5 14:01:46 crashbox kernel: [ 2538.357064]
generic_make_request+0xca/0x340
Jan  5 14:01:46 crashbox kernel: [ 2538.357068]  submit_bio+0x3e/0x120
Jan  5 14:01:46 crashbox kernel: [ 2538.357071]  ? bio_add_page+0x4c/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357074]
ext4_mpage_readpages+0x393/0x8f0
Jan  5 14:01:46 crashbox kernel: [ 2538.357078]  ?
_raw_spin_unlock_irqrestore+0xf/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.357081]  read_pages+0x6d/0x160
Jan  5 14:01:46 crashbox kernel: [ 2538.357085]
__do_page_cache_readahead+0x18e/0x1b0
Jan  5 14:01:46 crashbox kernel: [ 2538.357088]
ondemand_readahead+0x19c/0x320
Jan  5 14:01:46 crashbox kernel: [ 2538.357092]  ?
pagecache_get_page+0x22/0x240
Jan  5 14:01:46 crashbox kernel: [ 2538.357095]
generic_file_read_iter+0x842/0xb20
Jan  5 14:01:46 crashbox kernel: [ 2538.357100]  ?
preempt_count_add+0x44/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.357103]  ?
percpu_counter_add_batch+0x81/0xb0
Jan  5 14:01:46 crashbox kernel: [ 2538.357107]  ?
kmem_cache_alloc+0xa1/0xd0
Jan  5 14:01:46 crashbox kernel: [ 2538.357110]
generic_file_splice_read+0xf6/0x1a0
Jan  5 14:01:46 crashbox kernel: [ 2538.357114]
__x64_sys_splice+0x6dc/0x760
Jan  5 14:01:46 crashbox kernel: [ 2538.357118]  do_syscall_64+0x63/0x410
Jan  5 14:01:46 crashbox kernel: [ 2538.357121]  ?
switch_fpu_return+0x24/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.357125]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan  5 14:01:46 crashbox kernel: [ 2538.357127] RIP: 0033:0x7f4f3ff3dbf3
Jan  5 14:01:46 crashbox kernel: [ 2538.357130] Code: Bad RIP value.
Jan  5 14:01:46 crashbox kernel: [ 2538.357132] RSP:
002b:00007f4f164763a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000113
Jan  5 14:01:46 crashbox kernel: [ 2538.357134] RAX: ffffffffffffffda
RBX: 0000000000100000 RCX: 00007f4f3ff3dbf3
Jan  5 14:01:46 crashbox kernel: [ 2538.357136] RDX: 000000000000002b
RSI: 00007f4f164764d8 RDI: 0000000000000027
Jan  5 14:01:46 crashbox kernel: [ 2538.357137] RBP: 0000000000000000
R08: 0000000000100000 R09: 0000000000000004
Jan  5 14:01:46 crashbox kernel: [ 2538.357139] R10: 0000000000000000
R11: 0000000000000293 R12: 000000000000002b
Jan  5 14:01:46 crashbox kernel: [ 2538.357141] R13: 00007f4f164764d8
R14: 0000000000000027 R15: 00007f4f164764e8
Jan  5 14:01:46 crashbox kernel: [ 2538.357148] INFO: task
gnome-terminal-:4106 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.357150]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.357151] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.357152] gnome-terminal- D    0
4106   3410 0x00000000
Jan  5 14:01:46 crashbox kernel: [ 2538.357155] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.357159]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.357162]  ?
bit_wait_timeout+0x90/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.357165]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.357168]  io_schedule+0xd/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.357172]  bit_wait_io+0x8/0x50
Jan  5 14:01:46 crashbox kernel: [ 2538.357175]  __wait_on_bit+0x25/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.357178]
out_of_line_wait_on_bit+0x8d/0xb0
Jan  5 14:01:46 crashbox kernel: [ 2538.357181]  ?
var_wake_function+0x20/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.357185]
do_get_write_access+0x2d2/0x4d0
Jan  5 14:01:46 crashbox kernel: [ 2538.357188]
jbd2_journal_get_write_access+0x28/0x50
Jan  5 14:01:46 crashbox kernel: [ 2538.357191]
__ext4_journal_get_write_access+0x28/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357194]  ?
ext4_read_block_bitmap+0x29/0x40
Jan  5 14:01:46 crashbox kernel: [ 2538.357197]
ext4_free_blocks+0x2c0/0x940
Jan  5 14:01:46 crashbox kernel: [ 2538.357200]  ?
__ext4_ext_check+0x101/0x350
Jan  5 14:01:46 crashbox kernel: [ 2538.357203]
ext4_ext_remove_space+0x51b/0x1530
Jan  5 14:01:46 crashbox kernel: [ 2538.357207]  ?
_raw_write_unlock+0xd/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.357210]  ext4_truncate+0x2a1/0x380
Jan  5 14:01:46 crashbox kernel: [ 2538.357213]  ?
jbd2__journal_start+0xe1/0x170
Jan  5 14:01:46 crashbox kernel: [ 2538.357216]
ext4_evict_inode+0x231/0x4d0
Jan  5 14:01:46 crashbox kernel: [ 2538.357220]  evict+0xbf/0x190
Jan  5 14:01:46 crashbox kernel: [ 2538.357223]  __dentry_kill+0xc8/0x160
Jan  5 14:01:46 crashbox kernel: [ 2538.357226]  dput+0x130/0x2c0
Jan  5 14:01:46 crashbox kernel: [ 2538.357230]  __fput+0xf8/0x230
Jan  5 14:01:46 crashbox kernel: [ 2538.357233]  task_work_run+0x8e/0xb0
Jan  5 14:01:46 crashbox kernel: [ 2538.357236]  do_syscall_64+0x39a/0x410
Jan  5 14:01:46 crashbox kernel: [ 2538.357240]  ?
switch_fpu_return+0x24/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.357243]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan  5 14:01:46 crashbox kernel: [ 2538.357245] RIP: 0033:0x7f09f99c93eb
Jan  5 14:01:46 crashbox kernel: [ 2538.357248] Code: Bad RIP value.
Jan  5 14:01:46 crashbox kernel: [ 2538.357250] RSP:
002b:00007fff0416e358 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
Jan  5 14:01:46 crashbox kernel: [ 2538.357252] RAX: 0000000000000000
RBX: 0000558b1dfde520 RCX: 00007f09f99c93eb
Jan  5 14:01:46 crashbox kernel: [ 2538.357254] RDX: 00007f09fa758000
RSI: 000000000000ef7e RDI: 00007f09eb1e4000
Jan  5 14:01:46 crashbox kernel: [ 2538.357256] RBP: 0000558b1e123280
R08: 0000558b1e823360 R09: 002f396239373964
Jan  5 14:01:46 crashbox kernel: [ 2538.357257] R10: 0000000000000004
R11: 0000000000000206 R12: 0000558b1e823360
Jan  5 14:01:46 crashbox kernel: [ 2538.357259] R13: 0000000000000000
R14: 0000000000000000 R15: 0000558b1e6aabb0
Jan  5 14:01:46 crashbox kernel: [ 2538.357265] INFO: task
gvfsd-metadata:4334 blocked for more than 120 seconds.
Jan  5 14:01:46 crashbox kernel: [ 2538.357267]       Tainted: G
WC        5.4.8 #10
Jan  5 14:01:46 crashbox kernel: [ 2538.357268] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jan  5 14:01:46 crashbox kernel: [ 2538.357270] gvfsd-metadata  D    0
4334   3410 0x00000000
Jan  5 14:01:46 crashbox kernel: [ 2538.357272] Call Trace:
Jan  5 14:01:46 crashbox kernel: [ 2538.357276]  ? __schedule+0x1f5/0x5f0
Jan  5 14:01:46 crashbox kernel: [ 2538.357279]  ?
bit_wait_timeout+0x90/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.357282]  schedule+0x3e/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.357286]  io_schedule+0xd/0x30
Jan  5 14:01:46 crashbox kernel: [ 2538.357289]  bit_wait_io+0x8/0x50
Jan  5 14:01:46 crashbox kernel: [ 2538.357292]  __wait_on_bit+0x25/0x90
Jan  5 14:01:46 crashbox kernel: [ 2538.357296]
out_of_line_wait_on_bit+0x8d/0xb0
Jan  5 14:01:46 crashbox kernel: [ 2538.357298]  ?
var_wake_function+0x20/0x20
Jan  5 14:01:46 crashbox kernel: [ 2538.357302]
do_get_write_access+0x2d2/0x4d0
Jan  5 14:01:46 crashbox kernel: [ 2538.357305]
jbd2_journal_get_write_access+0x28/0x50
Jan  5 14:01:46 crashbox kernel: [ 2538.357308]
__ext4_journal_get_write_access+0x28/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357311]
__ext4_new_inode+0x489/0x1340
Jan  5 14:01:46 crashbox kernel: [ 2538.357315]  ? __d_rehash+0x59/0xa0
Jan  5 14:01:46 crashbox kernel: [ 2538.357318]  ext4_create+0xab/0x1b0
Jan  5 14:01:46 crashbox kernel: [ 2538.357323]  path_openat+0x106d/0x1560
Jan  5 14:01:46 crashbox kernel: [ 2538.357326]  ? __switch_to_asm+0x34/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357329]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357331]  ? __switch_to_asm+0x34/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357333]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357336]  ? __switch_to_asm+0x34/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357338]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357340]  do_filp_open+0x8c/0x100
Jan  5 14:01:46 crashbox kernel: [ 2538.357344]  ?
finish_task_switch+0x7b/0x220
Jan  5 14:01:46 crashbox kernel: [ 2538.357347]  ? __switch_to_asm+0x40/0x70
Jan  5 14:01:46 crashbox kernel: [ 2538.357351]  do_sys_open+0x17f/0x220
Jan  5 14:01:46 crashbox kernel: [ 2538.357354]  do_syscall_64+0x63/0x410
Jan  5 14:01:46 crashbox kernel: [ 2538.357357]  ?
switch_fpu_return+0x24/0xc0
Jan  5 14:01:46 crashbox kernel: [ 2538.357360]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan  5 14:01:46 crashbox kernel: [ 2538.357363] RIP: 0033:0x7f57b2c2a1f4
Jan  5 14:01:46 crashbox kernel: [ 2538.357366] Code: Bad RIP value.
Jan  5 14:01:46 crashbox kernel: [ 2538.357367] RSP:
002b:00007fffb02e6f70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Jan  5 14:01:46 crashbox kernel: [ 2538.357370] RAX: ffffffffffffffda
RBX: 000056151b449010 RCX: 00007f57b2c2a1f4
Jan  5 14:01:46 crashbox kernel: [ 2538.357371] RDX: 00000000000000c2
RSI: 000056151b449010 RDI: 00000000ffffff9c
Jan  5 14:01:46 crashbox kernel: [ 2538.357373] RBP: 000056151b449010
R08: 0000000000000000 R09: 00007fffb02e6f98
Jan  5 14:01:46 crashbox kernel: [ 2538.357375] R10: 0000000000000180
R11: 0000000000000293 R12: 00000000000000c2
Jan  5 14:01:46 crashbox kernel: [ 2538.357377] R13: 0000000000000180
R14: 0e38e38e38e38e39 R15: 000000005e1d22e7
Jan  5 14:01:47 crashbox kernel: [ 2539.461762] sysrq: Emergency Sync


