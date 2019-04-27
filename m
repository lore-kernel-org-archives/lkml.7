Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FB6C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8127B2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="G5vTyYid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfD0KWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:22:08 -0400
Received: from onstation.org ([52.200.56.107]:52326 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfD0KWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:22:07 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D55B63E93E;
        Sat, 27 Apr 2019 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1556360527;
        bh=wr+RyPvYNqIRm6tunmtg3868yYxfiG8UhCrxuizzydY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5vTyYidclsI7YEfnuTRkHsJdeReakcnhtoqfB9SBEj+m7vg20mLLTqkSwl40wx0l
         xsJGhRs6ik3AZvlfR6ceLDJSWtIKH4526Uwdz4azyYiHvFYaxyHMFJker+Q3HW+jEB
         mNhOZlepj8B+xhnBxuhxO4LczdRovsLttmm4E0yw=
Date:   Sat, 27 Apr 2019 06:22:06 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/8] qcom: spmi/ssbi gpio: correct gpio hogging
Message-ID: <20190427102206.GA296@basecamp>
References: <20190306005316.12232-1-masneyb@onstation.org>
 <20190427053034.GH3137@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427053034.GH3137@builder>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Fri, Apr 26, 2019 at 10:30:34PM -0700, Bjorn Andersson wrote:
> On Tue 05 Mar 16:53 PST 2019, Brian Masney wrote:
> 
> > Here are some patches that fix gpio hogging for all boards that use
> > spmi-gpio and ssbi-gpio. These depend on the following two patches
> > that were merged in 4.20-rc1:
> > 
> > commit 149a96047237 ("pinctrl: qcom: spmi-gpio: fix gpio-hog related
> > boot issues")
> > 
> > commit 7ed078557738 ("pinctrl: qcom: ssbi-gpio: fix gpio-hog related
> > boot issues")
> > 
> > I've already fixed pm8941 for the Nexus 5 and that fix is queued to go
> > into v5.1 during this merge window:
> > 
> > https://lore.kernel.org/lkml/20181101001149.13453-7-masneyb@onstation.org/
> > 
> > Andy: You may want to consider submitting these post rc1 as a fix for
> > v5.1 and possibly marking these for stable.
> > 
> > Brian Masney (8):
> >   ARM: dts: qcom: apq8064: add gpio-ranges
> >   ARM: dts: qcom: mdm9615: add gpio-ranges
> >   ARM: dts: qcom: msm8660: add gpio-ranges
> >   ARM: dts: qcom: pma8084: add gpio-ranges
> 
> Looks like I missed the ARM patches before. All 8 picked up now, with
> Linus' r-b.

Andy already picked these 8 patches up in his tree.

https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next

Brian
