Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC49C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1999921655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TDdHOpDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHPHhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:37:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60696 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfHPHhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:37:22 -0400
Received: from zn.tnic (p200300EC2F0A920041519BC41B2ACCA3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9200:4151:9bc4:1b2a:cca3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC67A1EC0A0E;
        Fri, 16 Aug 2019 09:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565941040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dkrYGBF1MgaVSBgQs7Dok4K4lGMWFQJbNvS7kMiPMUQ=;
        b=TDdHOpDqqEiUb6KC944Fq/ZkXjVEuW0/0hyfde1MGaeEK/ttVzNECIWI2bUcI2aO1prKeg
        orqEHrELWrai91txhwR7vQnowGHAT+GwohjnQzja+QWz9EiUdN9+fZwptFqsFk9LyuNy4Y
        XrR404mjUJ/jXxAsMJUf+j10QEb6fHc=
Date:   Fri, 16 Aug 2019 09:38:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH 2/3] x86: cpu: Add new Intel Atom CPU type
Message-ID: <20190816073810.GI18980@zn.tnic>
References: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
 <16de4480ae1216d5949d4d36787811dae35d2eff.1565856842.git.rahul.tanwar@linux.intel.com>
 <20190815122222.GE15313@zn.tnic>
 <68ad47a7-ac6f-0a1b-0892-850bb95c002b@linux.intel.com>
 <20190816064318.GC18980@zn.tnic>
 <d6452a93-16a7-451e-3abb-0bc65e89b0aa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6452a93-16a7-451e-3abb-0bc65e89b0aa@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 03:25:51PM +0800, Tanwar, Rahul wrote:
> 
> On 16/8/2019 2:43 PM, Borislav Petkov wrote:
> > Now to another question: you see how I put my reply to the previous mail
> > *below* the quoted text. Why is yours ontop? Why not put it after mine
> > since you're replying to it, like it is usually done on the mailing
> > lists and thus not confuse the reading order?
> > 
> > All I'm trying to say is, please do not top-post.
> 
> So sorry for missing out on this point. Will always keep in mind from now
> on.

Thanks!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
