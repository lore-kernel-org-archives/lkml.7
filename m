Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FCCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9FB21743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565213025;
	bh=grO+DVwLrFzvyLQYKg15Nx4cEFnP98gsoGYaAZVXCNE=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=wscO1ECJtIP7Yyx9vBr3S7cQ1oDfPGv+PgT3lv8lx4tvlaJkK2YxvEWcbyXI7MtYh
	 N+NzWCG+nEP706RN8i5dxsS0LUHpLeaO4v6phmOSnbvhVzbUFIvotehrimX9+kwVAF
	 oKPJG/pl4IOZB9UsI+XkvZA0cNSTXccZQQxc03P4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfHGVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388496AbfHGVXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:23:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD8921743;
        Wed,  7 Aug 2019 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565213022;
        bh=grO+DVwLrFzvyLQYKg15Nx4cEFnP98gsoGYaAZVXCNE=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=HyDHtsGXL7qFR5SHG5nRm31lPdR5tAbu0p7NddSzjlOnRyE7zT6ZyMv2KzD6jzKed
         wQ3AR2FAdiefQOUVhDCuOhH7JB2/zdKozYht+ePkhjbUGEzxSRyQ931W0+ymXlEB4m
         jeH/RMq/OXuyirasbX5na8iMfgKXnRlj5fSD4Jew=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190701165020.19840-1-colin.king@canonical.com>
References: <20190701165020.19840-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH][next] clk: Si5341/Si5340: remove redundant assignment to n_den
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 14:23:41 -0700
Message-Id: <20190807212342.ABD8921743@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-07-01 09:50:20)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable n_den is initialized however that value is never read
> as n_den is re-assigned a little later in the two paths of a
> following if-statement.  Remove the redundant assignment.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next

