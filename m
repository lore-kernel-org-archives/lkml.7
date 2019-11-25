Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7802C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A56B2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfKYKrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:47:17 -0500
Received: from ozlabs.org ([203.11.71.1]:37283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfKYKrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:14 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3dD2Kjlz9sRY; Mon, 25 Nov 2019 21:47:11 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8795a739e5c72abeec51caf36b6df2b37e5720c5
In-Reply-To: <bf930402613b41b42d0441b784e0cc43fc18d1fb.1572529632.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/sysdev: drop simple gpio
Message-Id: <47M3dD2Kjlz9sRY@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:11 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-31 at 13:47:30 UTC, Christophe Leroy wrote:
> There is a config item CONFIG_SIMPLE_GPIO which
> provides simple memory mapped GPIOs specific to powerpc.
> 
> However, the only platform which selects this option is
> mpc5200, and this platform doesn't use it.
> 
> There are three boards calling simple_gpiochip_init(), but
> as they don't select CONFIG_SIMPLE_GPIO, this is just a nop.
> 
> Simple_gpio is just redundant with the generic MMIO GPIO
> driver which can be found in driver/gpio/ and selected via
> CONFIG_GPIO_GENERIC_PLATFORM, so drop simple_gpio driver.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8795a739e5c72abeec51caf36b6df2b37e5720c5

cheers
