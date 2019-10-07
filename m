Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D707ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB202070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfJGPEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:04:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfJGPEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:04:33 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DD78B2800
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 15:04:33 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id c188so3440194wmd.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YEg7lP4ev+eAmAASdNoP10CUj57rL6PdHoSSAKLurOY=;
        b=ctHXW3AbXNL902rz9/0dbSiNTEfkTb31jEywkLrlIx1ClQHHhKWILYy2clZLti+w5+
         paFEAk4bGwl2VK039wPR51+gqUlQYY6l7NPqXPX8mj1w0HdAK5oL5DS2iOsZFpz6gdME
         RmD5qK+TrIUlw3nUXBEmAC66GXo4mxTYrf5+q1UwxgXYnNlw8BfPcERB01l67i//xqwT
         B5yzEx+4hGntUj2fm4k7lebQ+ZTrxywQD5hUGh0jZEYzbBIjaCy8zMXmVi1aH1LwMrFB
         dZjZ4itW5vmo901RONSpn6uPgLDGggaqJ4SJsIS/NSABqPs2cr7cXoCJbv3I6Y9iHBU1
         lsqA==
X-Gm-Message-State: APjAAAUjFbjLQDM2oVIEJLsGcxxft1M3OyqzrYtYpVoRV2mVDTxxQmyO
        baFLbh+dTH0343v5ybN07q9haxBf4mZOXd/iUIaSj00w5aaCaaG7ZQIaYXrZnDpgUYqRMmnp4A9
        Yghj1z8gTMhIB6NJHQpNvjx3m
X-Received: by 2002:adf:f58c:: with SMTP id f12mr19924704wro.38.1570460672080;
        Mon, 07 Oct 2019 08:04:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbyjiYR4AmtE+5fVQPV+uPZDcw6cypBQAOklECNdtSUHSRDFZcE+tmq5pGKtPDMoWdHRURJw==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr19924688wro.38.1570460671800;
        Mon, 07 Oct 2019 08:04:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2? ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
        by smtp.gmail.com with ESMTPSA id a71sm13969531wme.11.2019.10.07.08.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 08:04:31 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: synchronize .gitignore to Makefile
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20191007132656.19544-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <19953c09-96c1-0b7b-9146-3ad38bb765b6@redhat.com>
Date:   Mon, 7 Oct 2019 17:04:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007132656.19544-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/19 15:26, Vitaly Kuznetsov wrote:
> Because "Untracked files:" are annoying.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index b35da375530a..409c1fa75e03 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -1,4 +1,5 @@
>  /s390x/sync_regs_test
> +/s390x/memop
>  /x86_64/cr4_cpuid_sync_test
>  /x86_64/evmcs_test
>  /x86_64/hyperv_cpuid
> @@ -9,6 +10,7 @@
>  /x86_64/state_test
>  /x86_64/sync_regs_test
>  /x86_64/vmx_close_while_nested_test
> +/x86_64/vmx_dirty_log_test
>  /x86_64/vmx_set_nested_state_test
>  /x86_64/vmx_tsc_adjust_test
>  /clear_dirty_log_test
> 

Queued, thanks.

Paolo
