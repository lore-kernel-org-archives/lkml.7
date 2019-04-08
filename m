Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A766C282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F129E20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aoLDGG2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDHHn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:43:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfDHHnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:43:23 -0400
Received: from zn.tnic (p200300EC2F072700703BC679E0FEC46B.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:703b:c679:e0fe:c46b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9D231EC023E;
        Mon,  8 Apr 2019 09:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554709401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uMwepDwUTnY7KDF8TeqJpB3EXShixzEKqh862hFqPus=;
        b=aoLDGG2WwZIGl+5KeyxBXy8mKkrKcvOhkPASlIxt4CAbP3nOJ2VCqL9nrylVwTg+hEYGvR
        EAvVyObN/PZQJb6mfCybuuSthLCDOnSIO/HknNiPofPDHzWsKVhOopEXlN/8a9NekfH2Io
        vy9HnQ3oMDW/vwydFORJZ5+nbxIGycw=
Date:   Mon, 8 Apr 2019 09:43:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/5] Handle MCA banks in a per_cpu way
Message-ID: <20190408074318.GB15689@zn.tnic>
References: <20190407231331.52362-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190407231331.52362-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 11:13:47PM +0000, Ghannam, Yazen wrote:
> Yazen Ghannam (5):
>   x86/MCE: Make struct mce_banks[] static
>   x86/MCE: Handle MCA controls in a per_cpu way
>   x86/MCE/AMD: Don't cache block addresses on SMCA systems
>   x86/MCE: Make number of MCA banks per_cpu
>   x86/MCE: Save MCA control bits that get set in hardware
> 
>  arch/x86/kernel/cpu/mce/amd.c      |  87 +++++++++---------
>  arch/x86/kernel/cpu/mce/core.c     | 138 +++++++++++++++++++----------
>  arch/x86/kernel/cpu/mce/inject.c   |   7 +-
>  arch/x86/kernel/cpu/mce/internal.h |  12 +--
>  4 files changed, 137 insertions(+), 107 deletions(-)

This patchset doesn't apply cleanly. Please redo it against current
tip/master.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
