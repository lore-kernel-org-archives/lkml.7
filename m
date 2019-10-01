Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A82EECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12536205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569936433;
	bh=sfei3fNmNvi6lTi6MMR5a3wHggKkRsIZ/qgKoTItACc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SWpwW3u86PYtl1YNj+n6vaixndtrLeug/kwLBQZNv/Ku66cA1AhzSVSemCdyV3jsQ
	 mUGr76W9BV92bcvYBsNuWHlOX93vGgS6PMIKKNkrjnPOhkfSwizuVSyZgX/j66YHvE
	 ZxyeFJqhTskcSapF2UN5SQ5tVvIxGmXMCVMnQMy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbfJAN1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388261AbfJAN1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:27:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B89520842;
        Tue,  1 Oct 2019 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569936430;
        bh=sfei3fNmNvi6lTi6MMR5a3wHggKkRsIZ/qgKoTItACc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwpnvP758agt5PqeUSvUvJuo7UAvnivP7LNCqdbn0vx6FUf0HvSz0QmWxM480PmDV
         7UwXRrNNCcVXTqrIQpvLYCvx9cYOtvop5xs2JLS6pgSGiYCI14sb+lPYkOpptXC9HL
         e7DZ23oDhuuOix0WQi8LBGnMLuTJFbbq+ZTvjmAI=
Date:   Tue, 1 Oct 2019 14:27:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 0/5]arm64: vdso32: Address various issues
Message-ID: <20191001132705.fvwi5jbte4la7t7u@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926214342.34608-1-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:43:37PM +0100, Vincenzo Frascino wrote:
> this patch series is meant to address the various compilation issues you
> reported about arm64 vdso32.

Thanks, I've commented on the patches. Also, when you respin, please can
you drop the "As reported by Will Deacon ..." lines from the commit messages
and just add a Reported-by tag instead?

Thanks,

Will
