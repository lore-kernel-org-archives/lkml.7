Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB777C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 23:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742F520830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 23:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="wEfjN3me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfCCXRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 18:17:05 -0500
Received: from mail.nic.cz ([217.31.204.67]:41094 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfCCXRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 18:17:05 -0500
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id BFDB16337E;
        Mon,  4 Mar 2019 00:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551655021; bh=cOw9pxVm7UIFQ5guBs2exJs7gdA7G+so8U9cXF6Y5E4=;
        h=Date:From:To;
        b=wEfjN3meq1VVWKrgpYvcQyTaNnenS5YZF/Z2vMW0epuo1032cihRa6aMv4H7NBeSE
         CcXluebwtXF/YgzTqn6F9W2A+HU4AB9z12q9hGZnhlRWHN4f0c/1dkwLUNhUOjI30J
         xTyICIORk9Cd3YOVNCwaBIXpuGVAPIVy7Ruw/EVQ=
Date:   Mon, 4 Mar 2019 00:17:01 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 bus+gpio 5/5] dt-bindings: gpio: Document GPIOs via
 Moxtet bus
Message-ID: <20190304001701.0b1b9986@nic.cz>
In-Reply-To: <CACRpkdYpjjpVNUXRgT=XY758FGtDYow2fvwpah37T_GjTvLauQ@mail.gmail.com>
References: <20190301035852.26780-1-marek.behun@nic.cz>
        <20190301035852.26780-6-marek.behun@nic.cz>
        <CACRpkdYpjjpVNUXRgT=XY758FGtDYow2fvwpah37T_GjTvLauQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

do you know who is responsible for merging into drivers/bus?

I have received reviews for this and for previous versions only from
you and Rob.

Also, please do not merge yet. I have prepared a fourth version with
debugging over debugfs, fixed some checkpatch issues, and most
importantnly added interrupt reading support from moxtet.

I will send after proper testing is done for this new version.

Marek

On Fri, 1 Mar 2019 15:36:09 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Mar 1, 2019 at 4:59 AM Marek Beh=C3=BAn <marek.behun@nic.cz> wrot=
e:
>=20
> > This patch adds documentation of the device tree bindings for GPIOs
> > on the devices connected via Moxtet bus.
> >
> > Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org =20
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> > +               compatible =3D "cznic,moxtet-gpio"; =20
>=20
> Is cznic registered in
> Documentation/devicetree/bindings/vendor-prefixes.txt?
>=20
> Yours,
> Linus Walleij

