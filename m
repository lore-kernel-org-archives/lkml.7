Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D62BC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E1021D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570795960;
	bh=YYmhhj4+C3u3Ikgul464neRhC9LZSnJz2pJQmRyo3L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kJgPpEklPp5OTMxQ7vCwjb0rLgb/riOXkg38+7twph9mJnW9jv0SBVrxcEgC3UP3T
	 ZLETvtT5A0H/lNnssR5SkFbkfTbj6fnhTLPucVuEDjCrn5ZIQbWwvaI1GXKnDKNa7p
	 HY30R4uo8zmV5S0q2WD/OTmxqcyEw8ZuiLsfOd2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfJKMMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbfJKMMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:12:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1C721D56;
        Fri, 11 Oct 2019 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570795958;
        bh=YYmhhj4+C3u3Ikgul464neRhC9LZSnJz2pJQmRyo3L4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msCgP8uxanowLP0NV6otoCt5jyV1P6vHC0x2yySmQhc5+6CfR7u45dwR/D6/Xqw7q
         mgQbZt5wW+LZVsW7mp/LLA7cBPwGQRY/l6UWfIMGh/QE2P+8FuSvLuOZyjdYYHwdyj
         EuqUNF0YIGOqVtrDeMPiVjRnxNapmXKJVk9w7a2g=
Date:   Fri, 11 Oct 2019 13:12:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 09/10] lib/refcount: Remove unused
 'refcount_error_report()' function
Message-ID: <20191011121233.agenrrq5wopvydma@willie-the-truck>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-10-will@kernel.org>
 <201910101349.9400E7D0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910101349.9400E7D0@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 01:50:14PM -0700, Kees Cook wrote:
> On Mon, Oct 07, 2019 at 04:47:02PM +0100, Will Deacon wrote:
> > 'refcount_error_report()' has no callers. Remove it.
> 
> Seems like this could be collapsed into patch 8? Either way:

I preferred to do the heavy arch lifting in one patch, then clean up the
remaining parts separately, since this is just cosmetic.

> Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

Will
