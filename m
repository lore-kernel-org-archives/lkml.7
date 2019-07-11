Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD92C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133D920872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfGKRMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:12:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46465 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfGKRMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:12:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so7082517wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxtBFGrLM9ebJLyUflgxgAUhrlPh7lgx6/ntfyx9XO8=;
        b=NwF01X0ABkfCYizU6o9fK+wuyGOInIQ5jZONnXUhvBN+8SHjbWS6aKzKKWmlQza4Y5
         //m9Jw4gCYXaF7pbbYK6NGtxDaxcmJ3To7tMdg717ip6l2Rn/FtZnfdc0o/dwDO8rGGF
         MNSdXQ42pRfMhcDscZv/Rx6AP/Hv97HCrDQ6gTmsCURNAkitZgxK3vX5JgwIhynuufvG
         fbSN5vveHTBujosC6uvvmgjvxAye6uFDO7KoElRmSjpM70w/NYDlD29g5mNT8+oLIURQ
         JL94XADIWDtoRs1Z1GmUDDpIYtWmQCViKAmdH6+jhSC3ODFqnBQN+RCv1y7KHDj0tBlh
         ZrLA==
X-Gm-Message-State: APjAAAWgvGHTK0074iQ2kEeEkm7Z94S8M4WkR0Od7+TX5V/h2BK0WTg0
        x9qusIZTPg26UoAAzb6ineDLqA==
X-Google-Smtp-Source: APXvYqwz/aexZyXNB5ItnJK4ujGh9FOUDoat8ZBZvgm9Rop7VETOo2vYfNbEVE/0BZj02EvW3Avrjw==
X-Received: by 2002:a5d:62c1:: with SMTP id o1mr6244962wrv.293.1562865139278;
        Thu, 11 Jul 2019 10:12:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab? ([2001:b07:6468:f312:d066:6881:ec69:75ab])
        by smtp.gmail.com with ESMTPSA id u9sm5844898wrr.30.2019.07.11.10.12.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:12:18 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: PMU Event Filter
To:     Eric Hankland <ehankland@google.com>
Cc:     Wei Wang <wei.w.wang@intel.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, kvm@vger.kernel.org
References: <CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com>
 <21fd772c-2267-2122-c878-f80185d8ca86@redhat.com>
 <CAOyeoRVrXjdywi-00ZafkVtEb_x6f5ZEmdMqq6v67XMedv_LKQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8c0502f4-64eb-3d34-1d76-a313b8f2f37a@redhat.com>
Date:   Thu, 11 Jul 2019 19:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOyeoRVrXjdywi-00ZafkVtEb_x6f5ZEmdMqq6v67XMedv_LKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/19 19:04, Eric Hankland wrote:
> Thanks for your help. The "type"->"action" change and constant
> renaming sound good to me.

Good!  Another thing, synchronize_rcu is a bit slow for something that
runs whenever a VM starts.  KVM generally uses srcu instead (kvm->srcu
for things that change really rarely, kvm->irq_srcu for things that
change a bit more often).

Paolo

> On Thu, Jul 11, 2019 at 4:58 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 11/07/19 03:25, Eric Hankland wrote:
>>> - Add a VM ioctl that can control which events the guest can monitor.
>>
>> ... and finally:
>>
>> - the patch whitespace is damaged
>>
>> - the filter is leaked when the VM is destroyed
>>
>> - kmalloc(GFP_KERNEL_ACCOUNT) is preferrable to vmalloc because it
>> accounts memory to the VM correctly.
>>
>> Since this is your first submission, I have fixed up everything.
>>
>> Paolo

