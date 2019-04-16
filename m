Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FACC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DDA20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfDPVfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:35:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35164 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfDPVfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:35:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A28CB15A2;
        Tue, 16 Apr 2019 14:35:03 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48E73F59C;
        Tue, 16 Apr 2019 14:35:00 -0700 (PDT)
Date:   Tue, 16 Apr 2019 22:34:47 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/5] arm64: Use the correct style for SPDX License
 Identifier
Message-ID: <20190416213447.GA11724@brain-police>
References: <cover.1555427418.git.nishadkamdar@gmail.com>
 <ecdbe63bea1b1d2d67db6cc577aa32bf872f2310.1555427419.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecdbe63bea1b1d2d67db6cc577aa32bf872f2310.1555427419.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:49:35PM +0530, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style
> in the arm64 Hardware Architecture related files.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h | 2 +-
>  arch/arm64/include/asm/pointer_auth.h         | 2 +-
>  arch/arm64/include/asm/sdei.h                 | 2 +-
>  arch/arm64/include/asm/vmap_stack.h           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

I'll pick this up for 5.2.

Will
