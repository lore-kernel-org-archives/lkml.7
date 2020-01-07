Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD684C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FEE207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578379469;
	bh=SuMcimjtUPtH5zIrH2Hsfh1rRE1toB0xKgs/o5eWnAo=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=LdaPVSStR3uArQ6r3on4DIZieDLdOnxg9KjGdstsXSGxTh/2SS6/ZS8ZOrUxTWPui
	 6JzzV8FoGaOVqBTza38/6ujQ3oaf5WgN3l3MC7jNUphEkF5OWTOxhfJ1G0Ztzgygw+
	 WYxSujFgvwgi/WzrpW6SSlZf7o4PIfpAsRaxSyNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgAGGo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:44:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGGo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:44:28 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D808207E0;
        Tue,  7 Jan 2020 06:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578379467;
        bh=SuMcimjtUPtH5zIrH2Hsfh1rRE1toB0xKgs/o5eWnAo=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=LItP/KJRq9aSQJnFoFDs/H+98rAI9DV7SQdCfqQ4bmf+v/JY+DkkbkXRdLqFOzWRd
         bPK1RWSQ4Tg4ttu+ds6bBKiTlyan0KNNgLdpciA4Ak/aNIJ0C2sQgbWgGZ7WWP8GGN
         sEOWdpUx8oqeUq2Odx9Rp0V0Qn0+XEmYiv9NzHN0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-6-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-6-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 05/12] clk: fixed-rate: Document accuracy member
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:44:26 -0800
Message-Id: <20200107064427.7D808207E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:16)
> This member isn't documented, leading to kernel-doc warnings. Document
> it.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

