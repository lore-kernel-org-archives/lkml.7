Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A415C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DEF20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEOHEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:04:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46601 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfEOHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:04:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so2032084qtz.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 00:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/x4j8+P4m1EISwP0M38Z0UnU/waWQ3GkeT9+7Fw+Qg=;
        b=scar3RWzvmgUc/lpb4oaZtUdJ2fSH26bHBk+UM9FLoJFz93vIxVaBXEd6rRmVShzqE
         eq2h6jSN/60RJwJcZw7QbyDads4cpC1t0LJJh8PnN9il5oO83T85Px8wSdXuUpjrWiJ7
         U7KnvMJliz/LISTrzFGpzPOno2DID6+BNowC57umCV2N7KG15nRou7eu/3vURlFOIqKg
         nD5lveiM3BOK0dCRFYAy8TrSSdvEsRSpfh2ZllojR73QlwgW89AtPSZll/vKTLp2v8aH
         3CuOsvNlcmOizwyTAkcog6EY5cPCkdon12+w3gOf8yyWn3hOgcAIv01VtRh53Utly0Yp
         xPMg==
X-Gm-Message-State: APjAAAWEuNqdC+Pavq9YCh6625K+pGveGBX8of/b9caEyCmM/sAzkg1Q
        i10x7vPMq9FtPkMlDxDSmVZrMB3+3tYL3Q+x52E=
X-Google-Smtp-Source: APXvYqyICkC3CerfJr0tm1djW5WSt2GGOXQAYHjspKEgLHZ/beQE4UMAmkhKyyx6kDREb3zH09Gz8zoKGde9aR/0mbc=
X-Received: by 2002:ac8:2924:: with SMTP id y33mr33483911qty.212.1557903851749;
 Wed, 15 May 2019 00:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-4-elder@linaro.org>
In-Reply-To: <20190512012508.10608-4-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 09:03:55 +0200
Message-ID: <CAK8P3a3KLj5x-5VS5eUQfNVhPL101Dg_rezEzra4GFY5Dva2Cg@mail.gmail.com>
Subject: Re: [PATCH 03/18] dt-bindings: soc: qcom: add IPA bindings
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
>
> Add the binding definitions for the "qcom,ipa" device tree node.
>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .../devicetree/bindings/net/qcom,ipa.txt      | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,ipa.txt
>
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.txt b/Documentation/devicetree/bindings/net/qcom,ipa.txt
> new file mode 100644
> index 000000000000..2705e198f12e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.txt

For new bindings, we should use the yaml format so we can verify the
device tree files against the binding.

> +
> +- reg:
> +       Resources specifying the physical address spaces of the IPA and GSI.
> +
> +- reg-names:
> +       The names of the two address space ranges defined by the "reg"
> +       property.  Must be:
> +               "ipa-reg"
> +               "ipa-shared"
> +               "gsi"

Those are three, not two ;-)

        Arnd
