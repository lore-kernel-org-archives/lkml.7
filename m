Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F67C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB601206B6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=elka.pw.edu.pl header.i=@elka.pw.edu.pl header.b="VHB6rpis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfCCUjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:39:17 -0500
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:42791 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCCUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:39:16 -0500
Received: from [172.19.8.42] (178235205188.warszawa.vectranet.pl [178.235.205.188])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id E726468AE8E;
        Sun,  3 Mar 2019 21:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elka.pw.edu.pl;
        s=2007; t=1551645552;
        bh=JTKATcg5fXOYY7iVPRkoV8xBZBW4dMvErXMXAM2689o=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=VHB6rpisG3Qz02csNbxatr9S1TLTzutlLHlkLiLzrhVWQMYzB4egSL+4SSgjC7hwD
         JlkQJl/xtGI72IXFiWNYFRXQl7JYK20x4PVn+8LpzG8JBMC73M61GhKfRqfANPTHQn
         qYvTjnZR8qA/4CoAbXfodMq4X1Eo4+ELX1siJlJs=
Subject: Re: The "udl" driver crashes the kernel.
From:   Wojtek Zabolotny <W.Zabolotny@elka.pw.edu.pl>
To:     Pavel Machek <pavel@ucw.cz>,
        "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
Cc:     LKML <linux-kernel@vger.kernel.org>, bernie@plugable.com,
        linux-fbdev@vger.kernel.org, airlied@redhat.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org
References: <31dc20a5-66f4-051c-dfec-73924b00c0f8@elektron.elka.pw.edu.pl>
 <20181125230722.GD30242@amd>
 <2ed5f5c1-80a1-0790-a6f8-64d84284e9df@elka.pw.edu.pl>
Openpgp: preference=signencrypt
Autocrypt: addr=W.Zabolotny@elka.pw.edu.pl; prefer-encrypt=mutual; keydata=
 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
 /Xm2n+tTR7u0C80Uuw==
Message-ID: <f3c89582-c6d5-ef0b-2db3-b981ebda517c@elka.pw.edu.pl>
Date:   Sun, 3 Mar 2019 21:39:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2ed5f5c1-80a1-0790-a6f8-64d84284e9df@elka.pw.edu.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few more details. In the current configuration, inspite of kernel warni=
ngs the system is working, and I was able to configure both monitors (LCD=
 in my laptop and external LCD monitor connected to
UDL-165).

I have followed the procedure described in https://wiki.archlinux.org/ind=
ex.php/DisplayLink#USB_2.0_DL-1x5,_DL-1x0_Devices

# xrandr --listproviders
Providers: number : 2
Provider 0: id: 0x43 cap: 0xf, Source Output, Sink Output, Source Offload=
, Sink Offload crtcs: 2 outputs: 2 associated providers: 1 name:modesetti=
ng
Provider 1: id: 0x17a cap: 0x2, Sink Output crtcs: 1 outputs: 1 associate=
d providers: 1 name:modesetting
# xrandr --setprovideroutputsource 1 0

Afterwards I have configured screens in my Mate desktop using GUI.

However, the CPU occupancy is high and I get the following messages regar=
ding the softmmu operation:

[=C2=A0 212.020300] swiotlb_tbl_map_single: 10 callbacks suppressed
[=C2=A0 212.020309] udl 4-1.2:1.0: swiotlb buffer is full (sz: 999424 byt=
es)
[=C2=A0 212.020315] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 999424 =
bytes
[=C2=A0 278.355981] udl 4-1.2:1.0: swiotlb buffer is full (sz: 786432 byt=
es)
[=C2=A0 278.355988] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 786432 =
bytes
[=C2=A0 298.657084] traps: mate-notificati[1944] trap int3 ip:7f1526cbdca=
5 sp:7fffc1f65f00 error:0 in libglib-2.0.so.0.5800.3[7f1526c85000+7e000]
[=C2=A0 316.132315] udl 4-1.2:1.0: swiotlb buffer is full (sz: 1019904 by=
tes)
[=C2=A0 316.132319] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 1019904=
 bytes

=46rom time to time I also get the messages about the drm_get_object_put

Below are all the related messages. When I tried to disconnect the UDL-16=
5 from USB socket, the whole system crashed immediately.

[=C2=A0 117.364046] usb 1-1.3: reset full-speed USB device number 3 using=
 ehci-pci
