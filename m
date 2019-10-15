Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B89ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509C2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbfJORqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:46:21 -0400
Received: from foss.arm.com ([217.140.110.172]:44586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJORqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:46:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72400337;
        Tue, 15 Oct 2019 10:46:20 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C13993F6C4;
        Tue, 15 Oct 2019 10:46:18 -0700 (PDT)
Date:   Tue, 15 Oct 2019 18:46:16 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-s390@vger.kernel.org, f.fainelli@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, iommu@lists.linux-foundation.org,
        mbrugger@suse.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Subject: Re: [PATCH RFC 0/5] ARM: Raspberry Pi 4 DMA support
Message-ID: <20191015174616.GO13874@arrakis.emea.arm.com>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
 <20191014205859.GA7634@iMac-3.local>
 <384b42df01c0af973002fba0d5f02068e7f2e7b3.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <384b42df01c0af973002fba0d5f02068e7f2e7b3.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:48:22AM +0200, Nicolas Saenz Julienne wrote:
> A little off topic but I was wondering if you have a preferred way to refer to
> the arm architecture in a way that it unambiguously excludes arm64 (for example
> arm32 would work).

arm32 should be fine. Neither arm64 nor arm32 are officially endorsed
ARM Ltd names (officially the exception model is AArch32 while the
instruction set is one of A32/T32/T16).

-- 
Catalin
