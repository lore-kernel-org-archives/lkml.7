Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A96C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6592420881
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558060562;
	bh=UYmAe1IV/++E9IvKgowPVkw/M4qBmZ3jUfv2WsoAlU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1ngD+oN2jaU5x0t3VGNOeMZwwNiJLyhdcbKVskxs1djYlE4O5hyZv89Q18k6hbOBT
	 rhu4Bq0Mun34z8gwDMJkPno6jks8M3WyY7xOzbl+HUBmcfBp7BhgyvlqJGC63Ja+U1
	 mTw9udKx4CVahJRlmm3KW5VVl/d2OCR5dknKfIik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfEQCgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 22:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEQCgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:36:01 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D86BE20881;
        Fri, 17 May 2019 02:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558060561;
        bh=UYmAe1IV/++E9IvKgowPVkw/M4qBmZ3jUfv2WsoAlU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JezreGgfD+cVJDDB8iPEWLRhhOtQxSgCxpIpun5kyNh02ONIJKjdrh0t+ikF2H297
         BkCWl9XSWqWVN/hax4XLhrkok6uoMNhv6JeQ2/Accr7cOuObSWFu2H/OLG3HQuwImY
         P/5c4QOGilC90cqAFyR0c+awz9tbpxeCYna6cj6s=
Received: by mail-qk1-f171.google.com with SMTP id q197so3601392qke.7;
        Thu, 16 May 2019 19:36:00 -0700 (PDT)
X-Gm-Message-State: APjAAAWeOEKa6k0GuT89SygjXH98Z1elob+xNvv6UDM7El0kyTuGzu28
        KJJAKoA6Q0R1HjBqG6otG/xSFU7+ul+KKN+mxg==
X-Google-Smtp-Source: APXvYqz2joMRNZ9mMZ4ogBSnqyOT54U29XMbxHkz/jIeGjkl3P0GYwD4Bc4JrpD4ogzHg0IOKyai3+0yBV53K0p0oQM=
X-Received: by 2002:a37:358:: with SMTP id 85mr41442378qkd.174.1558060560115;
 Thu, 16 May 2019 19:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <1556016046-31231-1-git-send-email-amergnat@baylibre.com> <1556016046-31231-2-git-send-email-amergnat@baylibre.com>
In-Reply-To: <1556016046-31231-2-git-send-email-amergnat@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 May 2019 21:35:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ5b23Y-x2Rx7bDrAcs7kDgj-TyoWGeZ6j30M4_xQrodA@mail.gmail.com>
Message-ID: <CAL_JsqJ5b23Y-x2Rx7bDrAcs7kDgj-TyoWGeZ6j30M4_xQrodA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: Add pixart vendor
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        baylibre-upstreaming@groups.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 5:40 AM Alexandre Mergnat <amergnat@baylibre.com> wrote:
>
> PixArt Imaging Inc. is expertized in CMOS image sensors (CIS),
> capacitive touch controllers and related imaging application development.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

I've converted this file to json-schema as of v5.2-rc1. See commit
8122de54602e. Sorry, but you will have to rework this patch.

Rob
