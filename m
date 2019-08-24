Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C914C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D451B2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566673319;
	bh=Ur27vR1/2HgfpDMbK7K/TlEe+q+j8m31vDlrvbuGmJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uPHioSRT1rY0cSbAKj7KVJl2O8o3KGNSybyagttn3RO72kzgH85NpjsUmjELUY+yd
	 4vQzNV2sBU9j7Fy+oohcSrOgQcNPpS4AFIFQ2mrpoVudvLNuVOfpxpnIlPk0W8nD9N
	 JwhGif8/uA980epQrsEsS6eGPGfjv70w9+hWEFeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfHXTB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 15:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbfHXTB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 15:01:57 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2981920850;
        Sat, 24 Aug 2019 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566673316;
        bh=Ur27vR1/2HgfpDMbK7K/TlEe+q+j8m31vDlrvbuGmJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yc+tM+luWTvIH5tNv1EinwZi8WeOYZ+MRt54MM89QW+OvquNVB8BOHv6BeEvgbpcx
         KBlhBr9j3YwJGY4OQurjIRRb71CD6izEPkotTUObcnZUYX9kXNiZljhypH6Savn6ga
         3Tt4Fs2DAnbWohy+3CGU1QICG2Iy5Ow+hrfcHq/M=
Date:   Sat, 24 Aug 2019 21:01:44 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: imx: add imx8mq nitrogen support
Message-ID: <20190824190142.GA16308@X250.getinternet.no>
References: <20190819172606.6410-1-dafna.hirschfeld@collabora.com>
 <20190819172606.6410-2-dafna.hirschfeld@collabora.com>
 <CAL_JsqJx6pTw7Pr=7f0jkC81JF+EDkyhHrvFehSWZV=0wy+YXQ@mail.gmail.com>
 <26b78fe57106f47d34f14bec2f81732af40c3d8d.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26b78fe57106f47d34f14bec2f81732af40c3d8d.camel@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 06:27:39PM +0200, Dafna Hirschfeld wrote:
> On Mon, 2019-08-19 at 14:08 -0500, Rob Herring wrote:
> > On Mon, Aug 19, 2019 at 12:26 PM Dafna Hirschfeld
> > <dafna.hirschfeld@collabora.com> wrote:
> > > From: Gary Bisson <gary.bisson@boundarydevices.com>
> > > 
> > > The Nitrogen8M is an ARM based single board computer (SBC)
> > > designed to leverage the full capabilities of NXP’s i.MX8M
> > > Quad processor.
> > > 
> > > Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> > > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > > [Dafna: porting vendor's code to mainline]
> > > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Please add acks/reviewed-bys when posting new versions.
> > 
> Hi,
> Thank you for the remark, I forgot to add it. I will add it in the
> next.

I applied the patch with Rob's Reviewed-by on v3.

Shawn
