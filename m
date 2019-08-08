Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9175EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC92187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MEIoZWPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfHHIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:12:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731781AbfHHIMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:12:54 -0400
Received: from zn.tnic (p200300EC2F0FD700B5ECB790597D1186.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:b5ec:b790:597d:1186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0E851EC0BF2;
        Thu,  8 Aug 2019 10:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565251973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7GWg8dqLy9kBKDA8AmzGkXjbF+WFKtm6Ljlw7ip0bg0=;
        b=MEIoZWPS5DuE9ZDumkvzhhvuej/C4IP8irOClmtdk5ArDWXls+3cITLtOJfHANG0utqKPu
        y49iGjScyJo3D7cCzMryD5HDHPIqAvrOtHwnnDzQ8mKVpMVLUuGTrlk6wQ3YIlNkLkQvAr
        50JwzytvkeC9Bc54XknbQcC2SElNy1Y=
Date:   Thu, 8 Aug 2019 10:13:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190808081342.GB20745@zn.tnic>
References: <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
 <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
 <20190806183333.GA4698@zn.tnic>
 <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
 <20190806191559.GB4698@zn.tnic>
 <18004821-577d-b0dd-62b8-13b6f9264e72@intel.com>
 <20190806204054.GD4698@zn.tnic>
 <98eeaa53-d100-28ff-0b68-ba57e0ea90fb@intel.com>
 <20190808080841.GA20745@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808080841.GA20745@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:08:41AM +0200, Borislav Petkov wrote:
> Ok, tglx and I talked it over a bit on IRC: so your 1/10 patch is pretty
> close - just leave out the generic struct cacheinfo bits and put the
> cache inclusivity property in a static variable there.

... and by "there" I mean arch/x86/kernel/cpu/cacheinfo.c which contains
all cache properties etc on x86 and is the proper place to put stuff
like that.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
