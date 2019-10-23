Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E59ACA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2858214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405261AbfJWMVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:21:35 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJWMVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:21:35 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MFbeI-1iDxaN37DK-00H3xn; Wed, 23 Oct 2019 14:21:33 +0200
Received: by mail-qk1-f171.google.com with SMTP id u184so19536680qkd.4;
        Wed, 23 Oct 2019 05:21:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUF7DXtXcZia4FgF4ZT0ql5Pz8CqHq2LvFyMTLtPihHFBrDKsbV
        rpcSvWjmmFg7U54+KIGSqLMSfxzgMnysbiR2RvQ=
X-Google-Smtp-Source: APXvYqywolZK5PhhD1Ci5xyPoP7evjr9xymo+jxueW74UL7uRR5HCmN3nKfxdtCNF+ok3sOC78HxeesW7dFmNGJpN8M=
X-Received: by 2002:a37:a50f:: with SMTP id o15mr6758290qke.3.1571833292457;
 Wed, 23 Oct 2019 05:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-4-arnd@arndb.de> <20191023100958.GB10630@pi3>
In-Reply-To: <20191023100958.GB10630@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 14:21:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2YtMV2rSkR2yq5-47BmDKViROrwxaix8MsKxPSvbsz-w@mail.gmail.com>
Message-ID: <CAK8P3a2YtMV2rSkR2yq5-47BmDKViROrwxaix8MsKxPSvbsz-w@mail.gmail.com>
Subject: Re: [PATCH 04/36] usb: gadget: s3c-hsudc: remove platform header dependency
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qymyn6buMSNBWWTrimal6uo7OkrWGoTa0u/NRCPJeLPD6HR10sj
 Zi+nvZyx5srLrMp+d+B1UEUoRRXZr7cT6pqWBszIpZPjXYWQJeCkCm9OlEwfirKaBF38YHr
 pYUgFDlGDEgI89UXGyTiCJoeAevHYNULSIEidHqbrZyk6cKiPQm5UR5xj9qUDtEtZK4LVCn
 Q+6XmOU0b+MjF7n6Gv6RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fJiyN2UF8kw=:NOSOrNeGDRdF/UQXcogyXh
 NUGWP8gzBuMM4oyyfHEcx4l1oOHnFm+7IVQY/7ruXauVGR/zJPiNXQYsErcCoIvW8DTQ/HfO7
 FSoCxZZEd4uUbGwkTsCgWyLbfwPKZkkmr+qrlv8Vr6Y430bQOTYzeGf16ktZDNO7kLDqLyPzX
 IY1Y7oMZPx2HJEbTYayJ+hjcki3lP46oj9goK5mF/O6FSz5EwALyhRI2ddYfre37VM0M83Cqr
 x0JgaswHbsgaw9CrthyyOIgau+SK8AjHRSW9Rx073ZcrSndUae2PwVkV93xNRTJ4dlFWLEu5x
 KXDznyR26MGYXqme4IQ67nnZyZLYNRKma3HfYGyN5OD/UpbagewCSz1ifA5Pd9Fw3mYPujcph
 OzX8YL4j/4JOWndq0YaoremoletotE7ogVvJSCzPGmxcA3DbkEhS8T9TovMBQ7fz3Gw9NSOQJ
 DyOuH1sHe79sCfSZDsGSObpzz67iqLX03CdXDdz3iR8VzeDP0zyOQYhjwr9ToCkX7Egovewci
 SjdAMBls9U9rPb0FVlSXgjOkvy2nSibTQ8NEQ4vBeaKtemXQ2phXvDOoJMGeO1Z1+DoKF5iNU
 HK4Fxq2XWbNkqkfL+pDmqrmTJnESsoTK/tclVVCPKk1mAUHEviVBYKYiTyvHvH+xhhq3S6eIf
 e91yOYm/3Us6gKp7Ja5AG7K55lKsu0MDN0cnccPZUc7rTCY6K8BaB2mwEtywPHp5zOwH6qXyt
 uVoKMk9i0xkdqWyfTCR5Dsj3FAZlVoYXU3O1w4AQLH87vcu6pFglaNip12i4QPK1sK3QJju2y
 raOG4RPbpgh6lrMi6OssESTvx+gBLgsfiXovGtqTBaU0Kn4UDi+v+mCIv5yOy79ImXmEEyB7y
 PXxekqAFU1h7EK+lisrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:10 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:48PM +0200, Arnd Bergmann wrote:
> > @@ -1188,7 +1139,8 @@ static int s3c_hsudc_start(struct usb_gadget *gadget,
> >
> >       pm_runtime_get_sync(hsudc->dev);
> >
> > -     s3c_hsudc_init_phy();
> > +     if (hsudc->pd->phy_init)
> > +             hsudc->pd->gpio_init();
>
> Copy paste error - phy_init().

Fixed, thanks!

> Are here (and in previous usb gadget patch) any dependencies? If so, I
> would need an ack to take it through samsung-soc.

Yes. This patch should not depend on anything else, but later patches
in the series depend on it, so I'd like to keep everything together.

      Arnd
