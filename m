Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30AAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEC820651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEATzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:55:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:55:03 -0400
Received: from excalibur.cnev.de ([213.196.200.188]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9WeC-1hRPUo41DA-005VNG; Wed, 01 May 2019 21:54:47 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hLvJT-0000Cx-TE; Wed, 01 May 2019 21:54:43 +0200
Date:   Wed, 1 May 2019 21:54:43 +0200
From:   Karsten Merker <merker@debian.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zong@andestech.com" <zong@andestech.com>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
Message-ID: <20190501195443.trgjv6tujctsw5sw@excalibur.cnev.de>
References: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
 <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com>
 <20190501170053.GG11740@lakrids.cambridge.arm.com>
 <CAAhSdy2OuCb6wBrs-O=fTWo0D_CgwTztfV-kMDi=tPmSJhM7og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy2OuCb6wBrs-O=fTWo0D_CgwTztfV-kMDi=tPmSJhM7og@mail.gmail.com>
X-No-Archive: yes
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Wcvbk2phACwbUNrWanmcgvaG/SC1Qa2xqLynbBepDlxoWVqQ4EY
 Fk4o8lLOXe7Qyzqn5JoguFhonrfnGSpZ6l4q4tzGLSz2KFSBdPUCB7d4kfAEGaxjahIHdyp
 SlDodHWHDtDmnplGuKoJUWruDbJ3tzt8IQsyW8iR+KzpZ189HwyNhx8HI/cH54jKHaMbKuB
 4ZWxGgAMRvkXt7LlylWkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J9tQ4OSZ3ao=:dzfbPsQ3MnrH1ztAiTmZ2B
 M1AuxzxvjtbGbGSa2DXCW7u6jfchZljqRTBBUaXGbVwN/3sK8XniHlx9tEm2wjO9sZzTkz0Tt
 eXw+lWbpOwAq4zOTBcR3729m0n600y6dqOVU1ZFwOhYCeTzxpn0UyQFDcx/i6Ut2khFjWjypZ
 FF965xlxk9joK+TrlEdnXqc07g+q5foKln6KVyL25UeNAT+gimLJVSEfBOcIFT4dOElj/VBOT
 FK2wWfVEOmw7wpyzIBGggfGvUyCekiBrDBHk/GJ+kjAAuhTBiTlue8f1cPz5vkLhFR8D4meTO
 L62RN1uAGYF7zJ+Sv40erBWz5JR5Uxu+Y8s6VelzQyF18Zj1I3oHXdV/Ql2dQ4PTI7CVNXtha
 TrkBxAWOXNqyl1BkC5ykYSTERZqG9jyYj8sgjMwOjANAM0YiyMWuOQoeb4lA+DW/hvOvIHpSa
 Z9egQj2ChHNTy94b74uIZCXr/etDH1ogIAGzeNL4wArefPlxLrisidR7D8wMVmk4w0S0Mbnaf
 v/V2V91qzPbwC6906PQ4OI3KIsAgp9EipA7SCHqagHbWcBaa6PbonXT/Zm4/rkwC8wUOYRTJE
 B1EgzfkBL8E4oE9mPlFWmE8qcEDcZGYX0FNrTZQc+26kzcQfdrGJmoQr+OuClPW26mVZPE7kh
 zpVHt0InM8kNJ1B5iT1WoVwYjr0+4dQwob6z8HosF2X2J8O5p8ah8waYUowMGFXeOCKxtk86Z
 5yQ1kbjcMubeKe88OZ31WtLgmCTs20fJGzLrqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:41:52PM +0530, Anup Patel wrote:
> On Wed, May 1, 2019 at 10:30 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Apr 29, 2019 at 10:42:40PM -0700, Atish Patra wrote:
> > > On 4/29/19 4:40 PM, Palmer Dabbelt wrote:
> > > > On Tue, 23 Apr 2019 16:25:06 PDT (-0700), atish.patra@wdc.com wrote:
> > > > > Currently, last stage boot loaders such as U-Boot can accept only
> > > > > uImage which is an unnecessary additional step in automating boot flows.
> > > > >
> > > > > Add a simple image header that boot loaders can parse and directly
> > > > > load kernel flat Image. The existing booting methods will continue to
> > > > > work as it is.
> > > > >
> > > > > Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
> > > > >
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > ---
> > > > >   arch/riscv/include/asm/image.h | 32 ++++++++++++++++++++++++++++++++
> > > > >   arch/riscv/kernel/head.S       | 28 ++++++++++++++++++++++++++++
> > > > >   2 files changed, 60 insertions(+)
> > > > >   create mode 100644 arch/riscv/include/asm/image.h
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> > > > > new file mode 100644
> > > > > index 000000000000..76a7e0d4068a
> > > > > --- /dev/null
> > > > > +++ b/arch/riscv/include/asm/image.h
> > > > > @@ -0,0 +1,32 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +
> > > > > +#ifndef __ASM_IMAGE_H
> > > > > +#define __ASM_IMAGE_H
> > > > > +
> > > > > +#define RISCV_IMAGE_MAGIC        "RISCV"
> > > > > +
> > > > > +#ifndef __ASSEMBLY__
> > > > > +/*
> > > > > + * struct riscv_image_header - riscv kernel image header
> > > > > + *
> > > > > + * @code0:               Executable code
> > > > > + * @code1:               Executable code
> > > > > + * @text_offset: Image load offset
> > > > > + * @image_size:          Effective Image size
> > > > > + * @reserved:            reserved
> > > > > + * @magic:               Magic number
> > > > > + * @reserved:            reserved
> > > > > + */
> > > > > +
> > > > > +struct riscv_image_header {
> > > > > + u32 code0;
> > > > > + u32 code1;
> > > > > + u64 text_offset;
> > > > > + u64 image_size;
> > > > > + u64 res1;
> > > > > + u64 magic;
> > > > > + u32 res2;
> > > > > + u32 res3;
> > > > > +};
> > > >
> > > > I don't want to invent our own file format.  Is there a reason we can't just
> > > > use something standard?  Off the top of my head I can think of ELF files and
> > > > multiboot.
> > >
> > > Additional header is required to accommodate PE header format. Currently,
> > > this is only used for booti command but it will be reused for EFI headers as
> > > well. Linux kernel Image can pretend as an EFI application if PE/COFF header
> > > is present. This removes the need of an explicit EFI boot loader and EFI
> > > firmware can directly load Linux (obviously after EFI stub implementation
> > > for RISC-V).
> >
> > Adding the EFI stub on arm64 required very careful consideration of our
> > Image header and the EFI spec, along with the PE/COFF spec.
> >
> > For example, to be a compliant PE/COFF header, the first two bytes of
> > your kernel image need to be "MZ" in ASCII. On arm64 we happened to find
> > a valid instruction that we could rely upon that met this requirement...
> 
> The "MZ" ASCII (i.e. 0x5a4d) is "li s4,-13" instruction in RISC-V so this
> modifies "s4" register which is pretty harmless from Linux RISC-V booting
> perspective.
> 
> Of course, we should only add "MZ" ASCII in Linux RISC-V image header
> when CONFIG_EFI is enabled (just like Linux ARM64).

Probably I'm missing something obvious, but I cannot completely
follow you here. My understanding is as follows:

The kernel gets executed by jumping to the _start label, where it
currently immediately starts with setting up everything (mask
interrupts, disable FPU, etc).  Now we insert a structure before
the actual init code where the first 64 bits of the structure
(the code0 and code1 fields) are filled with values that
constitute a valid jump opcode to the actual init code behind the
end of the new structure.

If the first byte in a PE/COFF header has to be an ASCII "M",
that is 01001101 in binary.  RISC-V is little-endian and the last
two bits of the lowest-value byte define the type of instruction. 
According to the chapter "Base Instruction-Length Encoding" in
the RISC-V ISA spec everything except 11 as the lowest bits
denotes a compressed instruction and if I have puzzeled together
the the various instruction bits correctly, ASCII "MZ" would be
excuted as a compressed load immediate to x9/s1, wouldn't it?

If my previous thoughts are correct, this would also mean that
having a PE/COFF-compatible header for EFI boot would make a
kernel image inherently incompatible with performing a non-EFI
boot of the same image on systems that don't implement the C
extension.  As the work-in-progress RISC-V Unix platform spec
will probably mandate C, that probably won't be much of a
practical problem, though.

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
