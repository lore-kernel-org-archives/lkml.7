Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2323C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F25921920
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569830546;
	bh=gVWoOt5QIR04LPZZmJQ9F7du8ueLLuh79RcOf2CaaPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HX03i9B6q95dpl57ZM3ClcMTEPcoO5iSGwCoO14roaak6hQxVulNpKquCHVuANKHN
	 xNZqNhhQDhJL975oJg/PDZ+ICFYET6uApePkDlVwuIa9z6HaKUwhtTZFDB+v/vAfQ/
	 4mSY2jdQVkImZ9kSd7BwoUH7Ih8KGRvTzqsotHlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfI3IC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:02:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55240 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3ICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:02:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so12217160wmp.4;
        Mon, 30 Sep 2019 01:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fizj4yTUNCuGZAq8TVj3hQISg7yH6mFEeG99CtKC4TE=;
        b=IKc6hRLUXxyCgDakoy1CeXXtaLXx+BvOQn6YigMioJUI51jgbAfjgottgo0xQkzhto
         g+3xSP/2RtuwhYwKknS9IFmT+l47ZoOMsGbL98lySFH0E7iWCu7WIkhVLNCX6mRjwhEp
         aF8t9hbqnbVgdlp5lqg3S9e+MsiHvTlr3u+kPo8Qb53f5Smnng2BpC2gC88+SePD3fWs
         gOzELo1MimWkNbNwk1tf85bgvffkJ5OVfDo21ZeAtRkNasFsmM/vsVq5J4jekI8uzujI
         8MJfHu537HQwIfwhGLti1bkp5aBrH2ABqbeoS6oWSk7YfzR04O2k8YC0OjnvWN87ii1T
         oYiw==
X-Gm-Message-State: APjAAAWOagBPsKR92SAk5K6bce8YPIIekjnJKUWGgfFk4AjNLZO6oGE5
        en4zLMUnaGrJlSfbBJxkG9fe5I+q
X-Google-Smtp-Source: APXvYqxndPqHVxIHe63ZUThkAaMUEXaaoIZyED6YAbYpSbBXh+m6JJ93cT5e3vlVVimUo6YvZaoW2Q==
X-Received: by 2002:a1c:c1cc:: with SMTP id r195mr16991339wmf.50.1569830543182;
        Mon, 30 Sep 2019 01:02:23 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id a3sm19395536wmc.3.2019.09.30.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:02:22 -0700 (PDT)
Date:   Mon, 30 Sep 2019 10:02:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [GIT PULL 1/2] arm64: dts: exynos: Pull for v5.4
Message-ID: <20190930080217.GA23709@pi3>
References: <20190911183632.4317-1-krzk@kernel.org>
 <CAK8P3a2pBV+fh0rHitZ30Zz61QNRLfNSD-nhnzq4ZtxSh66F1Q@mail.gmail.com>
 <CAJKOXPcOSvc2DfoN+7Tca=t5dSm3RcKqmm06AfR0PAVBeY=GvQ@mail.gmail.com>
 <20190929175134.fsieffurfdiqhpj2@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190929175134.fsieffurfdiqhpj2@localhost>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 10:51:34AM -0700, Olof Johansson wrote:
> Hi,
> 
> On Thu, Sep 12, 2019 at 08:32:47AM +0200, Krzysztof Kozlowski wrote:
> > On Wed, 11 Sep 2019 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Wed, Sep 11, 2019 at 8:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Unfortunately the patches were applied right after closing the linux-next.
> > >
> > > Hi Krzysztof,
> > >
> > > I took a look at these and am not convinced this is right:
> > >
> > > > 1. Fix boot of Exynos7 due to wrong address/size of memory node,
> > >
> > > The current state is clearly broken and a fix is needed, but
> > > I'm not sure this is the right fix. Why do you have 32-bit physical
> > > addressing on a 64-bit chip? I looked at commit ef72171b3621
> > > that introduced it, and it seems it would be better to just
> > > revert back to 64-bit addresses.
> > 
> > We discussed with Marek Szyprowski that either we can go back to
> > 64-bit addressing or stick to 32. There are not known boards with more
> > than 4 GB of RAM so from this point of view the choice was irrelevant.
> > At the end of discussion I mentioned to stick with other arm64 boards
> > (although not all), so revert to have 64 bit address... but Marek
> > chosen differently. Since you ask, let's go back with revert.
> > 
> > >
> > > > 2. Move GPU under /soc node,
> > >
> > > No problem
> > >
> > > > 3. Minor cleanup of #address-cells.
> > >
> > > IIRC, an interrupt-controller is required to have a #address-cells
> > > property, even if that is normally zero. I don't remember the
> > > details, but the gic binding lists it as mandatory, and I think
> > > the PCI interrupt-map relies on it. I would just drop this patch.
> > 
> > Indeed, binding requires both address and size cells. I'll drop it.
> 
> Looking through the history of pending material, I didn't see a new pull for
> this material. Just checking in to see if there's something we missed?

No, it's me who forgot to resend. I was sure that I rebased the branch
and created new pull request. However it seems I did not. Let's keep it
for next merge window... v5.4-rc should be any minute, I guess?

Best regards,
Krzysztof

