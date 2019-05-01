Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403DC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113942183F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfEAQoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:44:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfEAQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:44:16 -0400
Received: from excalibur.cnev.de ([213.196.200.188]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MKKd7-1h3NB22Z3P-00Lomo; Wed, 01 May 2019 18:43:59 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hLsKq-0008J7-9P; Wed, 01 May 2019 18:43:56 +0200
Date:   Wed, 1 May 2019 18:43:56 +0200
From:   Karsten Merker <merker@debian.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        "zong@andestech.com" <zong@andestech.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
Message-ID: <20190501164355.ce76wjmq6sszrf5g@excalibur.cnev.de>
References: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
 <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:gQfgRV52/wutLP5y4mCshUvfjXUXinHlk5dmAqDo68cRBMaQlCw
 rMRY/Jx6izGcZPqiRMaSb8TjWhuJqrPuMAF0Fn/0Q/dASGB8KEcGrzvbkC+MlFBwE54km/c
 LZJ1xJzk3KnHcCEUwGyz6l354+2IcaYV8khYD6vipm2Ux7lPy8qoDldT2oEghZd9pVZgYD2
 OhOx/c3oYlexeVwooxJig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sDbHHpX80m8=:h9K1eA/AIbnevYg/2MjTYp
 Cz/vGhw0jx6Rtn/drvlUS4qRjpysjAndbHb5S4rgGxjUqadjr1dy+r9xhlyZWbbwA6RKLJny5
 emXj7SB+er8B30aMNeU3UcEihU4EIWklCWilbUa/o7Bl26x1Kf6324T20osihtUq9FmczgszF
 NFIA1iwxmHl7UyjYRhZkb3XACeDAy0AWaR4kt+i1D2HVNvyIi54/jSWxQ1zP8mT2Bajnpt15Q
 XcTx7h9QCZ14U/tu1wk6zNUv5gb6Op+CUFu0MhEjC8OC8fHC6ASrWsCYxFABGcr0+b1VY0A4D
 dmxex9febOQEt0kVFfq0NI9ixcip3RnfWZE4cB703e1InyKGO5UtBwL5g01yvpFF+wzfI/1Rm
 /H9uyaas5JfiNXvDeomTsrk6woMDxLpsLmEZ4duR+4kezNpd06/WxhdMRQq79JPoA1HQ67F45
 NRzR9IgW8blSJxg2NztAfcPNKdKGMJly6CFS+IcTA6X+40vRpTgxpfVu272dPmJHhArZCtO7R
 drHt+61Yw0fxHjMQ2kzmIzYKyqPtSYvPCWXMZwSF2zUarFd6mZgUeKgOHkIGvYNOpmnuwLK2c
 pgNe+urP0WZJAVHX6dJYvhz+FBS4Iv6Mjq0S0c3Y7ZZaQ2ET9QOfYgYeAC4reeYns4n81Vaxn
 KqSesOAjZMMUfmCBvYcvG465EHdp0+aCokXMRLZnY7SOwfMubkmjT5H7IxPaSUAClpaFL/wGW
 JzYKAewCRpDa/VDw2M5qPtv0Nq4XfZXi+kMutg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:42:40PM -0700, Atish Patra wrote:
> On 4/29/19 4:40 PM, Palmer Dabbelt wrote:
> > On Tue, 23 Apr 2019 16:25:06 PDT (-0700), atish.patra@wdc.com wrote:
> > > Currently, last stage boot loaders such as U-Boot can accept only
> > > uImage which is an unnecessary additional step in automating boot flows.
> > > 
> > > Add a simple image header that boot loaders can parse and directly
> > > load kernel flat Image. The existing booting methods will continue to
> > > work as it is.
> > > 
> > > Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
> > > 
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >   arch/riscv/include/asm/image.h | 32 ++++++++++++++++++++++++++++++++
> > >   arch/riscv/kernel/head.S       | 28 ++++++++++++++++++++++++++++
> > >   2 files changed, 60 insertions(+)
> > >   create mode 100644 arch/riscv/include/asm/image.h
> > > 
> > > diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> > > new file mode 100644
> > > index 000000000000..76a7e0d4068a
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/image.h
> > > @@ -0,0 +1,32 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __ASM_IMAGE_H
> > > +#define __ASM_IMAGE_H
> > > +
> > > +#define RISCV_IMAGE_MAGIC	"RISCV"
> > > +
> > > +#ifndef __ASSEMBLY__
> > > +/*
> > > + * struct riscv_image_header - riscv kernel image header
> > > + *
> > > + * @code0:		Executable code
> > > + * @code1:		Executable code
> > > + * @text_offset:	Image load offset
> > > + * @image_size:		Effective Image size
> > > + * @reserved:		reserved
> > > + * @magic:		Magic number
> > > + * @reserved:		reserved
> > > + */
> > > +
> > > +struct riscv_image_header {
> > > +	u32 code0;
> > > +	u32 code1;
> > > +	u64 text_offset;
> > > +	u64 image_size;
> > > +	u64 res1;
> > > +	u64 magic;
> > > +	u32 res2;
> > > +	u32 res3;
> > > +};
> > 
> > I don't want to invent our own file format.  Is there a reason we can't just
> > use something standard?  Off the top of my head I can think of ELF files and
> > multiboot.
> 
> Additional header is required to accommodate PE header format. Currently,
> this is only used for booti command but it will be reused for EFI headers as
> well. Linux kernel Image can pretend as an EFI application if PE/COFF header
> is present. This removes the need of an explicit EFI boot loader and EFI
> firmware can directly load Linux (obviously after EFI stub implementation
> for RISC-V).
> 
> ARM64 follows the similar header format as well.
> https://www.kernel.org/doc/Documentation/arm64/booting.txt

Hello Atish,

the arm64 header looks a bit different (quoted from the
aforementioned URL):

  u32 code0;                    /* Executable code */
  u32 code1;                    /* Executable code */
  u64 text_offset;              /* Image load offset, little endian */
  u64 image_size;               /* Effective Image size, little endian */
  u64 flags;                    /* kernel flags, little endian */
  u64 res2      = 0;            /* reserved */
  u64 res3      = 0;            /* reserved */
  u64 res4      = 0;            /* reserved */
  u32 magic     = 0x644d5241;   /* Magic number, little endian, "ARM\x64" */
  u32 res5;                     /* reserved (used for PE COFF offset) */

What I am unclear about is in which ways a RISC-V PE/COFF header
differs from an arm64 one as the arm64 struct is longer than your
RISC-V header and for arm64 the PE offset field is in the last
field, i.e. outside of the area covered by your RISC-V structure
definition.  Can you perhaps explain this part in a bit more
detail or does anybody else have a pointer to a specification of
the RISC-V PE/COFF header format (I have found a lot of documents
about COFF in general, but nothing specific to RISC-V).

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
