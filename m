Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02567C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C468920700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfC1LnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:43:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33754 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfC1LnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:43:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id bg8so4826906plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 04:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mX3ZNmbz3E6bL5fB7CSied1YiiuhskRa10DQGDO03lU=;
        b=i7UZ78OAtSb6ZZ0KIa1GJPZ95yQFApcFN9xutCgK3xOiAoLm6RMnhOZxqyWjdQ4gZI
         jfaZL5rwA4HML7yymMuqA2nagxjSUMjslQuB0DhxVyPK+XJuZZTJ6CJKAAWHkPcEKNkY
         o1jsZAWJy0EGtoxIDu48bxO1EnQzJQGEF69wITvNZiZf64Mgl1h9zdPlN0d3JK9B35Lm
         VrozAWJV225IhtRqcdehkW1nuDVWaQBBUVnD2fwMKTOmtDMRVvhhIr9uvsDiN+PWVS/g
         i654jPaj2GC0k79x4V2qeK9g5z48KKrk3IGBqH9+eAaVGPOr1QXU97jAIVGsLKYrY2Ta
         ManQ==
X-Gm-Message-State: APjAAAXiECC96jBhjmhzl0n1r//m5zpgchRzje+LLfkLfkcMirNccwTX
        547cajoAjFyq/wb6l1xJs+q2gA==
X-Google-Smtp-Source: APXvYqx2A/TMNggwE78YrfUH0fDr/fcDZP/WCS0MCJdq8x+BUtnpTpTABRNJYX9aZ5YVEP9gLm832w==
X-Received: by 2002:a17:902:bb92:: with SMTP id m18mr25270650pls.316.1553773382483;
        Thu, 28 Mar 2019 04:43:02 -0700 (PDT)
Received: from localhost.localdomain ([182.69.197.66])
        by smtp.gmail.com with ESMTPSA id i24sm19437197pfo.85.2019.03.28.04.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 04:43:01 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Steve Capper <Steve.Capper@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <58c6cda9-9fd4-3b3e-740a-7b9b80b1f634@redhat.com>
Date:   Thu, 28 Mar 2019 17:12:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for your review. Please see my comments inline:

On 03/26/2019 10:06 PM, James Morse wrote:
> Hi Bhupesh,
> 
> On 20/03/2019 05:09, Bhupesh Sharma wrote:
>> With ARMv8.2-LVA architecture extension availability, arm64 hardware
>> which supports this extension can support a virtual address-space upto
>> 52-bits.
>>
>> Since at the moment we enable the support of this extension in kernel
>> via CONFIG flags, e.g.
>>   - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52
>>
>> so, there is no clear mechanism in the user-space right now to
>> determine these CONFIG flag values and hence determine the maximum
>> virtual address space supported by the underlying kernel.
>>
>> User-space tools like 'makedumpfile' therefore are broken currently
>> as they have no proper method to calculate the 'PTRS_PER_PGD' value
>> which is required to perform a page table walk to determine the
>> physical address of a corresponding virtual address found in
>> kcore/vmcoreinfo.
>>
>> If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
>> it can be used in user-space to determine the maximum virtual address
>> supported by underlying kernel.
> 
> I don't think this really solves the problem, it feels fragile.
> 
> I can see how vmcoreinfo tells you VA_BITS==48, PAGE_SIZE==64K and PTRS_PER_PGD=1024.
> You can use this to work out that the top level page table size isn't consistent with a
> 48bit VA, so 52bit VA must be in use...
> 
> But wasn't your problem walking the kernel page tables? In particular the offset that we
> apply because the tables were based on a 48bit VA shifted up in swapper_pg_dir.
> 
> Where does the TTBR1_EL1 offset come from with this property? I assume makedumpfile
> hard-codes it when it sees 52bit is in use ... somewhere.
> We haven't solved the problem!

But isn't the TTBR1_EL1 offset already appended by the kernel via 
e842dfb5a2d3 ("arm64: mm: Offset TTBR1 to allow 52-bit PTRS_PER_PGD")
in case of kernel configuration where 52-bit userspace VAs are possible.