[=C2=A0 134.269573] [drm] vendor descriptor length:22 data:22 5f 01 00 20=
 05 00 01 03 04 02
[=C2=A0 134.436703] udl 4-1.2:1.0: fb1: udldrmfb frame buffer device
[=C2=A0 134.436735] [drm] Initialized udl 0.0.1 20120220 for 4-1.2:1.0 on=
 minor 2
[=C2=A0 134.436742] [drm] Initialized udl on minor 2
[=C2=A0 134.436849] usbcore: registered new interface driver udl
[=C2=A0 136.095399] WARNING: CPU: 4 PID: 920 at drivers/gpu/drm/drm_gem.c=
:893 drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 136.095403] Modules linked in: udl rfcomm ctr ccm cpufreq_userspa=
ce cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_st=
ate xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm=
 mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_com=
mon btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i91=
5 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal int=
el_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss=
 dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cf=
g80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[=C2=A0 136.095498]=C2=A0 mei_me mei i2c_algo_bit rfkill irqbypass iTCO_w=
dt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor =
wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghan=
dler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mb=
cache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul =
crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci x=
hci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 li=
bphy lpc_ich usb_common thermal
[=C2=A0 136.095604] CPU: 4 PID: 920 Comm: Xorg Tainted: P=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0 4.1=
9.0-2-amd64 #1 Debian 4.19.16-1
[=C2=A0 136.095607] Hardware name: Dell Inc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vostro 3750/0VP036, BIOS A14 09/26/2=
012
[=C2=A0 136.095639] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 136.095644] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff=
 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff =
ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[=C2=A0 136.095647] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[=C2=A0 136.095652] RAX: 0000000000000000 RBX: ffff97fd7f4eb000 RCX: 0000=
000000000000
[=C2=A0 136.095654] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff=
97fd7f4eb000
[=C2=A0 136.095657] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 0000=
0000010ffff0
[=C2=A0 136.095659] R10: 0000000000100004 R11: 0000000000000000 R12: 0000=
000000000000
[=C2=A0 136.095662] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff=
97fd8de12e00
[=C2=A0 136.095666] FS:=C2=A0 00007f57d6cfaa80(0000) GS:ffff97fdae300000(=
0000) knlGS:0000000000000000
[=C2=A0 136.095670] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[=C2=A0 136.095672] CR2: 00007f57bdeaa630 CR3: 0000000416a9e002 CR4: 0000=
0000000606e0
[=C2=A0 136.095675] Call Trace:
[=C2=A0 136.095695]=C2=A0 udl_gem_mmap+0x64/0xa0 [udl]
[=C2=A0 136.095743]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 136.095784]=C2=A0 drm_ioctl_kernel+0xa1/0xf0 [drm]
[=C2=A0 136.095818]=C2=A0 drm_ioctl+0x206/0x3a0 [drm]
[=C2=A0 136.095853]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 136.095861]=C2=A0 ? datagram_poll+0x25/0xf0
[=C2=A0 136.095866]=C2=A0 ? sock_poll+0x83/0xb0
[=C2=A0 136.095872]=C2=A0 ? ep_item_poll.isra.16+0x40/0xc0
[=C2=A0 136.095877]=C2=A0 ? sock_poll+0x83/0xb0
[=C2=A0 136.095883]=C2=A0 do_vfs_ioctl+0xa4/0x630
[=C2=A0 136.095889]=C2=A0 ? __x64_sys_epoll_ctl+0xe7/0x550
[=C2=A0 136.095894]=C2=A0 ksys_ioctl+0x60/0x90
[=C2=A0 136.095900]=C2=A0 __x64_sys_ioctl+0x16/0x20
[=C2=A0 136.095908]=C2=A0 do_syscall_64+0x53/0x100
[=C2=A0 136.095914]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[=C2=A0 136.095920] RIP: 0033:0x7f57d742b757
[=C2=A0 136.095924] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00=
 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[=C2=A0 136.095927] RSP: 002b:00007fff80edf058 EFLAGS: 00003246 ORIG_RAX:=
 0000000000000010
