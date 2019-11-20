Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1504C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBB6222A2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfKTIRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:17:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38906 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKTIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:17:35 -0500
Received: from [IPv6:2a00:5f00:102:0:3cf0:90ff:fe97:bc05] (unknown [IPv6:2a00:5f00:102:0:3cf0:90ff:fe97:bc05])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F3E37291278;
        Wed, 20 Nov 2019 08:17:31 +0000 (GMT)
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
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <53eda2aa-35d0-8776-e2cb-b6c4e8c1ff7f@collabora.com>
Date:   Wed, 20 Nov 2019 08:17:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5dd4ce40.1c69fb81.548f8.e723@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2019 05:25, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> clk/clk-next bisection: boot on tegra124-nyan-big
> 
> Summary:
>   Start:      cd89054e321a Merge branch 'clk-init-leak' into clk-next
>   Details:    https://kernelci.org/boot/id/5dd486b059b514415acf54bd
>   Plain log:  https://storage.kernelci.org//clk/clk-next/clk-fixes-for-linus-196-gcd89054e321a/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big.txt
>   HTML log:   https://storage.kernelci.org//clk/clk-next/clk-fixes-for-linus-196-gcd89054e321a/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big.html
>   Result:     25175c806a68 clk: tegra: Reimplement SOR clock on Tegra124
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       clk
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
>   Branch:     clk-next
>   Target:     tegra124-nyan-big
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     tegra_defconfig
>   Test suite: boot
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 25175c806a6841149abe46168e0af12593141612
> Author: Thierry Reding <treding@nvidia.com>
> Date:   Thu Jul 25 18:19:00 2019 +0200
> 
>     clk: tegra: Reimplement SOR clock on Tegra124
>     
>     In order to allow the display driver to deal uniformly with all SOR
>     generations, implement the SOR clocks in a way that is compatible with
>     Tegra186 and later.
>     
>     Acked-by: Stephen Boyd <sboyd@kernel.org>
>     Signed-off-by: Thierry Reding <treding@nvidia.com>

There was already a bisection last Thursday which found this
commit, and Thierry explained that it works in linux-next thanks
to other patches.  I guess those patches are not going to be
cherry-picked onto the clk-next branch, so this will keep failing
until it's rebased.  Is that right?

If so, I can turn off bisections on clk-next for now.  We need to
have a way in KernelCI to tell that a commit has been fixed to
cope with this kind of situation in general.

Thanks,
Guillaume
