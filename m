Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF407C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44ED22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566409445;
	bh=PyxwQDgDc5aOigK3c+vq8KjKb84oVZzrlhzvskhgtQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1U02AXMjt+avtEZit3P1JgMa4/jq8Pej58qGMwfsoPShGE+wZslyBLTuKeErN0YcP
	 rbAM2uYBVCFI+aVkhf1i5DeIhfISiVT76A2GRLn0yL7k7sY1bWWkp8hf7yNROiGsvS
	 kRFtEJyFnKqKELmyKFM4pt21wu62hhH3Bd5Sw3Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfHURoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfHURoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:44:03 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87342339F;
        Wed, 21 Aug 2019 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566409443;
        bh=PyxwQDgDc5aOigK3c+vq8KjKb84oVZzrlhzvskhgtQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=plq4ktDbbRn+azB2w7PINPSUbq3ErhQqZ7X3drQtKCRJoTJHSQUNZcJldJ52UxiEG
         TjRF7kIK6pK80xZ+Ou6QHF/Lu0fZomhzVEXQNOcIY3c7Tj75DPPsDbUxxoJylXTmGL
         M5IEyHxMus/G76cYdf+4HScK+Qvgt6AFlLEEB9HM=
Received: by mail-qt1-f173.google.com with SMTP id k13so4019516qtm.12;
        Wed, 21 Aug 2019 10:44:02 -0700 (PDT)
X-Gm-Message-State: APjAAAWyCN8KhrUObaprVQUbKZsrnldMkQVCimvDydCtypO8oYhdLMvo
        YdgpEWz9/hRnlwjJ+M0AvXKsO0T/O2goYD3Qug==
X-Google-Smtp-Source: APXvYqyQR+a47sPYtXE2oJEbDbhNlURhzSAM1nFDuJdD56V2bJUpYD2FaxDWVRw4fGXKdeXs21dF377WRfSMK/l8Aec=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr33003861qtc.110.1566409442105;
 Wed, 21 Aug 2019 10:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190820195959.6126-1-robh@kernel.org> <174045783.D6yh98NvXX@phil>
In-Reply-To: <174045783.D6yh98NvXX@phil>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Aug 2019 12:43:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJoMAHWDonXVik=y1D=_sx20OAzueBtB+YuSwzwU6iVFw@mail.gmail.com>
Message-ID: <CAL_JsqJoMAHWDonXVik=y1D=_sx20OAzueBtB+YuSwzwU6iVFw@mail.gmail.com>
Subject: Re: [PATCH 0/3] dt-bindings: Convert Arm Mali GPUs to DT schema
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:24 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Dienstag, 20. August 2019, 21:59:56 CEST schrieb Rob Herring:
> > This series converts the various Arm Mali GPU bindings to use the DT
> > schema format.
> >
> > The Midgard and Bifrost bindings generate warnings on 'interrupt-names'
> > because there's all different ordering. The Utgard binding generates
> > warnings on Rockchip platforms because 'clock-names' order is reversed.
>
> Are you planning on sending fixes for these, should I just change the
> ordering myself?

I wasn't planning on it. I just add warnings. :)

>
> > Rob Herring (3):
> >   dt-bindings: Convert Arm Mali Midgard GPU to DT schema
> >   dt-bindings: Convert Arm Mali Bifrost GPU to DT schema
> >   dt-bindings: Convert Arm Mali Utgard GPU to DT schema
>
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Thanks.

Rob
