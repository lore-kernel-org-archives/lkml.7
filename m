Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1982AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFC32081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfGOLJQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:09:16 -0400
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:37451 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729674AbfGOLJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:09:16 -0400
X-Greylist: delayed 1263 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 07:09:13 EDT
Received: from mail.zih.tu-dresden.de ([141.76.14.4])
        by mailout5.zih.tu-dresden.de with esmtps (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84_2)
        (envelope-from <manfred.benesch@tu-dresden.de>)
        id 1hmyWf-0003hn-4h; Mon, 15 Jul 2019 12:48:09 +0200
Received: from [141.76.83.88] (helo=127.0.0.1)
        by server-50.mailclusterdns.zih.tu-dresden.de with esmtpsa (TLSv1.2:AES128-SHA:128)
        (envelope-from <manfred.benesch@tu-dresden.de>)
        id 1hmyWY-0004JK-DC; Mon, 15 Jul 2019 12:48:02 +0200
From:   Manfred Benesch <manfred.benesch@tu-dresden.de>
Subject: Regression with display port monitor under xorg after undock/dock
 cycle
Openpgp: preference=signencrypt
Autocrypt: addr=manfred.benesch@tu-dresden.de; prefer-encrypt=mutual; keydata=
 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
 dcT2GitueeA=
To:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <99000c00-4e3a-a5c3-b392-dd7021458a3e@tu-dresden.de>
Date:   Mon, 15 Jul 2019 12:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-TUD-Original-From: manfred.benesch@tu-dresden.de
X-TUD-Virus-Scanned: mailout5.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everybody,

after upgrading from a kernel 5.0 to 5.2, i run into a reproducible
regression with a display-port monitor on a Quadro M1000M. I got the
following kernel message :

