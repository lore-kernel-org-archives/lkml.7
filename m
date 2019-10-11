Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D765C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E37214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfJKKFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:05:43 -0400
Received: from foss.arm.com ([217.140.110.172]:55194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfJKKFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:05:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4EAF337;
        Fri, 11 Oct 2019 03:05:41 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B43803F703;
        Fri, 11 Oct 2019 03:05:40 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:05:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
Message-ID: <20191011100521.GA5122@bogus>
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
 <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
> Hi
>
> Recently I've got access to ARM Juno R1 board and did some tests with
> current mainline kernel on it. I'm a bit surprised that enabling
> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
> this Kconfig option, I get no single message from the kernel, although I
> have earlycon enabled.
>

I don't have Juno R1 but I tried defconfig + CONFIG_PROVE_LOCKING and
it boots fine.

So if you disable CONFIG_PROVE_LOCKING(i.e. defconfig) boots fine ?
Are you using DTB from the mainline ?

> I've did my test with default defconfig and current linux-next,
> v5.4-rc1, v5.3 and v4.19. In all cases the result is the same. I'm
> booting kernel using a precompiled uboot from Linaro release and TFTP
> download.
>

OK, I use UEFI+GRUB but I don't think that should cause any issue.

> Is this a known issue? Other ARM64 boards I have access to (Samsung TM2e
> and RaspberryPi3) boots fine with the same kernel image.
>

Not that I am aware of. If you could send me the bootlog with defconfig
I can take a look and see if I get any clue.

--
Regards,
Sudeep
