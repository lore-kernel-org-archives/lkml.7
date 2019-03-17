Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E969C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7622086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552845764;
	bh=7Rt+DYkpkJqsM62CnnphOofF69PexMk0RNGpf5ISyOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LvO2z1Bg9EIa8rN9W7sGHdc1CObC9JaSWvlF/2+EO8B4Vz3IgDjDX5WIEnzLfsyAF
	 vwe/EHzx+9nyj+rGZBG1nAAnmF4Dc8iS4MCLJhu0X9RY8kGpX6oI02FrciHbkNmeI8
	 SHHtyHEMf2r5g/amXQYI9yrm876ttujIDzf9h8rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCQSCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfCQSCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:02:42 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 258132184C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552845761;
        bh=7Rt+DYkpkJqsM62CnnphOofF69PexMk0RNGpf5ISyOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hp/cR2SaceewV62YbbywZQo7iEp8zktViiBg/rRtsFcAwPoVfKD1UzXd5QBdy6e9X
         YYlrJoKnCNYDU/uKU+8YrNa3QY9bRDiR2nc4pOQirXG6GOq9ab3xfL0yotl2n8K63Z
         vV8Lh4SgQ+i3AobsIwvt3bs0u474PuGwT/MJ8XdU=
Received: by mail-wr1-f44.google.com with SMTP id t5so14568575wri.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:02:41 -0700 (PDT)
X-Gm-Message-State: APjAAAVwBG5E/PZwZI2jIgtzGYt4hZtgWoc5jZjlK+dHBs1vqjCneU40
        wuhXVRld5uSIC9thMbO0j1hX/T4LHEBsq0dJP1A=
X-Google-Smtp-Source: APXvYqynBWfDsNGTl9tJ+pfZwqTUWoTpnZ1PJ34k2tQhQauXSL0lRDh9XC64z2c+IfaWbSWg7wRAABwXJaOBc4PzRd0=
X-Received: by 2002:adf:ec41:: with SMTP id w1mr9794663wrn.184.1552845759641;
 Sun, 17 Mar 2019 11:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190317084443.158913-1-armax@google.com>
In-Reply-To: <20190317084443.158913-1-armax@google.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Sun, 17 Mar 2019 11:02:28 -0700
X-Gmail-Original-Message-ID: <CAGp9LzoWhFzjryv1BhUyjNZOU-K7pgKji94n_7B-Bzbu2mJ1Ow@mail.gmail.com>
Message-ID: <CAGp9LzoWhFzjryv1BhUyjNZOU-K7pgKji94n_7B-Bzbu2mJ1Ow@mail.gmail.com>
Subject: Re: [PATCH] dma: mediatek: addres minor style issues flagged by clang-format.
To:     Armando Miraglia <arma2ff0@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Brown <neil@brown.name>, devel@driverdev.osuosl.org,
        jbi.octave@gmail.com, gustavo@embeddedor.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, sergio.paracuellos@gmail.com,
        Armando Miraglia <armax@google.com>,
        linux-mediatek@lists.infradead.org, bhanusreemahesh@gmail.com,
        christian@lkamp.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 1:45 AM Armando Miraglia <arma2ff0@gmail.com> wrote:
>
> Running clang-format on mtk-hsdma.c I noticed that few lines would not
> need to be wrapped, since they fit 80 columns. This change changes such
> lines to better fit the style-guide.
>
> Signed-off-by: Armando Miraglia <armax@google.com>
> ---
>  drivers/staging/mt7621-dma/mtk-hsdma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
> index 97571f1d697b..74c374f7bef4 100644
> --- a/drivers/staging/mt7621-dma/mtk-hsdma.c
> +++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
> @@ -264,8 +264,7 @@ static void mtk_hsdma_reset(struct mtk_hsdam_engine *hsdma,
>         /* init desc value */
>         for (i = 0; i < HSDMA_DESCS_NUM; i++) {
>                 chan->tx_ring[i].addr0 = 0;
> -               chan->tx_ring[i].flags = HSDMA_DESC_LS0 |
> -                       HSDMA_DESC_DONE;
> +               chan->tx_ring[i].flags = HSDMA_DESC_LS0 | HSDMA_DESC_DONE;
>         }
>         for (i = 0; i < HSDMA_DESCS_NUM; i++) {
>                 chan->rx_ring[i].addr0 = 0;
> @@ -435,8 +434,7 @@ static irqreturn_t mtk_hsdma_irq(int irq, void *devid)
>         if (likely(status & HSDMA_INT_RX_Q0))
>                 tasklet_schedule(&hsdma->task);
>         else
> -               dev_dbg(hsdma->ddev.dev, "unhandle irq status %08x\n",
> -                       status);
> +               dev_dbg(hsdma->ddev.dev, "unhandle irq status %08x\n", status);
>         /* clean intr bits */
>         mtk_hsdma_write(hsdma, HSDMA_REG_INT_STATUS, status);
>

Acked-by: Sean Wang <sean.wang@kernel.org>

> --
> 2.21.0.360.g471c308f928-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
