Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A3CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE0F2067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfKHTvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:51:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731864AbfKHTvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:51:07 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD301C04BD48
        for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2019 19:51:06 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id u2so3870915wrm.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 11:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HVIeOx6nzmd9djN2e4574H+maZm9DfsxWD4R9Q206x0=;
        b=o6U9lIBo0vWK98k70k1YCIAnki23OjzLILoDLQs6PDhq57VpgGByEsnT6yy2f2kgtD
         Xk41/+5nftt4tcH3Pj4NJuqS+/tLvD08jouqQ8F+JSam5la10CCzYPk1uDnDX4LJeZ+8
         oDaJzH7NSW0rrxg91gYVrlFjvgjYEwjzj7PPLTnWtNYnqGdEHN/jty26uRFGnsrEIsGJ
         9xZqklXViXWaM1CISY9koIQ+0a379k93FvcsGq4jsCZ70Tl4TIMfwVXjrFoUuY9d7YLm
         mYDwdxWtJJePjm+0QcGhpGhHn6uH7e0tsKt/5ls5NdBJBZmSY5HkZPwV1NWWVKvWloJ9
         EMUg==
X-Gm-Message-State: APjAAAUsWzjpwgNQZf4s7bVCua7d1QD4lOL83GZ3JWfPMH6GJYt66nDc
        8ru5XlOi0T1C/vEav2fkuL1aUQGTA0CEfIi6kUa8i99KKOpC9KgMTYn8fEr8IIQULJd0amcxuQ6
        tO9J7+mgJzquHnj/sJ3eVRc5a
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr10517844wrv.216.1573242665047;
        Fri, 08 Nov 2019 11:51:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwh5QagsORgLMSC6facSW636Vhv994NNhYmi82cn5LKJsrOsA8bp3Br/6du+5NcGEbfP/45g==
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr10517822wrv.216.1573242664769;
        Fri, 08 Nov 2019 11:51:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e8cd:9f0f:a5dc:7ad5? ([2001:b07:6468:f312:e8cd:9f0f:a5dc:7ad5])
        by smtp.gmail.com with ESMTPSA id y16sm6599496wro.25.2019.11.08.11.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:51:04 -0800 (PST)
Subject: Re: [PATCH 03/13] kvm: monolithic: fixup x86-32 build
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-4-aarcange@redhat.com>
 <6ed4a5cd-38b1-04f8-e3d5-3327a1bd5d87@redhat.com>
 <678358c1-0621-3d2a-186e-b60742b2a286@redhat.com>
 <20191105135414.GA30717@redhat.com>
 <330acce5-a527-543b-84c0-f3d8d277a0e2@redhat.com>
 <20191105145651.GD30717@redhat.com>
 <ab18744b-afc7-75d4-b5f3-e77e9aae41a6@redhat.com>
 <20191108135631.GA22507@linux-8ccs>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b77283e5-a4bc-1849-fbfa-27741ab2dbd5@redhat.com>
Date:   Fri, 8 Nov 2019 20:51:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191108135631.GA22507@linux-8ccs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/19 14:56, Jessica Yu wrote:
> And I am
> not sure what Masahiro (who takes care of all things kbuild-related)
> thinks of this idea. But before implementing all this, is there
> absolutely no way around having the duplicated exported symbols? (e.g.,
> could the modules be configured/built in a mutally exclusive way? I'm
> lacking the context from the rest of the thread, so not sure which are
> the problematic modules.)

The problematic modules are kvm_intel and kvm_amd, so we cannot build
them in a mutually exclusive way (but we know it won't make sense to
load both).  We will have to build only one of them when built into
vmlinux, but the module case must support building both.

Currently we put the common symbols in kvm.ko, and kvm.ko acts as a kind
of "library" for kvm_intel.ko and kvm_amd.ko.  The problem is that
kvm_intel.ko and kvm_amd.ko currently pass a large array of function
pointers to kvm.ko, and Andrea measured a substantial performance
penalty from retpolines when kvm.ko calls back through those pointers.

Therefore he would like to remove kvm.ko, and that would result in
symbols exported from two modules.

I suppose we could use code patching mechanism to avoid the retpolines.
 Andrea, what do you think about that?  That would have the advantage
that we won't have to remove kvm_x86_ops. :)

Thanks,

Paolo
