Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C714BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D6320850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfCYUFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:05:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbfCYUFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:05:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78BB51596;
        Mon, 25 Mar 2019 13:05:53 -0700 (PDT)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312363F59C;
        Mon, 25 Mar 2019 13:05:51 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v7 9/10] KVM: arm64: docs: document KVM support of pointer
 authentication
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-10-git-send-email-amit.kachhap@arm.com>
Message-ID: <23e4a9d4-e9e1-2c1f-32ce-e7fd96080437@arm.com>
Date:   Mon, 25 Mar 2019 20:05:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552984243-7689-10-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
> This adds sections for KVM API extension for pointer authentication.
> A brief description about usage of pointer authentication for KVM guests
> is added in the arm64 documentations.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu

I think it makes sense to also update the Kconfig symbol description for
CONFIG_ARM64_PTR_AUTH, since it currently only mentions userspace
support, but now the option also enables KVM guest support.

It's also worth mentioning that CONFIG_ARM64_VHE=y is required for guest
support.

Thanks,
Kristina
