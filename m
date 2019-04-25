Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTTP_ESCAPED_HOST,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05697C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3507F20685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfDYT22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:28:28 -0400
Received: from muru.com ([72.249.23.125]:47438 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfDYT22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:28:28 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 557398105;
        Thu, 25 Apr 2019 19:28:43 +0000 (UTC)
Date:   Thu, 25 Apr 2019 12:28:23 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        matthew.hart@linaro.org, mgalka@collabora.com,
        tomeu.vizoso@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
Message-ID: <20190425192823.GF8007@atomide.com>
References: <5cbe596c.1c69fb81.e252.b9d0@mx.google.com>
 <155598159898.15276.8408514960097680895@swboyd.mtv.corp.google.com>
 <20190423144028.GA8007@atomide.com>
 <20190425172807.GW2803@sirena.org.uk>
 <9d076ce7-ce9b-07d9-21c7-e3e2eddf2fdb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d076ce7-ce9b-07d9-21c7-e3e2eddf2fdb@collabora.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Guillaume Tucker <guillaume.tucker@collabora.com> [190425 17:44]:
> On 25/04/2019 18:28, Mark Brown wrote:
> > On Tue, Apr 23, 2019 at 07:40:28AM -0700, Tony Lindgren wrote:
> > 
> >> Hmm do you guys have some index page of all the found "boot bisection"
> >> issues that I can check every morning while drinking coffee? :)
> > 
> > Sadly there's no web UI for this bit of the system.  The nearest would
> > be trying to find the reports on LKML but that is suboptimal.
> 
> Quite:
> 
>   https://www.google.co.uk/search?q=lkml.org+%22boot%20bisection%3A%22
> 
> Also there aren't that many bisections, maybe a couple per month.
> I think we could cc the KernelCI reports mailing list, or maybe
> have a new list, for people who want to receive all the bisection
> reports.  There should be more as we keep adding trees and
> especially when we start bisecting test suite results, not just
> boots.

OK well maybe still consider an automatically generated index page
of last few tens "boot bisection" links at some point.

Assuming LKML is always in Cc, and the "boot bisection" report
has the breaking patch inlined, it should show up also at
lore.kernel.org. So the next time around I have hard time
finding out if somebody already bisected something, I'll just
try:

https://lore.kernel.org/lkml/?q=%22boot+bisection%22

Regards,

Tony
