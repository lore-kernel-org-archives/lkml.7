Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28B1C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F65206A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="JgQfVVZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfKQHev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 02:34:51 -0500
Received: from cmta19.telus.net ([209.171.16.92]:55285 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfKQHeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 02:34:50 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id WF4ri6SulhFQMWF4siidWh; Sun, 17 Nov 2019 00:34:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1573976078; bh=oHONWlBiYxcY3vHgaaTmdCxFlOzGOZIziIMD8j5OunM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=JgQfVVZ7gMUwzLYBf/nyU0Q8sI9ATJk+6aBN24BcD4BNDmofA+g6dsEkspEh1Y8dy
         OT6ZRYIw0Xl8+5yuL3PLGx7cNo5xQHh+xZzu/pveEK1FP2m+sc6DfbCMcUKavbgiiK
         vylCr7WqNgEJE186Ymeld7+NKfv3wjHaLXDMxOVaY8Gw/yzX89OOeUX2Xa7xKzE+kh
         B81GiLmT2boUfK5hho2+u44orTZr3Nz8/qxpfGUsaFdo60ix/Og2O/Rxd4rWcvae0A
         fsD+0GszVqm6MVBOcay/pSgK8dC9OfjBo2N3Z65SFZDJMgbldPd2T09gCQenzTZ9DC
         uKXuJYHzgPl5w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=r77TgQKjGQsHNAKrUKIA:9 a=biQ02z-VheGHmCt8w5IA:9 a=CjuIK1q_8ugA:10
 a=p9fp_R1CCzWnbVg0NQkA:9 a=m-Z_27IZkzAA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Cc:     "'Linux ACPI'" <linux-acpi@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>,
        "'Dmitry Osipenko'" <digetx@gmail.com>
References: <2811202.iOFZ6YHztY@kreacher> <4551555.oysnf1Sd0E@kreacher>
In-Reply-To: <4551555.oysnf1Sd0E@kreacher>
Subject: RE: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Date:   Sat, 16 Nov 2019 23:34:31 -0800
Message-ID: <000a01d59d19$75793a80$606baf80$@net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_000B_01D59CD6.6755FA80"
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWED0vlByLFQ8J4Rz2jUgcX377w8gZBYsHg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfBryo2+5cGy+JJCqyW5LflwI1Kyh1GU3jbR1LM9fzQuIA3A0TsTvwAZKu1ArYSsg/7uy2xRPgC3YXLddj0lbcGpmIgLBmgomT5owtQzSFshe2rh+Y/Qd
 jk4cRDLOx1mCYWLl0O7hlDZ9RETt7Rqqtq6NTi6dMFWsYROTxSjBUOZ9owgKWmpy1mBXW5HS7RJg1xv+7DvekVYh/nAA5NxRzY1Kw68T4jKI3jqArDIpeQ1r
 at/lLs2JoTIRv9Ndu7jVoTyMMpe7SGURiQdOPyqB1KZpZREwGCCHJq+qvHdec71PymZqPgQKraqD7NBvszBHzSYiBJlMI8Gm6pV53amHsie8q7c+vB0Ui37E
 t+2z9UNmwxdVAnAhwi/cVbgp4u5dFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01D59CD6.6755FA80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2019.10.16 03:41 Rafael J. Wysocki wrote:

... deleted ...

Hi Rafael,

Not sure, but I think it is this one that
causes complaining when I try to set the
intel_pstate driver to passive mode.
I started from active mode, powersave governor,
no HWP.

Kernel: 5.4-rc7

I did not go back and try previous 5.4 RCs.
I did try kernel 5.3-rc8, because I already had
it installed, and it worked fine.

I use a script (for years), run as sudo:

doug@s15:~/temp$ cat set_cpu_passive
#! /bin/bash
cat /sys/devices/system/cpu/intel_pstate/status
echo passive > /sys/devices/system/cpu/intel_pstate/status
cat /sys/devices/system/cpu/intel_pstate/status

And I get this (very small excerpt):

freq_qos_add_request() called for active request
WARNING: CPU: 1 PID: 2758 at kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0
CPU: 1 PID: 2758 Comm: set_cpu_passive Not tainted 5.4.0-rc7-stock #727
Failed to add freq constraint for CPU0 (-22)

freq_qos_add_request() called for active request
WARNING: CPU: 1 PID: 2758 at kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0
CPU: 1 PID: 2758 Comm: set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727
Failed to add freq constraint for CPU1 (-22)

...

I'll attach the whole thing, but it will likely get removed
from the general list e-mails.

... Doug


------=_NextPart_000_000B_01D59CD6.6755FA80
Content-Type: text/plain;
	name="rjw.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rjw.txt"

Nov 16 22:54:33 s15 kernel: [  116.132508] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.132510] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.132521] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132522] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.132564]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.132577] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Not tainted 5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.132578] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.132581] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132583] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.132585] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.132587] RAX: 0000000000000000 RBX: =
ffff96034ccc33a8 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.132588] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.132589] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 00000000000003c1=0A=
Nov 16 22:54:33 s15 kernel: [  116.132591] R10: ffff960344aed6d8 R11: =
00000000000003c1 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.132592] R13: 00000000000285f8 R14: =
ffff96034d0adc90 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.132594] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.132596] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.132597] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132598] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.132605]  =
acpi_thermal_cpufreq_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.132608]  =
acpi_processor_notifier+0x28/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.132612]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.132615]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.132618]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.132622]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.132626]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.132631]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.132635]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.132638]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.132641]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.132644]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.132647]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.132650]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.132653]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132656]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.132658]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132661]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132663]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.132667]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.132671]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.132673] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132676] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.132677] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.132679] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132680] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.132681] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.132683] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.132684] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.132687] ---[ end trace =
a1f26554c8afbfac ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.132689] Failed to add freq constraint =
for CPU0 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.132728] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.132729] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.132734] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132735] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.132766]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.132775] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.132776] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.132778] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132780] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.132782] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.132783] RAX: 0000000000000000 RBX: =
ffff96034ccc3370 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.132784] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.132786] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 00000000000003f3=0A=
Nov 16 22:54:33 s15 kernel: [  116.132787] R10: ffff960344aed6d8 R11: =
00000000000003f3 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.132788] R13: 00000000000285f8 R14: =
ffff96034d0adc90 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.132790] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.132791] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.132792] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132793] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.132796]  =
acpi_processor_ppc_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.132798]  =
acpi_processor_notifier+0x34/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.132801]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.132804]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.132806]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.132810]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.132813]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.132816]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.132820]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.132823]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.132826]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.132828]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.132830]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.132832]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.132835]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132837]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.132839]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132842]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132844]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.132847]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.132850]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.132851] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132853] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.132854] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.132856] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132857] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.132859] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.132860] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.132861] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.132864] ---[ end trace =
a1f26554c8afbfad ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.132865] Failed to add freq constraint =
for CPU0 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.132953] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.132954] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.132959] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.132959] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.132990]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.133000] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.133001] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.133003] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133004] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.133005] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.133007] RAX: 0000000000000000 RBX: =
ffff96034ccc63a8 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.133008] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.133009] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 0000000000000425=0A=
Nov 16 22:54:33 s15 kernel: [  116.133010] R10: ffff960344aed0d8 R11: =
0000000000000425 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.133012] R13: 00000000000285f8 R14: =
ffff96034d0acc90 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133013] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133014] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.133016] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133017] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.133020]  =
acpi_thermal_cpufreq_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133022]  =
acpi_processor_notifier+0x28/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133025]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133027]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133030]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133033]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.133037]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133040]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.133043]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133046]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133049]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133052]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.133054]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133056]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.133058]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133060]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.133062]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133065]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133068]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133070]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.133073]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.133075] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133076] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.133077] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133079] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133080] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133081] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.133083] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.133084] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133087] ---[ end trace =
a1f26554c8afbfae ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.133088] Failed to add freq constraint =
for CPU1 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.133121] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.133121] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.133126] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133127] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.133158]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.133167] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.133168] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.133170] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133171] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.133172] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.133174] RAX: 0000000000000000 RBX: =
ffff96034ccc6370 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.133175] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.133176] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 0000000000000457=0A=
Nov 16 22:54:33 s15 kernel: [  116.133177] R10: ffff960344aed0d8 R11: =
0000000000000457 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.133179] R13: 00000000000285f8 R14: =
ffff96034d0acc90 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133180] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133181] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.133183] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133183] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.133186]  =
acpi_processor_ppc_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133188]  =
acpi_processor_notifier+0x34/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133191]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133194]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133196]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133199]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.133203]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133206]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.133210]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133212]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133215]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133218]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.133220]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133222]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.133224]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133226]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.133228]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133231]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133233]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133236]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.133239]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.133240] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133242] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.133243] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133245] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133246] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133247] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.133248] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.133249] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133252] ---[ end trace =
a1f26554c8afbfaf ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.133254] Failed to add freq constraint =
for CPU1 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.133422] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.133423] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.133426] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133427] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.133485]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.133489] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.133490] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.133491] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133492] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.133493] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.133493] RAX: 0000000000000000 RBX: =
ffff96034ccc27a8 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.133494] RDX: 0000000000000007 RSI: =
0000000000000000 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.133494] RBP: ffffba3f80527c30 R08: =
0000000000000000 R09: 0000000000000489=0A=
Nov 16 22:54:33 s15 kernel: [  116.133495] R10: ffff960344aed2d8 R11: =
0000000000000489 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.133495] R13: 00000000000285f8 R14: =
ffff96034d0af090 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133496] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133497] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.133497] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133498] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.133499]  =
acpi_thermal_cpufreq_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133500]  =
acpi_processor_notifier+0x28/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133503]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133504]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133505]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133507]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.133508]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133510]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.133511]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133512]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133514]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133515]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.133516]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133517]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.133518]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133519]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.133520]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133521]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133522]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133523]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.133524]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.133525] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133526] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.133526] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133527] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133528] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133528] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.133529] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.133529] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133530] ---[ end trace =
a1f26554c8afbfb0 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.133531] Failed to add freq constraint =
for CPU2 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.133546] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.133547] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.133549] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133549] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.133570]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.133586] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.133588] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.133591] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133593] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.133594] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.133596] RAX: 0000000000000000 RBX: =
ffff96034ccc2770 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.133599] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.133601] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 00000000000004bb=0A=
Nov 16 22:54:33 s15 kernel: [  116.133603] R10: ffff960344aed2d8 R11: =
00000000000004bb R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.133605] R13: 00000000000285f8 R14: =
ffff96034d0af090 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133607] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133609] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.133611] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133611] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.133613]  =
acpi_processor_ppc_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133614]  =
acpi_processor_notifier+0x34/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133615]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133616]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133617]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133619]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.133620]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133622]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.133623]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133624]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133626]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133627]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.133628]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133629]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.133630]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133631]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.133631]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133633]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133634]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133635]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.133636]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.133637] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133638] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.133638] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133639] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133639] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133640] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.133641] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.133641] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133642] ---[ end trace =
a1f26554c8afbfb1 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.133643] Failed to add freq constraint =
for CPU2 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.133706] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.133707] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.133709] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133709] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.133728]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.133735] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.133735] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.133738] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133739] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.133739] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.133740] RAX: 0000000000000000 RBX: =
ffff96034ccc2ba8 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.133740] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.133741] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 00000000000004ed=0A=
Nov 16 22:54:33 s15 kernel: [  116.133741] R10: ffff960344aed558 R11: =
00000000000004ed R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.133742] R13: 00000000000285f8 R14: =
ffff960341845090 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133743] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133743] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.133744] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133744] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.133745]  =
acpi_thermal_cpufreq_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133747]  =
acpi_processor_notifier+0x28/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133748]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133749]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133750]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133752]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.133753]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133754]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.133764]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133765]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133766]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133775]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.133775]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133776]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.133777]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133778]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.133779]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133780]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133782]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133783]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.133784]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.133785] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133786] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.133786] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133787] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133787] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133788] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.133788] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.133789] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133790] ---[ end trace =
a1f26554c8afbfb2 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.133791] Failed to add freq constraint =
for CPU3 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.133806] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.133806] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.133808] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133809] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.133847]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.133861] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.133862] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.133863] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133864] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.133864] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.133865] RAX: 0000000000000000 RBX: =
ffff96034ccc2b70 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.133865] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.133866] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 000000000000051f=0A=
Nov 16 22:54:33 s15 kernel: [  116.133866] R10: ffff960344aed558 R11: =
000000000000051f R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.133867] R13: 00000000000285f8 R14: =
ffff960341845090 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133868] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133868] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.133869] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133869] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.133870]  =
acpi_processor_ppc_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133871]  =
acpi_processor_notifier+0x34/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133872]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133874]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133875]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133876]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.133878]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133879]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.133881]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133882]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133883]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133884]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.133885]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133886]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.133887]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133888]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.133889]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133890]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133891]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133892]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.133894]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.133894] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133895] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.133895] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133896] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133897] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.133897] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.133898] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.133898] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133900] ---[ end trace =
a1f26554c8afbfb3 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.133900] Failed to add freq constraint =
for CPU3 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.133927] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.133928] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.133932] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133934] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.133970]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.133975] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.133975] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.133976] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133977] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.133977] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.133978] RAX: 0000000000000000 RBX: =
ffff96034ccc7fa8 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.133979] RDX: 0000000000000007 RSI: =
0000000000000001 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.133979] RBP: ffffba3f80527c30 R08: =
0000000000000000 R09: 0000000000000551=0A=
Nov 16 22:54:33 s15 kernel: [  116.133980] R10: ffff960344aedad8 R11: =
0000000000000551 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.133980] R13: 00000000000285f8 R14: =
ffff96034d24e090 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133981] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.133982] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.133982] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.133982] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.133984]  =
acpi_thermal_cpufreq_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133985]  =
acpi_processor_notifier+0x28/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133986]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133987]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.133988]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.133990]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.133991]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.133993]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.133994]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133996]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.133997]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.133998]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.133999]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134000]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.134001]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134002]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.134003]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134004]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134005]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134006]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.134008]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.134008] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134016] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.134017] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134018] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134018] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134019] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.134019] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.134020] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134021] ---[ end trace =
a1f26554c8afbfb4 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.134021] Failed to add freq constraint =
for CPU4 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.134044] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.134045] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.134047] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134047] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.134061]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.134065] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.134065] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.134066] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134067] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.134067] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.134068] RAX: 0000000000000000 RBX: =
ffff96034ccc7f70 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.134069] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.134069] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 0000000000000583=0A=
Nov 16 22:54:33 s15 kernel: [  116.134072] R10: ffff960344aedad8 R11: =
0000000000000583 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.134073] R13: 00000000000285f8 R14: =
ffff96034d24e090 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134075] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134077] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.134078] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134080] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.134082]  =
acpi_processor_ppc_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134084]  =
acpi_processor_notifier+0x34/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134086]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134088]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134090]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134093]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.134095]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134098]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.134100]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134103]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134105]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134108]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.134110]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134112]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.134114]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134116]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.134118]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134120]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134122]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134124]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.134126]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.134128] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134130] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.134131] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134132] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134132] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134133] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.134133] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.134134] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134135] ---[ end trace =
a1f26554c8afbfb5 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.134136] Failed to add freq constraint =
for CPU4 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.134164] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.134166] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.134168] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134168] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.134188]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.134193] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.134195] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.134196] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134197] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.134198] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.134199] RAX: 0000000000000000 RBX: =
ffff96034ccc67a8 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.134200] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.134200] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 00000000000005b5=0A=
Nov 16 22:54:33 s15 kernel: [  116.134201] R10: ffff960344aed658 R11: =
00000000000005b5 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.134202] R13: 00000000000285f8 R14: =
ffff96034cc2e090 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134204] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134205] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.134206] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134206] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.134208]  =
acpi_thermal_cpufreq_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134209]  =
acpi_processor_notifier+0x28/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134210]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134212]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134214]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134216]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.134218]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134219]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.134221]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134222]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134223]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134224]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.134227]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134229]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.134232]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134234]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.134235]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134236]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134237]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134238]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.134241]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.134242] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134244] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.134244] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134245] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134245] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134246] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.134246] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.134247] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134248] ---[ end trace =
a1f26554c8afbfb6 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.134249] Failed to add freq constraint =
for CPU5 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.134266] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.134266] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.134269] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134269] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.134291]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.134295] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.134295] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.134296] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134297] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.134297] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.134298] RAX: 0000000000000000 RBX: =
ffff96034ccc6770 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.134298] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.134299] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 00000000000005e7=0A=
Nov 16 22:54:33 s15 kernel: [  116.134299] R10: ffff960344aed658 R11: =
00000000000005e7 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.134300] R13: 00000000000285f8 R14: =
ffff96034cc2e090 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134301] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134301] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.134302] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134302] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.134303]  =
acpi_processor_ppc_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134304]  =
acpi_processor_notifier+0x34/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134305]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134306]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134308]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134309]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.134311]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134312]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.134313]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134315]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134316]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134317]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.134318]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134319]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.134320]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134321]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.134322]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134323]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134324]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134325]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.134326]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.134327] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134328] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.134328] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134329] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134329] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134330] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.134330] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.134331] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134332] ---[ end trace =
a1f26554c8afbfb7 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.134332] Failed to add freq constraint =
for CPU5 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.134401] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.134403] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.134406] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134407] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.134435]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.134439] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.134440] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.134441] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134441] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.134442] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.134442] RAX: 0000000000000000 RBX: =
ffff96034ccc4ba8 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.134443] RDX: 0000000000000007 RSI: =
0000000000000001 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.134443] RBP: ffffba3f80527c30 R08: =
0000000000000000 R09: 0000000000000619=0A=
Nov 16 22:54:33 s15 kernel: [  116.134444] R10: ffff960344aedfd8 R11: =
0000000000000619 R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.134444] R13: 00000000000285f8 R14: =
ffff96034cd33490 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134445] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134446] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.134446] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134447] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.134448]  =
acpi_thermal_cpufreq_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134449]  =
acpi_processor_notifier+0x28/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134450]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134452]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134453]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134454]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.134456]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134457]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.134459]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134461]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134464]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134466]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.134468]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134470]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.134472]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134474]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.134476]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134478]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134480]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134482]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.134484]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.134486] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134487] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.134487] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134488] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134488] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134489] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.134489] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.134490] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134491] ---[ end trace =
a1f26554c8afbfb8 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.134492] Failed to add freq constraint =
for CPU6 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.134508] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.134509] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.134512] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134512] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.134527]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.134531] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.134531] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.134532] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134533] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.134533] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.134534] RAX: 0000000000000000 RBX: =
ffff96034ccc4b70 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.134534] RDX: 0000000000000007 RSI: =
0000000000000001 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.134535] RBP: ffffba3f80527c30 R08: =
0000000000000000 R09: 000000000000064b=0A=
Nov 16 22:54:33 s15 kernel: [  116.134535] R10: ffff960344aedfd8 R11: =
000000000000064b R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.134536] R13: 00000000000285f8 R14: =
ffff96034cd33490 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134537] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134537] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.134538] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134538] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.134539]  =
acpi_processor_ppc_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134540]  =
acpi_processor_notifier+0x34/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134541]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134543]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134544]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134545]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.134548]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134550]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.134552]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134553]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134554]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134555]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.134556]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134557]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.134558]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134559]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.134560]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134561]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134562]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134563]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.134564]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.134565] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134566] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.134566] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134567] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134568] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134568] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.134569] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.134569] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134570] ---[ end trace =
a1f26554c8afbfb9 ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.134571] Failed to add freq constraint =
for CPU6 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.134651] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.134652] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.134654] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134654] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.134668]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.134672] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.134673] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.134673] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134674] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.134675] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.134675] RAX: 0000000000000000 RBX: =
ffff96034ccc17a8 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.134676] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.134676] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 000000000000067d=0A=
Nov 16 22:54:33 s15 kernel: [  116.134677] R10: ffff960344aed5d8 R11: =
000000000000067d R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.134677] R13: 00000000000285f8 R14: =
ffff960340627490 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134678] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134679] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.134679] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134680] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.134681]  =
acpi_thermal_cpufreq_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134682]  =
acpi_processor_notifier+0x28/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134683]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134684]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134686]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134687]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.134688]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134690]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.134691]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134693]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134694]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134695]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.134696]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134697]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.134698]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134699]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.134700]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134701]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134702]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134703]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.134705]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.134705] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134706] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.134706] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134707] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134708] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134708] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.134709] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.134709] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134710] ---[ end trace =
a1f26554c8afbfba ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.134711] Failed to add freq constraint =
for CPU7 (-22)=0A=
Nov 16 22:54:33 s15 kernel: [  116.134726] ------------[ cut here =
]------------=0A=
Nov 16 22:54:33 s15 kernel: [  116.134726] freq_qos_add_request() called =
for active request=0A=
Nov 16 22:54:33 s15 kernel: [  116.134728] WARNING: CPU: 1 PID: 2758 at =
kernel/power/qos.c:763 freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134729] Modules linked in: =
xt_conntrack ipt_REJECT nf_reject_ipv4 ebtable_filter ebtables =
ip6_tables xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp iptable_filter =
ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic ledtrig_audio bridge snd_hda_intel intel_rapl_msr =
snd_intel_nhlt intel_rapl_common snd_hda_codec stp snd_hda_core ppdev =
x86_pkg_temp_thermal snd_hwdep llc intel_powerclamp snd_pcm mei_hdcp =
snd_timer snd coretemp soundcore intel_cstate intel_rapl_perf input_leds =
serio_raw mei_me eeepc_wmi mei asus_wmi wmi_bmof sparse_keymap kvm_intel =
i2c_i801 lpc_ich kvm irqbypass parport_pc mac_hid parport ib_iser =
rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456 =
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul crc32_pclmul=0A=
Nov 16 22:54:33 s15 kernel: [  116.134742]  ghash_clmulni_intel =
i2c_algo_bit drm_kms_helper aesni_intel syscopyarea sysfillrect =
sysimgblt fb_sys_fops crypto_simd cryptd glue_helper e1000e drm ahci =
pata_acpi r8169 libahci realtek wmi video=0A=
Nov 16 22:54:33 s15 kernel: [  116.134746] CPU: 1 PID: 2758 Comm: =
set_cpu_passive Tainted: G        W         5.4.0-rc7-stock #727=0A=
Nov 16 22:54:33 s15 kernel: [  116.134747] Hardware name: System =
manufacturer System Product Name/P8Z68-M PRO, BIOS 4003 05/09/2013=0A=
Nov 16 22:54:33 s15 kernel: [  116.134748] RIP: =
0010:freq_qos_add_request+0x4c/0xa0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134748] Code: f6 74 6b 48 8b 46 30 48 =
89 f3 48 85 c0 74 25 48 3d 00 f0 ff ff 77 1d 48 c7 c6 20 54 a2 8f 48 c7 =
c7 88 e7 d0 8f e8 24 d7 f9 ff <0f> 0b 44 89 e0 5b 41 5c 5d c3 48 89 7b =
30 89 13 31 f6 89 ca 48 89=0A=
Nov 16 22:54:33 s15 kernel: [  116.134749] RSP: 0018:ffffba3f80527c20 =
EFLAGS: 00010282=0A=
Nov 16 22:54:33 s15 kernel: [  116.134750] RAX: 0000000000000000 RBX: =
ffff96034ccc1770 RCX: 0000000000000006=0A=
Nov 16 22:54:33 s15 kernel: [  116.134750] RDX: 0000000000000007 RSI: =
0000000000000086 RDI: ffff96034f457440=0A=
Nov 16 22:54:33 s15 kernel: [  116.134751] RBP: ffffba3f80527c30 R08: =
0000000000000001 R09: 00000000000006af=0A=
Nov 16 22:54:33 s15 kernel: [  116.134751] R10: ffff960344aed5d8 R11: =
00000000000006af R12: 00000000ffffffea=0A=
Nov 16 22:54:33 s15 kernel: [  116.134752] R13: 00000000000285f8 R14: =
ffff960340627490 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134752] FS:  00007fcfa6483700(0000) =
GS:ffff96034f440000(0000) knlGS:0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134753] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A=
Nov 16 22:54:33 s15 kernel: [  116.134753] CR2: 0000560c3e55ba00 CR3: =
0000000402e2c004 CR4: 00000000000606e0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134754] Call Trace:=0A=
Nov 16 22:54:33 s15 kernel: [  116.134755]  =
acpi_processor_ppc_init+0x68/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134756]  =
acpi_processor_notifier+0x34/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134757]  notifier_call_chain+0x4c/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134758]  =
__blocking_notifier_call_chain+0x47/0x60=0A=
Nov 16 22:54:33 s15 kernel: [  116.134760]  =
blocking_notifier_call_chain+0x16/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134762]  cpufreq_online+0x399/0x960=0A=
Nov 16 22:54:33 s15 kernel: [  116.134764]  cpufreq_add_dev+0x78/0x90=0A=
Nov 16 22:54:33 s15 kernel: [  116.134766]  =
subsys_interface_register+0xcb/0x120=0A=
Nov 16 22:54:33 s15 kernel: [  116.134767]  =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134769]  ? =
cpufreq_register_driver+0x15e/0x250=0A=
Nov 16 22:54:33 s15 kernel: [  116.134770]  =
intel_pstate_register_driver+0x38/0x70=0A=
Nov 16 22:54:33 s15 kernel: [  116.134771]  store_status+0xa5/0x170=0A=
Nov 16 22:54:33 s15 kernel: [  116.134772]  kobj_attr_store+0x12/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134773]  sysfs_kf_write+0x3c/0x50=0A=
Nov 16 22:54:33 s15 kernel: [  116.134774]  kernfs_fop_write+0x125/0x1a0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134775]  __vfs_write+0x1b/0x40=0A=
Nov 16 22:54:33 s15 kernel: [  116.134776]  vfs_write+0xb8/0x1b0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134777]  ksys_write+0x5e/0xe0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134778]  __x64_sys_write+0x1a/0x20=0A=
Nov 16 22:54:33 s15 kernel: [  116.134779]  do_syscall_64+0x57/0x190=0A=
Nov 16 22:54:33 s15 kernel: [  116.134780]  =
entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
Nov 16 22:54:33 s15 kernel: [  116.134781] RIP: 0033:0x7fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134782] Code: 73 01 c3 48 8b 0d d8 cb =
2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 =
00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 =
e8 fe dd 01 00 48 89 04 24=0A=
Nov 16 22:54:33 s15 kernel: [  116.134782] RSP: 002b:00007ffd4b8bfec8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134783] RAX: ffffffffffffffda RBX: =
0000000000000008 RCX: 00007fcfa5b712c0=0A=
Nov 16 22:54:33 s15 kernel: [  116.134783] RDX: 0000000000000008 RSI: =
00000000021dd408 RDI: 0000000000000001=0A=
Nov 16 22:54:33 s15 kernel: [  116.134784] RBP: 00000000021dd408 R08: =
00007fcfa5e40780 R09: 00007fcfa6483700=0A=
Nov 16 22:54:33 s15 kernel: [  116.134784] R10: 0000000000000099 R11: =
0000000000000246 R12: 0000000000000008=0A=
Nov 16 22:54:33 s15 kernel: [  116.134785] R13: 0000000000000001 R14: =
00007fcfa5e3f620 R15: 0000000000000000=0A=
Nov 16 22:54:33 s15 kernel: [  116.134787] ---[ end trace =
a1f26554c8afbfbb ]---=0A=
Nov 16 22:54:33 s15 kernel: [  116.134787] Failed to add freq constraint =
for CPU7 (-22)=0A=

------=_NextPart_000_000B_01D59CD6.6755FA80--

