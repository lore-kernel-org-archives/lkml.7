Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F2EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9185208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hnv/JQKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391943AbfITQ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:26:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388770AbfITQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V/m8W9O2Haha1e8N7X661vaEYz514z0rIXOBFhZpOLk=; b=hnv/JQKMMZUbM9rlNbOlzpzJC
        qtlcxyyrm/vuodKAFzgT0jVLnvq7LNNp2LsmEUWNsBv68rQti2lb8/po6ejkC9YCAZG4ZJySAyRU5
        OsHSGKhbmILRgR9nzkofugFn6bbDKeh7syXjThHx2CxQEXr23N3QYi5Kl8ik7bG6ybUrvSRgqTjr2
        Jxm38V5Whlt1KBsDFOsva8FclBT3fsGqai0pRlkWwKJlr6cp45uBiC3Q5Lf4FaAMxhtZRn48ktXbJ
        2rsT/esVMfHCrp/uX4fJS4xrh2u5aD1DJn+D+Gdb7dZchtzrURT9WouujJ3oWjKcvylDfUVM5ruf4
        yzH/lpbmA==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBLjW-0000se-9u; Fri, 20 Sep 2019 16:26:10 +0000
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <adea75a4-d69e-4241-caf3-84c908871fb6@infradead.org>
Date:   Fri, 20 Sep 2019 09:26:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/19 9:17 AM, Linus Torvalds wrote:
> On Tue, Sep 17, 2019 at 12:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> This Kselftest update for Linux 5.4-rc1 consists of several fixes to
>> existing tests and adds KUnit, a lightweight unit testing and mocking
>> framework for the Linux kernel from Brendan Higgins.
> 
> So I pulled this, but then I almost immediately unpulled it.
> 
> My reason for doing that may be odd, but it's because of the top-level
> 'kunit' directory. This shouldn't be on the top level.
> 
> The reason I react so strongly is that it actually breaks my finger
> memory. I don't type out filenames - I auto-compete them. So "kernel/"
> is "k<tab>", "drivers/" is "d<tab>" etc.
> 
> It already doesn't work for everything ("mm/" is actually "mm<tab>"
> not because we have files in the git tree, but because the build
> creates various "module" files), but this breaks a common pattern for
> me.
> 
>> In the future KUnit will be linked to Kselftest framework to provide
>> a way to trigger KUnit tests from user-space.
> 
> Can the kernel parts please move to lib/kunit/ or something like that?

Please also move the top-level Kconfig menu item "KUnit support" to
somewhere that is not top-level.  Maybe also in the lib/ menu.  Maybe
in lib/Kconfig.debug.


-- 
~Randy