[=C2=A0 136.095931] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000=
7f57d742b757
[=C2=A0 136.095934] RDX: 00007fff80edf090 RSI: 00000000c01064b3 RDI: 0000=
000000000038
[=C2=A0 136.095936] RBP: 00007fff80edf090 R08: 0000000000000000 R09: 0000=
555ab4d09270
[=C2=A0 136.095939] R10: 00007fff80edf03c R11: 0000000000003246 R12: 0000=
0000c01064b3
[=C2=A0 136.095941] R13: 0000000000000038 R14: 0000555ab4ae9220 R15: 0000=
000000000001
[=C2=A0 136.095947] ---[ end trace f558f2f0c6dcf780 ]---
[=C2=A0 136.097883] WARNING: CPU: 4 PID: 920 at drivers/gpu/drm/drm_gem.c=
:893 drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 136.097885] Modules linked in: udl rfcomm ctr ccm cpufreq_userspa=
ce cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_st=
ate xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm=
 mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_com=
mon btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i91=
5 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal int=
el_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss=
 dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cf=
g80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[=C2=A0 136.097961]=C2=A0 mei_me mei i2c_algo_bit rfkill irqbypass iTCO_w=
dt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor =
wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghan=
dler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mb=
cache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul =
crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci x=
hci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 li=
bphy lpc_ich usb_common thermal
[=C2=A0 136.098045] CPU: 4 PID: 920 Comm: Xorg Tainted: P=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0-2-amd6=
4 #1 Debian 4.19.16-1
[=C2=A0 136.098047] Hardware name: Dell Inc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vostro 3750/0VP036, BIOS A14 09/26/2=
012
[=C2=A0 136.098074] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 136.098077] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff=
 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff =
ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[=C2=A0 136.098079] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[=C2=A0 136.098083] RAX: 0000000000000000 RBX: ffff97fd7f4e8200 RCX: 0000=
000000000000
[=C2=A0 136.098085] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff=
97fd7f4e8200
[=C2=A0 136.098088] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 0000=
0000010ffff0
[=C2=A0 136.098090] R10: 0000000000100304 R11: 0000000000000000 R12: 0000=
000000000000
[=C2=A0 136.098092] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff=
97fd8de12e00
[=C2=A0 136.098096] FS:=C2=A0 00007f57d6cfaa80(0000) GS:ffff97fdae300000(=
0000) knlGS:0000000000000000
[=C2=A0 136.098098] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[=C2=A0 136.098100] CR2: 00007f57bdeaa630 CR3: 0000000416a9e002 CR4: 0000=
0000000606e0
[=C2=A0 136.098102] Call Trace:
[=C2=A0 136.098112]=C2=A0 udl_gem_mmap+0x64/0xa0 [udl]
[=C2=A0 136.098143]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 136.098171]=C2=A0 drm_ioctl_kernel+0xa1/0xf0 [drm]
[=C2=A0 136.098200]=C2=A0 drm_ioctl+0x206/0x3a0 [drm]
[=C2=A0 136.098233]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 136.098241]=C2=A0 ? do_mmap+0x3c7/0x5a0
[=C2=A0 136.098247]=C2=A0 do_vfs_ioctl+0xa4/0x630
[=C2=A0 136.098252]=C2=A0 ksys_ioctl+0x60/0x90
[=C2=A0 136.098258]=C2=A0 __x64_sys_ioctl+0x16/0x20
[=C2=A0 136.098263]=C2=A0 do_syscall_64+0x53/0x100
[=C2=A0 136.098268]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[=C2=A0 136.098271] RIP: 0033:0x7f57d742b757
[=C2=A0 136.098274] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00=
 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[=C2=A0 136.098276] RSP: 002b:00007fff80edf058 EFLAGS: 00003246 ORIG_RAX:=
 0000000000000010
