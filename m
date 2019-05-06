Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AD720B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557165199;
	bh=wy9Kdz8gDIglOh/yRrhq45HmbQS0KCcmSgVV85Wc3FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aMs1gMZXqe/7gNd/tsXqcVWw4dKW42ASnuGhXNtD3A+ZKOB6C1RxbCMAcOUv2r9Xl
	 X+8tCAUB4nT0azkC4VnO8nG50KCnOYd57+ZCPvWBvQ0R1vJpj7yOSKgpc45bMjr0ev
	 5Y5yAJDzHbnrbZWR1zru93/+3IdncPKhE4lnOAGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEFRxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:53:17 -0400
Received: from casper.infradead.org ([85.118.1.10]:47872 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFRxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I8pNQLMjRBu5BFZBSSfIZ99HA+Y2d2GsdkycVXf4c5I=; b=foq5V9FlHFineUekuJF58UXeu0
        2Qc/Kx3+Jq0qDB4Wjixm5cXRQojKm5d969cWYHSV+a/HrICI9N/cVf6ujDtUfshOR1SMnS3yzS9TY
        T+QEDK5JR/YL/WNhnPLXxJNXXV3cnxttjbyxqdKU2AoXwK9lHZmt1FkZBBxNSLdxkWCFXJGK8FciG
        oguY7W/sCAzc/C/GT+ZVSQ4UAXnvHR1H5p8+WzfzJjP2crzLFtfEqM50AI/TDQPJRqjXVVb9EbV4b
        +R/u1n3sG55BOqMkW5Bz1XT7Nu/fyIZZ1HaFOeaDK2PHGWMEvROKgdlNoXuCLaoG6f4LYSxq7XYO4
        dIq0qyDg==;
Received: from [179.182.172.35] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNhnU-0003GP-BP; Mon, 06 May 2019 17:53:05 +0000
Date:   Mon, 6 May 2019 14:52:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/27] Documentation: x86: convert boot.txt to reST
Message-ID: <20190506145258.2fc691b2@coco.lan>
In-Reply-To: <20190506170923.7117-3-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
        <20190506170923.7117-3-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue,  7 May 2019 01:08:58 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/x86/{boot.txt => boot.rst} | 530 ++++++++++++++---------
