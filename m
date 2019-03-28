Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D12C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F0C20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZjJPNRoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfC1Ofa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:35:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfC1Ofa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:35:30 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 243101EC02C1;
        Thu, 28 Mar 2019 15:35:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553783729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2i97X59RPKwcDBMhxQ/NybF8wcCaDshgXiyxrVwl1LM=;
        b=ZjJPNRoT2OCvkl9Kqi/eFkFEAFxdNcm75gyYVYY5DAEelEla9XhG2KIOm5/osy3BKTe3Vw
        rg78GHAcKZze3lD/bEGKYibBvP2KCn8gwJem+9FkO7T9jxBiTTMgeCOY9+AKTfeBhVNbrj
        ptzEv1vab4m7sRtlIGLnMdZAp58j2Cg=
Date:   Thu, 28 Mar 2019 15:35:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joe Perches <joe@perches.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] x86/boot: Split out parse_serial_port() helper
 for earlyprintk
Message-ID: <20190328143535.GO22720@zn.tnic>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-4-andriy.shevchenko@linux.intel.com>
 <20190328123504.GF22720@zn.tnic>
 <20190328131557.GY9224@smile.fi.intel.com>
 <20190328133907.GI22720@zn.tnic>
 <20190328135015.GA9224@smile.fi.intel.com>
 <20190328140329.GK22720@zn.tnic>
 <20190328142302.GE9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328142302.GE9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:23:02PM +0200, Andy Shevchenko wrote:
> If it's strong opinion, I consider this rather as NAK.
> Thank you for review.

Your call.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
