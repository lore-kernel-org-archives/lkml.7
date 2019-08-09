Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBEBC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491812086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405902AbfHIHsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:48:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405567AbfHIHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:48:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so97438426wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aRURCPsR50XeHaMxy4aGY+5TvqUSmUNLHU5PV2hq+Sc=;
        b=ZzanjQIKhWXOoLXP9gaT/i0YLvfiiVshP7kkBwxFnetDhlpctc/vuoKxGeydBKs5Ga
         ChnLDdd6aVDq9mjHp+jrkMBHr9/CjMaQnbLPNKr7fODylH2ppX7zom94yKZNzt4291sI
         dSga5twwdX077siCX6TUp46z7s7IeyH+ftO3XFMEwu5QtBW9NZewl/lAcuZKgCp+wn0L
         8Igt1mFZqtqybuAgAeAUscP2kyMXVdKAEOUa7dNk8pmvlCnGNy+WoCNkCF7RbQRMlbZt
         RM3kIqcF/OKi3qoRYB5Zqsi6E7wCkPm+5gwzB4Na8fjrSrbY97P+s/bgVMHROP8taQLr
         MT1Q==
X-Gm-Message-State: APjAAAXC3yibZXH8HbUe4x1yUF24/EJKWN64hb0mdxZWjJPsLUdEz11q
        e7WW0heXLb2TyyEYpzLExKaCjg==
X-Google-Smtp-Source: APXvYqwpqMiVUAPU8g9ahDmvVPjC05yU9bGUo5wuD9h15WS1oaYHAqTh2qJ2IidOMMi9/fG1axdPoQ==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr21487207wrn.257.1565336886420;
        Fri, 09 Aug 2019 00:48:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id l8sm194121076wrg.40.2019.08.09.00.48.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:48:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] MAINTAINERS: add KVM x86 reviewers
In-Reply-To: <1565336051-31793-1-git-send-email-pbonzini@redhat.com>
References: <1565336051-31793-1-git-send-email-pbonzini@redhat.com>
Date:   Fri, 09 Aug 2019 09:48:04 +0200
Message-ID: <875zn6dbkb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> This is probably overdone---KVM x86 has quite a few contributors that
> usually review each other's patches, which is really helpful to me.
> Formalize this by listing them as reviewers.  I am including people
> with various expertise:
>
> - Joerg for SVM (with designated reviewers, it makes more sense to have
> him in the main KVM/x86 stanza)
>
> - Sean for MMU and VMX
>

Sean is known to be a great SVM reviewer too!

> - Jim for VMX
>
> - Vitaly for Hyper-V and possibly SVM
>
> - Wanpeng for LAPIC and paravirtualization.
>
> Please ack if you are okay with this arrangement, otherwise speak up.
>
> In other news, Radim is going to leave Red Hat soon.  However, he has
> not been very much involved in upstream KVM development for some time,
> and in the immediate future he is still going to help maintain kvm/queue
> while I am on vacation.  Since not much is going to change, I will let
> him decide whether he wants to keep the maintainer role after he leaves.
>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6498ebaca2f6..c569bd194d2a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8738,14 +8738,6 @@ F:	virt/kvm/*
>  F:	tools/kvm/
>  F:	tools/testing/selftests/kvm/
>  
> -KERNEL VIRTUAL MACHINE FOR AMD-V (KVM/amd)
> -M:	Joerg Roedel <joro@8bytes.org>
> -L:	kvm@vger.kernel.org
> -W:	http://www.linux-kvm.org/
> -S:	Maintained
> -F:	arch/x86/include/asm/svm.h
> -F:	arch/x86/kvm/svm.c
> -
>  KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64)
>  M:	Marc Zyngier <marc.zyngier@arm.com>
>  R:	James Morse <james.morse@arm.com>
> @@ -8803,6 +8795,11 @@ F:	tools/testing/selftests/kvm/*/s390x/
>  KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
>  M:	Paolo Bonzini <pbonzini@redhat.com>
>  M:	Radim Krčmář <rkrcmar@redhat.com>
> +R:	Sean Christopherson <sean.j.christopherson@intel.com>
> +R:	Vitaly Kuznetsov <vkuznets@redhat.com>

Acked-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> +R:	Wanpeng Li <wanpengli@tencent.com>
> +R:	Jim Mattson <jmattson@google.com>
> +R:	Joerg Roedel <joro@8bytes.org>
>  L:	kvm@vger.kernel.org
>  W:	http://www.linux-kvm.org
>  T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> @@ -8810,8 +8807,12 @@ S:	Supported
>  F:	arch/x86/kvm/
>  F:	arch/x86/kvm/*/
>  F:	arch/x86/include/uapi/asm/kvm*
> +F:	arch/x86/include/uapi/asm/vmx.h
> +F:	arch/x86/include/uapi/asm/svm.h
>  F:	arch/x86/include/asm/kvm*
>  F:	arch/x86/include/asm/pvclock-abi.h
> +F:	arch/x86/include/asm/svm.h
> +F:	arch/x86/include/asm/vmx.h
>  F:	arch/x86/kernel/kvm.c
>  F:	arch/x86/kernel/kvmclock.c

-- 
Vitaly
