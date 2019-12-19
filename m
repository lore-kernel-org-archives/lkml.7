Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBE7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA06D2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576732480;
	bh=zutbo+tkyWAeoZo0maixsENGTToLoAmt9MwqGd10Gvk=;
	h=In-Reply-To:References:Cc:Subject:From:To:Date:List-ID:From;
	b=knNLsWKDCzyUQuwzwuUg/F1zkm6msf9iIQxLbEDCMXBdel7RlrcyOMzJ2au+W5xoN
	 YXgaVD2cGtNpeKPZF7BidGqM0PXM8PIK08MVul/j+vPI5oLwAgtqu8t+Otq/Lde7iK
	 Jo7xjhjQIe6H0LiwiANS8anUWoLtz962zW4f9FlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLSFOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfLSFOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:14:39 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B842146E;
        Thu, 19 Dec 2019 05:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576732478;
        bh=zutbo+tkyWAeoZo0maixsENGTToLoAmt9MwqGd10Gvk=;
        h=In-Reply-To:References:Cc:Subject:From:To:Date:From;
        b=SvdIWTueB22fAa/EqIDmetplXA/yHVHTxROAlv9nALYp6XEVxf+PZ13hSd6ZP7zUq
         aTg2Gj1IuqzblN2opxfhhQGK69ycvcncMQcLaTtpyasdIk7oDDXmNz1FnV+R7GK84H
         +SADY9DR+IEd06Bjcm6lnOiXp6BUonTRz8RoxwAc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191218190454.420358-3-lkundrak@v3.sk>
References: <20191218190454.420358-1-lkundrak@v3.sk> <20191218190454.420358-3-lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 2/2] clk: mmp2: Fix the order of timer mux parents
From:   Stephen Boyd <sboyd@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
User-Agent: alot/0.8.1
Date:   Wed, 18 Dec 2019 21:14:37 -0800
Message-Id: <20191219051438.C2B842146E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-12-18 11:04:54)
> Determined empirically, no documentation is available.
>=20
> The OLPC XO-1.75 laptop used parent 1, that one being VCTCXO/4 (65MHz), b=
ut
> thought it's a VCTCXO/2 (130MHz). The mmp2 timer driver, not knowing
> what is going on, ended up just dividing the rate as of
> commit f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")'
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Any Fixes: tag?

Acked-by: Stephen Boyd <sboyd@kernel.org>

