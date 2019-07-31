Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A09C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D1E206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564592113;
	bh=JDEMB0zREMLmLrMHdC+useYBlGljcUC+uo1OriFFjzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZV/n4+BKF+J2VyWt2p/jiWP4Iqbg+MEts2ER03Yg1lTaSsdF+rMYA0yq6LPDWpqJx
	 QbqhSWTabmKy/Sx3naY2QzDmhuDw+rMzJpbrMuhGM0Wp14WVfxtuf7Dbk6IccRSzkN
	 0AYl+VItWL0o+7Dj+Ym8nCtT7OV2df0M9Bimwdqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfGaQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfGaQzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:55:11 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5EB214DA;
        Wed, 31 Jul 2019 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564592111;
        bh=JDEMB0zREMLmLrMHdC+useYBlGljcUC+uo1OriFFjzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cAImF8l+MTX5ADdOiJKH/QneD3b8zhh4NS+aA1NAyHVfIxsAaqLYpsv7WWoB0TtwC
         2c+ItTFSXRfvJm8NLwOGBwC1tdL2l53EDDw8O2zAvqikMvMFvGEZ4ep8NiaBCipCVO
         J/gR1tv6gsEb3B4cn2OBbd6Mpyprif+nWU17dCsY=
Received: by mail-qk1-f180.google.com with SMTP id r21so49828242qke.2;
        Wed, 31 Jul 2019 09:55:10 -0700 (PDT)
X-Gm-Message-State: APjAAAUTqP6S7VK1YnaxO2UaYHxZ5Vt4OoMtmi5qk8vKm9Ltj+lwm28o
        KybPu5BSIyooVf4MtO1FXh56sfrN+uZtN9YIPQ==
X-Google-Smtp-Source: APXvYqyL4gjIwP3FgCPMgYyaj67zGUm/qznjmZ2P2Af+LHVuDZ8XmiPXVioHVdq5jApCgeXPOXaATEbkx/ux3T/Eogs=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr83759357qke.223.1564592110116;
 Wed, 31 Jul 2019 09:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190731124000.22072-1-narmstrong@baylibre.com> <20190731124000.22072-3-narmstrong@baylibre.com>
In-Reply-To: <20190731124000.22072-3-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Jul 2019 10:54:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJh0VJpRQtjEv4B9Zhw4vYPbx8spJtoR0Pmx3Mier5gjg@mail.gmail.com>
Message-ID: <CAL_JsqJh0VJpRQtjEv4B9Zhw4vYPbx8spJtoR0Pmx3Mier5gjg@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: arm: amlogic: add bindings for G12B
 based S922X SoC
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 6:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add a specific compatible for the Amlogic G12B family based S922X SoC
> to differentiate with the A311D SoC from the same family.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
