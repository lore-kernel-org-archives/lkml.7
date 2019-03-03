Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABDCC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE08206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=elka.pw.edu.pl header.i=@elka.pw.edu.pl header.b="MqQHoonT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfCCUVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:21:45 -0500
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:36293 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfCCUVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:21:44 -0500
X-Greylist: delayed 1300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Mar 2019 15:21:41 EST
Received: from [172.19.8.42] (178235205188.warszawa.vectranet.pl [178.235.205.188])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id 0F47168AEAA;
        Sun,  3 Mar 2019 20:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elka.pw.edu.pl;
        s=2007; t=1551643197;
        bh=TCFwPM/8MsHI7+CEqZc/9oNXydFLPuZ0LSo1qiLtL/I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MqQHoonTOLD350aCtAS6uOWaHBxTvsxLXvbZJDnhF1TMaqig2BFC7xeK+M2B4rBDx
         MQF0Np+NMrsTranSOm78PZn7QCzjDCcN+Zj0K+aQFZLZvVFS/T2MY2/vbriml01kVb
         L6JrZcHWMKMlUMVigbG32TPWFAip87VcGQT8lfs4=
Subject: Re: The "udl" driver crashes the kernel.
To:     Pavel Machek <pavel@ucw.cz>,
        "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
Cc:     LKML <linux-kernel@vger.kernel.org>, bernie@plugable.com,
        linux-fbdev@vger.kernel.org, airlied@redhat.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org
References: <31dc20a5-66f4-051c-dfec-73924b00c0f8@elektron.elka.pw.edu.pl>
 <20181125230722.GD30242@amd>
From:   Wojtek Zabolotny <W.Zabolotny@elka.pw.edu.pl>
Openpgp: preference=signencrypt
Autocrypt: addr=W.Zabolotny@elka.pw.edu.pl; prefer-encrypt=mutual; keydata=
 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
 /Xm2n+tTR7u0C80Uuw==
Message-ID: <2ed5f5c1-80a1-0790-a6f8-64d84284e9df@elka.pw.edu.pl>
Date:   Sun, 3 Mar 2019 20:59:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20181125230722.GD30242@amd>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.2018 00:07, Pavel Machek wrote:
> On Sun 2018-11-25 16:58:59, wzabolot@elektron.elka.pw.edu.pl wrote:
>> When I connect my Displaylink DL-165 adapter to my Debian/testing
>> machine, the "udl" driver is loaded and the following error messages
>> appears in kernel logs:
> 4.18 kernel. Might be worth testing latest stable, and latest
> mainline...
>
> Is there version that worked for you?
>
> I added udl maintainers to the Cc list.
>
> Best regards,

I have repeated the tests with my current Debian/testing setup (kernel 4.=
19.16), and still get warnings from kernel after loading the udl module:

[ 1208.605542] [drm] vendor descriptor length:22 data:22 5f 01 00 20 05 0=
0 01 03 04 02
[ 1208.706718] udl 4-1.2:1.0: fb1: udldrmfb frame buffer device
[ 1208.706746] [drm] Initialized udl 0.0.1 20120220 for 4-1.2:1.0 on mino=
r 2
[ 1208.706753] [drm] Initialized udl on minor 2
[ 1208.706876] usbcore: registered new interface driver udl
[ 1210.003149] WARNING: CPU: 0 PID: 993 at drivers/gpu/drm/drm_gem.c:893 =
drm_gem_object_put+0x33/0x40 [drm]
[ 1210.003153] Modules linked in: udl evdi(OE) rfcomm ctr ccm bnep cpufre=
q_userspace cpufreq_conservative cpufreq_powersave nft_counter xt_owner x=
t_state xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c nft_compat nf_tables nfnetlink binfmt_misc arc4 =
iwldvm mac80211 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l=
2 iwlwifi videobuf2_common nvidia_drm(POE)
nvidia_modeset(POE) videodev intel_rapl media x86_pkg_temp_thermal intel_=
powerclamp btusb snd_hda_codec_realtek snd_hda_codec_generic btrtl btbcm =
btintel bluetooth snd_hda_intel i915 snd_hda_codec
snd_hda_core drbg ansi_cprng snd_hwdep snd_pcm_oss snd_mixer_oss coretemp=
 kvm_intel snd_pcm ecdh_generic kvm snd_timer snd joydev serio_raw soundc=
ore drm_kms_helper cfg80211 irqbypass dell_wmi
sparse_keymap pcspkr drm dell_laptop
[ 1210.003247]=C2=A0 dell_smbios mei_me rfkill i2c_algo_bit dcdbas intel_=
cstate iTCO_wdt mei iTCO_vendor_support intel_uncore dell_smm_hwmon evdev=
 nvidia(POE) pcc_cpufreq intel_rapl_perf sg
