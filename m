Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE6C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914CC206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803042;
	bh=KibleVEOY0ttEwVml3Z0ZvJeh4yRykRT8EbfC0MbYW0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=V2yvV24d9wcw2q6Hlsrx3iAGquYUD4M5FeKJpVDXcak/amMP6v1pFUq0JAla4tSwQ
	 il2sgzIJjes4iVcyp+4pkrRLjnRG2/kAbRAdRXUN4oWVjXpkC9SI4ifE6hx/cOnwNL
	 Po40pj1l71ULtdTWZHZj1UUAL3QLQjAQuNWGCXvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfHNRN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730871AbfHNRNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:13:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F7162063F;
        Wed, 14 Aug 2019 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802800;
        bh=KibleVEOY0ttEwVml3Z0ZvJeh4yRykRT8EbfC0MbYW0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Fyy6wqp8lHW5LobX0qswlpjPtxGL/6clZk8DXHez+xNNt80+e8ulTaP0H2rRm+EHw
         C332wIzH7gVNJvDkR3/HKtm0Q1tn0B4vs3O1rL36No+xrbu1NbpkrnPWYC6b5ntI2K
         QiOuxwdvc/cJXSrUKnjCqRrfcHW9PF2OI4NFCRzw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814125012.8700-19-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org> <20190814125012.8700-19-vkoul@kernel.org>
Subject: Re: [PATCH 18/22] arm64: dts: qcom: sm8150: Add reserved-memory regions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 10:13:19 -0700
Message-Id: <20190814171320.2F7162063F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-14 05:50:08)
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/q=
com/sm8150.dtsi
> index 5258b79676f6..7111e1f092f4 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -153,6 +153,117 @@
>                 method =3D "smc";
>         };
> =20
> +       reserved_memory: reserved-memory {

Does this need a label?

> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +
> +               hyp_mem: memory@85700000 {
> +                       reg =3D <0x0 0x85700000 0x0 0x600000>;
> +                       no-map;
