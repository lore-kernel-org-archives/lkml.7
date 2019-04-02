Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CCFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B507206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfDBQ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:26:09 -0400
Received: from foss.arm.com ([217.140.101.70]:54104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730423AbfDBQ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:26:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA6C5374;
        Tue,  2 Apr 2019 09:26:08 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FA313F721;
        Tue,  2 Apr 2019 09:26:07 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:26:05 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, tglx@linutronix.de, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cpuidle/drivers/mbed: Add new governor for embedded
 systems
Message-ID: <20190402162605.sfu7xasexmno5qx7@queper01-lin>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
 <20190308212047.28767-4-daniel.lezcano@linaro.org>
 <20190402132236.7h264nffbgnojznw@queper01-lin>
 <a8db3115-b12b-3a8a-5dfc-a3d068ac3810@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8db3115-b12b-3a8a-5dfc-a3d068ac3810@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Apr 2019 at 18:02:02 (+0200), Daniel Lezcano wrote:
> I tried on a hikey960 with an android kernel 4.19.

OK. ISTR Hikey 960 had quite a few problems with idle states recently.
At some point it was so horribly broken that you could get something
like a 3x perf bonus in Jankbench _and_ save energy by just disabling
all idles states no ? I haven't been following closely but have these
issues been resolved ?

In any cases, your results seem to go in the right direction, and that's
not a blocker to go on with the review so :-)

> 
> The used percentile is the 95%, the tests are jankbench list_view and
> edit_text, and exoplayer. Values are normalized against the menu governor:
> 
> list_view:
>  frame duration -35%
>  count: +20%
>  energy: +1%
> 
> edit text:
>  frame duration -45%
>  count: +27%
>  energy: -0.3%
> 
> For audio and video playback, there is no frame drop.
> 
> audio
>  - energy: -2.8%
> 
> video
>  - energy: -3.8%
> 
> These are preliminary results.

Thanks for the details. Assuming the board support isn't too broken,
these look pretty good.

Cheers,
Quentin
