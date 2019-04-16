Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F74C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004D12077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfDPLl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:41:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53000 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbfDPLl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:41:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126FC15A2;
        Tue, 16 Apr 2019 04:41:26 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2206F3F68F;
        Tue, 16 Apr 2019 04:41:23 -0700 (PDT)
Date:   Tue, 16 Apr 2019 12:41:21 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
Subject: Re: [PATCH v2 1/3] arm64/fpsimd: Remove the prototype for
 sve_flush_cpu_state()
Message-ID: <20190416114118.GK3567@e103592.cambridge.arm.com>
References: <20190412171420.29065-1-julien.grall@arm.com>
 <20190412171420.29065-2-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412171420.29065-2-julien.grall@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 06:14:18PM +0100, Julien Grall wrote:
> The function sve_flush_cpu_state() has been removed in commit
> 21cdd7fd76e3 "KVM: arm64: Remove eager host SVE state saving".
> 
> So remove the associated prototype in asm/fpsimd.h.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>

Good spot, thanks.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> ---
>     Changes in v2:
>         - Patch added
> ---
>  arch/arm64/include/asm/fpsimd.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index ad6d2e41eb37..32abbfd852e8 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -64,7 +64,6 @@ extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
>  
>  extern void fpsimd_flush_task_state(struct task_struct *target);
>  extern void fpsimd_flush_cpu_state(void);
> -extern void sve_flush_cpu_state(void);
>  
>  /* Maximum VL that SVE VL-agnostic software can transparently support */
>  #define SVE_VL_ARCH_MAX 0x100
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
