Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A6FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4952089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391821AbfFKPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:48:38 -0400
Received: from foss.arm.com ([217.140.110.172]:36450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387966AbfFKPsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:48:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E8F4337;
        Tue, 11 Jun 2019 08:48:37 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C59B3F246;
        Tue, 11 Jun 2019 08:48:36 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:48:34 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/2] arm64: replace _BITUL() with BIT()
Message-ID: <20190611154834.GG4324@fuggles.cambridge.arm.com>
References: <20190527083412.26651-1-yamada.masahiro@socionext.com>
 <20190527083412.26651-3-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527083412.26651-3-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:34:12PM +0900, Masahiro Yamada wrote:
> Now that BIT() can be used from assembly code, replace _BITUL() with
> equivalent BIT().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/include/asm/sysreg.h | 82 ++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 41 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
