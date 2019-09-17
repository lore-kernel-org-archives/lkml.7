Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1331C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993A521881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568729823;
	bh=Eg8W+ajEjKC/yv26EKpx0aghgM1YzYkbqgvgzwL6m70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k7axXU3OhT5vixIt8jRu/ZnRN8O2yzmJKYGEbWHdhuwzFK7UuHu3Np1+jz1dDlH86
	 DX3aXo0OjfAyIf/sRL5gAYFWXN2vnX1xJFpTAWXUED5g5X17g7hYlCIGro8K1qqtTy
	 qm2KIkC1xs0jvYQ1+5KTtpFxw2RyHZClFTJ6Sb5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfIQORD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfIQORC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:17:02 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12AE21881;
        Tue, 17 Sep 2019 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568729821;
        bh=Eg8W+ajEjKC/yv26EKpx0aghgM1YzYkbqgvgzwL6m70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L7lqaxOLT5sbCuHbPI4FGhSu/i6bMYZnJblkyL6+O0ELC4RXb0ENmhALA06QYVYY/
         YC+4vA+gw8No3ATPGpdFOtolAEhYHf602PKGC4G2nVX3JV8i9ug94+3Pp8dLeNTcE6
         DeqDnX4hNYyZ7cxUrm+4j9FEKtDS+TtJZ2EqEvsc=
Received: by mail-qk1-f182.google.com with SMTP id s18so4181486qkj.3;
        Tue, 17 Sep 2019 07:17:01 -0700 (PDT)
X-Gm-Message-State: APjAAAV7WndghdO0Ee8xoksVufoXFTOIizasmS+VV+gnVRGaLYSfLMB5
        6xKRDYknEpgcKRrJF3Ux34h0zV8NjrWux2l5mA==
X-Google-Smtp-Source: APXvYqwA+ubotuCAbjbaEOhJ5K5H7G+033DyzYBBdrIaGwC3kGgavUiXjVBx7mnqkjhKNrrdOhiiMmBJPcgvh8IBMbc=
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr3680849qkb.119.1568729820993;
 Tue, 17 Sep 2019 07:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190917083453.25744-1-heiko@sntech.de>
In-Reply-To: <20190917083453.25744-1-heiko@sntech.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Sep 2019 09:16:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+OkHMEzx3goQoUt9xvfuGLbu4v7VD5y6wqrNYp96-z7g@mail.gmail.com>
Message-ID: <CAL_Jsq+OkHMEzx3goQoUt9xvfuGLbu4v7VD5y6wqrNYp96-z7g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: rockchip: fix Theobroma-System board bindings
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 3:35 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The naming convention for the existing Theobroma boards is
> soc-q7module-baseboard, so rk3399-puma-haikou and the in-kernel
> devicetrees also follow that scheme.
>
> For some reason in the binding a wrong or outdated naming slipped
> in which does not match the used devicetrees and makes the dt-schema
> complain now.
>
> Fix this by using the names used in the wild by actual boards.

Perhaps a Fixes tag.

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
