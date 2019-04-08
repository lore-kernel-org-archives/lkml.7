Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB41C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC0421473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="KuAH1DSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDHMJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:09:05 -0400
Received: from vps.xff.cz ([195.181.215.36]:56708 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfDHMJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554725342; bh=c7beZ3m7FZv9rSYonZbpUdXGje6sPNnMKBOAAW2Bwl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KuAH1DSktdQZjlijmwd1mhIzBe9a0K0rzrtEmLamzhlWA1XLhv8w8R55emG9k+X0b
         KWW87RPyZA09PCY4Pdja/2n5HwKvLUGi/1wx2UU/7Uka9mEAybtriVbM87buF0DXlv
         Xys7LhecpN2MN9WkJmkay1fABMCTAQQmnlg1nocQ=
Date:   Mon, 8 Apr 2019 14:09:01 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ziping Chen <techping.chan@gmail.com>,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com, wens@csie.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 3/4] ARM: dts: sunxi: Add R_LRADC support for
 A83T
Message-ID: <20190408120901.v46rdhqvobr5vuks@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>,
        mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ziping Chen <techping.chan@gmail.com>, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, wens@csie.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190327023339.25975-1-megous@megous.com>
 <20190327023339.25975-4-megous@megous.com>
 <20190408080056.lfzjxfkvs65oabuu@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408080056.lfzjxfkvs65oabuu@flea>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Mon, Apr 08, 2019 at 10:00:56AM +0200, Maxime Ripard wrote:
> On Wed, Mar 27, 2019 at 03:33:38AM +0100, megous@megous.com wrote:
> > From: Ziping Chen <techping.chan@gmail.com>
> >
> > Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC.
> > Now the driver has been modified to support it.
> >
> > Add support for it.
> >
> > Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> 
> It's missing your SoB.

Signed-off-by: Ondrej Jirman <megous@megous.com>

Please add it when aplying he patch.

regards,
  Ondrej

> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

