Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC88C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0679120673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfI0Kq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:46:27 -0400
Received: from foss.arm.com ([217.140.110.172]:48870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfI0Kq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:46:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AA3528;
        Fri, 27 Sep 2019 03:46:26 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653AD3F67D;
        Fri, 27 Sep 2019 03:46:25 -0700 (PDT)
Date:   Fri, 27 Sep 2019 11:46:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v3 0/5]arm64: vdso32: Address various issues
Message-ID: <20190927104623.GF20642@arrakis.emea.arm.com>
References: <20190926214342.34608-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926214342.34608-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:43:37PM +0100, Vincenzo Frascino wrote:
> Vincenzo Frascino (5):
>   arm64: vdso32: Introduce COMPAT_CC_IS_GCC
>   arm64: vdso32: Detect binutils support for dmb ishld
>   arm64: vdso32: Fix compilation warning
>   arm64: Remove gettimeofday.S
>   arm64: vdso32: Remove jump label config option in Makefile

You can add this as well:

Tested-by: Catalin Marinas <catalin.marinas@arm.com>
