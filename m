Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2152C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56C320700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553692356;
	bh=cxNh8KEPDWZccbjmkIpgldUPBd4j0XuUwi6lGUP5UCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jh/TKLBOZ3xLv0aImI80tnq40HS8XQ0olYbRQGiUUyZ3dRBvfNUPe/UBFGyjsy2mr
	 vNHpP3cX/myqAu4U6LRlWi376Ln+zkm8EOOs8gWq89hYGlvMZ2za+bu1sksTeWyWv4
	 bSoOzvJndLQLhFml2/JZglGtHeyguiYQG87399VE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfC0NMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfC0NMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:12:35 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B1821734;
        Wed, 27 Mar 2019 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553692354;
        bh=cxNh8KEPDWZccbjmkIpgldUPBd4j0XuUwi6lGUP5UCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w7oNR6zBRr22JAt1KVPDT/CrGdeBsPAqOj6IZ6rsYJPKWKm0W2rVy1YT56Ybz12Xc
         JeitrEDrKy68bcUiPDPcfj0pvyhEE96h1V4KBCWJKiDtxvRPjYzQt3UqPt9eHR/3GU
         /XhJlcMWmoWhdGWCJXu9j/XuylpQ86ezStWJGMUM=
Received: by mail-qk1-f180.google.com with SMTP id c189so9801610qke.6;
        Wed, 27 Mar 2019 06:12:34 -0700 (PDT)
X-Gm-Message-State: APjAAAU9/4gtrKBZ9dXPamZ2/0azF0BRURwjgEjuQ1QpNMDCRpsrOB8/
        H4EZ7SmKyJ+0C+r4shNfp123O2ZsV/a0W4mgHA==
X-Google-Smtp-Source: APXvYqxlRMLQ27c3NqYONNqr0ERb3Su8yfdv7W3Kve1LVSXJCRUjlume78Mpvi6YyPHolhmqoS7iMi7M5ATBf8MJptU=
X-Received: by 2002:a37:4a12:: with SMTP id x18mr28175519qka.184.1553692353829;
 Wed, 27 Mar 2019 06:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190327064150.31549-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190327064150.31549-1-andrew.smirnov@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Mar 2019 08:12:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQZrioBJN5CO3FMAzMZds=vX-uKvi1Ler2fb=MGOPkZA@mail.gmail.com>
Message-ID: <CAL_JsqLQZrioBJN5CO3FMAzMZds=vX-uKvi1Ler2fb=MGOPkZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add support for ZII i.MX7 RPU2 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 1:41 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add support for ZII i.MX7 RPU2 board.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
