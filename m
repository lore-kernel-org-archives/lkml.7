Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTTP_ESCAPED_HOST,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520DC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462AA20675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfDYRoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:44:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35290 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:44:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 4827A277A3B
Subject: Re: clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
To:     Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        matthew.hart@linaro.org, mgalka@collabora.com,
        tomeu.vizoso@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5cbe596c.1c69fb81.e252.b9d0@mx.google.com>
 <155598159898.15276.8408514960097680895@swboyd.mtv.corp.google.com>
 <20190423144028.GA8007@atomide.com> <20190425172807.GW2803@sirena.org.uk>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <9d076ce7-ce9b-07d9-21c7-e3e2eddf2fdb@collabora.com>
Date:   Thu, 25 Apr 2019 18:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190425172807.GW2803@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 18:28, Mark Brown wrote:
> On Tue, Apr 23, 2019 at 07:40:28AM -0700, Tony Lindgren wrote:
> 
>> Hmm do you guys have some index page of all the found "boot bisection"
>> issues that I can check every morning while drinking coffee? :)
> 
> Sadly there's no web UI for this bit of the system.  The nearest would
> be trying to find the reports on LKML but that is suboptimal.

Quite:

  https://www.google.co.uk/search?q=lkml.org+%22boot%20bisection%3A%22

Also there aren't that many bisections, maybe a couple per month.
I think we could cc the KernelCI reports mailing list, or maybe
have a new list, for people who want to receive all the bisection
reports.  There should be more as we keep adding trees and
especially when we start bisecting test suite results, not just
boots.

Guillaume
