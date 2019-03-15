Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74F7217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552658009;
	bh=175B290tcfY5ZsaSMxhEZUQSrH+IGeSdjbf+vuzc45I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NqKKcXgJcDNz7UMf/ZWOb4jIYhDwzzkN6hA7qDWiNsjFwzC1BjxNzWD03MzujCPzi
	 K5LKszCxAHVGfSwdjo6pEktfaMnXCe8bnaFN6rztJsn4W5/vaEylhuDCb2uvYE9zyc
	 fcZzhJRVS8ZYxEwUESFyUbh1pL4IPQqFGx2TxCsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfCONx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfCONx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:53:28 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7016218AC;
        Fri, 15 Mar 2019 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552658008;
        bh=175B290tcfY5ZsaSMxhEZUQSrH+IGeSdjbf+vuzc45I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MPK72iuOJj7489knTIlTUarQSiKeC7P8MVHKxd9JlVoW9LeFeHPI6hR7DofL6bz9E
         RvGqRllpt7oRZcTCgIp0o/7MsRhwqxZEorpseW3j0fgHNht+HoWRYIIa+CnORZFD9t
         8kEy0NGakKZfaVRX42WB4gdxHsvkb7dQAJTy8G0Q=
Received: by mail-qk1-f170.google.com with SMTP id n6so5502589qkf.1;
        Fri, 15 Mar 2019 06:53:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWfsyWy25BBva+3uTR4/LTrwWs1AxtqA1HVSDQcY+bOVkZ2jskr
        YNZvhCYTftdcM6QlaBNsIa3avN3SbQO9CHwa6A==
X-Google-Smtp-Source: APXvYqzhcJej0hphBBO+V6e7yphONUr2kAgT6abwY6lhDrqI/JtQ/xX0yFzlYF/pN5WjTgrOxwOORoJmkekOUOFrZU8=
X-Received: by 2002:a37:d285:: with SMTP id f127mr2896333qkj.147.1552658007098;
 Fri, 15 Mar 2019 06:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190315093651.24978-1-maxime.ripard@bootlin.com>
In-Reply-To: <20190315093651.24978-1-maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Mar 2019 08:53:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLCbTjjoAfDqcs=dqEo7AX5OPbXjb4v0D6R4XwWihuB4g@mail.gmail.com>
Message-ID: <CAL_JsqLCbTjjoAfDqcs=dqEo7AX5OPbXjb4v0D6R4XwWihuB4g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add YAML description for Allwinner boards
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 4:36 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> We've never had a board compatibles documentation for the Allwinner boards
> so far.
>
> Let's create a json-schema for them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        | 792 ++++++++++++++++++
>  1 file changed, 792 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunxi.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
