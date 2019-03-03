Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285C7C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53F220835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=elka.pw.edu.pl header.i=@elka.pw.edu.pl header.b="daiy1BKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCCUyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:54:08 -0500
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:47054 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfCCUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:54:08 -0500
Received: from [172.19.8.42] (178235205188.warszawa.vectranet.pl [178.235.205.188])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id B840868AE9D;
        Sun,  3 Mar 2019 21:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elka.pw.edu.pl;
        s=2007; t=1551646444;
        bh=Bt3XmQhAkylNe1sAA8gXS5K+n5NWnn6MDQB2kN4sXD4=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=daiy1BKMYS1pIYLyWZKGLYyrk0fIBuPe/O0y9O1gw6NJ25lrPWVLnv99zMer1ydfZ
         yRxczjDkS6jxE8ze7jbut0DuhY7DdJhlNSjmINb7YA+Xzrlxqb1MGrGkKkccCO8N/m
         Iq2zFcdb+OTo1ueP9cwCaOkRhLR2mU0etOweovxA=
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
 <f3c89582-c6d5-ef0b-2db3-b981ebda517c@elka.pw.edu.pl>
Openpgp: preference=signencrypt
Autocrypt: addr=W.Zabolotny@elka.pw.edu.pl; prefer-encrypt=mutual; keydata=
 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
 /Xm2n+tTR7u0C80Uuw==
Message-ID: <9ed52c22-c565-6df7-cd60-2953947c0311@elka.pw.edu.pl>
Date:   Sun, 3 Mar 2019 21:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f3c89582-c6d5-ef0b-2db3-b981ebda517c@elka.pw.edu.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It appeared that the crash was not immediate, and the messages got saved =
into /var/log/messages.
Below is full set of messages generated after disconnection of UDL-165.

I hope that they may help to isolate the problem.
With best regards,
Wojtek

Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.474832] usb 4-1.2: USB disconn=
ect, device number 3
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475503] WARNING: CPU: 6 PID: 7=
2 at drivers/gpu/drm/drm_mode_config.c:444 drm_mode_config_cleanup+0x288/=
0x2e0 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475505] Modules linked in: udl=
 rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave =
bnep nft_counter xt_owner xt_state xt_conntrack
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c nft_compat nf_tables=
 nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc vi=
deobuf2_memops videobuf2_v4l2 videobuf2_common btusb
btrtl btbcm snd_hda_codec_realtek videodev snd_hda_codec_generic btintel =
media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ans=
i_cprng intel_rapl x86_pkg_temp_thermal
intel_powerclamp ecdh_generic snd_hda_intel coretemp snd_hda_codec kvm_in=
tel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mix=
er_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm
cfg80211 snd_timer snd joydev soundcore serio_raw sparse_keymap pcspkr
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475561]=C2=A0 mei_me mei i2c_a=
lgo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_h=
wmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore
pcc_cpufreq intel_rapl_perf video dell_smo8800 button battery ac nvidia(P=
OE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_=
tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod cr=
ct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci li=
bahci aesni_intel xhci_pci xhci_hcd ehci_pci libata
ehci_hcd aes_x86_64 realtek crypto_simd usbcore cryptd psmouse scsi_mod g=
lue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475626] CPU: 6 PID: 72 Comm: k=
worker/6:1 Tainted: P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=
E=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0-2-amd64 #1 Debian 4.19.16-1
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475627] Hardware name: Dell In=
c.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vost=
ro 3750/0VP036, BIOS A14 09/26/2012
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475645] Workqueue: usb_hub_wq =
hub_event [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475666] RIP: 0010:drm_mode_con=
fig_cleanup+0x288/0x2e0 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475669] Code: 17 de 48 8b 45 0=
0 48 39 c5 75 62 48 8b 44 24 30 65 48 33 04 25 28 00 00 00 75 56 48 83 c4=
 38 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b 48 89 e6 48 89
