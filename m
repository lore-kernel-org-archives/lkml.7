Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D603EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA86F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403985AbfEXN5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:57:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44992 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403843AbfEXN47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:56:59 -0400
Received: from [IPv6:2a00:5f00:102:0:6dae:eb08:2e0f:5281] (unknown [IPv6:2a00:5f00:102:0:6dae:eb08:2e0f:5281])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 34688283DBD;
        Fri, 24 May 2019 14:56:58 +0100 (BST)
Subject: Re: mainline/master boot bisection: v5.2-rc1-172-g4dde821e4296 on
 meson-g12a-x96-max
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     tomeu.vizoso@collabora.com, mgalka@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org,
        matthew.hart@linaro.org, enric.balletbo@collabora.com,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <5ce78689.1c69fb81.58097.eacf@mx.google.com>
 <7hmujc0xnp.fsf@baylibre.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <f01b812e-ee18-528b-1859-620dd8f0fb53@collabora.com>
Date:   Fri, 24 May 2019 14:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7hmujc0xnp.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 14:50, Kevin Hilman wrote:
> "kernelci.org bot" <bot@kernelci.org> writes:
> 
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
>> mainline/master boot bisection: v5.2-rc1-172-g4dde821e4296 on meson-g12a-x96-max
>>
>> Summary:
>>   Start:      4dde821e4296 Merge tag 'xfs-5.2-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
>>   Details:    https://kernelci.org/boot/id/5ce72c6259b514ed817a3640
>>   Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-172-g4dde821e4296/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.txt
>>   HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-172-g4dde821e4296/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.html
>>   Result:     11a7bea17c9e arm64: dts: meson: g12a: add pinctrl support controllers
> 
> False alarm.
> 
> This one is failing in one lab but passing in another:
> https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v5.2-rc1-172-g4dde821e4296/
> 
> I'll look into what's the difference between labs.

Thanks for clarifying this.  I guess we should fix the logic
which detects regressions to discard cases where there is a
conflict between results in different labs.

Guillaume
