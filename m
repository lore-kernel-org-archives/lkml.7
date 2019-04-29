Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FC12087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="KCepw7VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfD2I2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:28:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34512 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfD2I2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:28:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id j6so11011211qtq.1;
        Mon, 29 Apr 2019 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIjwi9Pdwq2tpQOmRVLR8AJ+RfItycNgwKBPS/FfFwQ=;
        b=KCepw7VGzHhTmEryB3hPHprLKpgV2QymJ2RW0SjTSFDdpK0ktwAMBDSJ1ITy+XDh60
         DoPTY09BntxLpOu+kCo5BVMGZNy/qjM3Zj6aUXL1PUv1mNwY/Viwx9hmyBnY3bpuaeNI
         XKNVhhBOR2MP/AIpyjpQxeKiRYyJ8JIVSDDJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIjwi9Pdwq2tpQOmRVLR8AJ+RfItycNgwKBPS/FfFwQ=;
        b=fIgnEwo3TbJB87+l7paOWYyVRYYH0s+MLJxDvMWUOtbXnPOudnEdjc+5bBIDbl3813
         UsySk2ntAnGyB0Bdd/WEcDXRidKZNn25ynOHJuc5YgV3aK7Vjx7YQyhvAL7B+9rbv2yX
         7Nzj1yCCGxKQrEQC3Cc+d/5/FsIFlYGw2X/qmYaJiUD9l3CVqelaEx30l6nwcGmo5XYP
         wOTbNSBrsUD1IxtBWQHMBinXrtLfIwhtgSvNplnY8NjL8mk1fsBYwWTaJkO0yMRZKrF3
         1BLxva6Frk/0yxxLBKLT6Vsc64p3V2N//q5i3qpbRCjsgPK2VJUQRC2BQqkhXavNONCz
         wyEg==
X-Gm-Message-State: APjAAAUmcegzrRW3XHJyqDgnibbHFAGU4MAyBFScw0Jq3wVIBPyuoyNu
        3pHf2B33Rx/yMatcZJYxNbO8btojC1d6tXAFhtA=
X-Google-Smtp-Source: APXvYqyIzM18/pZaeSSVKfrsxmgXogVAee5aa7XHdKeT4Kr5aRXtgQ89YiVr3LiG7FMcDqt23jMOQnz29AtcwPe8azo=
X-Received: by 2002:a0c:ac83:: with SMTP id m3mr47431723qvc.85.1556526481157;
 Mon, 29 Apr 2019 01:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190416162150.150154-1-venture@google.com>
In-Reply-To: <20190416162150.150154-1-venture@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 29 Apr 2019 08:27:49 +0000
Message-ID: <CACPK8XeTOhcdKPsKgsBJXAYeMDeHRLOSLRF5XO0oT-5XUhghMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] update aspeed-bmc-opp-zaius device-tree
To:     Patrick Venture <venture@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 at 16:22, Patrick Venture <venture@google.com> wrote:
>
> Hi,
>
> This series contains three updates to the Zaius ASPEED device-tree to
> add voltrage regulators, and update addresses and aliases.  The Infineon
> and Intersil drivers are staged on hwmon-next, and the trivial device
> dt-bindings changed are up for review.

Applied to the aspeed SoC tree, thanks Patrick.

Cheers,

Joel

>
> Maxim Sloyko (1):
>   ARM: dts: aspeed: zaius: add Infineon and Intersil regulators
>
> Robert Lippert (2):
>   ARM: dts: aspeed: zaius: update 12V brick I2C address
>   ARM: dts: aspeed: zaius: fixed I2C bus numbers for pcie slots
>
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 121 +++++++++++++++++++--
>  1 file changed, 113 insertions(+), 8 deletions(-)
>
> --
> 2.21.0.392.gf8f6787159e-goog
>
