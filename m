Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C4C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AEC206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfIQNdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfIQNdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:33:06 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEE8414AFB6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:33:05 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id h6so1269229wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cg3dvAt0VFzmUN1YPgL+dPK2myjZsUUL53Sl0WEidEk=;
        b=ZikR31uFT3F0b3+OTsGzgzKteUWjrA2c5DcDhjSYvKuXL+2ZCW3PZ/Y4mAeaqcoCxd
         s1hcpzd0UiMUwJVscSEBL7zTrBuYuZ0fvP0aXijjIJC03BHPSZz/IKKACiuRT7GnB6gl
         RyyBToq/adqj7+8whzT6F8HbNF6TZoWxruSneUOiLkgOJgRnVGkErrug6aTR4qeuYZfC
         dLlbJUXf/UMZAZH+GRwD7NViPD3851MQy4cC7I55UTMForNCN+O8I7Rk9q5AusHUs6gr
         3S3IiugsU4EOxnJh6TouRclC7dqx6o49ZF1ItVG5RtIUw714atdtwSt2yt4oSyblPiId
         A3Fw==
X-Gm-Message-State: APjAAAWkoxbVqFhZGifVOqi3RNKH+aJEXYPeNHDQWsDoQOoxReIdIGof
        OIRKWBsOn4NkDOF0Wrx1AE6s8x0P9wgYOKd85Wcqzh/si0ZUYEqDDYDaO6WEYfHeaizyRfHxQXy
        5gMb35qQpNIS0ImfGKRCsHo7f
X-Received: by 2002:a05:6000:10ce:: with SMTP id b14mr2946366wrx.96.1568727184403;
        Tue, 17 Sep 2019 06:33:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwVIUY09eaidUdU2ahcWvWN6d65X3WK1nbAqCtgATGj0PFVUNV5ady3K77sD3EYpOtdpgtYGA==
X-Received: by 2002:a05:6000:10ce:: with SMTP id b14mr2946350wrx.96.1568727184137;
        Tue, 17 Sep 2019 06:33:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id c8sm2624551wrr.49.2019.09.17.06.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:33:03 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] KVM: selftests: Introduce VM_MODE_PXXV48_4K
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>
References: <20190830013619.18867-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3e648108-c82a-6505-a1eb-01c6a7caa175@redhat.com>
Date:   Tue, 17 Sep 2019 15:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830013619.18867-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/19 03:36, Peter Xu wrote:
> v3:
> - pick r-b
> - refine DEBUG macro [Drew]
> 
> v2:
> - pick r-bs
> - rebased to master
> - fix pa width detect, check cpuid(1):edx.PAE(bit 6)
> - fix arm compilation issue [Drew]
> - fix indents issues and ways to define macros [Drew]
> - provide functions for fetching cpu pa/va bits [Drew]
> 
> This series originates from "[PATCH] KVM: selftests: Detect max PA
> width from cpuid" [1] and one of Drew's comments - instead of keeping
> the hackish line to overwrite guest_pa_bits all the time, this series
> introduced the new mode VM_MODE_PXXV48_4K for x86_64 platform.
> 
> The major issue is that even all the x86_64 kvm selftests are
> currently using the guest mode VM_MODE_P52V48_4K, many x86_64 hosts
> are not using 52 bits PA (and in most cases, far less).  If with luck
> we could be having 48 bits hosts, but it's more adhoc (I've observed 3
> x86_64 systems, they are having different PA width of 36, 39, 48).  I
> am not sure whether this is happening to the other archs as well, but
> it probably makes sense to bring the x86_64 tests to the real world on
> always using the correct PA bits.
> 
> A side effect of this series is that it will also fix the crash we've
> encountered on Xeon E3-1220 as mentioned [1] due to the
> differenciation of PA width.
> 
> With [1], we've observed AMD host issues when with NPT=off.  However a
> funny fact is that after I reworked into this series, the tests can
> instead pass on both NPT=on/off.  It could be that the series changes
> vm->pa_bits or other fields so something was affected.  I didn't dig
> more on that though, considering we should not lose anything.
> 
> [1] https://lkml.org/lkml/2019/8/26/141
> 
> Peter Xu (4):
>   KVM: selftests: Move vm type into _vm_create() internally
>   KVM: selftests: Create VM earlier for dirty log test
>   KVM: selftests: Introduce VM_MODE_PXXV48_4K
>   KVM: selftests: Remove duplicate guest mode handling
> 
>  tools/testing/selftests/kvm/dirty_log_test.c  | 79 +++++--------------
>  .../testing/selftests/kvm/include/kvm_util.h  | 18 ++++-
>  .../selftests/kvm/include/x86_64/processor.h  |  3 +
>  .../selftests/kvm/lib/aarch64/processor.c     |  3 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 67 ++++++++++++----
>  .../selftests/kvm/lib/x86_64/processor.c      | 30 ++++++-
>  6 files changed, 121 insertions(+), 79 deletions(-)
> 

Queued, thanks.

Paolo