[=C2=A0 136.098280] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000=
7f57d742b757
[=C2=A0 136.098282] RDX: 00007fff80edf090 RSI: 00000000c01064b3 RDI: 0000=
000000000038
[=C2=A0 136.098284] RBP: 00007fff80edf090 R08: 0000000000000038 R09: 0000=
000100000000
[=C2=A0 136.098287] R10: 0000000000000001 R11: 0000000000003246 R12: 0000=
0000c01064b3
[=C2=A0 136.098289] R13: 0000000000000038 R14: 0000555ab4ae9220 R15: 0000=
000000000001
[=C2=A0 136.098293] ---[ end trace f558f2f0c6dcf781 ]---
[=C2=A0 212.020300] swiotlb_tbl_map_single: 10 callbacks suppressed
[=C2=A0 212.020309] udl 4-1.2:1.0: swiotlb buffer is full (sz: 999424 byt=
es)
[=C2=A0 212.020315] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 999424 =
bytes
[=C2=A0 278.355981] udl 4-1.2:1.0: swiotlb buffer is full (sz: 786432 byt=
es)
[=C2=A0 278.355988] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 786432 =
bytes
[=C2=A0 298.657084] traps: mate-notificati[1944] trap int3 ip:7f1526cbdca=
5 sp:7fffc1f65f00 error:0 in libglib-2.0.so.0.5800.3[7f1526c85000+7e000]
[=C2=A0 316.132315] udl 4-1.2:1.0: swiotlb buffer is full (sz: 1019904 by=
tes)
[=C2=A0 316.132319] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 1019904=
 bytes
[=C2=A0 316.132436] WARNING: CPU: 4 PID: 920 at drivers/gpu/drm/drm_gem.c=
:893 drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 316.132437] Modules linked in: udl rfcomm ctr ccm cpufreq_userspa=
ce cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_st=
ate xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm=
 mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_com=
mon btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i91=
5 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal int=
el_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss=
 dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cf=
g80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[=C2=A0 316.132475]=C2=A0 mei_me mei i2c_algo_bit rfkill irqbypass iTCO_w=
dt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor =
wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghan=
dler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mb=
cache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul =
crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci x=
hci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 li=
bphy lpc_ich usb_common thermal
[=C2=A0 316.132518] CPU: 4 PID: 920 Comm: Xorg Tainted: P=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0-2-amd6=
4 #1 Debian 4.19.16-1
[=C2=A0 316.132519] Hardware name: Dell Inc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vostro 3750/0VP036, BIOS A14 09/26/2=
012
[=C2=A0 316.132530] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 316.132532] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff=
 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff =
ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[=C2=A0 316.132533] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[=C2=A0 316.132535] RAX: 0000000000000000 RBX: ffff97fd7f4eac00 RCX: 0000=
000000000000
[=C2=A0 316.132536] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff=
97fd7f4eac00
[=C2=A0 316.132537] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 0000=
0000010ffff0
[=C2=A0 316.132538] R10: 0000000000100604 R11: 0000000000000000 R12: 0000=
000000000000
[=C2=A0 316.132539] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff=
97fd8de12e00
[=C2=A0 316.132540] FS:=C2=A0 00007f57d6cfaa80(0000) GS:ffff97fdae300000(=
0000) knlGS:0000000000000000
[=C2=A0 316.132541] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[=C2=A0 316.132543] CR2: 00007f57cd5ed00c CR3: 0000000416a9e004 CR4: 0000=
0000000606e0
[=C2=A0 316.132544] Call Trace:
[=C2=A0 316.132550]=C2=A0 udl_gem_mmap+0x64/0xa0 [udl]
[=C2=A0 316.132564]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 316.132575]=C2=A0 drm_ioctl_kernel+0xa1/0xf0 [drm]
[=C2=A0 316.132588]=C2=A0 drm_ioctl+0x206/0x3a0 [drm]
[=C2=A0 316.132601]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 316.132604]=C2=A0 ? fsnotify+0x34b/0x560
[=C2=A0 316.132608]=C2=A0 do_vfs_ioctl+0xa4/0x630
[=C2=A0 316.132610]=C2=A0 ksys_ioctl+0x60/0x90
[=C2=A0 316.132614]=C2=A0 ? ksys_write+0x9c/0xb0
[=C2=A0 316.132616]=C2=A0 __x64_sys_ioctl+0x16/0x20
[=C2=A0 316.132619]=C2=A0 do_syscall_64+0x53/0x100
[=C2=A0 316.132621]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[=C2=A0 316.132623] RIP: 0033:0x7f57d742b757
[=C2=A0 316.132625] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00=
 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[=C2=A0 316.132626] RSP: 002b:00007fff80edfc58 EFLAGS: 00003246 ORIG_RAX:=
 0000000000000010
