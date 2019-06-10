Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E2C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706412086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560203936;
	bh=0PkPVdz5GVGKK3sk7TXqMD/2uCtfIwQXWAIEJPKPXS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KodWF0pJKOq21apxSPC6wMDeMlBEFEBohn9Ho7nhrYhVy1jPFmMSqJZhyiicENWIX
	 KXQd5mUQK/+idmwa9T7sF2YScQ/XEjxUdr3pfABfdTo3OdhwroWjnjC3NE2ba0kWDg
	 VE57cF5Uv/IHRfTMpMrFgg2MctaHHIDHwq4y2lQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfFJV6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbfFJV6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:58:55 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDEAE212F5;
        Mon, 10 Jun 2019 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560203935;
        bh=0PkPVdz5GVGKK3sk7TXqMD/2uCtfIwQXWAIEJPKPXS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vEfoYgbBq11nuojqIl5e9i7RXs8dtqVAB0ysyomiAsFQ60a3iO7+gRazCHpKv3+Hj
         d6Jk8KCJYSMSnVxDbznJoY7vuau7PB2vH0B4qYiipoC0DJtvfp0xKOURJglbDN1y8m
         CxMGrgGUwRyGnnzsA56KLz3KKAuNcrJE1e+3LTTY=
Received: by mail-qt1-f172.google.com with SMTP id x47so12152507qtk.11;
        Mon, 10 Jun 2019 14:58:54 -0700 (PDT)
X-Gm-Message-State: APjAAAUnjM8QBLXFI3FKYbZVg9Ad89UDZIK+7sBWt3OhOuPD9WBjZLGo
        e2MLyTtmHLIKyj1RV7AiejwDODYg6vaaPrvIuQ==
X-Google-Smtp-Source: APXvYqzYmsQ1fTULRa5HAKFvUASBSBcpANP6JQU7H9+hyVCTO/yhwj4BIvezOoVzR8ZhDpYU91B05EHec2kVcFmKG98=
X-Received: by 2002:ac8:36b9:: with SMTP id a54mr61757193qtc.300.1560203934207;
 Mon, 10 Jun 2019 14:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190531063849.26142-1-manivannan.sadhasivam@linaro.org> <20190531063849.26142-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190531063849.26142-4-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 15:58:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLjKu_1Gep348-ERQgJrZ6vM2RxB2UW4heqGGg5syEFWw@mail.gmail.com>
Message-ID: <CAL_JsqLjKu_1Gep348-ERQgJrZ6vM2RxB2UW4heqGGg5syEFWw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: arm: stm32: Document Avenger96
 devicetree binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        loic pallardy <loic.pallardy@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 12:39 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> This commit documents Avenger96 devicetree binding based on
> STM32MP157 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
