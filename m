Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF7FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8082077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556284847;
	bh=Usdh73OyzqyaAvhxEiYq9KnyIE9QuuHcvhxkvakjJWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GY7BMHlGtEUeasfFgr2aKGU+FpxB686u9xV22WB5k42zRKLitCEtbeg2QWM/K0Sh0
	 kPW3u0lnwRtMLhFYPKlaudcp2JTABE1rKkxLA+9MG6ew2UyWOrZLnuVE1kuKSEnBb1
	 48M82E55mOULoP/2kJHBbod1T66bzWZEKmV5+w4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfDZNUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfDZNUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:20:46 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D599E2089E;
        Fri, 26 Apr 2019 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556284846;
        bh=Usdh73OyzqyaAvhxEiYq9KnyIE9QuuHcvhxkvakjJWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y4i93/Nrd0SxMr3ijKDhweqk1mELoJgIbq+knZRVUCG6S598WDw9zea4KJ30+JbxN
         aQqgK3d+PZmCgWHDLqEI0GrU+ljm0NbXfYbkPpt21hkUN5JZG36cpbqpCJVJYvVFXH
         3sprRi+kukGcX0zY1ite6wOdyrz1kBQX8yCTqO0A=
Received: by mail-qt1-f177.google.com with SMTP id p20so3987061qtc.9;
        Fri, 26 Apr 2019 06:20:45 -0700 (PDT)
X-Gm-Message-State: APjAAAWgqBSuwL3CKYZUSDrYoakfWWlZwoCll5L1QJJUTrmps7G24qUP
        q5fiPD/LRZs4u84CV1M605ZPlXfXN4qn8HoGrw==
X-Google-Smtp-Source: APXvYqy4AT+iMRbc5d0BeMezlj6n/SgeHRSnPLtD3rwt+yklJhwA1spsMaA2bxFZjLg3n869iEItRIAogL3NQ/2Sjr4=
X-Received: by 2002:ac8:2a51:: with SMTP id l17mr36321597qtl.76.1556284845110;
 Fri, 26 Apr 2019 06:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190425230314.26000-1-masneyb@onstation.org>
In-Reply-To: <20190425230314.26000-1-masneyb@onstation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 26 Apr 2019 08:20:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL0SQZSs8MmF6j1B_qfvCOcg9XMjUBUHFL+mnCk7xNB1A@mail.gmail.com>
Message-ID: <CAL_JsqL0SQZSs8MmF6j1B_qfvCOcg9XMjUBUHFL+mnCk7xNB1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: tsl2772: convert bindings to
 YAML format
To:     Brian Masney <masneyb@onstation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 6:03 PM Brian Masney <masneyb@onstation.org> wrote:
>
> Convert the tsl2772 device tree bindings to the new YAML format.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v2:
> - Remove allof from led-max-microamp. Split out enum list from [] to
>   individual lines for consistency with the compatible attribute.
> - Change 'proximity-sensor@39' in example to 'sensor@39'.
>
> Changes since v1:
> - Dropped description from reg and interrupts properties.
> - Dropped $ref from led-max-microamp, vdd-supply, and vddio-supply.
> - Changed 'tsl2772@39' in example to 'proximity-sensor@39'
>
>  .../devicetree/bindings/iio/light/tsl2772.txt | 42 ----------
>  .../bindings/iio/light/tsl2772.yaml           | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
