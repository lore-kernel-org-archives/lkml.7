Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B33C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C2E20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562789560;
	bh=arZwsIKK85xQA0UQRI89h6dbRX6S7Ni7CsW8dxaQYLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HxwsG7X850Wpx3/mZefwYdamFgh4FWo+wDRq5KgYCKj0P3xmc/8/lcMZuvVYioN/7
	 mL0F3zt7/RlUrnxB3vvIz87EXsUsjiAoC9wAUsWXhkfGAv+hKbNz+0cFzdanrgCuk2
	 ii5K9yqv5D8MBpa8fp3j5VpV1NqMWLbCGHx9yM4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfGJUMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfGJUMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:12:39 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B160720844;
        Wed, 10 Jul 2019 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562789558;
        bh=arZwsIKK85xQA0UQRI89h6dbRX6S7Ni7CsW8dxaQYLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p82GYfHGIWdmUya4nJbUygxwyI1+XOLI/IFwoJT1Zp8cB1DTyNpEH7+7KTf9AsV0q
         oDRhsN5b3wKb5+e5tP2DS900oefqYJkGYEpNDfh8IrBkyBs7QcLhLNMYg5oCI96Jny
         iPqsvpaGPDJi6IIb/JpRgw/F/6eGC6IKLWLvWd5E=
Received: by mail-qk1-f169.google.com with SMTP id s145so2961310qke.7;
        Wed, 10 Jul 2019 13:12:38 -0700 (PDT)
X-Gm-Message-State: APjAAAU0YZXKZVHbMqV+kE/OaMEztOP1L8cZeK0YuswcCN0Nm0mK6nnr
        8A4xbjRYMPQOlQfmdOPT4gBPIv+MjND/hkMNAA==
X-Google-Smtp-Source: APXvYqwQaQbDjnfpDjPm50aG8sIZxLG9tal9F/o52jr9suW9/+ne9DoY/hPPTpecvjX0l3Lhm/yKc8W+Q/UblrT2nyA=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr25593665qke.223.1562789557982;
 Wed, 10 Jul 2019 13:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190710192155.11489-1-tduszyns@gmail.com> <20190710192155.11489-2-tduszyns@gmail.com>
In-Reply-To: <20190710192155.11489-2-tduszyns@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Jul 2019 14:12:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8iLuif-UqVzpgwOLafVYr9aOo38EMeUnmYJ0a9aQ5DQ@mail.gmail.com>
Message-ID: <CAL_JsqJ8iLuif-UqVzpgwOLafVYr9aOo38EMeUnmYJ0a9aQ5DQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: pms7003: convert bindings
 to yaml
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 1:22 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> Convert existing device tree bindings to yaml.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  .../iio/chemical/plantower,pms7003.txt        | 26 ----------
>  .../iio/chemical/plantower,pms7003.yaml       | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
