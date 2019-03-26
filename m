Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C431C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D011E20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfCZKJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:09:58 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42045 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:09:58 -0400
Received: by mail-vk1-f195.google.com with SMTP id j195so2658534vkj.9;
        Tue, 26 Mar 2019 03:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiPDhCGszdoXkG6HlbhMQsncGp7yRxk7ATjnwu9mtSI=;
        b=TmyzBVLC6EPjJLkF5zYtBfvhYB88kQGzUtG55lLpJJ7x7dzhQyqwKsZOc6zxHFNLkD
         aQS0CYfOVmhyZlPfBYdaE/hsjWsnPOHVEx41FJyjAZem3TjSJoLu3Y0RU82ZcQy5XlX7
         UVA2Mbrmg4vXOF0TgW2JNixcoUKOiphTGaXflfosudsYSHSyRFk94nDgWnZ+P+cxTDPC
         MuMBKwtWKdBv+q1fdBmGxe/wnDLICK+RgIw+d0uhtuOAqqV+IP8EhRtG2/m9NX+Oyudn
         ggwwNR4SUqcGh/FQzPxrsqhEJWLTLQGPn3VP5/klU52QnWTT7g+C/i1GFIMJg90IF/GF
         U33g==
X-Gm-Message-State: APjAAAXK5D+3CDTNL4eqDyfnBtCQcGICw/hAAArfwx862bvpAv7blvDG
        8ksFKrS0qkvvnckatOmf/i10CAiAU4vAgfthtqQ=
X-Google-Smtp-Source: APXvYqznam6JKMLuhy/JCOry9qSbZRbnK4TTrK19byGNk/lODvPckj9prASa1CRkl6HgvB/5dTSGnweWtYHLSD5wF4I=
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr17634118vke.40.1553594996905;
 Tue, 26 Mar 2019 03:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190326095826.4987-1-jiada_wang@mentor.com> <20190326095826.4987-2-jiada_wang@mentor.com>
In-Reply-To: <20190326095826.4987-2-jiada_wang@mentor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Mar 2019 11:09:45 +0100
Message-ID: <CAMuHMdUOcPhy5D-RagprwZkqOOgNt+4bGfSLQzydydHBOt76kQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] arm64: dts: renesas: use extended audio dmac register
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:59 AM Jiada Wang <jiada_wang@mentor.com> wrote:
> Basic audio dmac register only supports busif from 0 to 3,
> in order to use busif4 ~ busif7, extended audio dmac register
> need to be used.
>
> This patch updates H3 (= r8a7795), M3-W (= r8a7796) and
> M3-N (=r8a77965) to use extended audio dmac register set.
>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
