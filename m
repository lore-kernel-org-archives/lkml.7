Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFACC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E1F214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565104011;
	bh=dCfRxSTdrclRoNkv/xjg9SIPiioXv6oSzqoCo0lY4ek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Za+Dj/9fsug8C9X1CO2KPiydAareVztJnSAP2S2p5P6OV4KS0qP7PbhlU0Wg95FFH
	 TtbxqK/h9O3KwCp+ZXImJCTWvsBeQxYd71ElchlyavWwWw2z28IV1TNCkV8VyPQBi1
	 lE141k+x8Ye8NXBIBW2UWQF2Z83t2ZAFInTGNaJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfHFPGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFPGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:06:49 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5AF2173B;
        Tue,  6 Aug 2019 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565104008;
        bh=dCfRxSTdrclRoNkv/xjg9SIPiioXv6oSzqoCo0lY4ek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=01L8WhCkW8n+jhUFCT8+O5Ij4fFbVH+cRrQSdmvUox2Sbs7D26uOfBSdHxqj3eGcZ
         mHqq6j+uc8anmZpBgxvOFxS6tuFzwI65nYnglCRU+iSHXzju2d4fxZf+npKD7LnXWt
         FH0GT4LrVfCqJWrTzy+i/nlAlIwTtlu4MI00TbWU=
Received: by mail-qk1-f171.google.com with SMTP id d15so63099331qkl.4;
        Tue, 06 Aug 2019 08:06:48 -0700 (PDT)
X-Gm-Message-State: APjAAAUe+L42m3S2tylPSQwJP5JGuOQMdEGQIQ6A91bWwGNAGOKd0IWJ
        Ozk+0liYOdhjkV3UMjPR2ciTkR2I/EHwqbFNIA==
X-Google-Smtp-Source: APXvYqwskMcAR/Gsy/TuAZnM+fL3o5yfNberLPPVu7PiOwhuQEN3u4auDF91Qxvn22wdqNF9i/GNEobuyrXTHoTDJJE=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr3748098qke.223.1565104007836;
 Tue, 06 Aug 2019 08:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190806124416.15561-1-narmstrong@baylibre.com> <20190806124416.15561-2-narmstrong@baylibre.com>
In-Reply-To: <20190806124416.15561-2-narmstrong@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Aug 2019 09:06:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZoS-nsH56BdcUYe-4sw1=ESZJH_3S2Y0mMwT701wuyw@mail.gmail.com>
Message-ID: <CAL_JsqKZoS-nsH56BdcUYe-4sw1=ESZJH_3S2Y0mMwT701wuyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: amlogic,meson-dw-hdmi:
 convert to yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 6:44 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic Synopsys DW-HDMI specifics over to YAML schemas.
>
> The original example and usage of clock-names uses a reversed "isfr"
> and "iahb" clock-names, the rewritten YAML bindings uses the reversed
> instead of fixing the device trees order.
>
> The #sound-dai-cells optional property has been added to match this node
> as a sound dai.
>
> The port connection table has been dropped in favor of a description
> of each port.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../display/amlogic,meson-dw-hdmi.txt         | 119 --------------
>  .../display/amlogic,meson-dw-hdmi.yaml        | 150 ++++++++++++++++++
>  2 files changed, 150 insertions(+), 119 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
