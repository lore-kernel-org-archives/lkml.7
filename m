Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629492465A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576054447;
	bh=Tc8YsA7/71DabQY0k9cKjLttdsXrujqC2d8DJMqM3qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bqAXCZL6s61eB1FOdmmXHXpEcdPo1j8GqGzrAbxtGic2SPUEf1/TYn17fV3lKMm8u
	 kW2ohkh6OEG88R8d2QB7HOCNfQzZuOUWWhuObHGU8TNBkqTNaYUACBZoIp+4UeKrsZ
	 mBTrF66TdRc7Bn9IwZGNj3fNXh+UcAm8ODqg8juM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfLKIyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfLKIyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:54:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57321208C3;
        Wed, 11 Dec 2019 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576054442;
        bh=Tc8YsA7/71DabQY0k9cKjLttdsXrujqC2d8DJMqM3qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4cPSRVw2Zb/rJdUK+gV2aUCfvDB2TcTGVhprVnGgrxPFuQFf/iMW8re+RMQ/FfKb
         oqfHhjYOvHLZ2BmiBkpl0M+vFVbaTJdThGj7Rnper2oXXmXOYfZYmlY/MlbVSB4gSa
         piM/CAm89Q1DQh/5mOdOqSYEDAekisxNEQ/GYhUk=
Date:   Wed, 11 Dec 2019 09:54:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Wang <wvw@google.com>, Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
Message-ID: <20191211085400.GB500800@kroah.com>
References: <20191205071953.121511-1-wvw@google.com>
 <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
 <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
 <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:54:11PM +0100, Daniel Lezcano wrote:
> On 10/12/2019 21:01, Wei Wang wrote:
> > On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 05/12/2019 08:19, Wei Wang wrote:
> >>> The paths thermal_zone%d and cooling_device%d are not intuitive and the
> >>> numbers are subject to change due to device tree change. This usually
> >>> leads to tree traversal in userspace code.

tree traversal is supposed to be done in userspace code :)

But what userspace code needs to do this, and for what?

thanks,

greg k-h
