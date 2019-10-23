Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9829CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA327214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfJWMXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:23:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJWMXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:23:16 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M42fA-1iNFfW2BvM-0003WG; Wed, 23 Oct 2019 14:23:14 +0200
Received: by mail-qk1-f179.google.com with SMTP id u184so19541488qkd.4;
        Wed, 23 Oct 2019 05:23:14 -0700 (PDT)
X-Gm-Message-State: APjAAAV1jZd8mWdGQrBmeGE15oZ30NbgA2sIAShlQqMihTtNfV0wJrHj
        WJRJzpCs5sPRUBmBagya4XcaNUMWYjmGyiGUNJk=
X-Google-Smtp-Source: APXvYqypyXNWat+KcfPfsodq+JQ+4QWo1ZTdvBPQPaxSxAVPk72AOIOGVimgq/tpICY5myV86eSBfmCrhOKUhQ+FPQU=
X-Received: by 2002:a37:a50f:: with SMTP id o15mr6769403qke.3.1571833393352;
 Wed, 23 Oct 2019 05:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-6-arnd@arndb.de> <20191023101257.GC10630@pi3>
In-Reply-To: <20191023101257.GC10630@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 14:22:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07S4bqeo_u0=Mk4eW=737jjh69q6bbMotugkiUQxt+ZA@mail.gmail.com>
Message-ID: <CAK8P3a07S4bqeo_u0=Mk4eW=737jjh69q6bbMotugkiUQxt+ZA@mail.gmail.com>
Subject: Re: [PATCH 06/36] ARM: samsung: move CONFIG_DEBUG_S3C_UART to Kconfig.debug
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UGKnZroa7E6+xWfZo0iy9U5wjXjviLng+fzxhWiE5tn6Vuwnnhw
 aRJZ+eNnGNLlK3oCpXI6u4M419Iqshflj8hzylGEs1DfyYfmk6S8cMoxTXk+WzUYqz43RIt
 L2gwJS1SuKb/0Omj6rWhu4wgiPDMuvoITT4EcfkWrXo6dBWJT7nr0xemKZhmEcTCQ0I1V/O
 sxKdlNFmyjRcpXc56w9YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pEyuLDJqn4U=:Pgz+iimq285zAXrzlY2JnX
 6vnfcgpCTL9TrDmUvEHLzxB8UccdCzLhmY0L8pSxd2sYFihyMoCfOZSVQH/AKmUR5Yq7RsB6R
 5ITp3gDxoyMK72mI46KPB/m5Cd4XZbPViDgQWBQS6OkzgfNVduBM2AKIx6WP1rhMJWZwtS6J/
 XIMZigZFNJjGKSHvH3ufq624Wa5KfskBIbMbvCuCN52BDLODNv7JJiYVZAACiBXDmDQV/bXoF
 yCVJhj+ptsMZ7wC0lsjVRaT7SLX2T8nOpRMzpj8Ez6RvNU3Gjc2aDdX+MYHl3cK7hNRv+t9yU
 z1gBsS/WJX1mgvFswx0lpGz3rCPobZlygb6+/BfBvLlgek/rSIK+CJxbYtPzxec3Q7sYTIPjN
 RUQunC96WCOMPJnVp51MatB288f/26BkdQa8Jy1f0YZ6A1ZJH1jhEC+CSt6G0ky5p7NjcI9Gz
 knqPK4arDsxkM3rUQBMizFMjBj5mSbSB5D33iGqDrLxCSdxFBinPGF/sZDdkoeKhgo3EK/33p
 P98ajS5ifWf90+NogUffVLTTlz8uz1JYb9JIWqtZngM1z8bW2DJGUfsvsoUcXEEpyXBHLlPdP
 2HsOXgF4aVo0Phoo1hASZ0LYYG62PDh/hKqz/E4wf2FbaroLlwV628juzTmdCelutelxSkXy9
 8nwxAs7GbYF2bgasc+uBVxZepuIczicyf7A9BxlcxbBiX7Ff8vspKEFUbr30oL+FuscUK5YaZ
 P7l41LL+fiyT6aaLDS67V3AnO+J+cPWEm4QAgZ/9A3FSuzhltQ6VuYaPpPKecSKM6jprFVVr8
 qLeNnKPmgCDReYcNO/z4yXQgEVYMtgvwueOHM2tyQsHrsCVVdQ2NQWilSpO0k2xwOEZ4nfty7
 uw/MMpBmQMUknQQ6dhQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Oct 10, 2019 at 10:29:50PM +0200, Arnd Bergmann wrote:
> > Before we can plat-samsung from the individual platforms,
>
> "Before we can split"? Or moved? What did you want to say here?

Rephrased now to:

| Before we can separate plat-samsung from the individual platforms,
| this one has to get moved to a place where it remains accessible.

Thanks,

     Arnd
