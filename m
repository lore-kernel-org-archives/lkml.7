Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC36CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3272053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfJUNoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:44:00 -0400
Received: from [217.140.110.172] ([217.140.110.172]:53138 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbfJUNoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:44:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 978551007;
        Mon, 21 Oct 2019 06:43:31 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80D133F718;
        Mon, 21 Oct 2019 06:43:29 -0700 (PDT)
Subject: Re: [PATCH v6 08/10] arm/arm64: Provide a wrapper for SMCCC 1.1 calls
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
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
References: <20191011125930.40834-1-steven.price@arm.com>
 <20191011125930.40834-9-steven.price@arm.com>
 <099040bb979b7cb878a7f489033aacc7@www.loen.fr>
From:   Steven Price <steven.price@arm.com>
Message-ID: <890a7909-1083-2e6d-368a-f1d03788f5a1@arm.com>
Date:   Mon, 21 Oct 2019 14:43:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <099040bb979b7cb878a7f489033aacc7@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2019 12:42, Marc Zyngier wrote:
> On 2019-10-11 13:59, Steven Price wrote:
[...]
> All this should most probably go on top of the SMCCC conduit cleanup that
> has already been already queued in the arm64 tree (see
> arm64/for-next/smccc-conduit-cleanup).

Good point, I'll rebase. Are you happy for the entire series to be based
on top of that? i.e. based on commit e6ea46511b1a ("firmware: arm_sdei:
use common SMCCC_CONDUIT_*")

Thanks,

Steve
