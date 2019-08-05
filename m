Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2AFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF2820B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565018934;
	bh=0OjQ8Rdqqx/BilDZyvjG6A1sMxbSpqh2cWddJ5gCTxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bUut7u4Os13UTDaOBQeUQuUjaBKC35CTKeqw2njvYelkQlfNs8JPEbx2VdyIGGn+j
	 N3bNbM8y5BqHIQtVPNIAm9MFpHRBsQD0bRPvpBDTH6K+/dh9LEGtKellEjfQurjcNs
	 GbOlHioY7eBWzj/hRmO74CDAA1bM2QuXONtY3Esc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfHEP2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfHEP2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:28:52 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2FC321734;
        Mon,  5 Aug 2019 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565018931;
        bh=0OjQ8Rdqqx/BilDZyvjG6A1sMxbSpqh2cWddJ5gCTxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=duH8pakwY9L3UpmLFj+tYRNB3e7+ek2sgh5AF5PT5QSI8PBN8JrF0qXVWWeMY1BDe
         7mqSzPL5PD4GdydB6QAzZzpuSBs5cO1fO0uxjV8epriAov44a/pr3add+zRHl66KhT
         XdxMbB9sU+JatZfB9FIvfHysQTOXsb4WWsz+o8N8=
Received: by mail-qt1-f174.google.com with SMTP id k10so12174326qtq.1;
        Mon, 05 Aug 2019 08:28:51 -0700 (PDT)
X-Gm-Message-State: APjAAAV6gsTCwknQtUHB4t/CVLDO6+VWQMU9OI0zOL2GjK1q8QlITsRE
        N/hQ+uMQLXTC/eC4S9hLQLsDhtppzbcNmNv85w==
X-Google-Smtp-Source: APXvYqx9Mp339aOHnb56VlztmeVuv2F5K0wvgS8FCwqrBT+3li2+QntQXhNvXx3cWwoB15jWc/TREdIJGl2K2FIijfw=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr107432491qtc.143.1565018931042;
 Mon, 05 Aug 2019 08:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <1564996320-10897-1-git-send-email-mars.cheng@mediatek.com> <1564996320-10897-2-git-send-email-mars.cheng@mediatek.com>
In-Reply-To: <1564996320-10897-2-git-send-email-mars.cheng@mediatek.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 5 Aug 2019 09:28:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5jydeN83BU+Ne+6muv7KWjceJrAApaOXYevLmUJh6qw@mail.gmail.com>
Message-ID: <CAL_Jsq+5jydeN83BU+Ne+6muv7KWjceJrAApaOXYevLmUJh6qw@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: mediatek: add support for mt6779
 reference board
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 3:13 AM Mars Cheng <mars.cheng@mediatek.com> wrote:
>
> Update binding document for mt6779 reference board
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek.yaml          |    4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
