Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40844C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B7F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564479472;
	bh=xpK0ZfPmYJ3fWD3eFkqOXdgjBfalS0zMMYn9nNn8F9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jvKvoVnK3B7pWykUOsh2J24l/n+JzbMbM6/AN+zjz367ru4WrGLhS6U9qa7aCaOZJ
	 1VZVT9dZ87+d28STKmRI+VGtdOzOYZF9jM6Y27OY7lUBE/MKnUftk67AQL9N5izZqA
	 e8CnmAmfJOtx233yvmHRYxIHblWlrzHqMSplx3ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfG3Jhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbfG3Jhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:37:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F385920882;
        Tue, 30 Jul 2019 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564479469;
        bh=xpK0ZfPmYJ3fWD3eFkqOXdgjBfalS0zMMYn9nNn8F9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zRQ8Umi6JQtOxbLZ9L2UYOWPniPq7irgZXl8ucJJnpv8ShrBDUiBazonF2iFf9hes
         uuzVcsSAE49t3lFOtISrwhhkQHogbs/ZNQCrG5s0k6h8Co2uwHvMy69hWeIvCq1210
         2KCOiPU12U1KZwYANr2/deL3h+4lz7c6bHqwmL6A=
Date:   Tue, 30 Jul 2019 10:37:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Replace strncmp with str_has_prefix
Message-ID: <20190730093745.nh2wps2iwmrdf6al@willie-the-truck>
References: <20190730024415.17208-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730024415.17208-1-hslester96@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:44:15AM +0800, Chuhong Yuan wrote:
> In commit b6b2735514bc
> ("tracing: Use str_has_prefix() instead of using fixed sizes")
> the newly introduced str_has_prefix() was used
> to replace error-prone strncmp(str, const, len).
> Here fix codes with the same pattern.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  arch/arm64/kernel/module-plts.c | 2 +-
>  arch/arm64/mm/numa.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I can pick this up for 5.4.

Will