dell_wmi_descriptor wmi_bmof wmi video ac button battery dell_smo8800 ipm=
i_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables =
autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod um=
s_realtek uas usb_storage crct10dif_pclmul crc32_pclmul crc32c_intel ghas=
h_clmulni_intel pcbc ahci xhci_pci libahci xhci_hcd
ehci_pci libata ehci_hcd realtek aesni_intel aes_x86_64 crypto_simd crypt=
d usbcore psmouse glue_helper scsi_mod r8169 i2c_i801 libphy lpc_ich usb_=
common thermal [last unloaded: udlfb]
[ 1210.003358] CPU: 0 PID: 993 Comm: Xorg Tainted: P=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0=
-2-amd64 #1 Debian 4.19.16-1
[ 1210.003360] Hardware name: Dell Inc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[ 1210.003393] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[ 1210.003397] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 1=
8 48 89 fb e8 ed 7f 05 f8 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3=
 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[ 1210.003400] RSP: 0018:ffffaa4cc23b3d10 EFLAGS: 00010246
[ 1210.003405] RAX: 0000000000000000 RBX: ffff9e749ad90800 RCX: 000000000=
0000000
[ 1210.003408] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff9e749=
ad90800
[ 1210.003411] RBP: ffff9e7496cbf020 R08: ffff9e74a720c910 R09: 000000000=
10ffff0
[ 1210.003413] R10: 0000000000100004 R11: 0000000000000000 R12: 000000000=
0000000
[ 1210.003416] R13: ffffaa4cc23b3dd0 R14: ffffaa4cc23b3dc8 R15: ffff9e74a=
2695d00
[ 1210.003420] FS:=C2=A0 00007ff1907cca80(0000) GS:ffff9e74ae200000(0000)=
 knlGS:0000000000000000
[ 1210.003423] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1210.003426] CR2: 00007ff18c785278 CR3: 00000004290f6002 CR4: 000000000=
00606f0
[ 1210.003429] Call Trace:
[ 1210.003446]=C2=A0 udl_gem_mmap+0x64/0xa0 [udl]
[ 1210.003484]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1210.003515]=C2=A0 drm_ioctl_kernel+0xa1/0xf0 [drm]
[ 1210.003549]=C2=A0 drm_ioctl+0x206/0x3a0 [drm]
[ 1210.003584]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1210.003592]=C2=A0 ? datagram_poll+0x25/0xf0
[ 1210.003599]=C2=A0 ? sock_poll+0x83/0xb0
[ 1210.003605]=C2=A0 ? ep_item_poll.isra.16+0x40/0xc0
[ 1210.003609]=C2=A0 ? sock_poll+0x83/0xb0
[ 1210.003616]=C2=A0 do_vfs_ioctl+0xa4/0x630
[ 1210.003621]=C2=A0 ? __x64_sys_epoll_ctl+0xe7/0x550
[ 1210.003626]=C2=A0 ksys_ioctl+0x60/0x90
[ 1210.003632]=C2=A0 __x64_sys_ioctl+0x16/0x20
[ 1210.003639]=C2=A0 do_syscall_64+0x53/0x100
[ 1210.003645]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1210.003650] RIP: 0033:0x7ff190efd757
[ 1210.003654] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 4=
8 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[ 1210.003657] RSP: 002b:00007ffd9dcaca98 EFLAGS: 00003246 ORIG_RAX: 0000=
000000000010
[ 1210.003662] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff19=
0efd757
[ 1210.003664] RDX: 00007ffd9dcacad0 RSI: 00000000c01064b3 RDI: 000000000=
000003d
[ 1210.003667] RBP: 00007ffd9dcacad0 R08: 0000000000000000 R09: 000055718=
bf5d820
[ 1210.003669] R10: 00007ffd9dcaca7c R11: 0000000000003246 R12: 00000000c=
01064b3
[ 1210.003672] R13: 000000000000003d R14: 000055718bd84f80 R15: 000000000=
0000001
[ 1210.003677] ---[ end trace 115b8e77b2a2c036 ]---
[ 1210.005818] WARNING: CPU: 0 PID: 993 at drivers/gpu/drm/drm_gem.c:893 =
drm_gem_object_put+0x33/0x40 [drm]
[ 1210.005820] Modules linked in: udl evdi(OE) rfcomm ctr ccm bnep cpufre=
q_userspace cpufreq_conservative cpufreq_powersave nft_counter xt_owner x=
t_state xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c nft_compat nf_tables nfnetlink binfmt_misc arc4 =
iwldvm mac80211 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l=
2 iwlwifi videobuf2_common nvidia_drm(POE)
nvidia_modeset(POE) videodev intel_rapl media x86_pkg_temp_thermal intel_=
powerclamp btusb snd_hda_codec_realtek snd_hda_codec_generic btrtl btbcm =
btintel bluetooth snd_hda_intel i915 snd_hda_codec
snd_hda_core drbg ansi_cprng snd_hwdep snd_pcm_oss snd_mixer_oss coretemp=
 kvm_intel snd_pcm ecdh_generic kvm snd_timer snd joydev serio_raw soundc=
