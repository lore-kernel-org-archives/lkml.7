Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2757C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B58F21903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563808381;
	bh=CTRrbtDJEmmUynhEaywLH4FjBvJM41mxMXhjYFm2FJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UtUgXJW1Hy+ccSzSwjqB0uTgPDpZoG6BfrhxrN6JNzGKM+C5x781Bicz1NNUdoZwl
	 LN3dCoYPWKZI8WuRZBgHm7+s2+9a51oJDywbJBzvZU5WQEJQ0HYDWT10Txe4xwY0ql
	 D1ocj7uOjSD51tGW2583dNSpbU/Tq7B5w8BWd8Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfGVPNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfGVPNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:13:00 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0998E21903;
        Mon, 22 Jul 2019 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563808379;
        bh=CTRrbtDJEmmUynhEaywLH4FjBvJM41mxMXhjYFm2FJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mLqsCo8IFjohG/jNdUX1EW+bWDtdWNlhFMzJ1yihY6oUs0KIG3BVZ+I6xtovt+CU5
         K9ukKYvHV//9MNcFpXG1UK729ELQzngElJBMMnqj447K7Syc8Yw48EhCn8HTQn7h34
         qp7SNfkzdyjXNBqb6xUj6eiPgaMvaiSRmN0j4MdA=
Received: by mail-qt1-f175.google.com with SMTP id a15so38853488qtn.7;
        Mon, 22 Jul 2019 08:12:59 -0700 (PDT)
X-Gm-Message-State: APjAAAXu7xGRkSzq5FDDRwV5/fzCsed69sxqFpQEEGU6Fnsz0GmfzMVF
        dURpCsksUGvP8XgEtavUVkubV9RI83iWaXH0Nw==
X-Google-Smtp-Source: APXvYqxIRQFEcMS1UiVSIRkDYcv77oPpLIW4fghgL55Uv4ewj763NwPFIjTM3isacKZ+SynYN6dK2LIsdKC4LGjFVl0=
X-Received: by 2002:a0c:baa1:: with SMTP id x33mr52172799qvf.200.1563808378300;
 Mon, 22 Jul 2019 08:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190722092211.100586-1-stephan@gerhold.net> <20190722092211.100586-3-stephan@gerhold.net>
In-Reply-To: <20190722092211.100586-3-stephan@gerhold.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 22 Jul 2019 09:12:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJe2L1EraVnHkjr8QOA3pG2_M3SHg3Q7EY1jXcwdznAhQ@mail.gmail.com>
Message-ID: <CAL_JsqJe2L1EraVnHkjr8QOA3pG2_M3SHg3Q7EY1jXcwdznAhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] dt-bindings: qcom: Document bindings for new
 MSM8916 devices
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:27 AM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Document the new samsung,a3u/a5u-eur and longcheer,l8150
> device tree bindings used in their device trees.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
