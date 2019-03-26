Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BAD2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553600544;
	bh=74ZRsHTPNoNpqDeKexuqbFcuWrT3JNthQpo9KBpmI0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FTsa7L3gp2vOXadPpQz2Yrxw4SfUbeaRm4LEK6wMMl8FlBP0vY0+KN8tTZ/FHErWK
	 1CC3P/SCdQlFrT4V7j4TB2tuAaczrNI2hYxE5rI+Qp6edSB4vNnKbrZsyiKf5blS10
	 mK21H4S9xB97JICK83MkqEfrd5tgcAKqFPh4syjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfCZLmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZLmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:42:22 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 616E020857;
        Tue, 26 Mar 2019 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553600541;
        bh=74ZRsHTPNoNpqDeKexuqbFcuWrT3JNthQpo9KBpmI0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=InxP+YqaGyf/SEfh34zhbcd4EI7XoEZo/s7FwAbeDTzDg3ubTvAjJoMrksO1NVjjz
         rZgAK5tBmwd6pgOVAWOUEsmcbt0MOhn36NAxOmgoe11iIAFTIiCupOuXJ86n4aU3D3
         8cpePdDtKy46wR+0S8Q1v4brwef0wWSdlum6ETZo=
Received: by mail-lf1-f50.google.com with SMTP id u2so8376243lfd.4;
        Tue, 26 Mar 2019 04:42:21 -0700 (PDT)
X-Gm-Message-State: APjAAAVgIDzVi1iwn7x1gR2na+Q43zoVB4gKEDq38KjaMe/DFK0gJKRd
        Y3FcX9yBeSybeh20QZL1nFzULP/ZepUgX18t6OE=
X-Google-Smtp-Source: APXvYqxTvJ30XucndfgFa0yIdPr8iaJ2KxiWVQyaktLoXfZ00ypacN/fRXeRmsYnVpne6lMAI8QJceZWxrjT00cLiKk=
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr4782075lfm.159.1553600539630;
 Tue, 26 Mar 2019 04:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190111132222eucas1p1d80caf8ba30422bc5fe1a1fac4cf48e8@eucas1p1.samsung.com>
 <CAL_JsqKt-ujsB-t9A=4dEAjqrvcquUG+qF3tFg1YCqmup_5wcw@mail.gmail.com> <20190111132139.12333-1-l.stelmach@samsung.com>
In-Reply-To: <20190111132139.12333-1-l.stelmach@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 26 Mar 2019 12:42:08 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfM+EUzBBBhrtSFw5-e7hiimsFT8okcd8J9gGyFdzd2+w@mail.gmail.com>
Message-ID: <CAJKOXPfM+EUzBBBhrtSFw5-e7hiimsFT8okcd8J9gGyFdzd2+w@mail.gmail.com>
Subject: Re: [PATCH v5.1 RESEND] dt-bindings: hwrng: Add Samsung Exynos 5250+
 True RNG bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        Otto Sabart <ottosabart@seberm.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 at 14:22, =C5=81ukasz Stelmach <l.stelmach@samsung.com>=
 wrote:
>
> Add binding documentation for the True Random Number Generator
> found on Samsung Exynos 5250+ SoCs.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---

Rob,
Could you apply this directly? You acked this some time ago but it
never went through drivers tree. Lukasz resent this patch and it is
waiting since then.
The driver implementing compatible is already in mainline.

Best regards,
Krzysztof
