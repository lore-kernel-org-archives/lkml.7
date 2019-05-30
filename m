Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD0DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D8E25A67
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Lp7NHqOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfE3ORQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:17:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40520 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3ORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:17:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id c70so3906026qkg.7;
        Thu, 30 May 2019 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+LOT5T/HmBUsdzCxRl5dLbbljv3/ECxiQWhmt5quQ0=;
        b=Lp7NHqOwMPQVLwKjwmPtyYv6BBVOczLj1a73C6xr2V2zY9ATwNY9UPq8yXTSXrkq5r
         L4phwmL0wNDGV9sklxFEuTIUL0WNtXLLw3syl3N7eBtW8YXwsMmtpFKW9fTFvEto0imz
         ylPC2npd0R+mRKamHItWAhq5iJJGp8hp4cE+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+LOT5T/HmBUsdzCxRl5dLbbljv3/ECxiQWhmt5quQ0=;
        b=hE8PfrwIA418ff/iweXVOwC6cR5Oz8HpjAbKbLdSnfNx6qfWO/McO6Kp4g1tP5L5gY
         YPYe4o/pH9k3b8uvSLQ3Sw3YT+LTurHqtSof8taVaX4ORCFJlxnglRQoNM0Zy8566dPv
         cAwX52d9vkBSyrLSP9CpNVOL9AeLKlAulPM0k1PVHmpArNhLp3VtDr6JLbDxjJRRluwk
         iaFqXLvHUyK6gTG7yvesSrmX52uiBICRo9/BJxRGBwYwJ4uLLwGRNUqJbFTs3LU2DFrU
         XLPkTQrgXCIsaaElAvp3fN/9ydPAUmQtXkJltzPgHcUnDRO+dJm2hn+oQZvXufK+7FPY
         5aHQ==
X-Gm-Message-State: APjAAAU6uF1zZmZbiUYCXJ95ViltHhbWJLzk5XqyRiUxKjOjUWelZePJ
        VNR+U6ZfkpLH/K4++mrkrKPdWQ88B5hH9WUz478=
X-Google-Smtp-Source: APXvYqxvcdqalIqdQbZ8c+pH8PwVq3is068RciFxLPOT3so+FaMecraJ+Da1cHA1B+kh92m1vrm1sTnOMVgRKO/Dr+E=
X-Received: by 2002:a37:a3c5:: with SMTP id m188mr3485959qke.223.1559225831160;
 Thu, 30 May 2019 07:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190530093948.12479-1-a.filippov@yadro.com>
In-Reply-To: <20190530093948.12479-1-a.filippov@yadro.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 30 May 2019 14:16:59 +0000
Message-ID: <CACPK8XfG7j4Z2bqX9CFxUeUrpx708Uqbh-5ts9W5SnDfDw-xYA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add YADRO VESNIN BMC
To:     Alexander Filippov <a.filippov@yadro.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 at 09:40, Alexander Filippov <a.filippov@yadro.com> wrote:
> @@ -0,0 +1,262 @@

Can we get a SDPX license string at the top of the file? Something like this:

// SPDX-License-Identifier: GPL-2.0+
// Copyright 2019 <copyright holder>

> +/dts-v1/;
> +
> +#include "aspeed-g4.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +

> +&i2c3 {
> +       status = "okay";
> +       cpr2021@59 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "general,cpr2021", "general,pmbus";

Do you have a driver for this one you plan on submitting?
