Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F5C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49046212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559941435;
	bh=7kLqo99x+myLGFG7D6oUu2gs7/bAKpDL+w8QlyMuDoI=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=w6FjSRmJEkZsloPmyLWgEq3nX9MUP8n3QbSub2sCgjWD0yzll9zjfKZZ7y25/BGZ2
	 Pg8OAjyHXroMS6Q3DXP3br4nFfdByGnknXBZKJ8h12TcDYK4PO9CzW1SzQbpEyJKlR
	 U4ajN0oRJ8TJJhq3ZtJn8o5iO3EaNf50SNvr6iw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfFGVDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfFGVDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:03:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A481208C0;
        Fri,  7 Jun 2019 21:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559941433;
        bh=7kLqo99x+myLGFG7D6oUu2gs7/bAKpDL+w8QlyMuDoI=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=zrqXXleyyiFBnXGMABSdHQoJlpoFCx660fQrvdSMyGm7ZMRwS7R+VmvkBr4PegzJI
         P/CP5xBIT28/xZCHnxlrPkHqZKRLjnXGJlIxug2e+epe+IK1pzSc7z+pitqcV0vERM
         +E3u9ohhCKQNFTlAi7WS/Pf9dToYqkIPvXmCnCcI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190502212502.24330-3-paul@crapouillou.net>
References: <20190502212502.24330-1-paul@crapouillou.net> <20190502212502.24330-3-paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/5] clk: ingenic/jz4770: Fix incorrect dividers for main clocks
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 14:03:52 -0700
Message-Id: <20190607210353.4A481208C0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-05-02 14:25:00)
> The main clocks (cclk, h0clk, h1clk, h2clk, c1clk, pclk) were using
> incorrect dividers, and thus reported an incorrect rate.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

