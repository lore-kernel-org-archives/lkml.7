Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D4DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2292084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="Ubqy6d9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbfCAPPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:15:13 -0500
Received: from mail.nic.cz ([217.31.204.67]:43164 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCAPPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:15:12 -0500
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id D8F6E63409;
        Fri,  1 Mar 2019 16:15:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551453310; bh=Yv0yM53GY1mKuwRkIotXkQbeO6wJpRga80qIfuUbAG8=;
        h=Date:From:To;
        b=Ubqy6d9OcOum3+5OcENF2OQWv11qraxmxcd4C0HluIKRJMeP/V4NSQIlLNSpnhuuv
         9y2ovAStaZ6lZV2obWcZVh2AvQPYgNbd8kbWaCSOxHySPFXsckNdfM9mXMf+4q6IDM
         m/FgJn75E4gMXQ/UtcMsFCzJT5oTkg+KAvqbHdk8=
Date:   Fri, 1 Mar 2019 16:15:10 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 bus+gpio 3/5] bus: moxtet: Add sysfs documentation
Message-ID: <20190301161510.20b15183@nic.cz>
In-Reply-To: <CACRpkdam_CYGtph16McpQQ_WwohpZr+Rzi1B=re4UrGxXmSEqg@mail.gmail.com>
References: <20190301035852.26780-1-marek.behun@nic.cz>
        <20190301035852.26780-4-marek.behun@nic.cz>
        <CACRpkdam_CYGtph16McpQQ_WwohpZr+Rzi1B=re4UrGxXmSEqg@mail.gmail.com>
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

On Fri, 1 Mar 2019 15:34:26 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> > +What:          /sys/bus/moxtet/devices/moxtet-<name>.<addr>/output_val=
ue
> > +Date:          March 2019
> > +KernelVersion: 5.2
> > +Contact:       Marek Beh=C3=BAn <marek.behun@nic.cz>
> > +Description:   (RW) Read last written value or write value to the
> > module on
> > +               this Moxtet address. Format: %x =20
>=20
> What is the usecase for these?
>=20
> If this is for debugging it should be in debugfs rather than in sysfs.
>=20
> If it is here for random userspace drivers, we need some good
> explanation as to why they can't just be kernel drivers.

Hmm, it was for debugging purposes but the ability to write there is
not needed anymore... Shall I make it read/only? Or completely remove
it?

Marek
