Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB11CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523BA214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572255263;
	bh=5SNe1YQt5wJ+qM2Hq/9urdRM6IpimM8L/9d2E8ooBA8=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=Z3BZUFToH15QlmgoYg7lbHZc14oRPZj/SVnGy1yZfQEm5u/MKHacf5TGt5zBlTsQN
	 IsqQBlQ8jvh39C5PeA125gGBebX6XgGy4CL4NnvVJJmKFd/Ygl/tWA89vAgx5dNFVD
	 AJYe2O1Q6WQXH8iGCjkaj9ssUQI3lTE1vc3SrDUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfJ1JeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbfJ1JeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:34:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5C120B7C;
        Mon, 28 Oct 2019 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572255261;
        bh=5SNe1YQt5wJ+qM2Hq/9urdRM6IpimM8L/9d2E8ooBA8=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=I4bKVX0icw11mdMLxAGaZvsJ33V2GZI6JsqYC3vyXtWqf0qiQiXzL/6YpjfHgurov
         mxhD0Zy3ct8a5kr9vAbMnxz+jpwYrJgFbtAiw+pVgGsbk7lFCoHKp/aJ4qwK/dwbLS
         Ce0CioKx30+Ni5bHrzTF7toEoitPOxivfxWTkKDU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191018154201.1276638-37-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-37-arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 37/46] ARM: pxa: move clk register definitions to driver
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
User-Agent: alot/0.8.1
Date:   Mon, 28 Oct 2019 02:34:20 -0700
Message-Id: <20191028093421.4F5C120B7C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2019-10-18 08:41:52)
> The clock register definitions are now used (almost) exclusively in the
> clk driver, and that relies on no other mach/*.h header files any more.
>=20
> Remove the dependency on mach/pxa*-regs.h by addressing the registers
> as offsets from a void __iomem * pointer, which is either passed from
> a board file, or (for the moment) ioremapped at boot time from a hardcoded
> address in case of DT (this should be moved into the DT of course).
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

