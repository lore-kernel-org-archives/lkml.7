Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D13C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AF9208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557780461;
	bh=A0UdYxon8ghsPmLDQj5qZFdVwXsJWqeY9Whr7tFjVDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BNaaAGDX8AcOzUlyZvjOuJEjyvhWICxr0xVqRSag2gMY1BPyfvuCSmi0ZmsWNhRxK
	 XMRNF4VkGZ7pRnlWFJ0ZF/xn3x6WHoS8AzLqKzQ018WBYlFnY3QweO+40axfpfvUDY
	 Ep+peDjivCxWiEz4iCDUBSjxHC7M++QhEezYxCuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfEMUrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfEMUrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:47:40 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A041C21473;
        Mon, 13 May 2019 20:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557780459;
        bh=A0UdYxon8ghsPmLDQj5qZFdVwXsJWqeY9Whr7tFjVDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2f3v4+R1IeE1rUFpgvOkVrF4S6OmzkYbX8kYvOSidD6Lt59JijaSSajYcsIPPrwQc
         SutE3iblzEFuZ8ox1YQHkH6ZLqWtx1HM8gRGqPL85jKHeqp2CRtW4vsIGI/7JHK+wT
         XX4qOANt3agrHlRSjl7PxC84XVvOinVPSyOZht+c=
Received: by mail-qt1-f175.google.com with SMTP id m32so13410081qtf.0;
        Mon, 13 May 2019 13:47:39 -0700 (PDT)
X-Gm-Message-State: APjAAAXkSbMWm8e9yQ+xyOxSg7IwUIPxvkUcMI9vsGu1tBOXVGzk8NgT
        DR2NOnh6BesMK9N/dj4EPQXbQWxQ8Byf/V6oCA==
X-Google-Smtp-Source: APXvYqzfpMaBz4WEUO6c/TBlbpArvkHgdVN7DB72QJ7ClwTzINXTCFbJH7nNJY5gdTbVCw+RqbSsGRaTRgk6zSVsNg4=
X-Received: by 2002:a0c:932e:: with SMTP id d43mr18277565qvd.77.1557780458893;
 Mon, 13 May 2019 13:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 May 2019 15:47:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJRdjoTo2hGrKWvcyer18wt9N6w0nkfa9xx_e2xJ6pkYg@mail.gmail.com>
Message-ID: <CAL_JsqJRdjoTo2hGrKWvcyer18wt9N6w0nkfa9xx_e2xJ6pkYg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     devicetree@vger.kernel.org, Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 7:06 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> For IP blocks that are generated from the public, open-source
> sifive-blocks repository, describe the version numbering policy
> that its maintainers intend to use, upon request from Rob
> Herring <robh@kernel.org>.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>
> Hi Rob, please let me know if this document works with your
> requirements, or if some changes are needed.  - Paul
>
>  .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt

I just noticed this was never re-spun and applied. We now have
bindings in tree referring to it though.

Rob
