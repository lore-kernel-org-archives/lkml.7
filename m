Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD230C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A120121848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfJBRYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:24:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34488 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:24:22 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 83D8E1542A3B8;
        Wed,  2 Oct 2019 10:24:20 -0700 (PDT)
Date:   Wed, 02 Oct 2019 10:24:17 -0700 (PDT)
Message-Id: <20191002.102417.205729199993915832.davem@davemloft.net>
To:     guillaume.tucker@collabora.com
Cc:     yamada.masahiro@socionext.com, torvalds@linux-foundation.org,
        mgalka@collabora.com, broonie@kernel.org, matthew.hart@linaro.org,
        khilman@baylibre.com, enric.balletbo@collabora.com,
        ndesaulniers@google.com, akpm@linux-foundation.org,
        tomeu.vizoso@collabora.com, urezki@gmail.com,
        joe.lawrence@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, penguin-kernel@i-love.sakura.ne.jp,
        schowdary@nvidia.com, catalin.marinas@arm.com
Subject: Re: net-next/master boot bisection: v5.3-13203-gc01ebd6c4698 on
 bcm2836-rpi-2-b
From:   David Miller <davem@davemloft.net>
In-Reply-To: <d8357536-6750-d9ba-e114-30944d8f95ab@collabora.com>
References: <5d94766b.1c69fb81.6d9f4.dc6d@mx.google.com>
        <d8357536-6750-d9ba-e114-30944d8f95ab@collabora.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Oct 2019 10:24:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Tucker <guillaume.tucker@collabora.com>
Date: Wed, 2 Oct 2019 18:21:31 +0100

> It seems like this isn't the case on the Raspberry Pi 2b with
> bcm2835_defconfig.  Here's an example of the kernel errors:

This has been fixed upstream I believe, it was some ARM assembler issue
or something like that.

In any event, definitely not a networking problem. :-)
