Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA86CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B39206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395528AbfJYPum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:50:42 -0400
Received: from foss.arm.com ([217.140.110.172]:42564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388136AbfJYPum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:50:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 605AC328;
        Fri, 25 Oct 2019 08:50:41 -0700 (PDT)
Received: from C02TF0J2HF1T.local (C02TF0J2HF1T.cambridge.arm.com [10.1.26.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04E5F3F71A;
        Fri, 25 Oct 2019 08:50:38 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:50:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/10] arm/arm64: Make use of the SMCCC 1.1 wrapper
Message-ID: <20191025155036.GA999@C02TF0J2HF1T.local>
References: <20191021152823.14882-1-steven.price@arm.com>
 <20191021152823.14882-10-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021152823.14882-10-steven.price@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:28:22PM +0100, Steven Price wrote:
> Rather than directly choosing which function to use based on
> psci_ops.conduit, use the new arm_smccc_1_1 wrapper instead.
> 
> In some cases we still need to do some operations based on the
> conduit, but the code duplication is removed.
> 
> No functional change.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
