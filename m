Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9815E233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfH1NEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:04:35 -0400
Received: from foss.arm.com ([217.140.110.172]:58902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfH1NEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:04:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56B99344;
        Wed, 28 Aug 2019 06:04:33 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BD043F246;
        Wed, 28 Aug 2019 06:04:31 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:04:30 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     edubezval@gmail.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 4/4] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190828130427.ed5372yq73qysjgh@queper01-lin>
References: <20190812084235.21440-1-quentin.perret@arm.com>
 <20190812084235.21440-5-quentin.perret@arm.com>
 <ebfd68984103084d63cf01a80cfa9538a1a15baf.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfd68984103084d63cf01a80cfa9538a1a15baf.camel@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 Aug 2019 at 20:58:47 (+0800), Zhang Rui wrote:
> this patch has coding style problems, please check the checkpatch.pl
> output.
> total: 5 errors, 17 warnings, 413 lines checked

Argh ! And that's what happens when I forget checkpatch ...
I'll fix this shortly. Sorry about that.

Quentin
