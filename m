Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77B122CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567143172;
	bh=0bCUCOe9JrT9J4vZlQHLm2jLYT2lBAJOVkLa79zh0sg=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=iygWu2PbWIjcL0ZNhp/d9GDEGo5Ao+WdYIBZHF9EUH+4tCkz8+dmcyk332jL8jmj/
	 OL4o6/0FYz3/TAzf/tfZhP7ZU5hNAe6+p1SsQj2H537HtosvgfqHvFn1JfoOhrs5Hc
	 chNxFT9BOfl/xlhHwVGe1gerceRLQJIFnRCKMyr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfH3Fcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfH3Fcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:32:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D772A21897;
        Fri, 30 Aug 2019 05:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567143171;
        bh=0bCUCOe9JrT9J4vZlQHLm2jLYT2lBAJOVkLa79zh0sg=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=gMxOGEp16fYHUr2YlQpldiMD08oslWv5R+hSAL98lpYlqNVuGDa4pvGdBqBES6zpK
         HUSFudiTftAlH6BKsQCIUMPSzcfMK+UHhMIWi7H2Fi9/ErPe2uzb+NL5HQimlQFG6C
         +IxTpKiwQeaKaOazOecBkaDnhw+oGR+PDuFZFlmo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190824152411.21757-2-sibis@codeaurora.org>
References: <20190824152411.21757-1-sibis@codeaurora.org> <20190824152411.21757-2-sibis@codeaurora.org>
Cc:     agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [RESEND PATCH v2 1/2] dt-bindings: reset: aoss: Add AOSS reset binding for SC7180 SoCs
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 22:32:50 -0700
Message-Id: <20190830053250.D772A21897@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2019-08-24 08:24:10)
> Add SC7180 AOSS reset to the list of possible bindings.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt | 4 ++--

Can you convert this binding to YAML/JSON schema? Would help to describe
the 'one of' requirement below in a more structured way.

>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt =
b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> index 510c748656ec5..3eb6a22ced4bc 100644
> --- a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> @@ -8,8 +8,8 @@ Required properties:
>  - compatible:
>         Usage: required
>         Value type: <string>
> -       Definition: must be:
> -                   "qcom,sdm845-aoss-cc"
> +       Definition: must be one of:
