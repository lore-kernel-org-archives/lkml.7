Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EC0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38842206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565632814;
	bh=KqkcRY38hH3yrpgFDbrT3X6ebYmN7bDU2bRKjVAzvD4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=mhDtUmqKvYWpQ7YJw28eX6IF+UCL3cWoV8BQy21uylAM0z1zHMyM+rMJr9FYtUgLv
	 p56FMFazE3HtG+KCJg1hpGjW7LhuTnHCY18CJvoDIAyTj8zdOB0P0Z2IydvQc3vfll
	 aBzCHXp1LIbInF5SR4sxEhTou/NBWnpIAHcGAleE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHLSAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfHLSAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:00:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 886D820663;
        Mon, 12 Aug 2019 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565632809;
        bh=KqkcRY38hH3yrpgFDbrT3X6ebYmN7bDU2bRKjVAzvD4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LE7wXtUl/C24s4iK/4fBljaCC38kfWW9kfbuYCNcfF319YutKQKDunzF2VUgh59G8
         BzpycVEMbVE7m0lkIFCnrTfR7YF0Rh+Hn/Kcf5Pm6RqR05SyqJ/JKnvrKCHDBV1QSt
         GJJ+o8kBusWlcQRxo72bGrAHZxdh3KuRSIJ0z/Qw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190810123620.27238-1-paul@crapouillou.net>
References: <20190810123620.27238-1-paul@crapouillou.net>
Subject: Re: [PATCH v2] clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 11:00:08 -0700
Message-Id: <20190812180009.886D820663@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-08-10 05:36:20)
> By using CLK_OF_DECLARE_DRIVER instead of the CLK_OF_DECLARE macro, we
> allow the driver to probe also as a platform driver.
>=20
> While this driver does not have code to probe as a platform driver, this
> is still useful for probing children devices in the case where the
> device node is compatible with "simple-mfd".
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

