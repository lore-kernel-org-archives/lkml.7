Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E33BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3194C20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565742285;
	bh=XjNc9xrwgDsZ/WsZBpqRC6whCi5UKe+l9/+yDLvS4ZY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=rafMkWuAn/mUhD6yLiKjVUo83a09CQD4JuSekCshJp70KUwSuZyyY0dsY0tzdLxzd
	 Bjtb28bjYoD2e3JRHTm4NZL28Am4sEht9Rbb8HP9ZgLLVJzCPDtogtGaeIMhcBggC8
	 Xq5oM2vbOb63oOW5v5IfuI/PEyHnY8VaUL1bLVRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfHNAYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHNAYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:24:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9169E20665;
        Wed, 14 Aug 2019 00:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565742281;
        bh=XjNc9xrwgDsZ/WsZBpqRC6whCi5UKe+l9/+yDLvS4ZY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=w9tAz5tkqw4jWUvQyaIlMRbh05P9pZWmuQbGxn00rtTuNtNGplBDUOq236AiN/UT8
         zv3dGvIqvRMvEFs+8mVMF5F9LXID0vsswk8Tl7f04YTZehcFlpIdtKho+glC0Gu6NX
         dd0p+PMuJtFCRRrhww5EaPC3ADojpO9ES9QqQ0h8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731193517.237136-3-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-3-sboyd@kernel.org>
Subject: Re: [PATCH 2/9] clk: lochnagar: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:24:40 -0700
Message-Id: <20190814002441.9169E20665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-31 12:35:10)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

