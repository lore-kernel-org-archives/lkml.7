Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BE4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0A2218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568816889;
	bh=5q3vXpVfMLjl2YjmXJxZQQGV0EcKWrcgUz73C6x30T8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wcnVew87yGjV8cJv9cbLdyIBCmUNlt9sx+WBq9fkFXLX2bY9s7LxB4t9UUXS9Mro5
	 znzKSuW85MaSH/MZzYNYVhXK1PtMRfk2U+5VKBJMYwqHNbmupeWC5/1CEfviHBwaeT
	 DMX9c1pkCf4+Nb3OB2U+arTYRPC968xqgFIm5g7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfIRO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIRO2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:28:07 -0400
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B54C021924;
        Wed, 18 Sep 2019 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568816886;
        bh=5q3vXpVfMLjl2YjmXJxZQQGV0EcKWrcgUz73C6x30T8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ba4o1lo7H5M0Bkey9QjJgKlytYEold2+Tr92Oqq0XjWXTRuMaQk4ECpE4Bcym2OoU
         VgOzQtw36JtjoKjet0E68dqGZP8Nd3HV/mWlk4cC+CsLkHv+QLhsQue6x3PVcQ+B85
         f0mQW+XOismF1Y0ZPox7DdF9Sw0qS7H7gFEP7r7M=
Received: by mail-yw1-f52.google.com with SMTP id x64so10239ywg.3;
        Wed, 18 Sep 2019 07:28:06 -0700 (PDT)
X-Gm-Message-State: APjAAAVBmvHxHJu/K8/0KIsv4ylPxJncORXqSL0I7nJriNi4F03ySc4t
        wsBp/hgI1MW+a/YS6fDgCOJiiDt/7G7YOI+RrQ==
X-Google-Smtp-Source: APXvYqw5G3bt/di0lrSkj1nCOaZlaS4Q/2r0yUPllZ9ZY6HdMcYoemkSqKqz/JjUcEKUGYaRq4XiSyhtyxGmFrcKgVY=
X-Received: by 2002:a0d:ddc9:: with SMTP id g192mr3210591ywe.281.1568816885977;
 Wed, 18 Sep 2019 07:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <1568815340-30401-1-git-send-email-pragnesh.patel@sifive.com>
In-Reply-To: <1568815340-30401-1-git-send-email-pragnesh.patel@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Sep 2019 09:27:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJwsLkQGjjoS_RvBXjSq4irrVPEpwrwTv7wL732YHM4dg@mail.gmail.com>
Message-ID: <CAL_JsqJwsLkQGjjoS_RvBXjSq4irrVPEpwrwTv7wL732YHM4dg@mail.gmail.com>
Subject: Re: [PATCH] regulator: dt-bindings: Fix building error for dt_binding_check
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 9:02 AM Pragnesh Patel
<pragnesh.patel@sifive.com> wrote:
>

The subject could be more specific rather than being one that applies
to any dt_binding_check breakage in regulators.

> Compatible property is not of type 'string' so replace enum
> with items.
>
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>  Documentation/devicetree/bindings/regulator/fixed-regulator.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> index a78150c..8d4a7b2 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> @@ -29,7 +29,7 @@ if:
>
>  properties:
>    compatible:
> -    enum:
> +    items:
>        - const: regulator-fixed
>        - const: regulator-fixed-clock

This means you expect: compatible = "regulator-fixed", "regulator-fixed-clock";

Did you actually run 'dt_binding_check' because it should fail on the example?

I gave you exact change to make. Just remove 'const: ' on each entry.

Rob
