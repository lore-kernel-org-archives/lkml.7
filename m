Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C90C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B2421743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558452384;
	bh=iGkz6BZGfgnVMTNR7D6Gc8n2oafP2tlbN+gEg58SOgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w6GVthtkcqKYUSXxCMSdCy60+L0GfRhrnSufqrJXAQolFyKAVTN+jolDuS5Isxa7V
	 qSpX//riMxDJzzqzGqfr2eXMzt2gKPhKuwHGTDHvA8r/ZMWc8R6WRtzMSZI92YYQPg
	 oADkZu8O84Xe0SC7ULTX1hTtRfyMg8QTijcICCKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfEUP0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbfEUP0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:26:23 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6479E217D7;
        Tue, 21 May 2019 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558452382;
        bh=iGkz6BZGfgnVMTNR7D6Gc8n2oafP2tlbN+gEg58SOgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LPan0OoquxfP+CI0zX4dxS2darinFP/btGENU/v8B2Rt3/kZQFsqph4g3Q0igIdy+
         xKknddwpqzrAd9v53nL3AbU9x65g3z0Oo3zHWAg+EvpuOz4KO5Kc7bVYa7qdOtPYho
         QuY98ftLY+1E/kbdehw3VW0UHwI3DJ7LBbOvczMg=
Received: by mail-qt1-f176.google.com with SMTP id t1so20916306qtc.12;
        Tue, 21 May 2019 08:26:22 -0700 (PDT)
X-Gm-Message-State: APjAAAVImKMTw5/PmyE87gX5IcyF226qHpQ5cDVAeHfukhs4RRStfans
        8Pz6nciBoNY1VPlYhyRfQfOli1IvLMt4/wgHdQ==
X-Google-Smtp-Source: APXvYqzQZSno9wojPimJguFsCsD2Brx/RDShSi4VwGE71wQY9X3Mjw8GOQUDteEXyxgmqI5nEQ6JJxGYVo0v+anUMmU=
X-Received: by 2002:aed:3f5b:: with SMTP id q27mr68089866qtf.143.1558452381663;
 Tue, 21 May 2019 08:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190521151952.2779-1-narmstrong@baylibre.com> <20190521151952.2779-3-narmstrong@baylibre.com>
In-Reply-To: <20190521151952.2779-3-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 May 2019 10:26:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+am_5q5ApjEo7bVXWsqEaZH-1kbqGVS51-O+p1poFLsQ@mail.gmail.com>
Message-ID: <CAL_Jsq+am_5q5ApjEo7bVXWsqEaZH-1kbqGVS51-O+p1poFLsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: amlogic: add Odroid-N2 binding
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:19 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
> from HardKernel.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Rob, Martin,
>
> I converted the patch you acked in yaml, I kept the Reviewed-by,
> is it ok for you ?

Yes, both look fine.

Rob
