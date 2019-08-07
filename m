Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40669C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160F121BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfHGGGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:06:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33585 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfHGGGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:06:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so21459811edq.0;
        Tue, 06 Aug 2019 23:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/lpt31sW6IRKi7RJr9azX9nzTF8MLAC2zx0C+oX2sE=;
        b=UsUIYbn3mF3rdIdk9auSr0nKNLofZ09kRRUuq59AUiCUwRjawnpWxJsg0itxGKaR+I
         v7qGblnIg+/wtdlXboreXHtzBZOPpajV4vQ+wxzyCnaGaodUDYUgWmvpiXFqY0GmDLeT
         VucFZUKf/dBlEXL4ulCnz7Iv4BaNAZzgfnFGF950MqSckoxCaIhIvet7ICK+es9echr/
         /BdnWKRvpBAPoJDq//wgomQW+bwp7WjPHb3bq/sXTxvIsSkD31P9zj8glVd9vltlyFX5
         6xUsrOWx2t9W7xUt0jyMHvo8O3k1sxD9LVXlIV8Rg5ZSyR1SAwdAjMHdPmQIafZRgs5D
         GxTg==
X-Gm-Message-State: APjAAAXVkaIJffFXEWrQipIjd8kvylCqeWMUDQYmwmL/NY0DCEMOiLET
        W4LKA5Z4P1ec6lEHiVJv2e9AXaLn9p0=
X-Google-Smtp-Source: APXvYqzmzzMlz7K1qtqvWvtddVoAgfaVLJaZzu1oL+XGsHKV9X14NSCSXqTpUcqPFGNzff1sLGOBHA==
X-Received: by 2002:a17:906:5859:: with SMTP id h25mr6878606ejs.202.1565158005768;
        Tue, 06 Aug 2019 23:06:45 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id rv16sm14945263ejb.79.2019.08.06.23.06.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 23:06:45 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id l2so78644347wmg.0;
        Tue, 06 Aug 2019 23:06:45 -0700 (PDT)
X-Received: by 2002:a1c:c545:: with SMTP id v66mr8804543wmf.51.1565158005041;
 Tue, 06 Aug 2019 23:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190728145944.4091-1-wens@kernel.org>
In-Reply-To: <20190728145944.4091-1-wens@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 7 Aug 2019 14:06:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v64P6BtZp+nRSG+Qegpx3bO-ie_GHdYpRjJM3Uf0mwvTLA@mail.gmail.com>
Message-ID: <CAGb2v64P6BtZp+nRSG+Qegpx3bO-ie_GHdYpRjJM3Uf0mwvTLA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i: a83t: Enable HDMI output on Cubietruck Plus
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:59 PM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The Cubietruck Plus has an HDMI connector tied to the HDMI output of the
> SoC.
>
> Enables display output via HDMI on the Cubietruck Plus. The connector
> device node is named "hdmi-connector" as there is also a display port
> connector, which is tied to the MIPI DSI output of the SoC through a
> MIPI-DSI-to-DP bridge. This part is not supported yet.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied for 5.4.
