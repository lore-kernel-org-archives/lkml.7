Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD65C17443
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 10:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F81221924
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 10:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="L5gnkNur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKIKLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 05:11:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45458 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKIKLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 05:11:51 -0500
Received: from zn.tnic (p200300EC2F1EA7009D7000FE00A4E362.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:a700:9d70:fe:a4:e362])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B4651EC0CF8;
        Sat,  9 Nov 2019 11:11:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573294310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CEeCWf0z3WtnIkSC44XBMnqQMurafw1H0plYSfhYdq8=;
        b=L5gnkNurZg5cHgNIseSlKsSAylSnAu1CiZd/KSyUyrKZF7HsISpeP8mukqZUbLaJjlwHxW
        8FwX8tgU5+DxxpqchFAjdNUwgZlkd0/wivPMEi13wzS8Gf1Fe7jp6I3e9/sFlnLMhHo3Zb
        2OGHLAcLqFnSia9sYa51PtDP8bPjSlY=
Date:   Sat, 9 Nov 2019 11:11:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 05/20] EDAC, mc: Remove needless zero string
 termination
Message-ID: <20191109101146.GB2699@zn.tnic>
References: <20191106093239.25517-1-rrichter@marvell.com>
 <20191106093239.25517-6-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106093239.25517-6-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 09:33:11AM +0000, Robert Richter wrote:
> Since this is a string already and strlen() has been used to advance
> the pointer, the end of the buffer is already zero terminated. Remove
> the needless zero string termination.

Changed that to:

"The e string to which this is pointing to has already been cleared
earlier in the function so remove the needless zero string termination."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
