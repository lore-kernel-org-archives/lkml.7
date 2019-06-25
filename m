Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F00C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A622A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jFen1YNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfFYPUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:20:10 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:34491 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfFYPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:20:10 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x5PFJrJP020791
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:19:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x5PFJrJP020791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561475994;
        bh=8eJocD6XzIfzyTq46YseYA8FJwhqn58xe1pkfONZbh0=;
        h=From:Date:Subject:To:Cc:From;
        b=jFen1YNQdtrnVha9uQMqeerfb1VlWi6kN8I7h3dP/Zh2O6eFIpSSKmtm0ZiKME56U
         zscZ9ZVsxkh2PV/rZU+kTzDH9e4O0cU6JGB47PaopHHuEO8mrlOP4HB3qE6sLM8RFI
         n42vlCLlWRGDD0h3/qtzgbEyaPKTttD3eEMHZ4VtMlhpbJbqLpnSvd3iDFDUt3LPnn
         R2LzORLrMKWvOw9A41OBCVEqw6DWS6brmfrpJOqwvflVZvgAMUy+jxB+MIEeCBsWdT
         zFpfXmz4Q+nh+egXyOno9ZNve7mE+rcx3tHZ/5nX+nEkOM5NgtdvAWarHRhkHyf+hO
         bdsZaLAT4/duA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id k9so11154859vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:19:54 -0700 (PDT)
X-Gm-Message-State: APjAAAU6AqyaXWaige5E50AFgsBa6VcqgJZ23ea+dEVsf2dEczGnfhnb
        g1tIcQ9fKpfUKxa7+mHVapf0OyGfALxRX3PcBBM=
X-Google-Smtp-Source: APXvYqxcY9vX2I0IiZ3EEMiqqLmbaEM4koPXF5Iv6tPmsp7IokzzjrS8GO7yww+g9mnQya0jZU62nEWCezjcLlFl3NQ=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr17458566vsd.215.1561475993331;
 Tue, 25 Jun 2019 08:19:53 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 26 Jun 2019 00:19:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNhp2o9kboRMJ66UJy5Z+T28K6CHO_=c02MaGoFyy-5Q@mail.gmail.com>
Message-ID: <CAK7LNASNhp2o9kboRMJ66UJy5Z+T28K6CHO_=c02MaGoFyy-5Q@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v5.3
To:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Please pull UniPhier DT updates (32bit) for the v5.3 MW.

Thanks.


The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v5.3

for you to fetch changes up to bc8841f0c1e6945fd7fde6faad3300d1b08abd86:

  ARM: dts: uniphier: update to new Denali NAND binding (2019-06-26
00:06:50 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v5.3

- Migrate to the new binding for the Denali NAND controller

----------------------------------------------------------------
Masahiro Yamada (1):
      ARM: dts: uniphier: update to new Denali NAND binding

 arch/arm/boot/dts/uniphier-ld4-ref.dts  | 4 ++++
 arch/arm/boot/dts/uniphier-ld4.dtsi     | 4 +++-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts | 4 ++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts | 4 ++++
 arch/arm/boot/dts/uniphier-pro4.dtsi    | 2 ++
 arch/arm/boot/dts/uniphier-pro5.dtsi    | 4 +++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi    | 4 +++-
 arch/arm/boot/dts/uniphier-sld8-ref.dts | 4 ++++
 arch/arm/boot/dts/uniphier-sld8.dtsi    | 4 +++-
 9 files changed, 30 insertions(+), 4 deletions(-)


-- 
Best Regards
Masahiro Yamada