>  Documentation/x86/index.rst              |   2 +
>  2 files changed, 329 insertions(+), 203 deletions(-)
>  rename Documentation/x86/{boot.txt => boot.rst} (73%)
> 
> diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.rst
> similarity index 73%
> rename from Documentation/x86/boot.txt
> rename to Documentation/x86/boot.rst
> index 223e484a1304..5f20de0ced23 100644
> --- a/Documentation/x86/boot.txt
> +++ b/Documentation/x86/boot.rst
> @@ -1,5 +1,8 @@
> -		     THE LINUX/x86 BOOT PROTOCOL
> -		     ---------------------------
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================
> +The Linux/x86 Boot Protocol
> +===========================
>  
>  On the x86 platform, the Linux kernel uses a rather complicated boot
>  convention.  This has evolved partially due to historical aspects, as
> @@ -10,88 +13,91 @@ real-mode DOS as a mainstream operating system.
>  
>  Currently, the following versions of the Linux/x86 boot protocol exist.
>  
> -Old kernels:	zImage/Image support only.  Some very early kernels
> +=============	============================================================
> +Old kernels	zImage/Image support only.  Some very early kernels
>  		may not even support a command line.
>  
> -Protocol 2.00:	(Kernel 1.3.73) Added bzImage and initrd support, as
> +Protocol 2.00	(Kernel 1.3.73) Added bzImage and initrd support, as
>  		well as a formalized way to communicate between the
>  		boot loader and the kernel.  setup.S made relocatable,
>  		although the traditional setup area still assumed
>  		writable.
>  
> -Protocol 2.01:	(Kernel 1.3.76) Added a heap overrun warning.
> +Protocol 2.01	(Kernel 1.3.76) Added a heap overrun warning.
>  
> -Protocol 2.02:	(Kernel 2.4.0-test3-pre3) New command line protocol.
> +Protocol 2.02	(Kernel 2.4.0-test3-pre3) New command line protocol.
>  		Lower the conventional memory ceiling.	No overwrite
>  		of the traditional setup area, thus making booting
>  		safe for systems which use the EBDA from SMM or 32-bit
>  		BIOS entry points.  zImage deprecated but still
>  		supported.
>  
> -Protocol 2.03:	(Kernel 2.4.18-pre1) Explicitly makes the highest possible
> +Protocol 2.03	(Kernel 2.4.18-pre1) Explicitly makes the highest possible
>  		initrd address available to the bootloader.
>  
> -Protocol 2.04:	(Kernel 2.6.14) Extend the syssize field to four bytes.
> +Protocol 2.04	(Kernel 2.6.14) Extend the syssize field to four bytes.
>  
> -Protocol 2.05:	(Kernel 2.6.20) Make protected mode kernel relocatable.
> +Protocol 2.05	(Kernel 2.6.20) Make protected mode kernel relocatable.
>  		Introduce relocatable_kernel and kernel_alignment fields.
>  
> -Protocol 2.06:	(Kernel 2.6.22) Added a field that contains the size of
> +Protocol 2.06	(Kernel 2.6.22) Added a field that contains the size of
>  		the boot command line.
>  
> -Protocol 2.07:	(Kernel 2.6.24) Added paravirtualised boot protocol.
> +Protocol 2.07	(Kernel 2.6.24) Added paravirtualised boot protocol.
>  		Introduced hardware_subarch and hardware_subarch_data
>  		and KEEP_SEGMENTS flag in load_flags.
>  
> -Protocol 2.08:	(Kernel 2.6.26) Added crc32 checksum and ELF format
> +Protocol 2.08	(Kernel 2.6.26) Added crc32 checksum and ELF format
>  		payload. Introduced payload_offset and payload_length
>  		fields to aid in locating the payload.
>  
> -Protocol 2.09:	(Kernel 2.6.26) Added a field of 64-bit physical
> +Protocol 2.09	(Kernel 2.6.26) Added a field of 64-bit physical
>  		pointer to single linked list of struct	setup_data.
>  
> -Protocol 2.10:	(Kernel 2.6.31) Added a protocol for relaxed alignment
> +Protocol 2.10	(Kernel 2.6.31) Added a protocol for relaxed alignment
>  		beyond the kernel_alignment added, new init_size and
>  		pref_address fields.  Added extended boot loader IDs.
>  
> -Protocol 2.11:	(Kernel 3.6) Added a field for offset of EFI handover
> +Protocol 2.11	(Kernel 3.6) Added a field for offset of EFI handover
>  		protocol entry point.
>  
> -Protocol 2.12:	(Kernel 3.8) Added the xloadflags field and extension fields
> +Protocol 2.12	(Kernel 3.8) Added the xloadflags field and extension fields
>  		to struct boot_params for loading bzImage and ramdisk
>  		above 4G in 64bit.
>  
> -Protocol 2.13:	(Kernel 3.14) Support 32- and 64-bit flags being set in
> +Protocol 2.13	(Kernel 3.14) Support 32- and 64-bit flags being set in
>  		xloadflags to support booting a 64-bit kernel from 32-bit
>  		EFI
> +=============	============================================================
>  
> -**** MEMORY LAYOUT
>  
> -The traditional memory map for the kernel loader, used for Image or
> -zImage kernels, typically looks like:
> -
> -	|			 |
> -0A0000	+------------------------+
> -	|  Reserved for BIOS	 |	Do not use.  Reserved for BIOS EBDA.
> -09A000	+------------------------+
> -	|  Command line		 |
> -	|  Stack/heap		 |	For use by the kernel real-mode code.
> -098000	+------------------------+	
> -	|  Kernel setup		 |	The kernel real-mode code.
> -090200	+------------------------+
> -	|  Kernel boot sector	 |	The kernel legacy boot sector.
> -090000	+------------------------+
> -	|  Protected-mode kernel |	The bulk of the kernel image.
> -010000	+------------------------+
> -	|  Boot loader		 |	<- Boot sector entry point 0000:7C00
> -001000	+------------------------+
> -	|  Reserved for MBR/BIOS |
> -000800	+------------------------+
> -	|  Typically used by MBR |
> -000600	+------------------------+ 
> -	|  BIOS use only	 |
> -000000	+------------------------+
> +Memory Layout
> +=============
>  
> +The traditional memory map for the kernel loader, used for Image or
> +zImage kernels, typically looks like::
> +
> +		|			 |
> +	0A0000	+------------------------+
> +		|  Reserved for BIOS	 |	Do not use.  Reserved for BIOS EBDA.
> +	09A000	+------------------------+
> +		|  Command line		 |
> +		|  Stack/heap		 |	For use by the kernel real-mode code.
> +	098000	+------------------------+
> +		|  Kernel setup		 |	The kernel real-mode code.
> +	090200	+------------------------+
> +		|  Kernel boot sector	 |	The kernel legacy boot sector.
> +	090000	+------------------------+
> +		|  Protected-mode kernel |	The bulk of the kernel image.
> +	010000	+------------------------+
> +		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
> +	001000	+------------------------+
> +		|  Reserved for MBR/BIOS |
> +	000800	+------------------------+
> +		|  Typically used by MBR |
> +	000600	+------------------------+
> +		|  BIOS use only	 |
> +	000000	+------------------------+
>  
>  When using bzImage, the protected-mode kernel was relocated to
>  0x100000 ("high memory"), and the kernel real-mode block (boot sector,
> @@ -116,36 +122,36 @@ zImage or old bzImage kernels, which need data written into the
>  above the 0x9A000 point; too many BIOSes will break above that point.
>  
>  For a modern bzImage kernel with boot protocol version >= 2.02, a
> -memory layout like the following is suggested:
> -
> -	~                        ~
> -        |  Protected-mode kernel |
> -100000  +------------------------+
> -	|  I/O memory hole	 |
> -0A0000	+------------------------+
> -	|  Reserved for BIOS	 |	Leave as much as possible unused
> -	~                        ~
> -	|  Command line		 |	(Can also be below the X+10000 mark)
> -X+10000	+------------------------+
> -	|  Stack/heap		 |	For use by the kernel real-mode code.
> -X+08000	+------------------------+	
> -	|  Kernel setup		 |	The kernel real-mode code.
> -	|  Kernel boot sector	 |	The kernel legacy boot sector.
> -X       +------------------------+
> -	|  Boot loader		 |	<- Boot sector entry point 0000:7C00
> -001000	+------------------------+
> -	|  Reserved for MBR/BIOS |
> -000800	+------------------------+
> -	|  Typically used by MBR |
> -000600	+------------------------+ 
> -	|  BIOS use only	 |
> -000000	+------------------------+
> -
> -... where the address X is as low as the design of the boot loader
> -permits.
> -
> -
> -**** THE REAL-MODE KERNEL HEADER
> +memory layout like the following is suggested::
> +
> +		~                        ~
> +		|  Protected-mode kernel |
> +	100000  +------------------------+
> +		|  I/O memory hole	 |
> +	0A0000	+------------------------+
> +		|  Reserved for BIOS	 |	Leave as much as possible unused
> +		~                        ~
> +		|  Command line		 |	(Can also be below the X+10000 mark)
> +	X+10000	+------------------------+
> +		|  Stack/heap		 |	For use by the kernel real-mode code.
> +	X+08000	+------------------------+
> +		|  Kernel setup		 |	The kernel real-mode code.
> +		|  Kernel boot sector	 |	The kernel legacy boot sector.
> +	X       +------------------------+
> +		|  Boot loader		 |	<- Boot sector entry point 0000:7C00
> +	001000	+------------------------+
> +		|  Reserved for MBR/BIOS |
> +	000800	+------------------------+
> +		|  Typically used by MBR |
> +	000600	+------------------------+
> +		|  BIOS use only	 |
> +	000000	+------------------------+
> +
> +  ... where the address X is as low as the design of the boot loader permits.
> +
> +
> +The Real-Mode Kernel Header
> +===========================
>  
>  In the following text, and anywhere in the kernel boot sequence, "a
>  sector" refers to 512 bytes.  It is independent of the actual sector
> @@ -159,61 +165,63 @@ sectors (1K) and then examine the bootup sector size.
>  
>  The header looks like:
>  
> -Offset	Proto	Name		Meaning
> -/Size
> -
> -01F1/1	ALL(1	setup_sects	The size of the setup in sectors
> -01F2/2	ALL	root_flags	If set, the root is mounted readonly
> -01F4/4	2.04+(2	syssize		The size of the 32-bit code in 16-byte paras
> -01F8/2	ALL	ram_size	DO NOT USE - for bootsect.S use only
> -01FA/2	ALL	vid_mode	Video mode control
> -01FC/2	ALL	root_dev	Default root device number
> -01FE/2	ALL	boot_flag	0xAA55 magic number
> -0200/2	2.00+	jump		Jump instruction
> -0202/4	2.00+	header		Magic signature "HdrS"
> -0206/2	2.00+	version		Boot protocol version supported
> -0208/4	2.00+	realmode_swtch	Boot loader hook (see below)
> -020C/2	2.00+	start_sys_seg	The load-low segment (0x1000) (obsolete)
> -020E/2	2.00+	kernel_version	Pointer to kernel version string
> -0210/1	2.00+	type_of_loader	Boot loader identifier
> -0211/1	2.00+	loadflags	Boot protocol option flags
> -0212/2	2.00+	setup_move_size	Move to high memory size (used with hooks)
> -0214/4	2.00+	code32_start	Boot loader hook (see below)
> -0218/4	2.00+	ramdisk_image	initrd load address (set by boot loader)
> -021C/4	2.00+	ramdisk_size	initrd size (set by boot loader)
> -0220/4	2.00+	bootsect_kludge	DO NOT USE - for bootsect.S use only
> -0224/2	2.01+	heap_end_ptr	Free memory after setup end
> -0226/1	2.02+(3 ext_loader_ver	Extended boot loader version
> -0227/1	2.02+(3	ext_loader_type	Extended boot loader ID
> -0228/4	2.02+	cmd_line_ptr	32-bit pointer to the kernel command line
> -022C/4	2.03+	initrd_addr_max	Highest legal initrd address
> -0230/4	2.05+	kernel_alignment Physical addr alignment required for kernel
> -0234/1	2.05+	relocatable_kernel Whether kernel is relocatable or not
> -0235/1	2.10+	min_alignment	Minimum alignment, as a power of two
> -0236/2	2.12+	xloadflags	Boot protocol option flags
> -0238/4	2.06+	cmdline_size	Maximum size of the kernel command line
> -023C/4	2.07+	hardware_subarch Hardware subarchitecture
> -0240/8	2.07+	hardware_subarch_data Subarchitecture-specific data
> -0248/4	2.08+	payload_offset	Offset of kernel payload
> -024C/4	2.08+	payload_length	Length of kernel payload
> -0250/8	2.09+	setup_data	64-bit physical pointer to linked list
> -				of struct setup_data
> -0258/8	2.10+	pref_address	Preferred loading address
> -0260/4	2.10+	init_size	Linear memory required during initialization
> -0264/4	2.11+	handover_offset	Offset of handover entry point
> -
> -(1) For backwards compatibility, if the setup_sects field contains 0, the
> -    real value is 4.
> -
> -(2) For boot protocol prior to 2.04, the upper two bytes of the syssize
> -    field are unusable, which means the size of a bzImage kernel
> -    cannot be determined.
> -
> -(3) Ignored, but safe to set, for boot protocols 2.02-2.09.
> +===========	========	=====================	============================================
> +Offset/Size	Proto		Name			Meaning
> +===========	========	=====================	============================================
> +01F1/1		ALL(1)		setup_sects		The size of the setup in sectors
> +01F2/2		ALL		root_flags		If set, the root is mounted readonly
> +01F4/4		2.04+(2)	syssize			The size of the 32-bit code in 16-byte paras
> +01F8/2		ALL		ram_size		DO NOT USE - for bootsect.S use only
> +01FA/2		ALL		vid_mode		Video mode control
> +01FC/2		ALL		root_dev		Default root device number
> +01FE/2		ALL		boot_flag		0xAA55 magic number
> +0200/2		2.00+		jump			Jump instruction
> +0202/4		2.00+		header			Magic signature "HdrS"
> +0206/2		2.00+		version			Boot protocol version supported
> +0208/4		2.00+		realmode_swtch		Boot loader hook (see below)
> +020C/2		2.00+		start_sys_seg		The load-low segment (0x1000) (obsolete)
> +020E/2		2.00+		kernel_version		Pointer to kernel version string
> +0210/1		2.00+		type_of_loader		Boot loader identifier
> +0211/1		2.00+		loadflags		Boot protocol option flags
> +0212/2		2.00+		setup_move_size		Move to high memory size (used with hooks)
> +0214/4		2.00+		code32_start		Boot loader hook (see below)
> +0218/4		2.00+		ramdisk_image		initrd load address (set by boot loader)
> +021C/4		2.00+		ramdisk_size		initrd size (set by boot loader)
> +0220/4		2.00+		bootsect_kludge		DO NOT USE - for bootsect.S use only
> +0224/2		2.01+		heap_end_ptr		Free memory after setup end
> +0226/1		2.02+(3)	ext_loader_ver		Extended boot loader version
> +0227/1		2.02+(3)	ext_loader_type		Extended boot loader ID
> +0228/4		2.02+		cmd_line_ptr		32-bit pointer to the kernel command line
> +022C/4		2.03+		initrd_addr_max		Highest legal initrd address
> +0230/4		2.05+		kernel_alignment	Physical addr alignment required for kernel
> +0234/1		2.05+		relocatable_kernel	Whether kernel is relocatable or not
> +0235/1		2.10+		min_alignment		Minimum alignment, as a power of two
> +0236/2		2.12+		xloadflags		Boot protocol option flags
> +0238/4		2.06+		cmdline_size		Maximum size of the kernel command line
> +023C/4		2.07+		hardware_subarch	Hardware subarchitecture
> +0240/8		2.07+		hardware_subarch_data	Subarchitecture-specific data
> +0248/4		2.08+		payload_offset		Offset of kernel payload
> +024C/4		2.08+		payload_length		Length of kernel payload
> +0250/8		2.09+		setup_data		64-bit physical pointer to linked list
> +							of struct setup_data
> +0258/8		2.10+		pref_address		Preferred loading address
> +0260/4		2.10+		init_size		Linear memory required during initialization
> +0264/4		2.11+		handover_offset		Offset of handover entry point
> +===========	========	=====================	============================================
> +
> +.. note::
> +  (1) For backwards compatibility, if the setup_sects field contains 0, the
> +      real value is 4.
> +
> +  (2) For boot protocol prior to 2.04, the upper two bytes of the syssize
> +      field are unusable, which means the size of a bzImage kernel
> +      cannot be determined.
> +
> +  (3) Ignored, but safe to set, for boot protocols 2.02-2.09.
>  
>  If the "HdrS" (0x53726448) magic number is not found at offset 0x202,
>  the boot protocol version is "old".  Loading an old kernel, the
> -following parameters should be assumed:
> +following parameters should be assumed::
>  
>  	Image type = zImage
>  	initrd not supported
> @@ -225,7 +233,8 @@ setting fields in the header, you must make sure only to set fields
>  supported by the protocol version in use.
>  
>  
> -**** DETAILS OF HEADER FIELDS
> +Details of Harder Fileds
> +========================
>  
>  For each field, some are information from the kernel to the bootloader
>  ("read"), some are expected to be filled out by the bootloader
> @@ -239,106 +248,132 @@ boot loaders can ignore those fields.
>  
>  The byte order of all fields is littleendian (this is x86, after all.)
>  
> +============	===========
>  Field name:	setup_sects
>  Type:		read
>  Offset/size:	0x1f1/1
>  Protocol:	ALL
> +============	===========
>  
>    The size of the setup code in 512-byte sectors.  If this field is
>    0, the real value is 4.  The real-mode code consists of the boot
>    sector (always one 512-byte sector) plus the setup code.
>  
> -Field name:	 root_flags
> -Type:		 modify (optional)
> -Offset/size:	 0x1f2/2
> -Protocol:	 ALL
> +============	=================
> +Field name:	root_flags
> +Type:		modify (optional)
> +Offset/size:	0x1f2/2
> +Protocol:	ALL
> +============	=================
>  
>    If this field is nonzero, the root defaults to readonly.  The use of
>    this field is deprecated; use the "ro" or "rw" options on the
>    command line instead.
>  
> +============	===============================================
>  Field name:	syssize
>  Type:		read
>  Offset/size:	0x1f4/4 (protocol 2.04+) 0x1f4/2 (protocol ALL)
>  Protocol:	2.04+
> +============	===============================================
>  
>    The size of the protected-mode code in units of 16-byte paragraphs.
>    For protocol versions older than 2.04 this field is only two bytes
>    wide, and therefore cannot be trusted for the size of a kernel if
>    the LOAD_HIGH flag is set.
>  
> +============	===============
>  Field name:	ram_size
>  Type:		kernel internal
>  Offset/size:	0x1f8/2
>  Protocol:	ALL
> +============	===============
>  
>    This field is obsolete.
>  
> +============	===================
>  Field name:	vid_mode
>  Type:		modify (obligatory)
>  Offset/size:	0x1fa/2
> +============	===================
>  
>    Please see the section on SPECIAL COMMAND LINE OPTIONS.
>  
> +============	=================
>  Field name:	root_dev
>  Type:		modify (optional)
>  Offset/size:	0x1fc/2
>  Protocol:	ALL
> +============	=================
>  
>    The default root device device number.  The use of this field is
>    deprecated, use the "root=" option on the command line instead.
>  
> +============	=========
>  Field name:	boot_flag
>  Type:		read
>  Offset/size:	0x1fe/2
>  Protocol:	ALL
> +============	=========
>  
>    Contains 0xAA55.  This is the closest thing old Linux kernels have
>    to a magic number.
>  
> +============	=======
>  Field name:	jump
>  Type:		read
>  Offset/size:	0x200/2
>  Protocol:	2.00+
> +============	=======
>  
>    Contains an x86 jump instruction, 0xEB followed by a signed offset
>    relative to byte 0x202.  This can be used to determine the size of
>    the header.
>  
> +============	=======
>  Field name:	header
>  Type:		read
>  Offset/size:	0x202/4
>  Protocol:	2.00+
> +============	=======
>  
>    Contains the magic number "HdrS" (0x53726448).
>  
> +============	=======
>  Field name:	version
>  Type:		read
>  Offset/size:	0x206/2
>  Protocol:	2.00+
> +============	=======
>  
>    Contains the boot protocol version, in (major << 8)+minor format,
>    e.g. 0x0204 for version 2.04, and 0x0a11 for a hypothetical version
>    10.17.
>  
> +============	=================
>  Field name:	realmode_swtch
>  Type:		modify (optional)
>  Offset/size:	0x208/4
>  Protocol:	2.00+
> +============	=================
>  
>    Boot loader hook (see ADVANCED BOOT LOADER HOOKS below.)
>  
> +============	=============
>  Field name:	start_sys_seg
>  Type:		read
>  Offset/size:	0x20c/2
>  Protocol:	2.00+
> +============	=============
>  
>    The load low segment (0x1000).  Obsolete.
>  
> +============	==============
>  Field name:	kernel_version
>  Type:		read
>  Offset/size:	0x20e/2
>  Protocol:	2.00+
> +============	==============
>  
>    If set to a nonzero value, contains a pointer to a NUL-terminated
>    human-readable kernel version number string, less 0x200.  This can
> @@ -348,17 +383,21 @@ Protocol:	2.00+
>    For example, if this value is set to 0x1c00, the kernel version
>    number string can be found at offset 0x1e00 in the kernel file.
>    This is a valid value if and only if the "setup_sects" field
> -  contains the value 15 or higher, as:
> +  contains the value 15 or higher, as::
>  
>  	0x1c00  < 15*0x200 (= 0x1e00) but
>  	0x1c00 >= 14*0x200 (= 0x1c00)
>  
> -	0x1c00 >> 9 = 14, so the minimum value for setup_secs is 15.
> +	0x1c00 >> 9 = 14
> +
> +  So the minimum value for setup_secs is 15.

IMO, this belongs to the literal block.

>  
> +============	==================
>  Field name:	type_of_loader
>  Type:		write (obligatory)
>  Offset/size:	0x210/1
>  Protocol:	2.00+
> +============	==================
>  
>    If your boot loader has an assigned id (see table below), enter
>    0xTV here, where T is an identifier for the boot loader and V is
> @@ -369,17 +408,20 @@ Protocol:	2.00+
>    Similarly, the ext_loader_ver field can be used to provide more than
>    four bits for the bootloader version.
>  
> -  For example, for T = 0x15, V = 0x234, write:
> +  For example, for T = 0x15, V = 0x234, write::
>  
> -  type_of_loader  <- 0xE4
> -  ext_loader_type <- 0x05
> -  ext_loader_ver  <- 0x23
> +	type_of_loader  <- 0xE4
> +	ext_loader_type <- 0x05
> +	ext_loader_ver  <- 0x23
>  
>    Assigned boot loader ids (hexadecimal):
>  
> -	0  LILO			(0x00 reserved for pre-2.00 bootloader)
> +	== ==============================

The table markup line here is too short.

> +	0  LILO
> +	   (0x00 reserved for pre-2.00 bootloader)
>  	1  Loadlin
> -	2  bootsect-loader	(0x20, all other values reserved)
> +	2  bootsect-loader
> +	   (0x20, all other values reserved)
>  	3  Syslinux
>  	4  Etherboot/gPXE/iPXE
>  	5  ELILO
> @@ -390,55 +432,70 @@ Protocol:	2.00+
>  	B  Qemu
>  	C  Arcturus Networks uCbootloader
>  	D  kexec-tools
> -	E  Extended		(see ext_loader_type)
> -	F  Special		(0xFF = undefined)
> -       10  Reserved
> -       11  Minimal Linux Bootloader <http://sebastian-plotz.blogspot.de>
> -       12  OVMF UEFI virtualization stack
> +	E  Extended (see ext_loader_type)
> +	F  Special (0xFF = undefined)
> +	10 Reserved
> +	11 Minimal Linux Bootloader
> +	   <http://sebastian-plotz.blogspot.de>
> +	12 OVMF UEFI virtualization stack
> +	== ==============================

Same here: extending the line above will require extending it here too.

With the above changes:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>


>  
> -  Please contact <hpa@zytor.com> if you need a bootloader ID
> -  value assigned.
> +  Please contact <hpa@zytor.com> if you need a bootloader ID value assigned.
>  
> +============	===================
>  Field name:	loadflags
>  Type:		modify (obligatory)
>  Offset/size:	0x211/1
>  Protocol:	2.00+
> +============	===================
>  
>    This field is a bitmask.
>  
>    Bit 0 (read):	LOADED_HIGH
> +
>  	- If 0, the protected-mode code is loaded at 0x10000.
>  	- If 1, the protected-mode code is loaded at 0x100000.
>  
>    Bit 1 (kernel internal): KASLR_FLAG
> +
>  	- Used internally by the compressed kernel to communicate
>  	  KASLR status to kernel proper.
> -	  If 1, KASLR enabled.
> -	  If 0, KASLR disabled.
> +
> +	    - If 1, KASLR enabled.
> +	    - If 0, KASLR disabled.
>  
>    Bit 5 (write): QUIET_FLAG
> +
>  	- If 0, print early messages.
>  	- If 1, suppress early messages.
> +
>  		This requests to the kernel (decompressor and early
>  		kernel) to not write early messages that require
>  		accessing the display hardware directly.
>  
>    Bit 6 (write): KEEP_SEGMENTS
> +
>  	Protocol: 2.07+
> +
>  	- If 0, reload the segment registers in the 32bit entry point.
>  	- If 1, do not reload the segment registers in the 32bit entry point.
> +
>  		Assume that %cs %ds %ss %es are all set to flat segments with
>  		a base of 0 (or the equivalent for their environment).
>  
>    Bit 7 (write): CAN_USE_HEAP
> +
>  	Set this bit to 1 to indicate that the value entered in the
>  	heap_end_ptr is valid.  If this field is clear, some setup code
>  	functionality will be disabled.
>  
> +
> +============	===================
>  Field name:	setup_move_size
>  Type:		modify (obligatory)
>  Offset/size:	0x212/2
>  Protocol:	2.00-2.01
> +============	===================
>  
>    When using protocol 2.00 or 2.01, if the real mode kernel is not
>    loaded at 0x90000, it gets moved there later in the loading
> @@ -447,14 +504,16 @@ Protocol:	2.00-2.01
>    itself.
>  
>    The unit is bytes starting with the beginning of the boot sector.
> -  
> +
>    This field is can be ignored when the protocol is 2.02 or higher, or
>    if the real-mode code is loaded at 0x90000.
>  
> +============	========================
>  Field name:	code32_start
>  Type:		modify (optional, reloc)
>  Offset/size:	0x214/4
>  Protocol:	2.00+
> +============	========================
>  
>    The address to jump to in protected mode.  This defaults to the load
>    address of the kernel, and can be used by the boot loader to
> @@ -462,47 +521,57 @@ Protocol:	2.00+
>  
>    This field can be modified for two purposes:
>  
> -  1. as a boot loader hook (see ADVANCED BOOT LOADER HOOKS below.)
> +    1. as a boot loader hook (see Advanced Boot Loader Hooks below.)
>  
> -  2. if a bootloader which does not install a hook loads a
> -     relocatable kernel at a nonstandard address it will have to modify
> -     this field to point to the load address.
> +    2. if a bootloader which does not install a hook loads a
> +       relocatable kernel at a nonstandard address it will have to modify
> +       this field to point to the load address.
>  
> +============	==================
>  Field name:	ramdisk_image
>  Type:		write (obligatory)
>  Offset/size:	0x218/4
>  Protocol:	2.00+
> +============	==================
>  
>    The 32-bit linear address of the initial ramdisk or ramfs.  Leave at
>    zero if there is no initial ramdisk/ramfs.
>  
> +============	==================
>  Field name:	ramdisk_size
>  Type:		write (obligatory)
>  Offset/size:	0x21c/4
>  Protocol:	2.00+
> +============	==================
>  
>    Size of the initial ramdisk or ramfs.  Leave at zero if there is no
>    initial ramdisk/ramfs.
>  
> +============	===============
>  Field name:	bootsect_kludge
>  Type:		kernel internal
>  Offset/size:	0x220/4
>  Protocol:	2.00+
> +============	===============
>  
>    This field is obsolete.
>  
> +============	==================
>  Field name:	heap_end_ptr
>  Type:		write (obligatory)
>  Offset/size:	0x224/2
>  Protocol:	2.01+
> +============	==================
>  
>    Set this field to the offset (from the beginning of the real-mode
>    code) of the end of the setup stack/heap, minus 0x0200.
>  
> +============	================
>  Field name:	ext_loader_ver
>  Type:		write (optional)
>  Offset/size:	0x226/1
>  Protocol:	2.02+
> +============	================
>  
>    This field is used as an extension of the version number in the
>    type_of_loader field.  The total version number is considered to be
> @@ -514,10 +583,12 @@ Protocol:	2.02+
>    Kernels prior to 2.6.31 did not recognize this field, but it is safe
>    to write for protocol version 2.02 or higher.
>  
> +============	=====================================================
>  Field name:	ext_loader_type
>  Type:		write (obligatory if (type_of_loader & 0xf0) == 0xe0)
>  Offset/size:	0x227/1
>  Protocol:	2.02+
> +============	=====================================================
>  
>    This field is used as an extension of the type number in
>    type_of_loader field.  If the type in type_of_loader is 0xE, then
> @@ -528,10 +599,12 @@ Protocol:	2.02+
>    Kernels prior to 2.6.31 did not recognize this field, but it is safe
>    to write for protocol version 2.02 or higher.
>  
> +============	==================
>  Field name:	cmd_line_ptr
>  Type:		write (obligatory)
>  Offset/size:	0x228/4
>  Protocol:	2.02+
> +============	==================
>  
>    Set this field to the linear address of the kernel command line.
>    The kernel command line can be located anywhere between the end of
> @@ -544,10 +617,12 @@ Protocol:	2.02+
>    zero, the kernel will assume that your boot loader does not support
>    the 2.02+ protocol.
>  
> +============	===============
>  Field name:	initrd_addr_max
>  Type:		read
>  Offset/size:	0x22c/4
>  Protocol:	2.03+
> +============	===============
>  
>    The maximum address that may be occupied by the initial
>    ramdisk/ramfs contents.  For boot protocols 2.02 or earlier, this
> @@ -556,10 +631,12 @@ Protocol:	2.03+
>    your ramdisk is exactly 131072 bytes long and this field is
>    0x37FFFFFF, you can start your ramdisk at 0x37FE0000.)
>  
> +============	============================
>  Field name:	kernel_alignment
>  Type:		read/modify (reloc)
>  Offset/size:	0x230/4
>  Protocol:	2.05+ (read), 2.10+ (modify)
> +============	============================
>  
>    Alignment unit required by the kernel (if relocatable_kernel is
>    true.)  A relocatable kernel that is loaded at an alignment
> @@ -571,25 +648,29 @@ Protocol:	2.05+ (read), 2.10+ (modify)
>    loader to modify this field to permit a lesser alignment.  See the
>    min_alignment and pref_address field below.
>  
> +============	==================
>  Field name:	relocatable_kernel
>  Type:		read (reloc)
>  Offset/size:	0x234/1
>  Protocol:	2.05+
> +============	==================
>  
>    If this field is nonzero, the protected-mode part of the kernel can
>    be loaded at any address that satisfies the kernel_alignment field.
>    After loading, the boot loader must set the code32_start field to
>    point to the loaded code, or to a boot loader hook.
>  
> +============	=============
>  Field name:	min_alignment
>  Type:		read (reloc)
>  Offset/size:	0x235/1
>  Protocol:	2.10+
> +============	=============
>  
>    This field, if nonzero, indicates as a power of two the minimum
>    alignment required, as opposed to preferred, by the kernel to boot.
>    If a boot loader makes use of this field, it should update the
> -  kernel_alignment field with the alignment unit desired; typically:
> +  kernel_alignment field with the alignment unit desired; typically::
>  
>  	kernel_alignment = 1 << min_alignment
>  
> @@ -597,44 +678,56 @@ Protocol:	2.10+
>    misaligned kernel.  Therefore, a loader should typically try each
>    power-of-two alignment from kernel_alignment down to this alignment.
>  
> -Field name:     xloadflags
> -Type:           read
> -Offset/size:    0x236/2
> -Protocol:       2.12+
> +============	==========
> +Field name:	xloadflags
> +Type:		read
> +Offset/size:	0x236/2
> +Protocol:	2.12+
> +============	==========
>  
>    This field is a bitmask.
>  
>    Bit 0 (read):	XLF_KERNEL_64
> +
>  	- If 1, this kernel has the legacy 64-bit entry point at 0x200.
>  
>    Bit 1 (read): XLF_CAN_BE_LOADED_ABOVE_4G
> +
>          - If 1, kernel/boot_params/cmdline/ramdisk can be above 4G.
>  
>    Bit 2 (read):	XLF_EFI_HANDOVER_32
> +
>  	- If 1, the kernel supports the 32-bit EFI handoff entry point
>            given at handover_offset.
>  
>    Bit 3 (read): XLF_EFI_HANDOVER_64
> +
>  	- If 1, the kernel supports the 64-bit EFI handoff entry point
>            given at handover_offset + 0x200.
>  
>    Bit 4 (read): XLF_EFI_KEXEC
> +
>  	- If 1, the kernel supports kexec EFI boot with EFI runtime support.
>  
> +
> +============	============
>  Field name:	cmdline_size
>  Type:		read
>  Offset/size:	0x238/4
>  Protocol:	2.06+
> +============	============
>  
>    The maximum size of the command line without the terminating
>    zero. This means that the command line can contain at most
>    cmdline_size characters. With protocol version 2.05 and earlier, the
>    maximum size was 255.
>  
> +============	====================================
>  Field name:	hardware_subarch
>  Type:		write (optional, defaults to x86/PC)
>  Offset/size:	0x23c/4
>  Protocol:	2.07+
> +============	====================================
>  
>    In a paravirtualized environment the hardware low level architectural
>    pieces such as interrupt handling, page table handling, and
> @@ -643,25 +736,31 @@ Protocol:	2.07+
>    This field allows the bootloader to inform the kernel we are in one
>    one of those environments.
>  
> +  ==========	==============================
>    0x00000000	The default x86/PC environment
>    0x00000001	lguest
>    0x00000002	Xen
>    0x00000003	Moorestown MID
>    0x00000004	CE4100 TV Platform
> +  ==========	==============================
>  
> +============	=========================
>  Field name:	hardware_subarch_data
>  Type:		write (subarch-dependent)
>  Offset/size:	0x240/8
>  Protocol:	2.07+
> +============	=========================
>  
>    A pointer to data that is specific to hardware subarch
>    This field is currently unused for the default x86/PC environment,
>    do not modify.
>  
> +============	==============
>  Field name:	payload_offset
>  Type:		read
>  Offset/size:	0x248/4
>  Protocol:	2.08+
> +============	==============
>  
>    If non-zero then this field contains the offset from the beginning
>    of the protected-mode code to the payload.
> @@ -674,29 +773,33 @@ Protocol:	2.08+
>    02 21).  The uncompressed payload is currently always ELF (magic
>    number 7F 45 4C 46).
>  
> +============	==============
>  Field name:	payload_length
>  Type:		read
>  Offset/size:	0x24c/4
>  Protocol:	2.08+
> +============	==============
>  
>    The length of the payload.
>  
> +============	===============
>  Field name:	setup_data
>  Type:		write (special)
>  Offset/size:	0x250/8
>  Protocol:	2.09+
> +============	===============
>  
>    The 64-bit physical pointer to NULL terminated single linked list of
>    struct setup_data. This is used to define a more extensible boot
>    parameters passing mechanism. The definition of struct setup_data is
> -  as follow:
> +  as follow::
>  
> -  struct setup_data {
> -	  u64 next;
> -	  u32 type;
> -	  u32 len;
> -	  u8  data[0];
> -  };
> +	struct setup_data {
> +		u64 next;
> +		u32 type;
> +		u32 len;
> +		u8  data[0];
> +	};
>  
>    Where, the next is a 64-bit physical pointer to the next node of
>    linked list, the next field of the last node is 0; the type is used
> @@ -708,10 +811,12 @@ Protocol:	2.09+
>    sure to consider the case where the linked list already contains
>    entries.
>  
> +============	============
>  Field name:	pref_address
>  Type:		read (reloc)
>  Offset/size:	0x258/8
>  Protocol:	2.10+
> +============	============
>  
>    This field, if nonzero, represents a preferred load address for the
>    kernel.  A relocating bootloader should attempt to load at this
> @@ -720,9 +825,11 @@ Protocol:	2.10+
>    A non-relocatable kernel will unconditionally move itself and to run
>    at this address.
>  
> +============	=======
>  Field name:	init_size
>  Type:		read
>  Offset/size:	0x260/4
> +============	=======
>  
>    This field indicates the amount of linear contiguous memory starting
>    at the kernel runtime start address that the kernel needs before it
> @@ -731,16 +838,18 @@ Offset/size:	0x260/4
>    be used by a relocating boot loader to help select a safe load
>    address for the kernel.
>  
> -  The kernel runtime start address is determined by the following algorithm:
> +  The kernel runtime start address is determined by the following algorithm::
>  
> -  if (relocatable_kernel)
> +	if (relocatable_kernel)
>  	runtime_start = align_up(load_address, kernel_alignment)
> -  else
> +	else
>  	runtime_start = pref_address
>  
> +============	===============
>  Field name:	handover_offset
>  Type:		read
>  Offset/size:	0x264/4
> +============	===============
>  
>    This field is the offset from the beginning of the kernel image to
>    the EFI handover protocol entry point. Boot loaders using the EFI
> @@ -749,7 +858,8 @@ Offset/size:	0x264/4
>    See EFI HANDOVER PROTOCOL below for more details.
>  
>  
> -**** THE IMAGE CHECKSUM
> +The Image Checksum
> +==================
>  
>  From boot protocol version 2.08 onwards the CRC-32 is calculated over
>  the entire file using the characteristic polynomial 0x04C11DB7 and an
> @@ -758,7 +868,8 @@ file; therefore the CRC of the file up to the limit specified in the
>  syssize field of the header is always 0.
>  
>  
> -**** THE KERNEL COMMAND LINE
> +The Kernel Command Line
> +=======================
>  
>  The kernel command line has become an important way for the boot
>  loader to communicate with the kernel.  Some of its options are also
> @@ -778,19 +889,20 @@ heap and 0xA0000.
>  If the protocol version is *not* 2.02 or higher, the kernel
>  command line is entered using the following protocol:
>  
> -	At offset 0x0020 (word), "cmd_line_magic", enter the magic
> -	number 0xA33F.
> +  - At offset 0x0020 (word), "cmd_line_magic", enter the magic
> +    number 0xA33F.
> +
> +  - At offset 0x0022 (word), "cmd_line_offset", enter the offset
> +    of the kernel command line (relative to the start of the
> +    real-mode kernel).
>  
> -	At offset 0x0022 (word), "cmd_line_offset", enter the offset
> -	of the kernel command line (relative to the start of the
> -	real-mode kernel).
> -	
> -	The kernel command line *must* be within the memory region
> -	covered by setup_move_size, so you may need to adjust this
> -	field.
> +  - The kernel command line *must* be within the memory region
> +    covered by setup_move_size, so you may need to adjust this
> +    field.
>  
>  
> -**** MEMORY LAYOUT OF THE REAL-MODE CODE
> +Memory Layout of The Real-Mode Code
> +===================================
>  
>  The real-mode code requires a stack/heap to be set up, as well as
>  memory allocated for the kernel command line.  This needs to be done
> @@ -806,10 +918,11 @@ segment has to be used:
>  	- When loading a zImage kernel ((loadflags & 0x01) == 0).
>  	- When loading a 2.01 or earlier boot protocol kernel.
>  
> -	  -> For the 2.00 and 2.01 boot protocols, the real-mode code  
> -	     can be loaded at another address, but it is internally
> -	     relocated to 0x90000.  For the "old" protocol, the
> -	     real-mode code must be loaded at 0x90000.
> +.. note::
> +     For the 2.00 and 2.01 boot protocols, the real-mode code
> +     can be loaded at another address, but it is internally
> +     relocated to 0x90000.  For the "old" protocol, the
> +     real-mode code must be loaded at 0x90000.
>  
>  When loading at 0x90000, avoid using memory above 0x9a000.
>  
> @@ -822,24 +935,29 @@ The kernel command line should not be located below the real-mode
>  code, nor should it be located in high memory.
>  
>  
> -**** SAMPLE BOOT CONFIGURATION
> +Sample Boot Configuartion
> +=========================
>  
>  As a sample configuration, assume the following layout of the real
> -mode segment:
> +mode segment.
>  
>      When loading below 0x90000, use the entire segment:
>  
> +        =============	===================
>  	0x0000-0x7fff	Real mode kernel
>  	0x8000-0xdfff	Stack and heap
>  	0xe000-0xffff	Kernel command line
> +	=============	===================
>  
>      When loading at 0x90000 OR the protocol version is 2.01 or earlier:
>  
> +	=============	===================
>  	0x0000-0x7fff	Real mode kernel
>  	0x8000-0x97ff	Stack and heap
>  	0x9800-0x9fff	Kernel command line
> +	=============	===================
>  
> -Such a boot loader should enter the following fields in the header:
> +Such a boot loader should enter the following fields in the header::
>  
>  	unsigned long base_ptr;	/* base address for real-mode segment */
>  
> @@ -898,7 +1016,8 @@ Such a boot loader should enter the following fields in the header:
>  	}
>  
>  
> -**** LOADING THE REST OF THE KERNEL
> +Loading The Rest of The Kernel
> +==============================
>  
>  The 32-bit (non-real-mode) kernel starts at offset (setup_sects+1)*512
>  in the kernel file (again, if setup_sects == 0 the real value is 4.)
> @@ -906,7 +1025,7 @@ It should be loaded at address 0x10000 for Image/zImage kernels and
>  0x100000 for bzImage kernels.
>  
>  The kernel is a bzImage kernel if the protocol >= 2.00 and the 0x01
> -bit (LOAD_HIGH) in the loadflags field is set:
> +bit (LOAD_HIGH) in the loadflags field is set::
>  
>  	is_bzImage = (protocol >= 0x0200) && (loadflags & 0x01);
>  	load_address = is_bzImage ? 0x100000 : 0x10000;
> @@ -916,8 +1035,8 @@ the entire 0x10000-0x90000 range of memory.  This means it is pretty
>  much a requirement for these kernels to load the real-mode part at
>  0x90000.  bzImage kernels allow much more flexibility.
>  
> -
> -**** SPECIAL COMMAND LINE OPTIONS
> +Special Command Line Options
> +============================
>  
>  If the command line provided by the boot loader is entered by the
>  user, the user may expect the following command line options to work.
> @@ -966,7 +1085,8 @@ or configuration-specified command line.  Otherwise, "init=/bin/sh"
>  gets confused by the "auto" option.
>  
>  
> -**** RUNNING THE KERNEL
> +Running the Kernel
> +==================
>  
>  The kernel is started by jumping to the kernel entry point, which is
>  located at *segment* offset 0x20 from the start of the real mode
> @@ -980,7 +1100,7 @@ interrupts should be disabled.  Furthermore, to guard against bugs in
>  the kernel, it is recommended that the boot loader sets fs = gs = ds =
>  es = ss.
>  
> -In our example from above, we would do:
> +In our example from above, we would do::
>  
>  	/* Note: in the case of the "old" kernel protocol, base_ptr must
>  	   be == 0x90000 at this point; see the previous sample code */
> @@ -1003,7 +1123,8 @@ switched off, especially if the loaded kernel has the floppy driver as
>  a demand-loaded module!
>  
>  
> -**** ADVANCED BOOT LOADER HOOKS
> +Advanced Boot Loader Hooks
> +==========================
>  
>  If the boot loader runs in a particularly hostile environment (such as
>  LOADLIN, which runs under DOS) it may be impossible to follow the
> @@ -1032,7 +1153,8 @@ IMPORTANT: All the hooks are required to preserve %esp, %ebp, %esi and
>  	(relocated, if appropriate.)
>  
>  
> -**** 32-bit BOOT PROTOCOL
> +32-bit Boot Protocol
> +====================
>  
>  For machine with some new BIOS other than legacy BIOS, such as EFI,
>  LinuxBIOS, etc, and kexec, the 16-bit real mode setup code in kernel
> @@ -1045,7 +1167,7 @@ traditionally known as "zero page"). The memory for struct boot_params
>  should be allocated and initialized to all zero. Then the setup header
>  from offset 0x01f1 of kernel image on should be loaded into struct
>  boot_params and examined. The end of setup header can be calculated as
> -follow:
> +follow::
>  
>  	0x0202 + byte value at offset 0x0201
>  
> @@ -1069,7 +1191,8 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
>  must be __BOOT_DS; interrupt must be disabled; %esi must hold the base
>  address of the struct boot_params; %ebp, %edi and %ebx must be zero.
>  
> -**** 64-bit BOOT PROTOCOL
> +64-bit Boot Protocol
> +====================
>  
>  For machine with 64bit cpus and 64bit kernel, we could use 64bit bootloader
>  and we need a 64-bit boot protocol.
> @@ -1080,7 +1203,7 @@ traditionally known as "zero page"). The memory for struct boot_params
>  could be allocated anywhere (even above 4G) and initialized to all zero.
>  Then, the setup header at offset 0x01f1 of kernel image on should be
>  loaded into struct boot_params and examined. The end of setup header
> -can be calculated as follows:
> +can be calculated as follows::
>  
>  	0x0202 + byte value at offset 0x0201
>  
> @@ -1107,7 +1230,8 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
>  must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
>  address of the struct boot_params.
>  
> -**** EFI HANDOVER PROTOCOL
> +EFI Handover Protocol
> +=====================
>  
>  This protocol allows boot loaders to defer initialisation to the EFI
>  boot stub. The boot loader is required to load the kernel/initrd(s)
> @@ -1115,7 +1239,7 @@ from the boot media and jump to the EFI handover protocol entry point
>  which is hdr->handover_offset bytes from the beginning of
>  startup_{32,64}.
>  
> -The function prototype for the handover entry point looks like this,
> +The function prototype for the handover entry point looks like this::
>  
>      efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
>  
> @@ -1124,11 +1248,11 @@ firmware, 'table' is the EFI system table - these are the first two
>  arguments of the "handoff state" as described in section 2.3 of the
>  UEFI specification. 'bp' is the boot loader-allocated boot params.
>  
> -The boot loader *must* fill out the following fields in bp,
> +The boot loader *must* fill out the following fields in bp::
>  
> -    o hdr.code32_start
> -    o hdr.cmd_line_ptr
> -    o hdr.ramdisk_image (if applicable)
> -    o hdr.ramdisk_size  (if applicable)
> +  - hdr.code32_start
> +  - hdr.cmd_line_ptr
> +  - hdr.ramdisk_image (if applicable)
> +  - hdr.ramdisk_size  (if applicable)
>  
>  All other fields should be zero.
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 9f34545a9c52..d7fc8efac192 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -7,3 +7,5 @@ x86-specific Documentation
>  .. toctree::
>     :maxdepth: 2
>     :numbered:
> +
> +   boot



Thanks,
Mauro
