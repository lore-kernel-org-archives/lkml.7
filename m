Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D51EC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531D12184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553962329;
	bh=Mbmh71Rr0u7jNuSwlT0PeR6clqao/MVNHnI2bVTa1yE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YFcId06U0IDFy2O5AFzK2KXMzHYx74emLvaUZ/Akdv97XjdVOHhBmwhPcfx6raRBn
	 Lk06oJsFlus/QQk0F46yvU+W25jaHI8MQ0hZ/hZ+i+Xw26t2gs6ECeCUCfooXGbwNn
	 Z1i+o3iDThwv+Kee67TX9m8m0xjXq0OoK4I/EtKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfC3QMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbfC3QMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:12:07 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D732173C;
        Sat, 30 Mar 2019 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553962326;
        bh=Mbmh71Rr0u7jNuSwlT0PeR6clqao/MVNHnI2bVTa1yE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xD+TMDPVUaEeZkk30qdhOCiRGg/XFdnGig/8EW8KCGVpvwpIa1cjtROSfAiGznNnt
         hc16gSsYW+CPYU43+E8tbrb/74szQYrvAofrE/z8DI+cbQk8YEW2jlH4kD+5xl7GZO
         tS74oQk004kgEGBQ/qHIkU4cnyWsrSaBPvUOE3u8=
Date:   Sat, 30 Mar 2019 16:12:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] devantech-srf04.yaml: transform DT binding to YAML
Message-ID: <20190330161200.6d0dec48@archlinux>
In-Reply-To: <CAL_JsqKV1Qy05oX9wm+Fz1HAkAEe4gE3whCNvafPfxsg6hgp8A@mail.gmail.com>
References: <20190326133938.oitfjxlx2kou26lm@arbad>
        <CAL_JsqKV1Qy05oX9wm+Fz1HAkAEe4gE3whCNvafPfxsg6hgp8A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 08:13:17 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Tue, Mar 26, 2019 at 8:40 AM Andreas Klinger <ak@it-klinger.de> wrote:
> >
> > devantech-srf04.yaml: yaml devicetree binding for iio ultrasonic
> > proximity driver of devantech srf04
> >
> > use devantech-srf04.txt, transform binding into yaml and remove the
> > outdated DT documentation
> >
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../bindings/iio/proximity/devantech-srf04.txt     | 28 ----------
> >  .../bindings/iio/proximity/devantech-srf04.yaml    | 59 ++++++++++++++++++++++
> >  2 files changed, 59 insertions(+), 28 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Given I've been feeling guilty for ages about never reviewing Rob's original work on
this (it sat in my todo list for a large number of months before I dropped it because
it had already merged), I'm very happy to see that it ends up being this simple!
I guess we have a lot of these change over patches to go ;)

Applied to the togreg branch of iio.git and pushed out as testing. Does anyone check
these yet?

Thanks,

Jonathan

