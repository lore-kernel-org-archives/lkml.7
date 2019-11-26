Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC34C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABFA2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfKZT4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:56:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57126 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKZT4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:56:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id AA72C283CEA
Subject: Re: clk/clk-next bisection: boot on tegra124-nyan-big
To:     Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     tomeu.vizoso@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <5dd4ce40.1c69fb81.548f8.e723@mx.google.com>
 <53eda2aa-35d0-8776-e2cb-b6c4e8c1ff7f@collabora.com>
 <20191122170141.4B9BF2068F@mail.kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <2e734116-55da-c799-58b4-14e8c02deece@collabora.com>
Date:   Tue, 26 Nov 2019 19:55:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122170141.4B9BF2068F@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2019 17:01, Stephen Boyd wrote:
> Quoting Guillaume Tucker (2019-11-20 00:17:28)
>> On 20/11/2019 05:25, kernelci.org bot wrote:
>>> Author: Thierry Reding <treding@nvidia.com>
>>> Date:   Thu Jul 25 18:19:00 2019 +0200
>>>
>>>     clk: tegra: Reimplement SOR clock on Tegra124
>>>     
>>>     In order to allow the display driver to deal uniformly with all SOR
>>>     generations, implement the SOR clocks in a way that is compatible with
>>>     Tegra186 and later.
>>>     
>>>     Acked-by: Stephen Boyd <sboyd@kernel.org>
>>>     Signed-off-by: Thierry Reding <treding@nvidia.com>
>>
>> There was already a bisection last Thursday which found this
>> commit, and Thierry explained that it works in linux-next thanks
>> to other patches.  I guess those patches are not going to be
>> cherry-picked onto the clk-next branch, so this will keep failing
>> until it's rebased.  Is that right?
>>
>> If so, I can turn off bisections on clk-next for now.  We need to
>> have a way in KernelCI to tell that a commit has been fixed to
>> cope with this kind of situation in general.
>>
> 
> I guess so. It's disappointing that a bisection hole was introduced
> though. I can possibly merge something onto clk-next from the Tegra tree
> to make this go away but the bisection hole will always exist. Or we can
> all wait a week and not care about this problem anymore.

Yes, let's just wait.  I'll check next week that the issue is
gone in the test reports and re-enable bisection accordingly.

Guillaume

