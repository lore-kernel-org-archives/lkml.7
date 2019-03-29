Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA1420700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553863011;
	bh=/Kkex8pPvQ5xEqugELsqf/YHixu2G+Ps11f1AqMEHoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ys1KE6QEWmWoKKUfSBCBIPEkk+7KOU0LHx5okzaQomwowvhMx9Buvt+NE1Fm6kI1e
	 lg6ZWo9Ths/tG/qf9dreIeN3TRqGyiukRPF09fcd29lHItZ31hnwt5tXJWe+F0Dtc/
	 ipWmbrs+WsgQTDHik8cmxWEVsQzz50EWxlgrZbwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfC2Mgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbfC2Mgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:36:49 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3EEF2184C;
        Fri, 29 Mar 2019 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553863008;
        bh=/Kkex8pPvQ5xEqugELsqf/YHixu2G+Ps11f1AqMEHoc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bV0QFjCgMJNILeuNIZmIy2Qw11x8YBrPdyacdfdfiiBwDb4AFbiZUktzPO9afdxQd
         k2BOBtE60Sf8JOEukoO4CeUXL/zVrWyidmcU22vo6Qb5dWoMQOZvRZHx5C+Jlnj8Gi
         6WaGYQGeuXwxc1qBfCiL2pfiy3TEpuRYddUryMho=
Received: by mail-qk1-f178.google.com with SMTP id c20so1200122qkc.10;
        Fri, 29 Mar 2019 05:36:48 -0700 (PDT)
X-Gm-Message-State: APjAAAV6nx1RHhtYkvOZQSp4x8+zS9CdecKxkmT6R344fOUj0gNl2OvD
        Y1pSzhuFpoxHc2bVZmK4q4D62GSZi5JTpUosaw==
X-Google-Smtp-Source: APXvYqwa89VWfKcs6ErCeYwsLOOYGmlVdLqBoZV0Onal07PjgvyqN6Msm2wFp0dtFqXhem96Wy6ox+d0b+e+jfeIg6k=
X-Received: by 2002:a37:d285:: with SMTP id f127mr38701890qkj.147.1553863008033;
 Fri, 29 Mar 2019 05:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190329083858.9988-1-andrew.smirnov@gmail.com> <20190329083858.9988-3-andrew.smirnov@gmail.com>
In-Reply-To: <20190329083858.9988-3-andrew.smirnov@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 Mar 2019 07:36:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJZwdeKAiuCmadyCM9kAHiFrDpAqGUFviMNqCGz+B72qw@mail.gmail.com>
Message-ID: <CAL_JsqJZwdeKAiuCmadyCM9kAHiFrDpAqGUFviMNqCGz+B72qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: fsl: Add support for ZII i.MX7
 RPU2 board
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

On Fri, Mar 29, 2019 at 3:39 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add support for ZII i.MX7 RPU2 board.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
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
