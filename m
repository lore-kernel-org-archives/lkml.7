Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FB2206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfGaROW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:14:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfGaROV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:14:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47100337;
        Wed, 31 Jul 2019 10:14:21 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DD0E3F71F;
        Wed, 31 Jul 2019 10:14:20 -0700 (PDT)
Date:   Wed, 31 Jul 2019 18:14:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     ard.biesheuvel@linaro.org, will@kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/efi: fix variable 'si' set but not used
Message-ID: <20190731171417.GF17773@arrakis.emea.arm.com>
References: <1564521828-4528-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564521828-4528-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 05:23:48PM -0400, Qian Cai wrote:
> GCC throws out this warning on arm64.
> 
> drivers/firmware/efi/libstub/arm-stub.c: In function 'efi_entry':
> drivers/firmware/efi/libstub/arm-stub.c:132:22: warning: variable 'si'
> set but not used [-Wunused-but-set-variable]
> 
> Fix it by making free_screen_info() a static inline function.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Queued for 5.3-rc3. Thanks.

-- 
Catalin
