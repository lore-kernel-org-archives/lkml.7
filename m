Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE2BC49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B25920872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437018AbfIJRF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436845AbfIJRF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:05:59 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C00D8369AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:05:58 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 1so58583wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jTN7yrs5BImP0ztJITVPxIbvfd1nbau/x4aKAUJCsuo=;
        b=csm7vJJPasue4H8vm+o3zQgtold8WyNnLtHhiWveG+plc/QPZbu/vPYUP6Ci8c6tM6
         StNbDQpLnAzksREySgflGxP8c5Fbk3nylxwxmz+PIkAWRx0RLw1I5LOiLmrKo6PhpKHw
         q6YEpboamLe3SjfqwoF9wLn8HTDujyotzUz2N6d2XbAh2lVQiZz0FnDBsMLbmHu7oM5w
         7chEsDlFQD6k0yQTVlYhjyDu5uq0hngBGQQnPXSB6FSB8fiilYl/JdnP1stmgDfr29IU
         Oqe4MA1275IBXtzhJRjJN3ItplYcwWvhtpD1fbnS4lLRvCd1KS1kSsHhYuAkESlrQDqX
         KdFg==
X-Gm-Message-State: APjAAAWtzYkKRPSD9oRUO1cuL+/1S1ICcuou1SpGSBHgnPE0TA+GbgvO
        C2aww33MSVHzep4vtFnpdDRbCTrM8HBJkJEjaKH5RZhaRON2dxWLko96C2FRI2/asei54ta1Bxf
        YATRCeB/GMMH4p9IF0LKMYf3d
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr438450wma.120.1568135157320;
        Tue, 10 Sep 2019 10:05:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxDDrxFlAzzHxvk36XY/616PH7XZzouT/DdV+oNbe4DLA1Luuuk6vcsXkVP+/0EEEsUzxtZZA==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr438412wma.120.1568135156940;
        Tue, 10 Sep 2019 10:05:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1435:25df:c911:3338? ([2001:b07:6468:f312:1435:25df:c911:3338])
        by smtp.gmail.com with ESMTPSA id r20sm24253567wrg.61.2019.09.10.10.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 10:05:56 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] KVM: X86: Some tracepoint enhancements
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
References: <20190906021722.2095-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <77e8aced-545f-24c6-6952-2f73a2231ce1@redhat.com>
Date:   Tue, 10 Sep 2019 19:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906021722.2095-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/19 04:17, Peter Xu wrote:
> v4:
> - pick r-b
> - swap the last two patches [Sean]
> 
> v3:
> - use unsigned int for vcpu id [Sean]
> - a new patch to fix ple_window type [Sean]
> 
> v2:
> - fix commit messages, change format of ple window tracepoint [Sean]
> - rebase [Wanpeng]
> 
> Each small patch explains itself.  I noticed them when I'm tracing
> some IRQ paths and I found them helpful at least to me.
> 
> Please have a look.  Thanks,
> 
> Peter Xu (4):
>   KVM: X86: Trace vcpu_id for vmexit
>   KVM: X86: Remove tailing newline for tracepoints
>   KVM: VMX: Change ple_window type to unsigned int
>   KVM: X86: Tune PLE Window tracepoint
> 
>  arch/x86/kvm/svm.c     | 16 ++++++++--------
>  arch/x86/kvm/trace.h   | 34 ++++++++++++++--------------------
>  arch/x86/kvm/vmx/vmx.c | 18 ++++++++++--------
>  arch/x86/kvm/vmx/vmx.h |  2 +-
>  arch/x86/kvm/x86.c     |  2 +-
>  5 files changed, 34 insertions(+), 38 deletions(-)
> 

Queued, thanks.

Paolo
