Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6B2C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA989208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567802309;
	bh=ffDIcLc2ncNH/UtO+YmpfmnO3dS0QRFzPH+iK6CIPgg=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=ny2L8L3usX3tz5a9TMUAbHJjBm1qjoq2CGkLGvUkQqG9USvNVdBU7Wm0egrUUffT9
	 PCIyLqgOsWzkRnjM5f/52FmUDDYTYqzHsHEKn2n1XcuEHGH0KUtz0GOKRfm2xl7h4K
	 65oPq4F33Pl01aFfQErOZkwnBuXKr3TpIA/Qeeuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfIFUi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfIFUi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:38:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2259208C3;
        Fri,  6 Sep 2019 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567802307;
        bh=ffDIcLc2ncNH/UtO+YmpfmnO3dS0QRFzPH+iK6CIPgg=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=hErkMkyA+vbCZnhlCpNfyn7ER5b7QSgf1bddzpRucpYafGbb9qEKDfuFOgaLRdcqO
         J2KDepF5vZCO2Gz+mtKILvuD0E6gds1R5y4Ms+WMZ8CuRr3fobHqLnDQGGQUv5DaQg
         TV57F1TgsuSJOgF7QpaMGvmi/9Qce96RKzsuaWh4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190906045659.20621-1-vkoul@kernel.org>
References: <20190906045659.20621-1-vkoul@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-qcs404: Use floor ops for sdcc clks
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 13:38:26 -0700
Message-Id: <20190906203827.A2259208C3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-09-05 21:56:59)
> Update the gcc qcs404 clock driver to use floor ops for sdcc clocks. As
> disuccsed in [1] it is good idea to use floor ops for sdcc clocks as we
> dont want the clock rates to do round up.
>=20
> [1]: https://lore.kernel.org/linux-arm-msm/20190830195142.103564-1-swboyd=
@chromium.org/
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Is Taniya writing the rest? Please don't dribble it out over the next
few weeks!

>  drivers/clk/qcom/gcc-qcs404.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
