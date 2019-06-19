Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D0FC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53C220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfFSIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:35:47 -0400
Received: from foss.arm.com ([217.140.110.172]:55812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbfFSIfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:35:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED6B9CFC;
        Wed, 19 Jun 2019 01:35:45 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 105993F246;
        Wed, 19 Jun 2019 01:35:43 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:35:42 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/3] Make IPA use PM_EM
Message-ID: <20190619083539.mveyly5celgs5pmg@queper01-lin>
References: <20190530092038.12020-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530092038.12020-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 May 2019 at 10:20:35 (+0100), Quentin Perret wrote:
> Quentin Perret (3):
>   arm64: defconfig: Enable CONFIG_ENERGY_MODEL
>   thermal: cpu_cooling: Make the power-related code depend on IPA
>   thermal: cpu_cooling: Migrate to using the EM framework
> 
>  arch/arm64/configs/defconfig  |   1 +
>  drivers/thermal/Kconfig       |   1 +
>  drivers/thermal/cpu_cooling.c | 428 ++++++++++++++--------------------
>  3 files changed, 178 insertions(+), 252 deletions(-)

Gentle ping on this :-)

Is there any chance for the series to make it in 5.3 ? Or is it too late
already ? In any case do let me know if there is anything I can do about
it.

Many thanks,
Quentin
