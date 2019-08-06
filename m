Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B73EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B473214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565102551;
	bh=ayNN7M5ClahzSEkoICsJ9tdxykID4BzfuIXdV5FkkSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ROg1E/2SumjSb5OryLpfcTNbuSeGnMXpHgzRbxO7GRQ7Xg3bduJJyFMmbT2B0bEbT
	 9BUHyhWT4t4hP8DDQgcWH/5Xvr4PWPfwVNVVldTfAl0nj7uotfrNZfn+edx7NufjF7
	 oHBGUULCyTV+9G8LnyJ67TSCWbw9xyZKWXJCDnJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfHFOma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730489AbfHFOm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:42:29 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F318E216B7;
        Tue,  6 Aug 2019 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565102549;
        bh=ayNN7M5ClahzSEkoICsJ9tdxykID4BzfuIXdV5FkkSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bTbWK6zN8e74EiUInvCzlJh8s8pDjATO9JzQUMdXxk6cU/2pZNm8TUK17uyZpVfJ0
         4FZI0AkjPnznc6y7v3VBWWAC1kQSnEwBjExjEj7sYOaXOcf5nPWXmFN8Z+rFyFpRUh
         hrxslYKA+xfCBbu9+gYq2vac2T4hyXzaOAopQ2GA=
Received: by mail-qk1-f182.google.com with SMTP id s145so63059835qke.7;
        Tue, 06 Aug 2019 07:42:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUG6Gm7aYG4mj+PrFVBtusHUmtvqQTIBGNt/MhQRTjVfVv2zOdM
        IJhcbKZCvws2gCfQLvzo1JqDhx7Iu5bWAGHpmA==
X-Google-Smtp-Source: APXvYqyYuQYdgl7KuocuQ/T+ajuGJuzeSGZTaiXznVOz10/x+Ufuo4OOyDhhu0VZEDMYzparLR0uzkrMOBPV7qu8mt8=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr3437539qke.393.1565102548144;
 Tue, 06 Aug 2019 07:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190806075520.14652-1-narmstrong@baylibre.com>
In-Reply-To: <20190806075520.14652-1-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Aug 2019 08:42:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=dUX-bPa06KxJowf_3GM2-mPwm4U1KyTXyH0thA1pvg@mail.gmail.com>
Message-ID: <CAL_JsqJ=dUX-bPa06KxJowf_3GM2-mPwm4U1KyTXyH0thA1pvg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: amlogic: fix x96-max/sei510 section in amlogic.yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 1:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> Move amediatech,x96-max and seirobotics,sei510 to the S905D2 section and
> update the S905D2 description to S905D2/X2/Y2.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
