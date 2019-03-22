Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAA0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B9F218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfCVIzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:55:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39112 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCVIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:55:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id p20so530096eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbpj/1n9YHLnSj2y+ud5HSLh+qgGg/u3+iU1IBadjOs=;
        b=aNQ4o9ElZCjWaBuFnY1o+CZphQ1sD9Sx2xd76XJq4P6RNdPFJRCDhrAQQ4OZuvfmir
         nny4KAwrrTCM0rUVpAhb8IYwTzL6BS4/Oeul8ss8c/7uZllGrCHRJmE86y2XjO6fejx2
         FHYEu6zChZG/4QACtFhFM7p0yBOrtzsrwnD6Uq3loVhCMWrioo66d9ywc4EqwTnt+hzF
         y/1NFu3Unbckcopiq7CoYHdxhF6gSvDkSwxMeHAbMfu+TI7expmU9wKwRI0BO7IteGK6
         0mcI4mhNUQbfY+Qm1STzdS6NAPbUNLeibaNV19BpbX5ZP1+5tLIhFu/zTeZ4/UZJ/B6K
         yUfQ==
X-Gm-Message-State: APjAAAWsdZO3PO/qELV7h7jlpueIDfTF+Br29J7ZFxho/Hx1epahIka/
        O8KF3BJfzRVGgQbtb/8DPZPm2QwUX3M=
X-Google-Smtp-Source: APXvYqxgD9rMYr3mbMsKXtkXHy4jmxR5ze8feFE4qJbpM+o3MwW1xKXh/rfo+NarOK9zzW4iuzjQRA==
X-Received: by 2002:a50:b1bc:: with SMTP id m57mr5391740edd.116.1553244942088;
        Fri, 22 Mar 2019 01:55:42 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id g3sm1561841ejp.31.2019.03.22.01.55.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 01:55:41 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id q1so1442554wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 01:55:41 -0700 (PDT)
X-Received: by 2002:adf:ec87:: with SMTP id z7mr5542735wrn.44.1553244941576;
 Fri, 22 Mar 2019 01:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190318125613.25268-1-maxime.ripard@bootlin.com>
In-Reply-To: <20190318125613.25268-1-maxime.ripard@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 22 Mar 2019 16:55:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HPVMyn8v5Fo9rBzsVE1CTTUv-YKpvbhUZLgWHxEyKLA@mail.gmail.com>
Message-ID: <CAGb2v64HPVMyn8v5Fo9rBzsVE1CTTUv-YKpvbhUZLgWHxEyKLA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i: a23/a33: Add R_I2C Controller
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 8:56 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The A23 and A33 both have an I2C controller in the ARISC domain, that share
> the same pins with the RSB bus.
>
> Even if it's an unusual configuration, that device can be used to drive the
> PMIC, so let's use it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
