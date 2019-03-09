Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF77C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A58820657
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCISFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:05:43 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:60954 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCISFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:05:43 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8BFBF9E749C;
        Sat,  9 Mar 2019 18:05:38 +0000 (GMT)
Date:   Sat, 9 Mar 2019 18:05:35 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: document the Meson G12A
 support
Message-ID: <20190309180535.070a82de@archlinux>
In-Reply-To: <CAFBinCA_bGFDOA5sLt26z++=LCtD_3xuaChQWDYJY2D0s2nHZQ@mail.gmail.com>
References: <20190304111217.882-1-narmstrong@baylibre.com>
        <20190304111217.882-2-narmstrong@baylibre.com>
        <CAFBinCA_bGFDOA5sLt26z++=LCtD_3xuaChQWDYJY2D0s2nHZQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 22:01:38 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Mon, Mar 4, 2019 at 12:12 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > Update the documentation to expicitly support the Meson-G12A SoC.  
> typo: explicitly
> 
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>  
> apart from that:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to the togreg branch of iio.git and pushed out
as testing to be completely ignored ;)

Thanks,

Jonathan