[  161.070503] nouveau 0000:01:00.0: 126.016 Gb/s available PCIe
bandwidth, limited by 8 GT/s x16 link at 0000:00:01.0 (capable of
992.439 Gb/s with 16 GT/s x63 link)
[  162.449210] WARNING: CPU: 5 PID: 1497 at
drivers/gpu/drm/drm_dp_mst_topology.c:3209
drm_dp_atomic_release_vcpi_slots+0x43/0xa0 [drm_kms_helper]
[  162.449211] Modules linked in: bnep cpufreq_conservative
cpufreq_userspace cpufreq_powersave msr binfmt_misc nls_ascii nls_cp437
vfat fat joydev arc4 uvcvideo btusb btrtl btbcm videobuf2_vmalloc
btintel mei_hdcp videobuf2_memops videobuf2_v4l2 videobuf2_common
bluetooth videodev media ecdh_generic ecc intel_rapl iwlmvm
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel mac80211 kvm
irqbypass snd_hda_codec_realtek intel_cstate snd_hda_codec_generic
iwlwifi intel_uncore deflate intel_rapl_perf efi_pstore snd_hda_intel
pcspkr snd_hda_codec efivars snd_hwdep snd_hda_core snd_pcm rmi_smbus
iTCO_wdt rmi_core snd_timer iTCO_vendor_support cfg80211 sg mei_me
nvidiafb mei vgastate fb_ddc thinkpad_acpi intel_pch_thermal nvram snd
tpm_crb soundcore tpm_tis rfkill ac battery tpm_tis_core tpm rng_core
pcc_cpufreq loop sunrpc ecryptfs efivarfs ip_tables x_tables autofs4
btrfs algif_skcipher af_alg mmc_block hid_generic usbhid hid lrw fuse
fan dm_raid raid456 async_raid6_recov async_memcpy async_pq
[  162.449241]  async_xor async_tx xor raid6_pq libcrc32c md_mod
dm_snapshot dm_bufio dm_crypt dm_mirror dm_region_hash dm_log dm_mod
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel nouveau
i915 rtsx_pci_sdmmc mmc_core mxm_wmi ttm i2c_algo_bit xhci_pci xhci_hcd
aesni_intel drm_kms_helper e1000e aes_x86_64 psmouse crypto_simd ptp
serio_raw cryptd glue_helper pps_core rtsx_pci drm usbcore i2c_i801
mfd_core sd_mod evdev thermal wmi video button
[  162.449259] CPU: 5 PID: 1497 Comm: Xorg Tainted: G                T
5.2.0-thinkpad #1
[  162.449261] Hardware name: LENOVO 20EQS3V200/20EQS3V200, BIOS
N1EET82W (1.55 ) 12/18/2018
[  162.449268] RIP: 0010:drm_dp_atomic_release_vcpi_slots+0x43/0xa0
[drm_kms_helper]
[  162.449270] Code: 50 08 48 8d 70 08 48 8d 5a f0 48 39 d6 74 1b 48 3b
6a f0 75 08 eb 2f 48 39 69 f0 74 29 48 8b 4b 10 48 8d 59 f0 48 39 ce 75
ed <0f> 0b 48 c7 c7 00 4e 5c c0 48 89 c2 48 89 ee e8 09 76 db ff b8 ea
[  162.449271] RSP: 0018:ffffa68d435cfa68 EFLAGS: 00010246
[  162.449272] RAX: ffff97bdba93c1a0 RBX: ffff97bdba93c198 RCX:
ffff97bdba93c1a0
[  162.449273] RDX: ffff97bdba93c1a8 RSI: ffff97bdba93c1a8 RDI:
0000000000000010
[  162.449274] RBP: ffff97bdcae43000 R08: ffff97bdcb905600 R09:
ffff97bdcbfc7200
[  162.449275] R10: ffffa68d435cfa20 R11: ffff97bdcbfc7200 R12:
0000000000000004
[  162.449276] R13: ffff97bdb4025a80 R14: 0000000000000003 R15:
ffff97bdb7f92010
[  162.449277] FS:  00007f57bcf45200(0000) GS:ffff97bdcf540000(0000)
knlGS:0000000000000000
[  162.449278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  162.449280] CR2: 000055f5b0838a90 CR3: 0000000475bf6002 CR4:
00000000003606e0
[  162.449281] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  162.449281] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  162.449282] Call Trace:
[  162.449293]  drm_atomic_helper_check_modeset+0x391/0xa80 [drm_kms_helper]
[  162.449301]  drm_atomic_helper_check+0x14/0x90 [drm_kms_helper]
[  162.449352]  nv50_disp_atomic_check+0x83/0x1d0 [nouveau]
[  162.449371]  drm_atomic_check_only+0x5b3/0x870 [drm]
[  162.449387]  drm_atomic_commit+0x13/0x50 [drm]
[  162.449395]  drm_atomic_helper_set_config+0x77/0x80 [drm_kms_helper]
[  162.449411]  drm_mode_setcrtc+0x548/0x740 [drm]
[  162.449425]  ? drm_mode_getcrtc+0x180/0x180 [drm]
[  162.449435]  drm_ioctl_kernel+0xbb/0x100 [drm]
[  162.449446]  drm_ioctl+0x2e2/0x380 [drm]
[  162.449457]  ? drm_mode_getcrtc+0x180/0x180 [drm]
[  162.449508]  nouveau_drm_ioctl+0x68/0xc0 [nouveau]
[  162.449513]  do_vfs_ioctl+0xb0/0x690
[  162.449517]  ksys_ioctl+0x70/0x80
[  162.449520]  __x64_sys_ioctl+0x16/0x20
[  162.449522]  do_syscall_64+0x55/0x120
[  162.449525]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  162.449527] RIP: 0033:0x7f57ba419017
[  162.449529] Code: 00 00 00 48 8b 05 81 7e 2b 00 64 c7 00 26 00 00 00
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 7e 2b 00 f7 d8 64 89 01 48
[  162.449530] RSP: 002b:00007fff12e4fcf8 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[  162.449532] RAX: ffffffffffffffda RBX: 0000000000000014 RCX:
00007f57ba419017
[  162.449533] RDX: 00007fff12e4fd30 RSI: 00000000c06864a2 RDI:
0000000000000014
[  162.449534] RBP: 00007fff12e4fd30 R08: 0000000000000000 R09:
000055f5b115cce0
[  162.449535] R10: 00007fff12e4fed0 R11: 0000000000003246 R12:
00000000c06864a2
[  162.449536] R13: 0000000000000014 R14: 000055f5b0863000 R15:
000055f5b078d230
[  162.449538] ---[ end trace 11d212b7f8d04b60 ]---
[  162.449562] [drm:drm_dp_atomic_release_vcpi_slots [drm_kms_helper]]
*ERROR* no VCPI for [MST PORT:0000000020cedb5a] found in mst state
00000000bab63e56

I can trigger that bug easily with the following steps :

1. boot into xorg/desktop

2. expand the screen to the external monitor (e.g.with "xrandr --output
DP-1-1-1 --auto --right-of eDP1")

3. undock the laptop

4. redock the laptop results in the kernel warning showed above

After getting that warning there is no way to get the external monitor
working again until a whole reboot cycle.

I have checked some older versions of the kernel and that bug was
introduced in 5.1-rc1.

The hardware is a Lenovo P50 laptop with a workstation dock and a Dell
U2412M connected on the display port of the docking station. The
external screen is connected to a Quadro M1000M graphic card driven with
the nouveau driver.

A possible work around for the moment is to disable the external monitor
with "xrandr --output DP-1-1-1 --off" before undocking.

If you need further informations let me know.

Best Regards

Manfred Benesch



