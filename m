Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC4620721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574438766;
	bh=Tu4H4P1AVeo7ELA2PShYalSySTPBAUZ6/0PJNNMATTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uqsusolp1S1FW15QcBwPkmmE3l+H8t3TTeh6Cw1HhgllII6jFvA1A0EdYjT3E4p4G
	 XasdSacgY3UdsUTiD50woWS966nW39pBoTJDg1mk5lDDthZNsbf9nJgYYUvE+cwxre
	 g3Ml66c0juQj+XM8Vl91T8G6bbZ+OOcXy6gAycnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKVQGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfKVQGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:06:05 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0F82072E;
        Fri, 22 Nov 2019 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574438765;
        bh=Tu4H4P1AVeo7ELA2PShYalSySTPBAUZ6/0PJNNMATTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JA9hNEZ1XEMN5U9lk+h6oJ2IxnkG7elq2UsNlVEQ4SPO/9mYsR1nfTpaybOxEwFPD
         79Hi2N6pt3ikTmThQbcZ3bs5B5yuzrFFDOG8IoGfQU/mIXA5oBybla3wWxBja5aUru
         Wdk7RC2o83T0PUuZlI25H//38W1DETC4r7yNkRv4=
Received: by mail-qk1-f181.google.com with SMTP id m16so6682614qki.11;
        Fri, 22 Nov 2019 08:06:04 -0800 (PST)
X-Gm-Message-State: APjAAAW1CvvVjAgGEhcA3CBfan0TmWlIhmgLNVaE+Tm8Ir6xJyZ/Am0O
        0vfRE+HiJqjp3q6pfT3lKtNbD42T1P+rH3ENow==
X-Google-Smtp-Source: APXvYqy1Ebob1mRhqaDTvDg4E4x8lKPYBMtMcMhEJLzmxt2VOIm9Fji7i7HAbQxoJ+2pRtKCcD9DPFt4LgwClIPfnk4=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr8639331qkn.254.1574438764015;
 Fri, 22 Nov 2019 08:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20191116205026.dvlevawj5obq7weh@smtp.gmail.com>
In-Reply-To: <20191116205026.dvlevawj5obq7weh@smtp.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Nov 2019 10:05:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJzi_0eYj=rMxwQe+OTh_m3ngocOvcPZd-tykAwAJAw6g@mail.gmail.com>
Message-ID: <CAL_JsqJzi_0eYj=rMxwQe+OTh_m3ngocOvcPZd-tykAwAJAw6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad7292: Update SPDX identifier
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 2:50 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Update SPDX identifier to the preferred dual GPL-2.0 OR BSD-2-Clause
> licensing.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> I split the changes into 2 different patches since they are about
> different issues.
>
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