ore drm_kms_helper cfg80211 irqbypass dell_wmi
sparse_keymap pcspkr drm dell_laptop
[ 1210.005907]=C2=A0 dell_smbios mei_me rfkill i2c_algo_bit dcdbas intel_=
cstate iTCO_wdt mei iTCO_vendor_support intel_uncore dell_smm_hwmon evdev=
 nvidia(POE) pcc_cpufreq intel_rapl_perf sg
dell_wmi_descriptor wmi_bmof wmi video ac button battery dell_smo8800 ipm=
i_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables =
autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod um=
s_realtek uas usb_storage crct10dif_pclmul crc32_pclmul crc32c_intel ghas=
h_clmulni_intel pcbc ahci xhci_pci libahci xhci_hcd
ehci_pci libata ehci_hcd realtek aesni_intel aes_x86_64 crypto_simd crypt=
d usbcore psmouse glue_helper scsi_mod r8169 i2c_i801 libphy lpc_ich usb_=
common thermal [last unloaded: udlfb]
[ 1210.006005] CPU: 0 PID: 993 Comm: Xorg Tainted: P=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 OE=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0-2-amd64 #=
1 Debian 4.19.16-1
[ 1210.006007] Hardware name: Dell Inc.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[ 1210.006038] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[ 1210.006042] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 1=
8 48 89 fb e8 ed 7f 05 f8 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3=
 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[ 1210.006044] RSP: 0018:ffffaa4cc23b3d10 EFLAGS: 00010246
[ 1210.006048] RAX: 0000000000000000 RBX: ffff9e749ad93800 RCX: 000000000=
0000000
[ 1210.006050] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff9e749=
ad93800
[ 1210.006053] RBP: ffff9e7496cbf020 R08: ffff9e74a720c910 R09: 000000000=
10ffff0
[ 1210.006055] R10: 0000000000100304 R11: 0000000000000000 R12: 000000000=
0000000
[ 1210.006058] R13: ffffaa4cc23b3dd0 R14: ffffaa4cc23b3dc8 R15: ffff9e74a=
2695d00
[ 1210.006062] FS:=C2=A0 00007ff1907cca80(0000) GS:ffff9e74ae200000(0000)=
 knlGS:0000000000000000
[ 1210.006065] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1210.006067] CR2: 00007ff18c785278 CR3: 00000004290f6002 CR4: 000000000=
00606f0
[ 1210.006069] Call Trace:
[ 1210.006080]=C2=A0 udl_gem_mmap+0x64/0xa0 [udl]
[ 1210.006115]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1210.006146]=C2=A0 drm_ioctl_kernel+0xa1/0xf0 [drm]
[ 1210.006178]=C2=A0 drm_ioctl+0x206/0x3a0 [drm]
[ 1210.006212]=C2=A0 ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1210.006220]=C2=A0 ? do_mmap+0x3c7/0x5a0
[ 1210.006227]=C2=A0 do_vfs_ioctl+0xa4/0x630
[ 1210.006234]=C2=A0 ksys_ioctl+0x60/0x90
[ 1210.006239]=C2=A0 __x64_sys_ioctl+0x16/0x20
[ 1210.006246]=C2=A0 do_syscall_64+0x53/0x100
[ 1210.006251]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1210.006255] RIP: 0033:0x7ff190efd757
[ 1210.006259] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 4=
8 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[ 1210.006261] RSP: 002b:00007ffd9dcaca98 EFLAGS: 00003246 ORIG_RAX: 0000=
000000000010
[ 1210.006265] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff19=
0efd757
[ 1210.006268] RDX: 00007ffd9dcacad0 RSI: 00000000c01064b3 RDI: 000000000=
000003d
[ 1210.006271] RBP: 00007ffd9dcacad0 R08: 000000000000003d R09: 000000010=
0000000
[ 1210.006273] R10: 0000000000000001 R11: 0000000000003246 R12: 00000000c=
01064b3
[ 1210.006275] R13: 000000000000003d R14: 000055718bd84f80 R15: 000000000=
0000001
[ 1210.006280] ---[ end trace 115b8e77b2a2c037 ]---

With best regards,
Wojtek

--=20
Wojciech M Zabolotny, PhD
Institute of Electronic Systems
Faculty of Electronics and Information Technology
Warsaw University of Technology


