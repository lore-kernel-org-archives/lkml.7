Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A694BCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EBA2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405520AbfJRFvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:51:08 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55252 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfJRFvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:51:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41B33329;
        Thu, 17 Oct 2019 22:50:39 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905093F68E;
        Thu, 17 Oct 2019 22:53:24 -0700 (PDT)
Date:   Fri, 18 Oct 2019 06:50:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v2 2/5] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191018055027.GB31836@e107533-lin.cambridge.arm.com>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
 <20191017123508.26130-3-sudeep.holla@arm.com>
 <20191018054740.maqbzbk7secgpc2r@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018054740.maqbzbk7secgpc2r@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:17:40AM +0530, Viresh Kumar wrote:
> On 17-10-19, 13:35, Sudeep Holla wrote:
> > diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> > similarity index 90%
> > rename from drivers/cpufreq/arm_big_little.c
> > rename to drivers/cpufreq/vexpress-spc-cpufreq.c
> > index 7fe52fcddcf1..b7e1aa000c80 100644
> > --- a/drivers/cpufreq/arm_big_little.c
> > +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> > @@ -1,20 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * ARM big.LITTLE Platforms CPUFreq support
> > + * Versatile Express SPC CPUFreq Interface driver
> >   *
> > - * Copyright (C) 2013 ARM Ltd.
> > - * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> > + * Copyright (C) 2019 ARM Ltd.
>
> Should this be 2013-2019 instead ?
>

Sure.

--
Regards,
Sudeep
