Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41721C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA672183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jItn95M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfCTQar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:30:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52976 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfCTQaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:30:46 -0400
Received: from nazgul.tnic (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E57E1EC09F1;
        Wed, 20 Mar 2019 17:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553099445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oE+B5yvHr/p/VPTWiTBiNOlCfaS/abCl9HvISL3Fv9o=;
        b=jItn95M8p2DWMQuNap19vMVcM/8pifGlU+WPHU0d3x6lQem1GgnCO9b/qSQkRp8PNiGKMj
        bVMoMh486KSqDM+yKfW0y0ZL+ET+1pXnC/OL1l8xPfNLp3qi0XlI1VXehXGMpT3D2Uk1Bq
        FMj/QfLDW36chwon1sMdGqPoh29wFQY=
Date:   Wed, 20 Mar 2019 17:30:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
Message-ID: <20190320163038.GD15821@nazgul.tnic>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
 <8742b0a2-de4e-9865-cb3e-dfda0dec6a0a@infradead.org>
 <20190320151715.GG9224@smile.fi.intel.com>
 <415863c9-8a06-f392-a558-bce694069d09@infradead.org>
 <20190320161543.GH9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320161543.GH9224@smile.fi.intel.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:15:43PM +0200, Andy Shevchenko wrote:
> I don't see the proper place.

I see Documentation/x86/earlyprintk.txt which kinda begs to collect
earlyprintk documentation...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