[=C2=A0 316.132628] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000=
7f57d742b757
[=C2=A0 316.132628] RDX: 00007fff80edfc90 RSI: 00000000c01064b3 RDI: 0000=
000000000038
[=C2=A0 316.132629] RBP: 00007fff80edfc90 R08: 0000555ab4c906f0 R09: 0000=
000000000006
[=C2=A0 316.132630] R10: 0000555ab3ff3010 R11: 0000000000003246 R12: 0000=
0000c01064b3
[=C2=A0 316.132631] R13: 0000000000000038 R14: 0000555ab4c91f80 R15: 0000=
555ab4a03cc0
[=C2=A0 316.132633] ---[ end trace f558f2f0c6dcf782 ]---
[=C2=A0 335.726489] WARNING: CPU: 1 PID: 920 at drivers/gpu/drm/drm_gem.c=
:893 drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 335.726494] Modules linked in: udl rfcomm ctr ccm cpufreq_userspa=
ce cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_st=
ate xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm=
 mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_com=
mon btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i91=
5 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal int=
el_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss=
 dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cf=
g80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[=C2=A0 335.726589]=C2=A0 mei_me mei i2c_algo_bit rfkill irqbypass iTCO_w=
dt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor =
wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghan=
dler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mb=
cache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul =
crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci x=
hci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 li=
bphy lpc_ich usb_common thermal
[=C2=A0 335.726697] CPU: 1 PID: 920 Comm: Xorg Tainted: P=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0-2-amd6=
4 #1 Debian 4.19.16-1
[=C2=A0 335.726700] Hardware name: Dell Inc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vostro 3750/0VP036, BIOS A14 09/26/2=
012
[=C2=A0 335.726732] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 335.726737] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff=
 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff =
ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[=C2=A0 335.726740] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[=C2=A0 335.726744] RAX: 0000000000000000 RBX: ffff97fda60f6e00 RCX: 0000=
000000000000
[=C2=A0 335.726747] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff=
97fda60f6e00
[=C2=A0 335.726750] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 0000=
0000010ffff0
[=C2=A0 335.726752] R10: 0000000000100604 R11: 0000000000000000 R12: 0000=
000000000000
[=C2=A0 335.726755] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff=
97fd8de12e00
[=C2=A0 335.726759] FS:=C2=A0 00007f57d6cfaa80(0000) GS:ffff97fdae240000(=
0000) knlGS:0000000000000000
[=C2=A0 335.726762] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[=C2=A0 335.726765] CR2: 00007f57cd5a3004 CR3: 0000000416a9e005 CR4: 0000=
0000000606e0
[=C2=A0 335.726768] Call Trace:
[=C2=A0 335.726786]=C2=A0 udl_gem_mmap+0x64/0xa0 [udl]
[=C2=A0 335.726823]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 335.726854]=C2=A0 drm_ioctl_kernel+0xa1/0xf0 [drm]
[=C2=A0 335.726888]=C2=A0 drm_ioctl+0x206/0x3a0 [drm]
[=C2=A0 335.726923]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 335.726934]=C2=A0 ? __set_current_blocked+0x3d/0x60
[=C2=A0 335.726939]=C2=A0 ? signal_setup_done+0x94/0xb0
[=C2=A0 335.726947]=C2=A0 ? __fpu__restore_sig+0x90/0x460
[=C2=A0 335.726956]=C2=A0 do_vfs_ioctl+0xa4/0x630
[=C2=A0 335.726967]=C2=A0 ? _copy_from_user+0x37/0x60
[=C2=A0 335.726974]=C2=A0 ksys_ioctl+0x60/0x90
[=C2=A0 335.726981]=C2=A0 __x64_sys_ioctl+0x16/0x20
[=C2=A0 335.726991]=C2=A0 do_syscall_64+0x53/0x100
[=C2=A0 335.727000]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[=C2=A0 335.727011] RIP: 0033:0x7f57d742b757
[=C2=A0 335.727015] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00=
 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[=C2=A0 335.727017] RSP: 002b:00007fff80edfc58 EFLAGS: 00003246 ORIG_RAX:=
 0000000000000010
