Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BD6C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65B626D3F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfFCV7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:59:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:65178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFCV7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:59:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 14:07:26 -0700
X-ExtLoop1: 1
Received: from ray.jf.intel.com (HELO [10.7.198.156]) ([10.7.198.156])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2019 14:07:26 -0700
Subject: Re: linux-next: runtime failure of next-20190603
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190603162215.6390707f@canb.auug.org.au>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <a6c98d75-078a-797f-a582-9687324e8c02@intel.com>
Date:   Mon, 3 Jun 2019 14:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603162215.6390707f@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/19 11:22 PM, Stephen Rothwell wrote:
> My qemu powerpc_pseries_le_defconfig boots failed today with the
> following output at shutdown time:
...
> [   32.112430] NIP [c000000000bbeb38] xas_load+0x8/0xd0
...
> Reverting commit
> 
> fa858b6eec3f ("XArray: Add xas_replace")
> 
> made the failure go away.

I'm seeing a similar softlockup:

> [124384.345395] watchdog: BUG: soft lockup - CPU#1 stuck for 22s!
> [TaskSchedulerFo:22804] [124384.345405] Modules linked in: bridge
> stp llc ctr ccm hid_logitech_hidpp hid_logitech_dj xt_MASQUERADE
> rfcomm hid_generic usbhid hid bnep iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ip_tables x_tables bpfilter arc4
> iwlmvm intel_rapl snd_hda_codec_hdmi x86_pkg_temp_thermal mac80211
> wmi_bmof coretemp snd_hda_codec_realtek snd_hda_codec_generic
> ghash_clmulni_intel snd_hda_intel snd_hda_codec aesni_intel
> snd_hwdep aes_x86_64 snd_hda_core glue_helper crypto_simd
> thinkpad_acpi cryptd snd_pcm nvram iwlwifi btusb ledtrig_audio
> btrtl snd_seq_midi btbcm snd_seq_midi_event btintel snd_rawmidi
> bluetooth snd_seq snd_timer snd_seq_device ecdh_generic cfg80211
> ecc snd joydev soundcore kvm_intel mac_hid wmi kvm irqbypass
> squashfs zstd_decompress lz4_decompress netconsole rtsx_pci_sdmmc
> rtsx_pci [124384.345426] CPU: 1 PID: 22804 Comm: TaskSchedulerFo
> Not tainted 5.2.0-rc2 #14 [124384.345427] Hardware name: LENOVO
> 20F5S7V800/20F5S7V800, BIOS R02ET70W (1.43 ) 01/28/2019 
> [124384.345431] RIP: 0010:xas_load+0x2c/0x80 [124384.345432] Code:
> 89 fb e8 67 ff ff ff eb 5b 48 3d 00 10 00 00 76 5f 0f b6 48 fe 48
> 8d 70 fe 38 4b 10 77 52 48 8b 53 08 48 d3 ea 83 e2 3f 89 d0 <48> 8d
> 44 c6 20 48 8b 40 08 48 89 73 18 48 89 c1 83 e1 03 48 83 f9 
> [124384.345433] RSP: 0018:ffffc900095f3a70 EFLAGS: 00000206
> ORIG_RAX: ffffffffffffff13 [124384.345434] RAX: 0000000000000022
> RBX: ffffc900095f3a80 RCX: 0000000000000006 [124384.345435] RDX:
> 0000000000000022 RSI: ffff888085eb4490 RDI: ffffc900095f3a80 
> [124384.345435] RBP: 00000000001dc8b0 R08: 0000000000000001 R09:
> ffff8884216fab80 [124384.345436] R10: ffff8884216fa000 R11:
> ffff8884216fa000 R12: 0000000000000000 [124384.345437] R13:
> ffff88840a006bd8 R14: 00000000001dc8b0 R15: ffff88810cc12580 
> [124384.345437] FS:  00007f1aa5b77700(0000)
> GS:ffff888411880000(0000) knlGS:0000000000000000 [124384.345438]
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [124384.345439]
> CR2: 00007f1ae3ffd9d0 CR3: 00000003e925c001 CR4: 00000000003626e0 
> [124384.345439] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000 [124384.345440] DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 [124384.345440] Call Trace: 
> [124384.345464]  find_get_entry+0x74/0x1a0 [124384.345466]
> pagecache_get_page+0x27/0x250 [124384.345467]
> __try_to_reclaim_swap.isra.38+0x47/0xe0 [124384.345469]
> free_swap_and_cache+0x6e/0x70 [124384.345470]
> unmap_page_range+0x444/0xa50 [124384.345472]  unmap_vmas+0x81/0xe0 
> [124384.345474]  exit_mmap+0xab/0x1a0 [124384.345477]
> mmput+0x5d/0x130 [124384.345478]  do_exit+0x2af/0xbf0 
> [124384.345480]  do_group_exit+0x3d/0xb0 [124384.345481]
> get_signal+0x12d/0x8b0 [124384.345483]  do_signal+0x36/0x6a0 
> [124384.345485]  ? __might_fault+0x2b/0x30 [124384.345486]  ?
> _copy_from_user+0x5b/0x90 [124384.345488]  ?
> exit_to_usermode_loop+0x4a/0xb0 [124384.345489]
> exit_to_usermode_loop+0x62/0xb0 [124384.345507]
> do_syscall_64+0xfc/0x120 [124384.345508]
> entry_SYSCALL_64_after_hwframe+0x49/0xbe

I saw this over a period of time and caught a bunch of different
softlokup messages.  They almost all appear under xas_load, though:

 RIP: 0010:xas_load+0x13/0x80
 RIP: 0010:xas_load+0x17/0x80
 RIP: 0010:xas_load+0x1b/0x80
 RIP: 0010:xas_load+0x27/0x80
 RIP: 0010:xas_load+0x2c/0x80
 RIP: 0010:xas_load+0x35/0x80
 RIP: 0010:xas_load+0x35/0x80
 RIP: 0010:xas_load+0x35/0x80
 RIP: 0010:xas_load+0x35/0x80
 RIP: 0010:xas_load+0x35/0x80
 RIP: 0010:xas_load+0x45/0x80
 RIP: 0010:xas_load+0x66/0x80
 RIP: 0010:xas_load+0xb/0x80
 RIP: 0010:xas_start+0x45/0x90

So it seems like it's actively spinning in a fairly big loop since
it's hitting a bunch of different places.

I only hit this once, though.  It's not easily reproducible for me.  I
haven't tried the above revert.