ef 48 c7 c3 20 de b9 c1 e8 04 8c ff ff eb 0c
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475671] RSP: 0018:ffffba82c1df=
7ba8 EFLAGS: 00010216
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475673] RAX: ffff97fda71c8818 =
RBX: ffff97fda71cab68 RCX: 0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475675] RDX: ffff97fda71cab30 =
RSI: 0000000000000000 RDI: ffff97fda71cab48
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475676] RBP: ffff97fda71ca800 =
R08: 0000000000000000 R09: ffffffffc1b7d800
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475678] R10: ffff97fd817d6080 =
R11: 0000000000000001 R12: ffff97fda71cab70
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475679] R13: ffff97fdabb91000 =
R14: ffff97fdabb910a0 R15: 00000000ffffffed
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475682] FS:=C2=A0 000000000000=
0000(0000) GS:ffff97fdae380000(0000) knlGS:0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475683] CS:=C2=A0 0010 DS: 000=
0 ES: 0000 CR0: 0000000080050033
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475685] CR2: 0000559468f29b7c =
CR3: 00000001c120a003 CR4: 00000000000606e0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475686] Call Trace:
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475697]=C2=A0 udl_driver_unloa=
d+0x2a/0x40 [udl]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475717]=C2=A0 drm_dev_unregist=
er+0x4b/0xe0 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475737]=C2=A0 drm_dev_unplug+0=
x21/0x60 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475751]=C2=A0 usb_unbind_inter=
face+0x79/0x290 [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475758]=C2=A0 device_release_d=
river_internal+0x1af/0x270
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475763]=C2=A0 bus_remove_devic=
e+0xe5/0x150
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475767]=C2=A0 device_del+0x136=
/0x350
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475780]=C2=A0 usb_disable_devi=
ce+0x93/0x250 [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475793]=C2=A0 usb_disconnect+0=
xc3/0x270 [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475806]=C2=A0 hub_event+0xc80/=
0x15a0 [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475812]=C2=A0 process_one_work=
+0x1a7/0x3a0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475816]=C2=A0 worker_thread+0x=
30/0x390
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475820]=C2=A0 ? pwq_unbound_re=
lease_workfn+0xd0/0xd0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475822]=C2=A0 kthread+0x112/0x=
130
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475825]=C2=A0 ? kthread_bind+0=
x30/0x30
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475828]=C2=A0 ret_from_fork+0x=
35/0x40
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475831] ---[ end trace f558f2f=
0c6dcf788 ]---
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475959] WARNING: CPU: 6 PID: 7=
2 at drivers/gpu/drm/drm_mode_config.c:478 drm_mode_config_cleanup+0x2c4/=
0x2e0 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.475959] Modules linked in: udl=
 rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave =
bnep nft_counter xt_owner xt_state xt_conntrack
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c nft_compat nf_tables=
 nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc vi=
deobuf2_memops videobuf2_v4l2 videobuf2_common btusb
btrtl btbcm snd_hda_codec_realtek videodev snd_hda_codec_generic btintel =
media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ans=
i_cprng intel_rapl x86_pkg_temp_thermal
intel_powerclamp ecdh_generic snd_hda_intel coretemp snd_hda_codec kvm_in=
tel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mix=
er_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm
cfg80211 snd_timer snd joydev soundcore serio_raw sparse_keymap pcspkr
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476008]=C2=A0 mei_me mei i2c_a=
lgo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_h=
wmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore
pcc_cpufreq intel_rapl_perf video dell_smo8800 button battery ac nvidia(P=
OE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_=
tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod cr=
ct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci li=
bahci aesni_intel xhci_pci xhci_hcd ehci_pci libata
ehci_hcd aes_x86_64 realtek crypto_simd usbcore cryptd psmouse scsi_mod g=
lue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476065] CPU: 6 PID: 72 Comm: k=
worker/6:1 Tainted: P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=
E=C2=A0=C2=A0=C2=A0=C2=A0 4.19.0-2-amd64 #1 Debian 4.19.16-1
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476067] Hardware name: Dell In=
c.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vost=
ro 3750/0VP036, BIOS A14 09/26/2012
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476084] Workqueue: usb_hub_wq =
hub_event [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476113] RIP: 0010:drm_mode_con=
fig_cleanup+0x2c4/0x2e0 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476116] Code: ff ff eb 0c 48 8=
b 70 48 48 89 df e8 e6 f4 ff ff 48 89 e7 e8 de 91 ff ff 48 85 c0 75 e7 48=
 89 e7 e8 61 92 ff ff e9 ef fd ff ff <0f> 0b e9 e6 fe ff ff
