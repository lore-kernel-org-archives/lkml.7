Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CCC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0CC20820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbfIDQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:07:10 -0400
Received: from foss.arm.com ([217.140.110.172]:57812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733172AbfIDQCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7813828;
        Wed,  4 Sep 2019 09:02:06 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40F573F246;
        Wed,  4 Sep 2019 09:02:04 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] arm64: Stolen time support
To:     Andrew Jones <drjones@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190830084255.55113-1-steven.price@arm.com>
 <20190903080348.5whavgrjki7zrtmd@kamzik.brq.redhat.com>
 <20190903084921.zikiucdruymfgfsq@kamzik.brq.redhat.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <6c68dd0c-5103-cd2d-4162-b37c6d10460b@arm.com>
Date:   Wed, 4 Sep 2019 17:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903084921.zikiucdruymfgfsq@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2019 09:49, Andrew Jones wrote:
> On Tue, Sep 03, 2019 at 10:03:48AM +0200, Andrew Jones wrote:
>> Hi Steven,
>>
>> I had some fun testing this series with the KVM selftests framework. It
>> looks like it works to me, so you may add
>>
>> Tested-by: Andrew Jones <drjones@redhat.com>
>>
> 
> Actually, I probably shouldn't be quite so generous with this tag yet,
> because I haven't yet tested the guest-side changes. To do that I'll
> need to start prototyping something for QEMU. I need to finish some other
> stuff first, but then I can do that.

Thanks for the testing, I'll wait for your other testing before adding
your Tested-by tag.

Steve
