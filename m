Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3570C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D292146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="potIwON6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbfDARaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:15 -0400
Received: from tomli.me ([153.92.126.73]:32924 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732857AbfDARaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:12 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 43ce0b20;
        Mon, 1 Apr 2019 17:30:09 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:ddd9:ae88)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 01 Apr 2019 17:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=7F9VIyfsvvRgVWBle54e3Kq6qZTmmRPbFDXFUOwwjdM=; b=potIwON6/1OF7V4SyEte7FZPA6NH2V0HrglQYm9f37Fp+18LZF0QK7n8RtFaiGjBE19LbH7ZMcxui0WrsPWC1o6oQQu0qSGynI7h/H9dHLL9X3XX3RpAMR44G/WFSGytUxoNca1pSQ58Ll5TSXkhDuvScXGQJD9FfyaRyVz+F/HvuK/6ubHSpeR7/b1G11toha/98ohma1WHnd44+Q2rIIH1PABi+1+jGfEwwTRV0rZK3PeGPCiBAWLnneBj9tB2OKaU50Q1qGSsuecGUoxblt5N4eTGgm6SkislNVS5ilovI2X4Tq+ZHnFwbz+FgAyfFkPVkH8mRA7FeAQMhJXoUQ==
Date:   Tue, 2 Apr 2019 01:30:00 +0800
From:   Tom Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 5/7] Documentation: fb: sm712fb: add information
 mainly about 2D.
Message-ID: <20190401172959.GD15736@localhost.localdomain>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-6-tomli@tomli.me>
 <20190331185428.mpqbaq32cmm7izfv@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331185428.mpqbaq32cmm7izfv@debian>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 07:54:28PM +0100, Sudip Mukherjee wrote:
> On Fri, Mar 22, 2019 at 01:17:57PM +0800, Yifeng Li wrote:
> > +video controllers. This series of video controller is a legacy from ~1998,
> > +and was used on many classic, "prehistoric" laptops from 1998-2004, such as
> > +IBM Thinkpad S30 and 240X. It was also used on some servers, industrial
> > +computers, x86 and non-x86 embedded devices where only basic graphics was
> > +needed.
> 
> I think this is wrong. Loongson 3A Notebook was released around 2011-2012
> and had SM712.

"This series of video controller is a legacy from ~1998 and was used on many
classic, prehistoric laptops from 1998-2004" is an objective fact. Even if
they have been used on newer hardware, it doesn't automatically make the original
statement false.

But I agree that the description gives incomplete information, I think this
paragraph should be reworded for clarity.

I would change the description to,

> "sm712fb" is a graphics framebuffer driver for Silicon Motion SM710 (LynxEM),
SM712 (LynxEM+), and SM720 (Lynx3DM, Lynx3DM+, aka. LynxEM4+) series of video
controllers.

> This series of video controllers is a legacy product from ~1998, they are
designed to be primarily used on low-power mobile systems running Windows 95/
98/NT/2000, some examples are HP OmniBook XE2 (2000), Panasonic TOUGHBook 28
(2002), FLORA 210W NL3 (2003), Sony Vaio VGN-U50 (2004) OQO Model 01 (2004).

> After 2004, they continued to be used on some non-x86 systems, including
PowerPC and MIPS. It also saw applications on embedded devices, servers,
industrial computers, embedded devices, where low-power operation and/or only
basic graphics was needed.

> Notably, Lemote YeeLoong 8089, a MIPS laptop based on the Chinese Loongson
[...]

I think it would be enough.

BTW, most Loongson 3A notebooks don't use SM712. I don't know that there are
Loongson 3A notebooks that are still using SM712 graphics chip, do you have one?
Could you tell me its model number?

> > +The first feature is planned to be implemented soon, but the maintainer
> > +does not receive any monetary or hardware support from any company or OEMs,
> > +and he has to purchase a test platform personally. The 1998's hardware
> > +still costs 200 USD+, so don't expected an ETA. If you have a Big-Endian
> > +platform and willing to help testing, please contact the maintainer, thanks!
> 
> I am not sure why will you want to mention about monetary or hardware
> support. Maintainers are supposed to work voluntarily.

I agree, I will reword it.

> > +Other VGA modes, dual-head, or hardware cursor support should be possible to
> > +implement, but parts of the code must be rewritten, and there's little demand
> > +for them on this legacy (retro?) platform, so there's no plan to implement them.
> > +If you have a genuine need for them, please contact the maintainers.
> 
> If there is any need for new features then I think the plan should be to
> make a drm driver.

That's the plan. I will reword.

> There is a MAINTAINERS file to list the maintainers. There is no need to
> add that in documentation.

I see.

Thanks,
Tom Li