0f 0b eb 9a e8 4c e1 af dd 66 66 2e 0f 1f 84
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476118] RSP: 0018:ffffba82c1df=
7ba8 EFLAGS: 00010206
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476121] RAX: ffff97fd835b2608 =
RBX: ffff97fda71cac38 RCX: 000000008020001e
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476123] RDX: ffff97fda71cac60 =
RSI: 0000000000000001 RDI: ffff97fda71cac38
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476125] RBP: ffff97fda71ca800 =
R08: 0000000000000000 R09: ffffffffc1b7d900
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476127] R10: ffff97fda9dd5b00 =
R11: 0000000000000001 R12: ffff97fda71cab08
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476129] R13: ffff97fdabb91000 =
R14: ffff97fdabb910a0 R15: 00000000ffffffed
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476132] FS:=C2=A0 000000000000=
0000(0000) GS:ffff97fdae380000(0000) knlGS:0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476134] CS:=C2=A0 0010 DS: 000=
0 ES: 0000 CR0: 0000000080050033
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476136] CR2: 0000559468f29b7c =
CR3: 00000001c120a003 CR4: 00000000000606e0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476138] Call Trace:
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476147]=C2=A0 udl_driver_unloa=
d+0x2a/0x40 [udl]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476174]=C2=A0 drm_dev_unregist=
er+0x4b/0xe0 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476201]=C2=A0 drm_dev_unplug+0=
x21/0x60 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476220]=C2=A0 usb_unbind_inter=
face+0x79/0x290 [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476225]=C2=A0 device_release_d=
river_internal+0x1af/0x270
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476231]=C2=A0 bus_remove_devic=
e+0xe5/0x150
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476235]=C2=A0 device_del+0x136=
/0x350
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476254]=C2=A0 usb_disable_devi=
ce+0x93/0x250 [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476271]=C2=A0 usb_disconnect+0=
xc3/0x270 [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476289]=C2=A0 hub_event+0xc80/=
0x15a0 [usbcore]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476296]=C2=A0 process_one_work=
+0x1a7/0x3a0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476301]=C2=A0 worker_thread+0x=
30/0x390
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476306]=C2=A0 ? pwq_unbound_re=
lease_workfn+0xd0/0xd0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476308]=C2=A0 kthread+0x112/0x=
130
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476311]=C2=A0 ? kthread_bind+0=
x30/0x30
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476315]=C2=A0 ret_from_fork+0x=
35/0x40
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.476319] ---[ end trace f558f2f=
0c6dcf789 ]---
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.483330] general protection fau=
lt: 0000 [#1] SMP PTI
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.483446] CPU: 3 PID: 920 Comm: =
Xorg Tainted: P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 OE=C2=A0=
=C2=A0=C2=A0=C2=A0 4.19.0-2-amd64 #1 Debian 4.19.16-1
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.483606] Hardware name: Dell In=
c.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dell System Vost=
ro 3750/0VP036, BIOS A14 09/26/2012
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.483757] RIP: 0010:mutex_lock+0=
x19/0x30
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.483835] Code: 00 66 66 66 66 9=
0 be 02 00 00 00 e9 41 fb ff ff 90 66 66 66 66 90 53 48 89 fb e8 d2 dc ff=
 ff 31 c0 65 48 8b 14 25 40 5c 01 00 <f0> 48 0f b1 13 74 06
48 89 df 5b eb ca 5b c3 0f 1f 84 00 00 00 00
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.484123] RSP: 0018:ffffba82c25f=
7d78 EFLAGS: 00010246
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.484215] RAX: 0000000000000000 =
RBX: a0f7807825ab4211 RCX: 0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.484332] RDX: ffff97fd9228ac40 =
RSI: ffff97fd8de30a18 RDI: a0f7807825ab4211
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.484450] RBP: a0f7807825ab3f81 =
R08: ffffba82c25f7de0 R09: 0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.484569] R10: ffffba82c25f7eb0 =
R11: 0000000000000000 R12: ffff97fd8de30a18
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.484685] R13: ffff97fda65f0888 =
R14: ffffba82c25f7de0 R15: ffffba82c25f7de0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.484806] FS:=C2=A0 00007f57d6cf=
aa80(0000) GS:ffff97fdae2c0000(0000) knlGS:0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.484938] CS:=C2=A0 0010 DS: 000=
0 ES: 0000 CR0: 0000000080050033
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485034] CR2: 00007f8169eed000 =
CR3: 0000000416a9e005 CR4: 00000000000606e0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485151] Call Trace:
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485260]=C2=A0 drm_mode_object_=
unregister+0x1e/0x60 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485395]=C2=A0 drm_framebuffer_=
free+0x1b/0x30 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485510]=C2=A0 drm_fb_release+0=
x107/0x180 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485596]=C2=A0 ? unmap_region+0=
xdd/0x110
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485704]=C2=A0 drm_file_free.pa=
rt.5+0x296/0x2e0 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485825]=C2=A0 drm_release+0xaa=
/0x120 [drm]
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485906]=C2=A0 __fput+0xac/0x1e=
0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.485972]=C2=A0 task_work_run+0x=
8a/0xb0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486046]=C2=A0 exit_to_usermode=
_loop+0xeb/0xf0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486127]=C2=A0 do_syscall_64+0x=
fd/0x100
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486200]=C2=A0 entry_SYSCALL_64=
_after_hwframe+0x44/0xa9
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486287] RIP: 0033:0x7f57d750f5=
87
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486357] Code: 00 00 0f 05 48 3=
d 00 f0 ff ff 77 3f c3 66 0f 1f 44 00 00 53 89 fb 48 83 ec 10 e8 c4 fb ff=
 ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77
