Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CDD2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Z3qXzv/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfKZVp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:45:59 -0500
Received: from vps.xff.cz ([195.181.215.36]:45622 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKZVp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1574804757; bh=ayuTHAY+hrJkpnkLRJINl7ENLTS1Zur7p3Jq1ISHp2Q=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=Z3qXzv/O3SYbEixrKlvHyyL09gNT5vLKKJjl/vq4otAMu+mlquQJ8a5wAj/cJVsWm
         ETm6Op5i2/z21fDH0kyV3qIJebXojimVr9xu4wTr5oKJdVdBFNHgZTERYd1M92RN11
         1nuZ4j/aPHycRyuJDFoiPjjx1Xv2F3TK/cjuRU+U=
Date:   Tue, 26 Nov 2019 22:45:57 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] arm: Fix topology setup in case of CPU hotplug for
 CONFIG_SCHED_MC
Message-ID: <20191126214557.53afmorihwqimq2n@core.my.home>
Mail-Followup-To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20191120104212.14791-1-dietmar.eggemann@arm.com>
 <20191124214753.m6lwcdemnddltctw@core.my.home>
 <50dfafee-55c3-767c-55f4-7d263feafe87@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50dfafee-55c3-767c-55f4-7d263feafe87@arm.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 11:42:02AM +0100, Dietmar Eggemann wrote:
> On 24/11/2019 22:47, Ondřej Jirman wrote:
> > Hello,
> > 
> > On Wed, Nov 20, 2019 at 10:42:12AM +0000, Dietmar Eggemann wrote:
> 
> [...]
> 
> >> Fixes: ca74b316df96 ("arm: Use common cpu_topology structure and functions")
> >> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > 
> > This fixes CPU hotplug and correspondent suspend to ram/resume failures (that
> > disables and re-enables non-boot CPUs) on A83T SoC, that I've seen since
> > 5.4-rc1.
> > 
> > Tested-by: Ondrej Jirman <megous@megous.com>
> 
> Thanks for testing! Which Cpufreq driver is your system using?

Hello,

it's using cpufreq-dt.

regards,
	o.

> [...]
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
