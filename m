Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B181CC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828D221835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436544AbfIGRIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:08:55 -0400
Received: from muru.com ([72.249.23.125]:60162 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbfIGRIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:08:55 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A75FC805C;
        Sat,  7 Sep 2019 17:09:23 +0000 (UTC)
Date:   Sat, 7 Sep 2019 10:08:50 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] ARM: dts: replace opp-v1 tables by opp-v2 for
 omap34xx and omap36xx
Message-ID: <20190907170850.GI52127@atomide.com>
References: <cover.1567839375.git.hns@goldelico.com>
 <326e1bfe9e7c04346b4fcc0386303d7f93d0ba77.1567839375.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326e1bfe9e7c04346b4fcc0386303d7f93d0ba77.1567839375.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190907 06:57]:
> In addition, move omap3 from whitelist to blacklist in cpufreq-dt-platdev
> in the same patch, because doing either first breaks operation and
> may make trouble in bisect.
> 
> We also can remove opp-v1 table for omap3-n950-n9 since it is now
> automatically detected.
> 
> We also fix a wrong OPP4 voltage for omap3430 which must be
> 0.6V + 54*12.5mV = 1275mV. Otherwise the twl4030 driver will reject
> this OPP.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Acked-by: Tony Lindgren <tony@atomide.com>
