Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62069C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D08622DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566317768;
	bh=o+9Y1S8EJeybPB3/XiGd1VecFWcI3U1F/7ifdtRoKzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j2AjCNy269q44SxLnMfKaqpp5+JUWdL06nyNaP0j1VcBUXnxO5YJwwahDp1awurHI
	 7E11c+OQ1mPfP8Y4rPPDtjbLgnqWlMdIqTmwiznzuEDKEPIf9LOOLBrEXd+nevxqr+
	 QeXzLEP85keqV4za6AoHoCZyP4jeQpYy0DUlP46Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfHTQQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTQQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:16:06 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED6B230F2;
        Tue, 20 Aug 2019 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566317766;
        bh=o+9Y1S8EJeybPB3/XiGd1VecFWcI3U1F/7ifdtRoKzQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hq3LvZjFfnrBR33GHefdlaXFKqMqUujeYNw2kRo6h4AY/lH46aepgIsEYj17NJaEY
         d6B/fUXh/S7aVrOkFzKwupvPvyW+mRANSNf29yG8OQCAjwpbZOw7mN5hwHQTr5v2Gn
         FTSZ+jbiwvHthFu3wAs1dOgwtWnkrmiBHqzFL7Ps=
Received: by mail-qt1-f173.google.com with SMTP id i4so6652701qtj.8;
        Tue, 20 Aug 2019 09:16:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWegxsc1rk+o7dNwLl29BAgJ2SZbUN82td8+DeXbCvRqfKHCqJU
        lynCey/nqz1Gchb6C9LIQHZNsg3o/EFvSdF9Zw==
X-Google-Smtp-Source: APXvYqz7/XDtwS8pKWW3WNm/atXtEdgaMroF8d1FCSG5RqKVSlW11FfeZTvwkmlYEEwGR9WC60bpQDx079FVVKGuyUQ=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr26685231qto.224.1566317765244;
 Tue, 20 Aug 2019 09:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190820144052.18269-1-narmstrong@baylibre.com> <20190820144052.18269-5-narmstrong@baylibre.com>
In-Reply-To: <20190820144052.18269-5-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Aug 2019 11:15:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKFBcstWfaG-n6k9169bF0o7DDq1Uy6EcTF4p-Ta_DOBA@mail.gmail.com>
Message-ID: <CAL_JsqKFBcstWfaG-n6k9169bF0o7DDq1Uy6EcTF4p-Ta_DOBA@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: arm: amlogic: add SM1 bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 9:41 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add bindings for the new Amlogic SM1 SoC Family.
>
> It a derivative of the G12A SoC Family with :
> - Cortex-A55 core instead of A53
> - more power domains
> - a neural network co-processor
> - a CSI input and image processor
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
