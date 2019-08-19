Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C4822CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566241026;
	bh=PpzftFy+vdiatOV+exGKaz9N/3u/KbCTsM0d09Za0es=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bNy723P4v+iqPXPttpXqQYqkB/2jH9JKfqDNX2T8ji/j5RaTDT84qpx0Iz+kN4Z/S
	 aJNYdaK5IGAL0Ozb8FBeO5E2A6uS7Lsjww99txIX/k3JRJRfljsSWr85nLUl08dG2H
	 cO1AXLnrxurNdILQ3rgs3d4uwUfjztNQraRrNumU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfHSS5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfHSS5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:57:05 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1ABA22CF4;
        Mon, 19 Aug 2019 18:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566241024;
        bh=PpzftFy+vdiatOV+exGKaz9N/3u/KbCTsM0d09Za0es=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HZQ6yz5NGksGii9M1i5p7wjUL7g8sLBJxRBKY5eopCEtPHL3Ik4FxqTrAXLTdGD51
         whAWTJqe40JDFzOs2spq+afA1cpJhacz8H2SU/BaA9k0zfEsU67d6ehiAsW3FsCLqQ
         y1qY5NGFRE6M02bsXI3DQ46CiB4n6Ezxt5lG1Bq4=
Received: by mail-qt1-f181.google.com with SMTP id y26so3091296qto.4;
        Mon, 19 Aug 2019 11:57:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUVy2jzOcVhJr+7/D9hnb5zEFgvQFRuli6uZtbviOp/9Ex05gD7
        VbJmerdk+zLLctZWXI1f9nicUfx56+j/a22Hvw==
X-Google-Smtp-Source: APXvYqyem9usStmeAj3X3lcl6uuICrDQDfmec0Vvyrcebdi+L8pRqRmBajRkKgyiE/FrM7aOJG7WZwyRe3W8Eaubi6I=
X-Received: by 2002:ac8:7593:: with SMTP id s19mr22505378qtq.136.1566241023152;
 Mon, 19 Aug 2019 11:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190819182039.24892-1-mripard@kernel.org> <20190819182039.24892-4-mripard@kernel.org>
In-Reply-To: <20190819182039.24892-4-mripard@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Aug 2019 13:56:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+wd=z3e72VUP1rkEagrrQu+Cg2Ypqo_ZmBFaZ1LOkRvw@mail.gmail.com>
Message-ID: <CAL_Jsq+wd=z3e72VUP1rkEagrrQu+Cg2Ypqo_ZmBFaZ1LOkRvw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: watchdog: sun4i: Add the watchdog clock
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 1:20 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The Allwinner watchdog has a clock that has been described in some DT, but
> not all of them.
>
> The binding is also completely missing that description. Let's add that
> property to be consistent.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - New patch
> ---
>  .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
