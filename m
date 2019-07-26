Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B51C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2167122BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfGZWKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:10:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35620 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfGZWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:10:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so55854900wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 15:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3uH6wRDL6m6XJhTTMaf9vseYu7YZD/ywsLcXQB/jjqU=;
        b=r5Of8k9B/95usG5WVZQCp3mmF12PzwRanh3NLv/KV64klIywSD9QNgR+12LVaR+eoF
         meDT2YqBPuGSy/xhnzq4Px3CbMSpY+b3ehUXv2y0Vk7BkqxhU81YTGZDb2KGDI8G3dfi
         Xa1FxUZUml67tfJDoX6vKzSW5Du3BGnkXGQCzIACtXWC3/gVNQkq18UxUEiNMWRQKSd8
         mTQn177GsJoZkZGDTUTDpHjv/9LXRspfVrQZu4HJETbxOJyVFePmb/peTH3HzbH6zjCL
         EIf0Uaesg/9qDgF2XsxK4dmuhr94UjyeHypi4D67aOcnyjo4A4Dp157Z7i8599B5WUYc
         Qbuw==
X-Gm-Message-State: APjAAAU2kAz8iE1mlQHvvtYY/2ASqU7Mey922CVxnDLRuwKchbvQPWbw
        bPzfg7/E5xUFKqei9i5OJvJZ6WruVuw=
X-Google-Smtp-Source: APXvYqzcff0a62xyZ1uFR2gsycPFMbRcnCLACAl1fTNDob/Jl6sm3/hEJ5mjpbBEtl+zmxqlsSDf9A==
X-Received: by 2002:a5d:568e:: with SMTP id f14mr22603718wrv.167.1564179033572;
        Fri, 26 Jul 2019 15:10:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9036:7130:d6ec:a346? ([2001:b07:6468:f312:9036:7130:d6ec:a346])
        by smtp.gmail.com with ESMTPSA id k9sm37976888wmi.33.2019.07.26.15.10.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 15:10:33 -0700 (PDT)
Subject: Re: [PATCH] Documentation: move Documentation/virtual to
 Documentation/virt
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christoph Hellwig <hch@lst.de>, rkrcmar@redhat.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190724072449.19599-1-hch@lst.de>
 <b9baabbb-9e9b-47cf-f5a8-ea42ba1ddc25@redhat.com>
 <20190724120005.31a990af@lwn.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <be4ba4a7-a21b-8c56-4517-8886a754ff55@redhat.com>
Date:   Sat, 27 Jul 2019 00:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724120005.31a990af@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/19 20:00, Jonathan Corbet wrote:
>  - kvm/api.txt pretty clearly belongs in the userspace-api book, rather
>    than tossed in with:
> 
>  - kvm/review-checklist.txt, which belongs in the subsystem guide, if only
>    we'd gotten around to creating it yet, or
> 
>  - kvm/mmu.txt, which is information for kernel developers, or
> 
>  - uml/UserModeLinux-HOWTO.txt, which belongs in the admin guide.
> 
> I suspect that organization is going to be one of the main issues to talk
> about in Lisbon.  Meanwhile, I hope that this rename won't preclude
> organizational work in the future.

Absolutely not, this rename was just about a badly-named directory.  I
totally agree with the above reorganization.  Does the userspace API
cover only syscall or perhaps sysfs interfaces?   There are more API
files (amd-memory-encryption.txt, cpuid.txt, halt-polling.txt msr.txt,
ppc-pv.txt, s390-diag.txt) but, with the exception of
amd-memory-encryption.txt and halt-polling.txt, they cover the
emulated-hardware interfaces that KVM provides to virtual machines.

Paolo
