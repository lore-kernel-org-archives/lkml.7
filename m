Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B4C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055BB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfDOV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:57:54 -0400
Received: from stcim.de ([78.46.90.227]:43660 "EHLO stcim.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfDOV5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:57:54 -0400
Received: from xdsl-89-0-59-235.nc.de ([89.0.59.235] helo=porty)
        by stcim with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <contact@stefanchrist.eu>)
        id 1hG9bo-00010H-Rg; Mon, 15 Apr 2019 23:57:49 +0200
Date:   Mon, 15 Apr 2019 23:57:48 +0200
From:   Stefan Lengfeld <contact@stefanchrist.eu>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/12] i2c: core: introduce callbacks for atomic transfers
Message-ID: <20190415215748.e6jrii25nqliy7me@porty>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-4-wsa+renesas@sang-engineering.com>
X-PGP-Key: https://stefanchrist.eu/personal/Stefan_Lengfeld_0xE44A23B289092311.asc
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Apr 03, 2019 at 02:40:10PM +0200, Wolfram Sang wrote:
> We had the request to access devices very late when interrupts are not
> available anymore multiple times now. Mostly to prepare shutdown or
> reboot. Allow adapters to specify a specific callback for this case.
> Note that we fall back to the generic {master|smbus}_xfer callback if
> this new atomic one is not present. This is intentional to preserve the
> previous behaviour and avoid regressions. Because there are drivers not
> using interrupts or because it might have worked "accidently" before.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Stefan Lengfeld <contact@stefanchrist.eu>

Kind regards,
Stefan