2b 89 d7 89 44 24 0c e8 06 fc ff ff 8b 44 24
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486638] RSP: 002b:00007fff80ed=
f220 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486692] RAX: 0000000000000000 =
RBX: 0000000000000038 RCX: 00007f57d750f587
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486742] RDX: 0000000000000000 =
RSI: 0000000000000000 RDI: 0000000000000038
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486792] RBP: 0000555ab4ae91d0 =
R08: 000000000000052f R09: 0000555ab4731ee0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486844] R10: 0000000000000007 =
R11: 0000000000000293 R12: 0000555ab4b2d410
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486894] R13: 0000000000000001 =
R14: 0000555ab4bde1b0 R15: 00007f57d6cfa6f8
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.486946] Modules linked in: udl=
 rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave =
bnep nft_counter xt_owner xt_state xt_conntrack
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c nft_compat nf_tables=
 nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc vi=
deobuf2_memops videobuf2_v4l2 videobuf2_common btusb
btrtl btbcm snd_hda_codec_realtek videodev snd_hda_codec_generic btintel =
media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ans=
i_cprng intel_rapl x86_pkg_temp_thermal
intel_powerclamp ecdh_generic snd_hda_intel coretemp snd_hda_codec kvm_in=
tel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mix=
er_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm
cfg80211 snd_timer snd joydev soundcore serio_raw sparse_keymap pcspkr
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.492348]=C2=A0 mei_me mei i2c_a=
lgo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_h=
wmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore
pcc_cpufreq intel_rapl_perf video dell_smo8800 button battery ac nvidia(P=
OE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_=
tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod cr=
ct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci li=
bahci aesni_intel xhci_pci xhci_hcd ehci_pci libata
ehci_hcd aes_x86_64 realtek crypto_simd usbcore cryptd psmouse scsi_mod g=
lue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.504652] ---[ end trace f558f2f=
0c6dcf78a ]---
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.506267] RIP: 0010:mutex_lock+0=
x19/0x30
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.507862] Code: 00 66 66 66 66 9=
0 be 02 00 00 00 e9 41 fb ff ff 90 66 66 66 66 90 53 48 89 fb e8 d2 dc ff=
 ff 31 c0 65 48 8b 14 25 40 5c 01 00 <f0> 48 0f b1 13 74 06
48 89 df 5b eb ca 5b c3 0f 1f 84 00 00 00 00
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.511338] RSP: 0018:ffffba82c25f=
7d78 EFLAGS: 00010246
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.513025] RAX: 0000000000000000 =
RBX: a0f7807825ab4211 RCX: 0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.514752] RDX: ffff97fd9228ac40 =
RSI: ffff97fd8de30a18 RDI: a0f7807825ab4211
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.516495] RBP: a0f7807825ab3f81 =
R08: ffffba82c25f7de0 R09: 0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.518108] R10: ffffba82c25f7eb0 =
R11: 0000000000000000 R12: ffff97fd8de30a18
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.519742] R13: ffff97fda65f0888 =
R14: ffffba82c25f7de0 R15: ffffba82c25f7de0
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.521560] FS:=C2=A0 00007f57d6cf=
aa80(0000) GS:ffff97fdae2c0000(0000) knlGS:0000000000000000
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.523286] CS:=C2=A0 0010 DS: 000=
0 ES: 0000 CR0: 0000000080050033
Mar=C2=A0 3 21:39:35 wzdell kernel: [ 1270.524964] CR2: 00007f8169eed000 =
CR3: 0000000416a9e005 CR4: 00000000000606e0



