Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBF3C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D332080D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfFTNSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:18:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37121 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbfFTNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:18:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so3151068wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GCMRRsAPTDkb7BUWGSo1gQlzzv4GcqeIfZdRd482QY0=;
        b=HMQsSi+ba7cEilQfd5KpUUuXmzO8cgetlCUYhUDiAjrI5zmZIqRPMBgNaNH3olLkl4
         SXSby29oD/piE97Tff6USds0D9bUKMXB89aHOg18WS5efU8tZXQyCbmoBV029EWH6Hxv
         IoFADe7o6R4XMfZG7uV6cGmxiCyM6SGUg3HvqP2yP4yWIg28D6yRxx2WQoAn5JXGoear
         42UvgjYiD+CDoheThNaQ12fyOyLMVd0kIJhdGQxw2OAsj/XHNP1iqjbjFeeDlMz5h7go
         +XDnEyXE5BfeCUsmAyAXlSnfIKVwvv63WkeENfXA71HSayVQDBub+dNRjkMqzWrowGeU
         GJDg==
X-Gm-Message-State: APjAAAXLqnwtzL3mcdcvOMgqWOPoyeBOsRJ/mfC/LiyR0gle67HJSNpR
        geU/7PCdC51Js5/08xJ2lO0L7w==
X-Google-Smtp-Source: APXvYqweONTr/NmXXg7LOIoADi9spcEwDT5qdS05x9J7ZdEgu/6X1XDcocFaHgy6VlFrOKfyw7BHhg==
X-Received: by 2002:a1c:e718:: with SMTP id e24mr2980684wmh.104.1561036714634;
        Thu, 20 Jun 2019 06:18:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab? ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
        by smtp.gmail.com with ESMTPSA id d18sm36768327wrb.90.2019.06.20.06.18.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:18:34 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: reorganize initial steps of
 vmx_set_nested_state
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Aaron Lewis <aaronlewis@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1560959396-13969-1-git-send-email-pbonzini@redhat.com>
 <87zhmcfo0w.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ab81435-d94a-1883-a7e0-e2eba6a1ba68@redhat.com>
Date:   Thu, 20 Jun 2019 15:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87zhmcfo0w.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/19 14:18, Vitaly Kuznetsov wrote:
> There's also something wrong with the patch as it fails to apply because
> of (not only?) whitespace issues or maybe I'm just applying it to the
> wrong tree...

Yes, there's a change to KVM_GET/SET_NESTED_STATE structs from Liran.

Paolo