[=C2=A0 335.727022] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000=
7f57d742b757
[=C2=A0 335.727025] RDX: 00007fff80edfc90 RSI: 00000000c01064b3 RDI: 0000=
000000000038
[=C2=A0 335.727028] RBP: 00007fff80edfc90 R08: 0000555ab4c906f0 R09: 0000=
000000000006
[=C2=A0 335.727030] R10: 0000555ab3ff3010 R11: 0000000000003246 R12: 0000=
0000c01064b3
[=C2=A0 335.727033] R13: 0000000000000038 R14: 0000555ab4c91f80 R15: 0000=
555ab4a03cc0
[=C2=A0 335.727038] ---[ end trace f558f2f0c6dcf783 ]---
[=C2=A0 371.536170] WARNING: CPU: 1 PID: 920 at drivers/gpu/drm/drm_gem.c=
:893 drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 371.536172] Modules linked in: udl rfcomm ctr ccm cpufreq_userspa=
ce cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_st=
ate xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm=
 mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_com=
mon btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i91=
5 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal int=
el_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss=
 dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cf=
g80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[=C2=A0 371.536204]=C2=A0 mei_me mei i2c_algo_bit rfkill irqbypass iTCO_w=
dt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor =
wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghan=
dler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mb=
cache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul =
crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci x=
hci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 li=
bphy lpc_ich usb_common thermal
[=C2=A0 371.536241] CPU: 1 PID: 920 Comm: Xorg Tainted: P=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0-2-amd6=
4 #1 Debian 4.19.16-1
[=C2=A0 371.536242] Hardware name: Dell Inc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vostro 3750/0VP036, BIOS A14 09/26/2=
012
[=C2=A0 371.536251] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 371.536253] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff=
 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff =
ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[=C2=A0 371.536254] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[=C2=A0 371.536255] RAX: 0000000000000000 RBX: ffff97fda60f7600 RCX: 0000=
000000000000
[=C2=A0 371.536256] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff=
97fda60f7600
[=C2=A0 371.536257] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 0000=
0000010ffff0
[=C2=A0 371.536257] R10: 0000000000100604 R11: 0000000000000000 R12: 0000=
000000000000
[=C2=A0 371.536258] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff=
97fd8de12e00
[=C2=A0 371.536259] FS:=C2=A0 00007f57d6cfaa80(0000) GS:ffff97fdae240000(=
0000) knlGS:0000000000000000
[=C2=A0 371.536260] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[=C2=A0 371.536261] CR2: 000056441c407000 CR3: 0000000416a9e004 CR4: 0000=
0000000606e0
[=C2=A0 371.536262] Call Trace:
[=C2=A0 371.536269]=C2=A0 udl_gem_mmap+0x64/0xa0 [udl]
[=C2=A0 371.536279]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 371.536288]=C2=A0 drm_ioctl_kernel+0xa1/0xf0 [drm]
[=C2=A0 371.536298]=C2=A0 drm_ioctl+0x206/0x3a0 [drm]
[=C2=A0 371.536308]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 371.536311]=C2=A0 ? iput+0x76/0x200
[=C2=A0 371.536314]=C2=A0 do_vfs_ioctl+0xa4/0x630
[=C2=A0 371.536316]=C2=A0 ksys_ioctl+0x60/0x90
[=C2=A0 371.536317]=C2=A0 __x64_sys_ioctl+0x16/0x20
[=C2=A0 371.536320]=C2=A0 do_syscall_64+0x53/0x100
[=C2=A0 371.536322]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[=C2=A0 371.536324] RIP: 0033:0x7f57d742b757
[=C2=A0 371.536325] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00=
 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[=C2=A0 371.536326] RSP: 002b:00007fff80edfc58 EFLAGS: 00003246 ORIG_RAX:=
 0000000000000010
[=C2=A0 371.536328] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000=
7f57d742b757
[=C2=A0 371.536328] RDX: 00007fff80edfc90 RSI: 00000000c01064b3 RDI: 0000=
000000000038
[=C2=A0 371.536329] RBP: 00007fff80edfc90 R08: 0000555ab4c906f0 R09: 0000=
7f57d74f6d20
[=C2=A0 371.536330] R10: 0000555ab3ff3010 R11: 0000000000003246 R12: 0000=
0000c01064b3
[=C2=A0 371.536331] R13: 0000000000000038 R14: 0000555ab4c91f80 R15: 0000=
555ab4a03cc0
[=C2=A0 371.536332] ---[ end trace f558f2f0c6dcf784 ]---
[=C2=A0 388.386692] WARNING: CPU: 5 PID: 920 at drivers/gpu/drm/drm_gem.c=
:893 drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 388.386693] Modules linked in: udl rfcomm ctr ccm cpufreq_userspa=
ce cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_st=
ate xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm=
 mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_com=
