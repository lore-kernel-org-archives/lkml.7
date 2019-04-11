Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A038C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A1C2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555015012;
	bh=KVRO4N+YmNSEwrAJxjB4DQbCD37K3bAaxfX/GXXqZD4=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=QIVicAj7Uhq1c7FmDKzdVOW5DfwjtbwXLzRPiSuV9+xkQdn7V/f/ssUkqMfjP1r/z
	 ywmw4gohpx9hVsXvpe1D7hHpcmKrbEBXxmZ3Fx3dE5T7tccwPuQmqst6AAy4ersGs1
	 Cy6/S77yr6LwMrAdHtop0R+n0iaLtM9RhVShzOpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDKUgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDKUgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:36:50 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E4432075B;
        Thu, 11 Apr 2019 20:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555015009;
        bh=KVRO4N+YmNSEwrAJxjB4DQbCD37K3bAaxfX/GXXqZD4=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=m8ZrUXQ40Y/Csqw86y4NHBJIoDr30sUZkU1rPQ4sc0mJbBf9wec66+ckFhCfHv0TU
         rBbNFPf4R7w50h+d8ecHbwiHhQsG5pdzpAwbRZF5g1hdpxMeSw6O33ORMjIuHXbQDO
         Is2ZYcsM9ApxjEQO9ATlr0kBtiVYNHKsUP+edMLc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190306174758.22462-4-bjorn.andersson@linaro.org>
References: <20190306174758.22462-1-bjorn.andersson@linaro.org> <20190306174758.22462-4-bjorn.andersson@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/3] clk: qcom: Add QCS404 TuringCC
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155501500860.20095.12195621768250948176@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:36:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-03-06 09:47:58)
> The Turing Clock Controller provides resources related to running the
> Turing subsystem.
>=20
> PM runtime is used to ensure that the associated AHB clock is ticking
> while the clock framework is accessing the registers in the Turing clock
> controller.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

