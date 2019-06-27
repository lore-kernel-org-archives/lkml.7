Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D15C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F1F20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfF0ICM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:02:12 -0400
Received: from foss.arm.com ([217.140.110.172]:48718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfF0ICM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:02:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D48360;
        Thu, 27 Jun 2019 01:02:11 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2673F246;
        Thu, 27 Jun 2019 01:02:10 -0700 (PDT)
Date:   Thu, 27 Jun 2019 09:02:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>, Qian Cai <cai@lca.pw>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: Move jump_label_init() before parse_early_param()
Message-ID: <20190627080207.sdpwjoi4wnc664gp@mbp>
References: <201906261343.5F26328@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906261343.5F26328@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, Jun 26, 2019 at 01:51:15PM -0700, Kees Cook wrote:
> This moves arm64 jump_label_init() from smp_prepare_boot_cpu() to
> setup_arch(), as done already on x86, in preparation from early param
> usage in the init_on_alloc/free() series:
> https://lkml.kernel.org/r/1561572949.5154.81.camel@lca.pw

This looks fine to me. Is there any other series to be merged soon that
depends on this patch (the init_on_alloc/fail one)? If not, I can queue
it for 5.3.

-- 
Catalin
