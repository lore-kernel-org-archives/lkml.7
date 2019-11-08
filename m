Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF251FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB97E206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfKHVCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:02:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfKHVCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:02:55 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C8DEC057F52
        for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2019 21:02:55 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id h191so3527607wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 13:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nmq1GRytWblh4euOCRxuEbZgIoXZxuuSJXUDKh29oIk=;
        b=ltIfLzSQTMtPVB51kMxraCy8xppbBFOq/oPrV1nH6m9O3I7Jtsk84C0DEd/ZW9LQmQ
         S/Mz3A2siz5MKyN3okWbPD3kiz/3wJOkdEJL5+8XLb8JVsYZ6N5k3dfinCrQqG9UH420
         8+67qLz6PfC3yC+JoyGHFjwvdWCa3nHrQAPo0Cpd61N4iEWfEO2sfKmzRRuZeO54oTga
         3WfCtmWs9qZ9vrXCys3Ml0UmSCsfWxOJqMwMdTqIFHo+6EMvDQyzWOZe9EL6X272qlc7
         m/n3d4D0LjoSRZPuPfDpacXDAqewM8SR4LgaM8a/jv6q+I++lWMGJ2i63tvssRQkT6Tf
         3tFQ==
X-Gm-Message-State: APjAAAWCsHkmwCwF/ph9eKSdHIMW7gbzYqMs1VOIfqTLIqQdIS45Hlj9
        94uzU/0a31rp2ToOyRJo9mYaK8pqJMZ7M9EuGZSW3N23QnIANlIMc4XMTdyTwH44dDZPdI8LT27
        +DmylVgv8mA8esFSr8UgtV3Yd
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr9706141wmg.12.1573246973743;
        Fri, 08 Nov 2019 13:02:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/r6N66RU82TBDTILIQyY7RHqJh4iD/jrgGSamtcwPgbTwlkWB5WWPfNwcD7uzL3Q1oJWlbw==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr9706123wmg.12.1573246973469;
        Fri, 08 Nov 2019 13:02:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e8cd:9f0f:a5dc:7ad5? ([2001:b07:6468:f312:e8cd:9f0f:a5dc:7ad5])
        by smtp.gmail.com with ESMTPSA id y8sm5515162wmi.9.2019.11.08.13.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 13:02:52 -0800 (PST)
Subject: Re: [PATCH 03/13] kvm: monolithic: fixup x86-32 build
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, kvm@vger.kernel.org,
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
 <b77283e5-a4bc-1849-fbfa-27741ab2dbd5@redhat.com>
 <20191108200103.GA532@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9a3d2936-bd26-430f-a962-9b0f6fe0c2a0@redhat.com>
Date:   Fri, 8 Nov 2019 22:02:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191108200103.GA532@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/19 21:01, Andrea Arcangeli wrote:
> On Fri, Nov 08, 2019 at 08:51:04PM +0100, Paolo Bonzini wrote:
>> I suppose we could use code patching mechanism to avoid the retpolines.
>>  Andrea, what do you think about that?  That would have the advantage
>> that we won't have to remove kvm_x86_ops. :)
> 
> page 17 covers pvops:
> 
> https://people.redhat.com/~aarcange/slides/2019-KVM-monolithic.pdf

You can patch call instructions directly using text_poke when
kvm_intel.ko or kvm_amd.ko, I'm not sure why that would be worse for TLB
or RAM usage.  The hard part is recording the location of the call sites
using some pushsection/popsection magic.

Paolo
