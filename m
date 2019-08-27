Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE77C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28802189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfH0QMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:12:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41115 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbfH0QMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:12:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id i4so21805981qtj.8;
        Tue, 27 Aug 2019 09:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRE+ONyqMbnDAqAAt7DNGwf4rRMmk/Hc31TRfDzpAP4=;
        b=NvBDM/Fmk+0Gbswsr2vZZYkLbZrTzW9TO0uzdrvfJRzEiPpKzCoMVriHaD89sI/KUK
         AS6VURCsktY4yLe5W2fGoiAfTU5CPzvQWBoN38xm2r9ePTfYOj5fPSBrN5BtwbRsoG9f
         pPfSmQy/Pid/S92C/IS9u8a7uyJAUUQd/mtY4Y01jbl8ehjxg+VkYjSluKb/OtAjtEal
         lAnDQtJq7eGQUTmoTpuyDycjVplkL+Hn6xxPDtyIESFT2Ba0M3KbNVoZyZlgasgaoaHf
         qEAYKPdS1YobzL6SsV6aFSjOUDCadaJHUTUuPOYBzrLnZ89As+JiIgFYRN7JjsrTI8pC
         ah9g==
X-Gm-Message-State: APjAAAWTJpoF9VkXkxG3Xvt4j8TgsEB8qVyr+I5+WyZiKYDsUas1pIuV
        p16c6X60h3rCQ0UNr3aPFZ+O9t32KBeuYL9tKKo=
X-Google-Smtp-Source: APXvYqzJzXwniWV11iyI5rB1xzenfbGjuNt16WjkWMKnungYxIEtSdoNzRX/9im4O+QtvL8NXUN1aMXrq3HPv0xExpQ=
X-Received: by 2002:aed:3363:: with SMTP id u90mr23512125qtd.7.1566922365105;
 Tue, 27 Aug 2019 09:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190827154851.10486-1-enric.balletbo@collabora.com> <20190827161045.GC26807@tuxbook-pro>
In-Reply-To: <20190827161045.GC26807@tuxbook-pro>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Aug 2019 18:12:28 +0200
Message-ID: <CAK8P3a2h2gUhxcVgD5JhR1Uo4qUSuG5yp4RCrAxevNmyD4ZRTA@mail.gmail.com>
Subject: Re: [PATCH] arm/arm64: defconfig: Update configs to use the new
 CROS_EC options
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        SoC Team <soc@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Daniel Mack <daniel@zonque.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Yannick Fertr?" <yannick.fertre@st.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tony Lindgren <tony@atomide.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 6:08 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 27 Aug 08:48 PDT 2019, Enric Balletbo i Serra wrote:
>
> > Recently we refactored the CrOS EC drivers moving part of the code from
> > the MFD subsystem to the platform chrome subsystem. During this change
> > we needed to rename some config options, so, update the defconfigs
> > accordingly.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Tested-by: Gwendal Grignou <gwendal@chromium.org>
>
> Can we make the entries in the generic arm64 defconfig modules?

Good idea.

Actually I would prefer to have all of them as modules for consistency,
if at all possible.

       Arnd
