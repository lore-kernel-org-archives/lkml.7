Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FFCC468D8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD642086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560185286;
	bh=oFtb1o3AXLUr4k9TH9OD5ZZ8qF8S9a/ouxAXF91MYh0=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=lx4PBe0SjUrZ1sUu43v3qsEYQSw27Llxi2eg5dLFimnZ6mRtsyRqmiQ0dlPTyc/4E
	 uLYQ+OXhxndfCRt6CF78n8UdmJedVmkowmZI03lhr7GHEK7PpevKI/YNj2qVaEbwbL
	 PcOF5o4DsX1ngMQjtvOzLbzwYNhQOBMIYUY9svMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfFJQsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfFJQsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:48:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D15206C3;
        Mon, 10 Jun 2019 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560185285;
        bh=oFtb1o3AXLUr4k9TH9OD5ZZ8qF8S9a/ouxAXF91MYh0=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=tBcMESXBdsEGjobi+BHjlGd2RIqXKwu6aeRyd10RYmRrXjQpm69IIqrxRkhXkEUGP
         AQyCw2PvGkD4ULELPPRFasXJIN7qpaewJiXRuwPJDsMS6aGgFogx+c/GJwb3W3C3dm
         dVV/fDf3akooB5cM5Lom0XOdDCSitrtzKqlGPfuY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <048a25c0-3a2c-3906-84d4-5eb67f3ce2ef@codeaurora.org>
References: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org> <1559754961-26783-6-git-send-email-sricharan@codeaurora.org> <20190608034835.GH24059@builder> <048a25c0-3a2c-3906-84d4-5eb67f3ce2ef@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, sboyd@codeaurora.org, linus.walleij@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] arm64: dts: Add ipq6018 SoC and CP01 board support
User-Agent: alot/0.8.1
Date:   Mon, 10 Jun 2019 09:48:04 -0700
Message-Id: <20190610164805.18D15206C3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sricharan R (2019-06-10 08:45:22)
> On 6/8/2019 9:18 AM, Bjorn Andersson wrote:
> > On Wed 05 Jun 10:16 PDT 2019, Sricharan R wrote:
> >> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/d=
ts/qcom/ipq6018.dtsi
> >> new file mode 100644
> >> index 0000000..79cccdd
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> >> +                    compatible =3D "fixed-clock";
> >> +                    clock-frequency =3D <32000>;
> >> +                    #clock-cells =3D <0>;
> >> +            };
> >> +
> >> +            xo: xo {
> >> +                    compatible =3D "fixed-clock";
> >> +                    clock-frequency =3D <24000000>;
> >> +                    #clock-cells =3D <0>;
> >> +            };
> >> +
> >> +            bias_pll_cc_clk {
> >=20
> > Please give this a label and reference it from the node that uses it
> > (regardless of the implementation matching by clock name).
> >=20
>  ok, in that case, so might have to remove these for now, till we add
>  the corresponding users.

Yes, please remove them. They don't look like board clks, instead
they're SoC level details that need to be created by some clk driver
like GCC.

>=20
> >> +                    compatible =3D "fixed-clock";
> >> +                    clock-frequency =3D <300000000>;
> >> +                    #clock-cells =3D <0>;
> >> +            };
> >> +
> >> +            bias_pll_nss_noc_clk {
> >> +                    compatible =3D "fixed-clock";
> >> +                    clock-frequency =3D <416500000>;
> >> +                    #clock-cells =3D <0>;
> >> +            };
> >> +