I copy a snippet from the git log of the above from Steve, which 
explains the above:

"   In other words a 48-bit kernel virtual address will have a different
     pgd_index when using PTRS_PER_PGD = 64 and 1024.

     If, however, we note that:
     kva = 0xFFFF << 48 + lower (where lower[63:48] == 0b)
     and, PGDIR_SHIFT = 42 (as we are dealing with 64KB PAGE_SIZE)

     We can consider:
     (kva >> PGDIR_SHIFT) & (1024 - 1) - (kva >> PGDIR_SHIFT) & (64 - 1)
      = (0xFFFF << 6) & 0x3FF - (0xFFFF << 6) & 0x3F     // "lower" 
cancels out
      = 0x3C0

     In other words, one can switch PTRS_PER_PGD to the 52-bit value 
globally
     provided that they increment ttbr1_el1 by 0x3C0 * 8 = 0x1E00 bytes when
     running with 48-bit kernel VAs (TCR_EL1.T1SZ = 16).

     For kernel configuration where 52-bit userspace VAs are possible, this
     patch offsets ttbr1_el1 and sets PTRS_PER_PGD corresponding to the
     52-bit value.
"

Accordingly we have the following assembler helper in 
'arch/arm64/include/asm/assembler.h':

        .macro  offset_ttbr1, ttbr
#ifdef CONFIG_ARM64_52BIT_VA
        orr     \ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
#endif
        .endm

where:
#ifdef CONFIG_ARM64_52BIT_VA
/* Must be at least 64-byte aligned to prevent corruption of the TTBR */
#define TTBR1_BADDR_4852_OFFSET        (((UL(1) << (52 - PGDIR_SHIFT)) - \
                                 (UL(1) << (48 - PGDIR_SHIFT))) * 8)
#endif

And before any load TTBR1 operation in the kernel we offset ttbr1_el1, 
in case CONFIG_ARM64_52BIT_VA is true, for e.g in 
'arch/arm64/kernel/head.S':

ENTRY(__enable_mmu)
<..snip..>
	offset_ttbr1 x1
         msr     ttbr1_el1, x1                   // load TTBR1
<..snip..>

So, the user-space (makedumpfile, for e.g.), just needs to know the 
PTRS_PER_PGD value and it can calculate the pgd_index for a virtual 
address using the following formula:

pgd_index(vaddr) = (((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1));

Note that the above computation holds true both for PTRS_PER_PGD = 64 
(48-bit kernel with 48-bit User VA) and 1024 (48-bit with 52-bit User 
VA) cases. And these are the configurations for which we are trying to 
fix the user-space regressions reported (on arm64) recently.

> Today __cpu_setup() sets T0SZ and T1SZ differently for 52bit VA, but in the future it
> could set them the same, or different the other-way-round.
> 
> Will makedumpfile using this value keep working once T1SZ is 52bit VA too? In this case
> there would be no ttbr offset.
 >
> If you need another vmcoreinfo flag once that happens, we've done something wrong here.

I am currently experimenting with Steve's patches for 52-bit kernel VA 
(<https://lwn.net/Articles/780093/>) and will comment more on the same 
when I am able to get the user-space utilities like makedumpfile and 
kexec-tools to work with the same on both ARMv8 Fast Simulator model and 
older CPUs which don't support ARMv8.2 extensions.

However, I think we should not hold up fixes for regressions already 
reported, because the 52-bit kernel VA changes probably still need some 
more rework.

> (Not to mention what happens if the TTBR1_EL1 uses 52bit va, but TTBR0_EL1 doesn't)

I am wondering if there are any real users of the above combination.

So far, I have generally come across discussions where the following 
variations of the address spaces have been proposed/requested:
- 48bit kernel VA + 48-bit User VA,
- 48-bit kernel VA + 52-bit User VA,
- 52-bit kernel VA + 52-bit User VA.

Thanks,
Bhupesh

>> Suggested-by: Steve Capper <Steve.Capper@arm.com>
> 
> (CC: +Steve)
> 
> 
> Thanks,
> 
> James
> 

