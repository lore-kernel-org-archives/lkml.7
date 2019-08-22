Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B70C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58EB2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496595;
	bh=L9UMGcdA614fnSHWQ04BSdS4ymvZGTviHvehBqLdubs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S6ZpUXFhBaGvIHFVZHyr8HZUlE0t4lsZdVvi8aiIhJJWaccEo/j6pqExsoQWO7C0h
	 Q3ScZLdKXrSCySeOz9KIRVfnOtmRWx7BwiaND4QJg7kYapclWT+ieM5jkp3RBPl6ek
	 9cb8jOjcC+qin9OyYAtrGKz5QsezJl46s88oY9pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389846AbfHVR4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbfHVR4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:56:34 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27CA4233FD;
        Thu, 22 Aug 2019 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566496593;
        bh=L9UMGcdA614fnSHWQ04BSdS4ymvZGTviHvehBqLdubs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZNLjdK+2Tq5C2CzVvNoWBQJCMNgJaYiAZrGB2fXAjonnhn+dzQ3Vx7E63+MqY88+p
         i2vdqvHMZiNOqz5ZBEtZKtOZnRp/mSd9geEiqx2AdkHp4kf7K3VFWyq2Y6CUgYT2xA
         bbT+p1lhoCDgWcMgSTgwRWxpB1Ga+pT/rPA6IQdI=
Received: by mail-qt1-f171.google.com with SMTP id y26so8742687qto.4;
        Thu, 22 Aug 2019 10:56:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUjZkkkhqlMrIy/gmvovn7tvkkQEgQJyc9muQgEsJmB1BiEJi2C
        v6r//ljQjXJZqszZ5WOWr8JCCXztvfXbvvkxTA==
X-Google-Smtp-Source: APXvYqxmpTMuJpoR2hQvI30KNyZXaO90aPAJVNRDaz/KGX8/IUr6Sp01aMXULiLAaSLUCCkn9iQ5zlj6tY+yhexEMPk=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr890120qto.224.1566496592345;
 Thu, 22 Aug 2019 10:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190822060238.3887-1-krzk@kernel.org> <20190822060238.3887-3-krzk@kernel.org>
In-Reply-To: <20190822060238.3887-3-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 22 Aug 2019 12:56:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq++LZ82v9WbyHK8pQg3WVQOxLvWcJ-qM0QAnhzKw033vA@mail.gmail.com>
Message-ID: <CAL_Jsq++LZ82v9WbyHK8pQg3WVQOxLvWcJ-qM0QAnhzKw033vA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310 compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 1:02 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Add the compatibles for Kontron i.MX6UL N6310 SoM and boards.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v6:
> 1. Split entries to pass the dtbs_check.
>
> Changes since v5:
> New patch
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
