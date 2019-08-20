Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FFDC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D37A22DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566317785;
	bh=bq0/jB5m4Jp2FX8tBxSzWeqfhZTnVq066dgi39PlpzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YGlSvQF9yBb3Y5JPotfbfPObS5LZ8F1t5heDxK0ZN48wSiSe7c6heVsRKjb+1Ortr
	 DmLdPvpv0i3RmKhZqgb5/XBpcZq/OkrDQNRcR1YgYY30CWM+91PH9ODyt+e8XM2FIi
	 lmsRd6OGvBgy/9waxryLB6grvVXRFmiWpEgKsUzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfHTQQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTQQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:16:24 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A7C922DD6;
        Tue, 20 Aug 2019 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566317783;
        bh=bq0/jB5m4Jp2FX8tBxSzWeqfhZTnVq066dgi39PlpzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TClCeVoX+Lao6744v1UtRF8HhC2UQ2O5TO4HnDMwLhBzXPXaXeg3mhBCGKmLEgQD3
         6PHk/4MEGIVN+wNL1L4SkDQYveyMBVn1UZu/Q3GTwx3vpwjjmAUtB51+m6/ppcbkYa
         F736nAUWf3TfUAuhGN1ohivoz5Kn+FgeyuP5FVg8=
Received: by mail-qt1-f179.google.com with SMTP id v38so6677273qtb.0;
        Tue, 20 Aug 2019 09:16:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXYKhff/zrZla/ZDVYHpUFsDsf/77UTmukxmDAEL6Y90Y1XJhVH
        KjATx5OSD0laITt/PT7Q89b7BUkYOzrnlK73aA==
X-Google-Smtp-Source: APXvYqwp9qLnX0fVBz6JKjNTCRZjs4AvNuGh+ir98aRhQvRHBFS366WOun9yixr1j0KWUOR7JkKRSM8t6XOkoOt3MOs=
X-Received: by 2002:ac8:7593:: with SMTP id s19mr26991334qtq.136.1566317782530;
 Tue, 20 Aug 2019 09:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190820144052.18269-1-narmstrong@baylibre.com> <20190820144052.18269-6-narmstrong@baylibre.com>
In-Reply-To: <20190820144052.18269-6-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Aug 2019 11:16:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKAL0UG2afJgOVjtzgDA9oQ35p9ieSYnzys5OPYU-RvmQ@mail.gmail.com>
Message-ID: <CAL_JsqKAL0UG2afJgOVjtzgDA9oQ35p9ieSYnzys5OPYU-RvmQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: arm: amlogic: add SEI Robotics SEI610 bindings
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
> Add the compatible for the Amlogic SM1 Based SEI610 board.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
