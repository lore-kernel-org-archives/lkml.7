Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08838C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9BD21841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfI0QGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbfI0QGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:06:12 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED90C4FCD9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 16:06:11 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id z1so1295293wrw.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tlYFE41qduUsi9igPqMAFQ5dqyYqpx0jVUAbChdW/Eo=;
        b=aJ8VsNxncC9d2zK7/60VkimsSXsOwdVQacZX1ACr4dRhmDKyiq41XtJ8SQFnBxiQu7
         HtYe7JueR9neNFdZLFsznIV7y5kIXFitU/mq1JaCn7KfFGbtiAP+G02DteqJevCs+dA6
         paQ+ZQMkJVDsCGQqGmsk0m7DwVz/Zpr4BrLcugnxh3WIrBQgIdGlCP9Zh6c2+Qj1uYmm
         rF3nUBN3Br/t6MHQzQePq+14843e+XzixLyNzhO0cieG9LWTibx9oGIgkmXrkceeCT31
         gxebIqxp9a2hJ5YndMN3DqX1ssVF/BIQ7fcSHdmw1yS6coD/2Eb7vayUcg0S+Az5U+h3
         /gVw==
X-Gm-Message-State: APjAAAWHpDHxTEzStZYGqXstgeBe8tqa3btKv3qywguWvmejceloKFU2
        fmBZjhgdPgng3QaFwHq9iZGERkStsZHjm4W9WmLPxwFQ7rLvtpBmPSWMw6LR9C3oQJ2lamM+ADM
        9R1Zo2lHZSir0OP7RqDUGYyjr
X-Received: by 2002:a1c:3281:: with SMTP id y123mr7358548wmy.34.1569600370619;
        Fri, 27 Sep 2019 09:06:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFArU+p/KU2rbV17Ovb/ZTBtvnhY/hp2ypmjzNk5cpIipG3YqAAMHsuxC4y7l1J9dVv8+MFQ==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr7358526wmy.34.1569600370301;
        Fri, 27 Sep 2019 09:06:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id h17sm17822385wme.6.2019.09.27.09.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 09:06:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: x86: clarify what is reported on
 KVM_GET_MSRS failure
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
References: <20190927155413.31648-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9af23f2e-6f82-e597-abec-ee69c9735faa@redhat.com>
Date:   Fri, 27 Sep 2019 18:06:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927155413.31648-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/19 17:54, Vitaly Kuznetsov wrote:
> When KVM_GET_MSRS fail the report looks like
> 
> ==== Test Assertion Failure ====
>   lib/x86_64/processor.c:1089: r == nmsrs
>   pid=28775 tid=28775 - Argument list too long
>      1	0x000000000040a55f: vcpu_save_state at processor.c:1088 (discriminator 3)
>      2	0x00000000004010e3: main at state_test.c:171 (discriminator 4)
>      3	0x00007fb8e69223d4: ?? ??:0
>      4	0x0000000000401287: _start at ??:?
>   Unexpected result from KVM_GET_MSRS, r: 36 (failed at 194)
> 
> and it's not obvious that '194' here is the failed MSR index and that
> it's printed in hex. Change that.
> 
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index c53dbc6bc568..6698cb741e10 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1085,7 +1085,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
>  	for (i = 0; i < nmsrs; i++)
>  		state->msrs.entries[i].index = list->indices[i];
>  	r = ioctl(vcpu->fd, KVM_GET_MSRS, &state->msrs);
> -        TEST_ASSERT(r == nmsrs, "Unexpected result from KVM_GET_MSRS, r: %i (failed at %x)",
> +        TEST_ASSERT(r == nmsrs, "Unexpected result from KVM_GET_MSRS, r: %i (failed MSR was 0x%x)",
>                  r, r == nmsrs ? -1 : list->indices[r]);
>  
>  	r = ioctl(vcpu->fd, KVM_GET_DEBUGREGS, &state->debugregs);
> 

Queued, thanks.

Paolo
