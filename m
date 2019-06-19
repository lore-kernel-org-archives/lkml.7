Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C2DC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF6B21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfFSHEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:04:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32985 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbfFSHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:04:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so9175840pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 00:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GRtGy7EtU8jAUy4yjm+riLlSPb0h7m/0LVZFMRonxGc=;
        b=mlRxdRXyZpQX/7PePompFthb6sPVAsTP+PGk6HHyOFeNXVLrjNw9K/l1JnGKQOQavE
         3248AtV9OPKb7AspfolrS0EYydjYFdtjfDWr++OxHaFn9u0GSv9RqAlpkX/iLhUcZRZb
         6igLOZ/PXR4jYdRpdonErADvqLhWLHtB0BXV+JI+QlCrc/Ipb1wYU1ILuhf4JdPTcbP3
         NzAJyLYAB1NC4zSvLJ6NB08bYQwC347hIZheixgQfNL1nUR7zXFFxJPDoCWONhfqR8tY
         mK7LHqW/P1ulBnWPSbhrgsF4ej/h4W961eKLWxWKV0N2Cq3AY0PVytMl+g6K0dPafIok
         KHmA==
X-Gm-Message-State: APjAAAUl7yWq4uFxoUMyevBMig41KjETFl4HPytQeYPGbzgX85TQbcyX
        Cf1Y4uiLu2Y6L1NSiP5c/H3yrg==
X-Google-Smtp-Source: APXvYqyRdGXM+Smc3hV/EoxiTjkWKnX1cbCHAGS/7j+K5uF7RUjeUIGPuiQ6LZuMklZ2vjFNydYcfA==
X-Received: by 2002:a63:5b1d:: with SMTP id p29mr6212374pgb.297.1560927860195;
        Wed, 19 Jun 2019 00:04:20 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id v23sm17622559pff.185.2019.06.19.00.04.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 00:04:19 -0700 (PDT)
Date:   Wed, 19 Jun 2019 00:04:19 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 00:03:34 PDT (-0700)
Subject:     Re: [PATCH 2/3] riscv: select SiFive platform drivers with SOC_SIFIVE
In-Reply-To: <1560799790-20287-3-git-send-email-lollivier@baylibre.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, lollivier@baylibre.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     lollivier@baylibre.com
Message-ID: <mhng-e248d181-8676-4355-9825-d06049606d85@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 12:29:49 PDT (-0700), lollivier@baylibre.com wrote:
> On selection of SOC_SIFIVE select the corresponding platform drivers.
>
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
>  arch/riscv/Kconfig.socs | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 60dae1b5f276..536c0ef4aee8 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -2,6 +2,11 @@ menu "SoC selection"
>
>  config SOC_SIFIVE
>         bool "SiFive SoCs"
> +       select SERIAL_SIFIVE
> +       select SERIAL_SIFIVE_CONSOLE
> +       select CLK_SIFIVE
> +       select CLK_SIFIVE_FU540_PRCI
> +       select SIFIVE_PLIC
>         help
>           This enables support for SiFive SoC platform hardware.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
