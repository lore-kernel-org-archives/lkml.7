Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA38DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4802168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440253AbfIWR6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:58:31 -0400
Received: from muru.com ([72.249.23.125]:34314 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393421AbfIWR6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:58:30 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DE9AA809F;
        Mon, 23 Sep 2019 17:59:02 +0000 (UTC)
Date:   Mon, 23 Sep 2019 10:58:27 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: devicetree.c: remove orphan
 pinctrl_dt_has_hogs()
Message-ID: <20190923175827.GA5610@atomide.com>
References: <20190923142005.5632-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923142005.5632-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rasmus Villemoes <linux@rasmusvillemoes.dk> [190923 14:20]:
> The helper pinctrl_dt_has_hogs() was introduced in
> 99e4f67508e1 (pinctrl: core: Use delayed work for hogs), but the sole
> use then got removed shortly after in 950b0d91dc10 (pinctrl: core: Fix
> regression caused by delayed work for hogs).

Oops, thanks for catching it:

Acked-by: Tony Lindgren <tony@atomide.com>
