Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D4FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC2320870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfCYJ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:58:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbfCYJ6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:58:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3980715AB;
        Mon, 25 Mar 2019 02:58:15 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47C53F614;
        Mon, 25 Mar 2019 02:58:11 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: Comments cleanup in mmu.c
To:     yuzenghui@huawei.com, christoffer.dall@arm.com,
        marc.zyngier@arm.com
Cc:     james.morse@arm.com, julien.thierry@arm.com,
        wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1553500925-26000-1-git-send-email-yuzenghui@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <194b5370-0ed2-5dbd-9a5d-e20e4f8413ec@arm.com>
Date:   Mon, 25 Mar 2019 09:58:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553500925-26000-1-git-send-email-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/03/2019 08:02, Zenghui Yu wrote:
> Some comments in virt/kvm/arm/mmu.c are outdated and incorrect.
> Get rid of these comments, to keep the code&comment correct and
> current as a whole.
> 
> Only a cleanup here, no functional change.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   virt/kvm/arm/mmu.c | 23 +++++++++--------------
>   1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index ffd7acd..0a6efe7 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -102,8 +102,7 @@ static bool kvm_is_device_pfn(unsigned long pfn)
>    * @addr:	IPA
>    * @pmd:	pmd pointer for IPA
>    *
> - * Function clears a PMD entry, flushes addr 1st and 2nd stage TLBs. Marks all
> - * pages in the range dirty.
> + * Function clears a PMD entry, flushes addr 1st and 2nd stage TLBs.
>    */
>   static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
>   {
> @@ -121,8 +120,7 @@ static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
>    * @addr:	IPA
>    * @pud:	pud pointer for IPA
>    *
> - * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs. Marks all
> - * pages in the range dirty.
> + * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs.
>    */
>   static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pudp)
>   {
> @@ -899,9 +897,8 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
>    * kvm_alloc_stage2_pgd - allocate level-1 table for stage-2 translation.
>    * @kvm:	The KVM struct pointer for the VM.
>    *
> - * Allocates only the stage-2 HW PGD level table(s) (can support either full
> - * 40-bit input addresses or limited to 32-bit input addresses). Clears the
> - * allocated pages.
> + * Allocates only the stage-2 HW PGD level table(s) of size defined by
> + * stage2_pgd_size(kvm).
>    *
>    * Note we don't need locking here as this is only called when the VM is
>    * created, which can only be done once.
> @@ -1451,13 +1448,11 @@ static void stage2_wp_pmds(struct kvm *kvm, pud_t *pud,
>   }
>   
>   /**
> -  * stage2_wp_puds - write protect PGD range
> -  * @pgd:	pointer to pgd entry
> -  * @addr:	range start address
> -  * @end:	range end address
> -  *
> -  * Process PUD entries, for a huge PUD we cause a panic.
> -  */
> + * stage2_wp_puds - write protect PGD range
> + * @pgd:	pointer to pgd entry
> + * @addr:	range start address
> + * @end:	range end address
> + */


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
