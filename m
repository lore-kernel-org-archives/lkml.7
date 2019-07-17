Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6382C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAA820880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563394104;
	bh=q1RZuoJ0KNx0kwwTFepZFUYUm+UwOXQ71bx5OWCE9YE=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=g9FyxOEyEm9c9ED6nHjc+djsTnLNV8xpOdSMI5DkqRumyIpaoqHlry2QReAoFvcDG
	 vFsONwToCkIuUGu2GwRyx9klLgD0ucgYRcKldX70zTcLmd5EqS7SCnBNyTBbtotWss
	 wbgztZp/m4AHdSUX4322IJgcDuZjEpc+gKujsoBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfGQUIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfGQUIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:08:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77A120818;
        Wed, 17 Jul 2019 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563394101;
        bh=q1RZuoJ0KNx0kwwTFepZFUYUm+UwOXQ71bx5OWCE9YE=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=VLvETRuYIlo2HPZACe/xsmKOqdJXKcLNpAdiE3R3w03k9QztUe2xijFzIFwLcuDKc
         f3vuIss/LZJUonZR4/CuN2mYYEbt3f4nI9YZTYOo1tNDmIuC9OIsrmBI3E1LCMjb03
         8/jA+fN2Ztb1qQFWSWVSJTkIlQX7lQs6OsqeiQi4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190715173527.5719-1-digetx@gmail.com>
References: <20190715173527.5719-1-digetx@gmail.com>
Subject: Re: [PATCH v1 1/2] clk: tegra: divider: Fix missing check for enable-bit on rate's recalculation
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 13:08:20 -0700
Message-Id: <20190717200821.A77A120818@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-07-15 10:35:26)
> Unset "enable" bit means that divider is in bypass mode, hence it doesn't
> have any effect in that case.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Any Fixes tags for these patches?