mon btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i91=
5 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal int=
el_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss=
 dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cf=
g80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[=C2=A0 388.386723]=C2=A0 mei_me mei i2c_algo_bit rfkill irqbypass iTCO_w=
dt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor =
wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghan=
dler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mb=
cache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul =
crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci x=
hci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 li=
bphy lpc_ich usb_common thermal
[=C2=A0 388.386760] CPU: 5 PID: 920 Comm: Xorg Tainted: P=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0-2-amd6=
4 #1 Debian 4.19.16-1
[=C2=A0 388.386761] Hardware name: Dell Inc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vostro 3750/0VP036, BIOS A14 09/26/2=
012
[=C2=A0 388.386770] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[=C2=A0 388.386772] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff=
 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff =
ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[=C2=A0 388.386773] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[=C2=A0 388.386774] RAX: 0000000000000000 RBX: ffff97fd71863800 RCX: 0000=
000000000000
[=C2=A0 388.386775] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff=
97fd71863800
[=C2=A0 388.386776] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 0000=
0000010ffff0
[=C2=A0 388.386776] R10: 0000000000100604 R11: 0000000000000000 R12: 0000=
000000000000
[=C2=A0 388.386777] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff=
97fd8de12e00
[=C2=A0 388.386778] FS:=C2=A0 00007f57d6cfaa80(0000) GS:ffff97fdae340000(=
0000) knlGS:0000000000000000
[=C2=A0 388.386779] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[=C2=A0 388.386780] CR2: 000056441c407000 CR3: 0000000416a9e001 CR4: 0000=
0000000606e0
[=C2=A0 388.386781] Call Trace:
[=C2=A0 388.386787]=C2=A0 udl_gem_mmap+0x64/0xa0 [udl]
[=C2=A0 388.386797]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 388.386806]=C2=A0 drm_ioctl_kernel+0xa1/0xf0 [drm]
[=C2=A0 388.386824]=C2=A0 drm_ioctl+0x206/0x3a0 [drm]
[=C2=A0 388.386834]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[=C2=A0 388.386839]=C2=A0 ? __set_current_blocked+0x3d/0x60
[=C2=A0 388.386840]=C2=A0 ? signal_setup_done+0x94/0xb0
[=C2=A0 388.386844]=C2=A0 ? __fpu__restore_sig+0x90/0x460
[=C2=A0 388.386846]=C2=A0 do_vfs_ioctl+0xa4/0x630
[=C2=A0 388.386850]=C2=A0 ? _copy_from_user+0x37/0x60
[=C2=A0 388.386851]=C2=A0 ksys_ioctl+0x60/0x90
[=C2=A0 388.386853]=C2=A0 __x64_sys_ioctl+0x16/0x20
[=C2=A0 388.386855]=C2=A0 do_syscall_64+0x53/0x100
[=C2=A0 388.386858]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[=C2=A0 388.386859] RIP: 0033:0x7f57d742b757
[=C2=A0 388.386860] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00=
 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[=C2=A0 388.386861] RSP: 002b:00007fff80edfc58 EFLAGS: 00003246 ORIG_RAX:=
 0000000000000010
[=C2=A0 388.386863] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000=
7f57d742b757
[=C2=A0 388.386863] RDX: 00007fff80edfc90 RSI: 00000000c01064b3 RDI: 0000=
000000000038
[=C2=A0 388.386864] RBP: 00007fff80edfc90 R08: 0000555ab4c906f0 R09: 0000=
000000000006
[=C2=A0 388.386865] R10: 0000555ab3ff3010 R11: 0000000000003246 R12: 0000=
0000c01064b3
[=C2=A0 388.386866] R13: 0000000000000038 R14: 0000555ab4c91f80 R15: 0000=
555ab4a03cc0
[=C2=A0 388.386867] ---[ end trace f558f2f0c6dcf785 ]---

With best regards,
Wojtek

--=20
Wojciech M Zabolotny, PhD
Institute of Electronic Systems
Faculty of Electronics and Information Technology
Warsaw University of Technology


