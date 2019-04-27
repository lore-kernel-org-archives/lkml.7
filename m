Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E1AC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9744C20693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556385605;
	bh=bg2diye7/W+QkFoepDqbwLJ6OBqcwmiuQ6xt+slEIN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=htCg/mC1OXHqoTKyJIAhZMV9yPyOWSxwRPDozNkhojQgda+qNHOAVUIvFGnUUkMms
	 M8oZSBs0z3Lv0o0RBGTKW2eYIdINC4sva/ofGKC1dbBzbK87d+qyrf3Wyd1uArsdva
	 OEsPcusjq4k4DkMrOnKBWbpYyyQTJk2TyE5xJ4i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfD0RUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:20:04 -0400
Received: from casper.infradead.org ([85.118.1.10]:49278 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0RUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qtFQQAwoi09eUMZi/ZI9FG4BSUCxuVZYlTnZeG57ejo=; b=PNgDcDoCV0FPEAQWdflbHIHtIL
        nIP8N0DRtVuY/xcFG3LUTS6xgFEhTiA30xveH5TKKAgjQzGNrXLEyXSPW9Y9MU0J6VWmbIBzhmnZy
        7O12LpCRBKmNnCwAFqnbnElsgxzm2rsT212gNBtXZ3P1OMZpc564NsbeZsAUmkL1S+Z0fW32UQTp6
        MNdoFZw2Bl1QYy65PDQCHI2yqo0XpfsP5uVmTDQrupQpBF78WGE8kpTDODgq3XchQDsaOPH2+Dqdp
        yajMRiLAkZqz5k99SnMNcYC3KUod7WbdkH+0eguW3Z3O6Rw6OS7hVqAta30sXHptM272nz7DA5zcD
        cGxElBgA==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKQzV-0001cL-Uf; Sat, 27 Apr 2019 17:19:58 +0000
Date:   Sat, 27 Apr 2019 14:19:52 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/27] Documentation: x86: convert zero-page.txt to reST
Message-ID: <20190427141952.4727075e@coco.lan>
In-Reply-To: <20190426153150.21228-9-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-9-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:31 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/x86/index.rst     |  1 +
>  Documentation/x86/zero-page.rst | 45 +++++++++++++++++++++++++++++++++
>  Documentation/x86/zero-page.txt | 40 -----------------------------
>  3 files changed, 46 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/x86/zero-page.rst
>  delete mode 100644 Documentation/x86/zero-page.txt
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 7b8388ebd43d..9a0b5f38ef6b 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -14,3 +14,4 @@ Linux x86 Support
>     kernel-stacks
>     entry_64
>     earlyprintk
> +   zero-page
> diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
> new file mode 100644
> index 000000000000..70f10eabca86
> --- /dev/null
> +++ b/Documentation/x86/zero-page.rst
> @@ -0,0 +1,45 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========
> +Zero Page
> +=========
> +The additional fields in struct boot_params as a part of 32-bit boot
> +protocol of kernel. These should be filled by bootloader or 16-bit
> +real-mode setup code of the kernel. References/settings to it mainly
> +are in::
> +
> +  arch/x86/include/uapi/asm/bootparam.h
> +
> +===========	=====	=======================	================================

Same comment that I made on a past patch: please extend the tail markup here...

> +Offset/Size	Proto	Name			Meaning
> +
> +000/040		ALL	screen_info		Text mode or frame buffer information
> +						(struct screen_info)
> +040/014		ALL	apm_bios_info		APM BIOS information (struct apm_bios_info)
> +058/008		ALL	tboot_addr      	Physical address of tboot shared page
> +060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
> +						(struct ist_info)
> +080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
> +090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
> +0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
> +						OBSOLETE!!
> +0B0/010		ALL	olpc_ofw_header		OLPC's OpenFirmware CIF and friends
> +0C0/004		ALL	ext_ramdisk_image	ramdisk_image high 32bits
> +0C4/004		ALL	ext_ramdisk_size	ramdisk_size high 32bits
> +0C8/004		ALL	ext_cmd_line_ptr	cmd_line_ptr high 32bits
> +140/080		ALL	edid_info		Video mode setup (struct edid_info)
> +1C0/020		ALL	efi_info		EFI 32 information (struct efi_info)
> +1E0/004		ALL	alt_mem_k		Alternative mem check, in KB
> +1E4/004		ALL	scratch			Scratch field for the kernel setup code
> +1E8/001		ALL	e820_entries		Number of entries in e820_table (below)
> +1E9/001		ALL	eddbuf_entries		Number of entries in eddbuf (below)
> +1EA/001		ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
> +						(below)
> +1EB/001		ALL     kbd_status      	Numlock is enabled
> +1EC/001		ALL     secure_boot		Secure boot is enabled in the firmware
> +1EF/001		ALL	sentinel		Used to detect broken bootloaders
> +290/040		ALL	edd_mbr_sig_buffer	EDD MBR signatures
> +2D0/A00		ALL	e820_table		E820 memory map table
> +						(array of struct e820_entry)
> +D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
> +===========	=====	=======================	================================

... and here.

After this change:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
> deleted file mode 100644
> index 68aed077f7b6..000000000000
> --- a/Documentation/x86/zero-page.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -The additional fields in struct boot_params as a part of 32-bit boot
> -protocol of kernel. These should be filled by bootloader or 16-bit
> -real-mode setup code of the kernel. References/settings to it mainly
> -are in:
> -
> -  arch/x86/include/uapi/asm/bootparam.h
> -
> -
> -Offset	Proto	Name		Meaning
> -/Size
> -
> -000/040	ALL	screen_info	Text mode or frame buffer information
> -				(struct screen_info)
> -040/014	ALL	apm_bios_info	APM BIOS information (struct apm_bios_info)
> -058/008	ALL	tboot_addr      Physical address of tboot shared page
> -060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
> -				(struct ist_info)
> -080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
> -090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
> -0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
> -				OBSOLETE!!
> -0B0/010	ALL	olpc_ofw_header	OLPC's OpenFirmware CIF and friends
> -0C0/004	ALL	ext_ramdisk_image ramdisk_image high 32bits
> -0C4/004	ALL	ext_ramdisk_size  ramdisk_size high 32bits
> -0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
> -140/080	ALL	edid_info	Video mode setup (struct edid_info)
> -1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
> -1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
> -1E4/004	ALL	scratch		Scratch field for the kernel setup code
> -1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
> -1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
> -1EA/001	ALL	edd_mbr_sig_buf_entries	Number of entries in edd_mbr_sig_buffer
> -				(below)
> -1EB/001	ALL     kbd_status      Numlock is enabled
> -1EC/001	ALL     secure_boot	Secure boot is enabled in the firmware
> -1EF/001	ALL	sentinel	Used to detect broken bootloaders
> -290/040	ALL	edd_mbr_sig_buffer EDD MBR signatures
> -2D0/A00	ALL	e820_table	E820 memory map table
> -				(array of struct e820_entry)
> -D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)



Thanks,
Mauro
