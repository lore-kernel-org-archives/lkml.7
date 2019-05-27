Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B9EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C202075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfE0WRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:17:12 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfE0WRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:17:11 -0400
Received: from excalibur.cnev.de ([194.8.209.98]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhlCa-1h0jzV2GtE-00dknW; Tue, 28 May 2019 00:16:25 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hVNul-0000rz-WA; Tue, 28 May 2019 00:16:20 +0200
Date:   Tue, 28 May 2019 00:16:19 +0200
From:   Karsten Merker <merker@debian.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karsten Merker <merker@debian.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [v4 PATCH] RISC-V: Add an Image header that boot loader can
 parse.
Message-ID: <20190527221619.fkxtzk4jpeyfoptf@excalibur.cnev.de>
References: <20190524041814.7497-1-atish.patra@wdc.com>
 <CAKv+Gu9U56b50TrfriBfRFed_1aoXg2Y624tu7v5m2y+6DVq5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKv+Gu9U56b50TrfriBfRFed_1aoXg2Y624tu7v5m2y+6DVq5w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:IggtGFZrbp9GZe50tguh26rLf9NXZcqGQm/DxENZxO6zmFTT7ar
 xrlreaf7E2MLlnT/NZ5xFEoQDP+tlltS3BsFa2S0/HZg/8G0NkmtrqFET36hPHZsHh/TnaG
 fQx3pSKdqVTG2GdS2HHMt9yleoggHD7BUyP8DqxizgvAb9A0gxVC9+Uhxs0p+PD4DgwJc1O
 rFR0o7Ab0r+BhUlhU7A6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zgr8CE5oZTc=:mCiXxlktW4T3elxbJzmy9h
 ucPcOpiaHc/ZVs8XcLqtTBDU4ftCJUM7te/CIgMrHrzALY7QwXoKjVrRZf/7uTWQYMEVKeS+B
 sT2AUUgEk5oATbyNHxOJvKOcu1Wv/mkOndeot2LBPno0YmYZPNQ0Ssw/h0Dy8GHKVoU+hibVP
 jJbNDIJW7Y7iwbmRDTE25tPMU5LZYSezxn1LwvpgIYMcnBfudy05fqYF/c0hk7Sz3HMlAjlXV
 Hyw9Rfgfum3p2rhOa024YmRdzr7XvC4Wu1192B9iU7SPaWkk1oNtCAMcP/n14ymVmrdr5Sdtp
 EZo/ToGaQU+YfRxS9WnVddpRPO4w4er0Cs/XKefQhPNw6mmHhRuWm+bsnKT9tEApZ6KZMBxbO
 nIBGw35tpBjvCmjYYWHlFxeaSplSeVyK0eW05IBRrqvNZSNPMZCP+8hYvQFssEbVcg8DtK8sx
 WqR3vNrG6goAI6AJWmm5NKXcsqjl7psS5r4BAa/VghXBYDFJZDxpn6zpWokcUg96KP+fyauQd
 +WRZxUy6lj060T4UBwydhr8qhz/HlZ7NEnWsmyphs7ecalmlxZVAuAOmD5UwMxUniArxo3j7n
 V8dY5kdr8nkNwVGk3DKny0jI6xfnWEs+YzKQx24n9ddg8FDoOQJNSdZvKx7AV/Z1xisFHTIE7
 /8wZiY9YemXFqAjlRb/jfbCiLtarGRyMdNkhV2fstxXQclS6dBmXmmrZ3ewpU97eE/KvvKtnd
 MTuk3Rf3QPxWIQ2kC4aanwsguVF2VwIH4qYUTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 04:34:57PM +0200, Ard Biesheuvel wrote:
> On Fri, 24 May 2019 at 06:18, Atish Patra <atish.patra@wdc.com> wrote:
> > Currently, the last stage boot loaders such as U-Boot can accept only
> > uImage which is an unnecessary additional step in automating boot
> > process.
> >
> > Add an image header that boot loader understands and boot Linux from
> > flat Image directly.
> >
> > This header is based on ARM64 boot image header and provides an
> > opportunity to combine both ARM64 & RISC-V image headers in future.
> >
> > Also make sure that PE/COFF header can co-exist in the same image so
> > that EFI stub can be supported for RISC-V in future. EFI specification
> > needs PE/COFF image header in the beginning of the kernel image in order
> > to load it as an EFI application. In order to support EFI stub, code0
> > should be replaced with "MZ" magic string and res4(at offset 0x3c)
> > should point to the rest of the PE/COFF header (which will be added
> > during EFI support).
[...]
> >  Documentation/riscv/boot-image-header.txt | 50 ++++++++++++++++++
> >  arch/riscv/include/asm/image.h            | 64 +++++++++++++++++++++++
> >  arch/riscv/kernel/head.S                  | 32 ++++++++++++
> >  3 files changed, 146 insertions(+)
> >  create mode 100644 Documentation/riscv/boot-image-header.txt
> >  create mode 100644 arch/riscv/include/asm/image.h
> >
> > diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.txt
> > new file mode 100644
> > index 000000000000..68abc2353cec
> > --- /dev/null
> > +++ b/Documentation/riscv/boot-image-header.txt
> > @@ -0,0 +1,50 @@
> > +                               Boot image header in RISC-V Linux
> > +                       =============================================
> > +
> > +Author: Atish Patra <atish.patra@wdc.com>
> > +Date  : 20 May 2019
> > +
> > +This document only describes the boot image header details for RISC-V Linux.
> > +The complete booting guide will be available at Documentation/riscv/booting.txt.
> > +
> > +The following 64-byte header is present in decompressed Linux kernel image.
> > +
> > +       u32 code0;                /* Executable code */
> > +       u32 code1;                /* Executable code */
> 
> Apologies for not mentioning this in my previous reply, but given that
> you already know that you will need to put the magic string MZ at
> offset 0x0, it makes more sense to not put any code there at all, but
> educate the bootloader that the first executable instruction is at
> offset 0x20, and put the spare fields right after it in case you ever
> need more than 2 slots. (On arm64, we were lucky to be able to find an
> opcode that happened to contain the MZ bit pattern and act almost like
> a NOP, but it seems silly to rely on that for RISC-V as well)
> 
> So something like
> 
> u16 pe_res1;  /* MZ for EFI bootable images, don't care otherwise */
> u8 magic[6];    /* "RISCV\0"
> 
> u64 text_offset;          /* Image load offset, little endian */
> u64 image_size;           /* Effective Image size, little endian */
> u64 flags;                /* kernel flags, little endian */
> 
> u32 code0;                /* Executable code */
> u32 code1;                /* Executable code */
> 
> u64 reserved[2];     /* reserved for future use */
> 
> u32 version;              /* Version of this header */
> u32 pe_res2;                 /* Reserved for PE COFF offset */

Hello,

wouldn't that immediately break existing systems (including qemu
when loading kernels with the "-kernel" option) that rely on the
fact that the kernel entry point is always at the kernel load
address?  The ARM64 header and Atish's original RISC-V proposal
based on the ARM64 header keep the property that jumping to the
kernel load address always works, regardless of what the
particular header looks like and which potential future
extensions it includes, but the proposed change above wouldn't do
that.

Although I agree that having to integrate the "MZ" string as an
instruction isn't particularly nice, I don't think that this is a
sufficient justification for breaking compatibility with prior
kernel releases and/or existing boot firmware.  On RISC-V, the
"MZ" string is a compressed load immediate to x20/s4, i.e. an
instruction that should be "harmless" as far as the kernel boot
flow is concerned as the x20/s4 register AFAIK doesn't contain any
information that the kernel would use.

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
