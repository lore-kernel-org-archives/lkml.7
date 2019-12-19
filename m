Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE4C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D77A21582
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576736678;
	bh=h47HwmbwWxnlP7sBKCa1G3atR7pn17uNb4Yp+RU4vVI=;
	h=In-Reply-To:References:Cc:Subject:From:To:Date:List-ID:From;
	b=NdJAh2erdLQA1o4TSKeA4Ah1mfyYAucu/tpHtdXVc67iTGMNiTjdf7r5uhCBuYpet
	 /BS7bItpMeifEj4fYBXnzP4gN2nbTp2pQMxFcujBHcimi2Acg/VowCslk+Z1/IWekV
	 vEbZ/PmwM84yI0zHeMI07yvWHUZKxYGAP9wGSWAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLSGYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:24:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfLSGYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:24:37 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33C221582;
        Thu, 19 Dec 2019 06:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576736676;
        bh=h47HwmbwWxnlP7sBKCa1G3atR7pn17uNb4Yp+RU4vVI=;
        h=In-Reply-To:References:Cc:Subject:From:To:Date:From;
        b=sKk19ckN/ORE7LCrCWeTvqkyQX+ROrsKH96zmlmEibioSAcm76isoyd9DJiWM0p0F
         e3EaUp0XJjFUSQYfX82VGMFUFUvgZmqSwBJxk5aPU8SWchyst4k2GUPme+VnNyV4hh
         RpUspYrNg2r1BAh/7UfGoB2H+KYA7bgHwSZtNhgw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191125135910.679310-4-niklas.cassel@linaro.org>
References: <20191125135910.679310-1-niklas.cassel@linaro.org> <20191125135910.679310-4-niklas.cassel@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] clk: qcom: hfpll: register as clock provider
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
User-Agent: alot/0.8.1
Date:   Wed, 18 Dec 2019 22:24:35 -0800
Message-Id: <20191219062436.A33C221582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2019-11-25 05:59:05)
> From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>=20
> Make the output of the high frequency pll a clock provider.
> On the QCS404 this PLL controls cpu frequency scaling.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

