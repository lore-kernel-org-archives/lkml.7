Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCABEC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E4C222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576093983;
	bh=y19maRtWwVQFWVhwa3u7o+m6LVOIsxRzQxftwBneXRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1LDMS66OgQps/hOVlXhgfJwFXJl5UtRXZH9EmeAobSReE4aqx+wOOpORmMs4/Z/9o
	 VLLf5a7TmVhdT3ZE766Zex82H4SCB5oBAxduhIXwJhMOeoXZUJEAEsy+CaS9ukUtF3
	 0rqc6/+h3NEbu6T9QQaLewrxfanM6zLj65WA5sxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLKTxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfLKTxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:53:02 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50AC0222C4;
        Wed, 11 Dec 2019 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576093981;
        bh=y19maRtWwVQFWVhwa3u7o+m6LVOIsxRzQxftwBneXRA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KGNgHImha5d+ESZ/IJYUXTSgAMUJ62et0UphLgQSA4lvWfjvLBNDcF3nRn3BjnAZF
         ZdO8NY+yadtc+sTEnqnBWqHueFL41XHW9I34lxWq+lQK5tCmLYjh37a+DhiEL/QeHX
         QywbYkh0FEiaYDwHXGETVmkRhcAjKVUNsLdDznfI=
Received: by mail-qk1-f177.google.com with SMTP id r14so12581700qke.13;
        Wed, 11 Dec 2019 11:53:01 -0800 (PST)
X-Gm-Message-State: APjAAAUlhGm/lJfyTEKK/zG5FVnp6QauLFfRN+PgBCHJK8pCkCz9Dbe7
        PtEQYT9BXD7kJzbpzDdCnhGcAQGRxknU99THxw==
X-Google-Smtp-Source: APXvYqzVkZGwMq5ckUx1CJq8f6u6AcQxonLAnwW1KXsKrKeqNeJGszYLXKDW6houMOzevVZ2dhsm2zCBnN3+qHaqRJM=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr4719586qkd.223.1576093980385;
 Wed, 11 Dec 2019 11:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20191211150021.20125-1-benjamin.gaignard@st.com>
In-Reply-To: <20191211150021.20125-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Dec 2019 13:52:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com>
Message-ID: <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: fix nodename pattern
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:00 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Typical pwm nodes should be named pwm@xxx.
> The pattern shouldn't match nodes named pwm-xxx to avoid
> conflicts with pinmux or pwm-fan nodes.

It only matches pwm-$(a-hex-number), not any string, so that shouldn't
be a problem. This is needed for things like GPIO based devices (not
just PWMs) which don't have any address.

Pinmux nodes are going to need to adopt some sort of standard pattern
we can match on.

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
> index fa4f9de92090..29b86886c282 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> @@ -11,7 +11,7 @@ maintainers:
>
>  properties:
>    $nodename:
> -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> +    pattern: "^pwm(@.*[0-9a-f])*$"
>
>    "#pwm-cells":
>      description:
> --
> 2.15.0
>
