Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898BB218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfCORnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:43:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfCORnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25BDF3084294;
        Fri, 15 Mar 2019 17:43:04 +0000 (UTC)
Received: from [10.36.112.50] (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77F2E5D6A6;
        Fri, 15 Mar 2019 17:42:50 +0000 (UTC)
Subject: Re: [PATCH] KVM: export <linux/kvm_para.h> and <asm/kvm_para.h> iif
 KVM is supported
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?B?UmFkaW0gS3Lvv73vv73vv71t77+977+977+977+977+977+9?= 
        <rkrcmar@redhat.com>, kvm@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <1549432390-11457-1-git-send-email-yamada.masahiro@socionext.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <e7ae9588-d653-002f-3d1c-9863258f8579@redhat.com>
Date:   Fri, 15 Mar 2019 18:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549432390-11457-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 15 Mar 2019 17:43:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/19 06:53, Masahiro Yamada wrote:
> I do not see any consistency about headers_install of <linux/kvm_para.h>
> and <asm/kvm_para.h>.
> 
> According to my analysis of Linux 5.0-rc5, there are 3 groups:
> 
>  [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported
> 
>     alpha, arm, hexagon, mips, powerpc, s390, sparc, x86
> 
>  [2] <asm/kvm_para.h> is exported, but <linux/kvm_para.h> is not
> 
>     arc, arm64, c6x, h8300, ia64, m68k, microblaze, nios2, openrisc
> 
>  [3] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported
> 
>     csky, nds32, riscv
> 
> This does not match to the actual KVM support. At least, [2] is
> half-baked.
> 
> Nor do arch maintainers look like they care about this. For example,
> commit 0add53713b1c ("microblaze: Add missing kvm_para.h to Kbuild")
> exported <asm/kvm_para.h> to user-space in order to fix an in-kernel
> build error.
> 
> We have two ways to make this consistent:
> 
>  [A] export both <linux/kvm_para.h> and <asm/kvm_para.h> for all
>      architectures, irrespective of the KVM support
> 
>  [B] Match the header export of <linux/kvm_para.h> and <asm/kvm_para.h>
>      to the KVM support
> 
> My first attempt was [A] because the code looks better, but Paolo
> showed preference in [B].
> 
>   https://patchwork.kernel.org/patch/10794919/
> 
> So, this commit is the implementation of [B].
> 
> For most architectures, <asm/kvm_para.h> was moved to the kernel-space.
> I changed include/uapi/linux/Kbuild so that it checks generated
> asm/kvm_para.h as well as check-in ones.
> 
> After this commit, there will be two groups:
> 
>  [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported
> 
>     arm arm64 mips powerpc s390 x86
> 
>  [2] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported
> 
>     alpha arc c6x csky h8300 hexagon ia64 m68k microblaze nds32 nios2
>     openrisc parisc riscv sh sparc unicore32 xtensa
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> The alternative solution [A] is available at:
> https://patchwork.kernel.org/patch/10794919/
> 
> Comparing the code diff, I personally prefer [A]...
> 
> 
>  arch/alpha/include/asm/Kbuild            | 1 +
>  arch/alpha/include/uapi/asm/kvm_para.h   | 2 --
>  arch/arc/include/asm/Kbuild              | 1 +
>  arch/arc/include/uapi/asm/Kbuild         | 1 -
>  arch/arm/include/uapi/asm/Kbuild         | 1 +
>  arch/arm/include/uapi/asm/kvm_para.h     | 2 --
>  arch/c6x/include/asm/Kbuild              | 1 +
>  arch/c6x/include/uapi/asm/Kbuild         | 1 -
>  arch/h8300/include/asm/Kbuild            | 1 +
>  arch/h8300/include/uapi/asm/Kbuild       | 1 -
>  arch/hexagon/include/asm/Kbuild          | 1 +
>  arch/hexagon/include/uapi/asm/kvm_para.h | 2 --
>  arch/ia64/include/asm/Kbuild             | 1 +
>  arch/ia64/include/uapi/asm/Kbuild        | 1 -
>  arch/m68k/include/asm/Kbuild             | 1 +
>  arch/m68k/include/uapi/asm/Kbuild        | 1 -
>  arch/microblaze/include/asm/Kbuild       | 1 +
>  arch/microblaze/include/uapi/asm/Kbuild  | 1 -
>  arch/mips/include/uapi/asm/Kbuild        | 1 +
>  arch/mips/include/uapi/asm/kvm_para.h    | 5 -----
>  arch/nios2/include/asm/Kbuild            | 1 +
>  arch/nios2/include/uapi/asm/Kbuild       | 1 -
>  arch/openrisc/include/asm/Kbuild         | 1 +
>  arch/openrisc/include/uapi/asm/Kbuild    | 1 -
>  arch/parisc/include/asm/Kbuild           | 1 +
>  arch/parisc/include/uapi/asm/Kbuild      | 1 -
>  arch/s390/include/uapi/asm/Kbuild        | 1 +
>  arch/s390/include/uapi/asm/kvm_para.h    | 8 --------
>  arch/sh/include/asm/Kbuild               | 1 +
>  arch/sh/include/uapi/asm/Kbuild          | 1 -
>  arch/sparc/include/asm/Kbuild            | 1 +
>  arch/sparc/include/uapi/asm/kvm_para.h   | 2 --
>  arch/unicore32/include/asm/Kbuild        | 1 +
>  arch/unicore32/include/uapi/asm/Kbuild   | 1 -
>  arch/xtensa/include/asm/Kbuild           | 1 +
>  arch/xtensa/include/uapi/asm/Kbuild      | 1 -
>  include/uapi/linux/Kbuild                | 2 ++
>  37 files changed, 20 insertions(+), 33 deletions(-)
>  delete mode 100644 arch/alpha/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/arm/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/hexagon/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/mips/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/s390/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/sparc/include/uapi/asm/kvm_para.h
> 
> diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
> index dc0ab28..70b7833 100644
> --- a/arch/alpha/include/asm/Kbuild
> +++ b/arch/alpha/include/asm/Kbuild
> @@ -6,6 +6,7 @@ generic-y += exec.h
>  generic-y += export.h
>  generic-y += fb.h
>  generic-y += irq_work.h
> +generic-y += kvm_para.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += preempt.h
> diff --git a/arch/alpha/include/uapi/asm/kvm_para.h b/arch/alpha/include/uapi/asm/kvm_para.h
> deleted file mode 100644
> index baacc49..0000000
> --- a/arch/alpha/include/uapi/asm/kvm_para.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#include <asm-generic/kvm_para.h>
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
> index caa2702..6e165e1 100644
> --- a/arch/arc/include/asm/Kbuild
> +++ b/arch/arc/include/asm/Kbuild
> @@ -10,6 +10,7 @@ generic-y += hardirq.h
>  generic-y += hw_irq.h
>  generic-y += irq_regs.h
>  generic-y += irq_work.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
> index 0febf1a..c1b06dc 100644
> --- a/arch/arc/include/uapi/asm/Kbuild
> +++ b/arch/arc/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
> -generic-y += kvm_para.h
>  generic-y += ucontext.h
> diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
> index eee8f7d..482e5ec 100644
> --- a/arch/arm/include/uapi/asm/Kbuild
> +++ b/arch/arm/include/uapi/asm/Kbuild
> @@ -4,3 +4,4 @@ include include/uapi/asm-generic/Kbuild.asm
>  generated-y += unistd-common.h
>  generated-y += unistd-oabi.h
>  generated-y += unistd-eabi.h
> +generic-y += kvm_para.h
> diff --git a/arch/arm/include/uapi/asm/kvm_para.h b/arch/arm/include/uapi/asm/kvm_para.h
> deleted file mode 100644
> index baacc49..0000000
> --- a/arch/arm/include/uapi/asm/kvm_para.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#include <asm-generic/kvm_para.h>
> diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
> index 63b4a17..249c9f6 100644
> --- a/arch/c6x/include/asm/Kbuild
> +++ b/arch/c6x/include/asm/Kbuild
> @@ -19,6 +19,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
> diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
> index 0febf1a..c1b06dc 100644
> --- a/arch/c6x/include/uapi/asm/Kbuild
> +++ b/arch/c6x/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
> -generic-y += kvm_para.h
>  generic-y += ucontext.h
> diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
> index 961c1dc..c86e3e7 100644
> --- a/arch/h8300/include/asm/Kbuild
> +++ b/arch/h8300/include/asm/Kbuild
> @@ -24,6 +24,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += linkage.h
>  generic-y += local.h
>  generic-y += local64.h
> diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
> index 0febf1a..c1b06dc 100644
> --- a/arch/h8300/include/uapi/asm/Kbuild
> +++ b/arch/h8300/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
> -generic-y += kvm_para.h
>  generic-y += ucontext.h
> diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
> index b25fd42..d046e8c 100644
> --- a/arch/hexagon/include/asm/Kbuild
> +++ b/arch/hexagon/include/asm/Kbuild
> @@ -19,6 +19,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> diff --git a/arch/hexagon/include/uapi/asm/kvm_para.h b/arch/hexagon/include/uapi/asm/kvm_para.h
> deleted file mode 100644
> index baacc49..0000000
> --- a/arch/hexagon/include/uapi/asm/kvm_para.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#include <asm-generic/kvm_para.h>
> diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
> index 43e21fe..11f1916 100644
> --- a/arch/ia64/include/asm/Kbuild
> +++ b/arch/ia64/include/asm/Kbuild
> @@ -2,6 +2,7 @@ generated-y += syscall_table.h
>  generic-y += compat.h
>  generic-y += exec.h
>  generic-y += irq_work.h
> +generic-y += kvm_para.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += preempt.h
> diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
> index 5b819e5..1d5c4aa 100644
> --- a/arch/ia64/include/uapi/asm/Kbuild
> +++ b/arch/ia64/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  generated-y += unistd_64.h
> -generic-y += kvm_para.h
> diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
> index 95f8f63..2c359d9 100644
> --- a/arch/m68k/include/asm/Kbuild
> +++ b/arch/m68k/include/asm/Kbuild
> @@ -13,6 +13,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
> index 960bf1e..439f515 100644
> --- a/arch/m68k/include/uapi/asm/Kbuild
> +++ b/arch/m68k/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  generated-y += unistd_32.h
> -generic-y += kvm_para.h
> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> index 791cc8d5..1a8285c 100644
> --- a/arch/microblaze/include/asm/Kbuild
> +++ b/arch/microblaze/include/asm/Kbuild
> @@ -17,6 +17,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += linkage.h
>  generic-y += local.h
>  generic-y += local64.h
> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> index 97823ec..3f03cf6 100644
> --- a/arch/microblaze/include/uapi/asm/Kbuild
> +++ b/arch/microblaze/include/uapi/asm/Kbuild
> @@ -1,5 +1,4 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  generated-y += unistd_32.h
> -generic-y += kvm_para.h
>  generic-y += ucontext.h
> diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
> index 0851c10..57dd982 100644
> --- a/arch/mips/include/uapi/asm/Kbuild
> +++ b/arch/mips/include/uapi/asm/Kbuild
> @@ -6,3 +6,4 @@ generated-y += unistd_o32.h
>  generated-y += unistd_nr_n32.h
>  generated-y += unistd_nr_n64.h
>  generated-y += unistd_nr_o32.h
> +generic-y += kvm_para.h
> diff --git a/arch/mips/include/uapi/asm/kvm_para.h b/arch/mips/include/uapi/asm/kvm_para.h
> deleted file mode 100644
> index 7e16d7c..0000000
> --- a/arch/mips/include/uapi/asm/kvm_para.h
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -#ifndef _UAPI_ASM_MIPS_KVM_PARA_H
> -#define _UAPI_ASM_MIPS_KVM_PARA_H
> -
> -
> -#endif /* _UAPI_ASM_MIPS_KVM_PARA_H */
> diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
> index 8fde4fa..88a667d 100644
> --- a/arch/nios2/include/asm/Kbuild
> +++ b/arch/nios2/include/asm/Kbuild
> @@ -23,6 +23,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
> diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
> index 0febf1a..c1b06dc 100644
> --- a/arch/nios2/include/uapi/asm/Kbuild
> +++ b/arch/nios2/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
> -generic-y += kvm_para.h
>  generic-y += ucontext.h
> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index 1f04844b..ad06de9 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -21,6 +21,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
> diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
> index 0febf1a..c1b06dc 100644
> --- a/arch/openrisc/include/uapi/asm/Kbuild
> +++ b/arch/openrisc/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
> -generic-y += kvm_para.h
>  generic-y += ucontext.h
> diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
> index 0b1e354..3abb960 100644
> --- a/arch/parisc/include/asm/Kbuild
> +++ b/arch/parisc/include/asm/Kbuild
> @@ -12,6 +12,7 @@ generic-y += irq_regs.h
>  generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
> index c54353d..214a39a 100644
> --- a/arch/parisc/include/uapi/asm/Kbuild
> +++ b/arch/parisc/include/uapi/asm/Kbuild
> @@ -2,4 +2,3 @@ include include/uapi/asm-generic/Kbuild.asm
>  
>  generated-y += unistd_32.h
>  generated-y += unistd_64.h
> -generic-y += kvm_para.h
> diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
> index da3e0d4..96ad5d7 100644
> --- a/arch/s390/include/uapi/asm/Kbuild
> +++ b/arch/s390/include/uapi/asm/Kbuild
> @@ -3,3 +3,4 @@ include include/uapi/asm-generic/Kbuild.asm
>  
>  generated-y += unistd_32.h
>  generated-y += unistd_64.h
> +generic-y += kvm_para.h
> diff --git a/arch/s390/include/uapi/asm/kvm_para.h b/arch/s390/include/uapi/asm/kvm_para.h
> deleted file mode 100644
> index b9ab584..0000000
> --- a/arch/s390/include/uapi/asm/kvm_para.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/*
> - * User API definitions for paravirtual devices on s390
> - *
> - * Copyright IBM Corp. 2008
> - *
> - *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
> - */
> diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
> index a6ef3fe..7bf2cb6 100644
> --- a/arch/sh/include/asm/Kbuild
> +++ b/arch/sh/include/asm/Kbuild
> @@ -9,6 +9,7 @@ generic-y += emergency-restart.h
>  generic-y += exec.h
>  generic-y += irq_regs.h
>  generic-y += irq_work.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
> index eaa30bc..0ec45ff 100644
> --- a/arch/sh/include/uapi/asm/Kbuild
> +++ b/arch/sh/include/uapi/asm/Kbuild
> @@ -2,5 +2,4 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  generated-y += unistd_32.h
> -generic-y += kvm_para.h
>  generic-y += ucontext.h
> diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
> index b82f64e..a22cfd5 100644
> --- a/arch/sparc/include/asm/Kbuild
> +++ b/arch/sparc/include/asm/Kbuild
> @@ -9,6 +9,7 @@ generic-y += exec.h
>  generic-y += export.h
>  generic-y += irq_regs.h
>  generic-y += irq_work.h
> +generic-y += kvm_para.h
>  generic-y += linkage.h
>  generic-y += local.h
>  generic-y += local64.h
> diff --git a/arch/sparc/include/uapi/asm/kvm_para.h b/arch/sparc/include/uapi/asm/kvm_para.h
> deleted file mode 100644
> index baacc49..0000000
> --- a/arch/sparc/include/uapi/asm/kvm_para.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#include <asm-generic/kvm_para.h>
> diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
> index 1d1544b..d77d953 100644
> --- a/arch/unicore32/include/asm/Kbuild
> +++ b/arch/unicore32/include/asm/Kbuild
> @@ -18,6 +18,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
> diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
> index 0febf1a..c1b06dc 100644
> --- a/arch/unicore32/include/uapi/asm/Kbuild
> +++ b/arch/unicore32/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
> -generic-y += kvm_para.h
>  generic-y += ucontext.h
> diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
> index e255683..d474c34 100644
> --- a/arch/xtensa/include/asm/Kbuild
> +++ b/arch/xtensa/include/asm/Kbuild
> @@ -15,6 +15,7 @@ generic-y += irq_work.h
>  generic-y += kdebug.h
>  generic-y += kmap_types.h
>  generic-y += kprobes.h
> +generic-y += kvm_para.h
>  generic-y += linkage.h
>  generic-y += local.h
>  generic-y += local64.h
> diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> index 960bf1e..439f515 100644
> --- a/arch/xtensa/include/uapi/asm/Kbuild
> +++ b/arch/xtensa/include/uapi/asm/Kbuild
> @@ -1,4 +1,3 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  generated-y += unistd_32.h
> -generic-y += kvm_para.h
> diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
> index 5f24b50..059dc2b 100644
> --- a/include/uapi/linux/Kbuild
> +++ b/include/uapi/linux/Kbuild
> @@ -7,5 +7,7 @@ no-export-headers += kvm.h
>  endif
>  
>  ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/asm/kvm_para.h),)
> +ifeq ($(wildcard $(objtree)/arch/$(SRCARCH)/include/generated/uapi/asm/kvm_para.h),)
>  no-export-headers += kvm_para.h
>  endif
> +endif
> 

Thanks, queued for 5.2.

Paolo
