Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66062C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DAA20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="L7E8+IRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfDBIzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:55:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50666 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727583AbfDBIzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:55:36 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30F5B1EC0669;
        Tue,  2 Apr 2019 10:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554195335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=npCYkg5K+Xqv5zwlckJItjgfP+oeKUroHRCoLQtln04=;
        b=L7E8+IRMu45ZSi0G9SkjMrLhWdj6R63V3KL8NMFxML7ULDhNxDI7yT/YGP6zrPZFNyBTSt
        gJ1HKtuSCnwMedalTpbX1ld8fljP6MkAKdwT9Dvt88z8ANkfwCh6hTANE4EZnNyQSVYvBX
        2YlxktkzKCG0hX+P1gxhT2jGpHVEwno=
Date:   Tue, 2 Apr 2019 10:55:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     thor.thayer@linux.intel.com
Cc:     mchehab@kernel.org, james.morse@arm.com, atull@kernel.org,
        richard.gong@intel.com, gregkh@linuxfoundation.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: Intel: Add Stratix10 ECC DBE SMC call
Message-ID: <20190402085529.GC6826@zn.tnic>
References: <1553870639-23895-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553870639-23895-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 09:43:58AM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Reserve ECC Double Bit Error SMC call to alert U-Boot that
> a DBE has occurred. Moving the call from local EDAC header
> file to this common file.

Is there any particular reason this needs to be two patches or can I
merge them into one?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
