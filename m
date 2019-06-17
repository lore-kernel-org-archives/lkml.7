Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A9FC31E59
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613BC2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfFQMrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:47:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:41406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfFQMrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:47:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66235AEF1;
        Mon, 17 Jun 2019 12:47:15 +0000 (UTC)
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Qian Cai <cai@lca.pw>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f23fe795-5023-be6a-8007-86d3141306ed@suse.cz>
Date:   Mon, 17 Jun 2019 14:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 7:32 PM, Mikhail Gavrilov wrote:
> On Wed, 29 May 2019 at 09:05, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> Hi folks.
>> I am observed kernel panic after update to git tag 5.2-rc2.
>> This crash happens at memory pressing when swap being used.
>>
>> Unfortunately in journalctl saved only this:
>>
> 
> Now I captured better trace.

The VM_BUG_ON_PAGE has been touched in 5.2-rc1 by commit
5fd4ca2d84b2 ("mm: page cache: store only head pages in i_pages")
CCing relevant people and keeping rest of mail for reference.

> : page:ffffd6d34dff0000 refcount:1 mapcount:1 mapping:ffff97812323a689
> index:0xfecec363
> : anon
> : flags: 0x17fffe00080034(uptodate|lru|active|swapbacked)
> : raw: 0017fffe00080034 ffffd6d34c67c508 ffffd6d3504b8d48 ffff97812323a689
> : raw: 00000000fecec363 0000000000000000 0000000100000000 ffff978433ace000
> : page dumped because: VM_BUG_ON_PAGE(entry != page)
> : page->mem_cgroup:ffff978433ace000
> : ------------[ cut here ]------------
> : kernel BUG at mm/swap_state.c:170!
> : invalid opcode: 0000 [#1] SMP NOPTI
> : CPU: 1 PID: 221 Comm: kswapd0 Not tainted 5.2.0-0.rc2.git0.1.fc31.x86_64 #1
> : Hardware name: System manufacturer System Product Name/ROG STRIX
> X470-I GAMING, BIOS 2202 04/11/2019
> : RIP: 0010:__delete_from_swap_cache+0x20d/0x240
> : Code: 30 65 48 33 04 25 28 00 00 00 75 4a 48 83 c4 38 5b 5d 41 5c 41
> 5d 41 5e 41 5f c3 48 c7 c6 2f dc 0f 8a 48 89 c7 e8 93 1b fd ff <0f> 0b
> 48 c7 c6 a8 74 0f 8a e8 85 1b fd ff 0f 0b 48 c7 c6 a8 7d 0f
> : RSP: 0018:ffffa982036e7980 EFLAGS: 00010046
> : RAX: 0000000000000021 RBX: 0000000000000040 RCX: 0000000000000006
> : RDX: 0000000000000000 RSI: 0000000000000086 RDI: ffff97843d657900
> : RBP: 0000000000000001 R08: ffffa982036e7835 R09: 0000000000000535
> : R10: ffff97845e21a46c R11: ffffa982036e7835 R12: ffff978426387120
> : R13: 0000000000000000 R14: ffffd6d34dff0040 R15: ffffd6d34dff0000
> : FS:  0000000000000000(0000) GS:ffff97843d640000(0000) knlGS:0000000000000000
> : CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> : CR2: 00002cba88ef5000 CR3: 000000078a97c000 CR4: 00000000003406e0
> : Call Trace:
> :  delete_from_swap_cache+0x46/0xa0
> :  try_to_free_swap+0xbc/0x110
> :  swap_writepage+0x13/0x70
> :  pageout.isra.0+0x13c/0x350
> :  shrink_page_list+0xc14/0xdf0
> :  shrink_inactive_list+0x1e5/0x3c0
> :  shrink_node_memcg+0x202/0x760
> :  ? do_shrink_slab+0x52/0x2c0
> :  shrink_node+0xe0/0x470
> :  balance_pgdat+0x2d1/0x510
> :  kswapd+0x220/0x420
> :  ? finish_wait+0x80/0x80
> :  kthread+0xfb/0x130
> :  ? balance_pgdat+0x510/0x510
> :  ? kthread_park+0x90/0x90
> :  ret_from_fork+0x22/0x40
> : Modules linked in: uinput rfcomm fuse xt_CHECKSUM xt_MASQUERADE tun
> bridge stp llc nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT
> ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4
> xt_conntrack ebtable_nat ip6table_nat ip6table_mangle ip6table_raw
> ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw
> iptable_security cmac nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> libcrc32c ip_set nfnetlink ebtable_filter ebtables ip6table_filter
> ip6_tables iptable_filter ip_tables bnep sunrpc vfat fat edac_mce_amd
> arc4 kvm_amd rtwpci snd_hda_codec_realtek rtw88 kvm eeepc_wmi
> snd_hda_codec_generic asus_wmi sparse_keymap ledtrig_audio
> snd_hda_codec_hdmi video wmi_bmof mac80211 snd_hda_intel uvcvideo
> snd_hda_codec videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
> irqbypass snd_usb_audio videobuf2_common snd_hda_core videodev
> snd_usbmidi_lib snd_seq snd_hwdep snd_rawmidi snd_seq_device btusb
> snd_pcm crct10dif_pclmul btrtl crc32_pclmul btbcm btintel bluetooth
> :  cfg80211 snd_timer ghash_clmulni_intel joydev snd k10temp soundcore
> media sp5100_tco ccp i2c_piix4 ecdh_generic rfkill ecc gpio_amdpt
> pcc_cpufreq gpio_generic acpi_cpufreq binfmt_misc hid_logitech_hidpp
> hid_logitech_dj uas usb_storage hid_sony ff_memless amdgpu
> amd_iommu_v2 gpu_sched ttm drm_kms_helper igb nvme dca drm
> crc32c_intel i2c_algo_bit nvme_core wmi pinctrl_amd
> : ---[ end trace 3840e49b1d8d2c24 ]---
> 
> 
> $ /usr/src/kernels/`uname -r`/scripts/faddr2line
> /lib/debug/lib/modules/`uname -r`/vmlinux
> __delete_from_swap_cache+0x20d
> __delete_from_swap_cache+0x20d/0x240:
> __delete_from_swap_cache at mm/swap_state.c:170 (discriminator 1)
> 
> 
> 
> 
> --
> Best Regards,
> Mike Gavrilov.
> 

