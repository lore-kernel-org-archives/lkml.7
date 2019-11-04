Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D98CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB85C21E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="CdhAcD1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfKDMQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:16:51 -0500
Received: from vps.xff.cz ([195.181.215.36]:52184 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbfKDMQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572869808; bh=KCFoy8DEuYBh4BpeRyFcEMigPcCpT5yYzcAzcagUIs4=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=CdhAcD1TaKtfCfj2iNbv9h3SK1MnjM7OKVHMIgbtizM66lAc3IplaQ5wtrkdQubkr
         is7SXs0ZAS9+oS/nX7oNBsCjZzCLasEctUuyrM8zllMtksBfLkSVRcoCmvYmfYuLIP
         zLpVg+HzvGshd1RWscfjtZUttHDzlJJHB4F89kb8=
Date:   Mon, 4 Nov 2019 13:16:48 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: orange-pi-3: Enable USB 3.0
 host support
Message-ID: <20191104121648.jxgs2eoj6loh2as2@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20191020134229.1216351-1-megous@megous.com>
 <20191020134229.1216351-5-megous@megous.com>
 <20191021110946.gxmib3to7n7v2vof@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021110946.gxmib3to7n7v2vof@gilmour>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Mon, Oct 21, 2019 at 01:09:46PM +0200, Maxime Ripard wrote:
> On Sun, Oct 20, 2019 at 03:42:29PM +0200, megous@megous.com wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > Enable Allwinner's USB 3.0 phy and the host controller. Orange Pi 3
> > board has GL3510 USB 3.0 4-port hub connected to the SoC's USB 3.0
> > port. All four ports are exposed via USB3-A connectors. VBUS is
> > always on, since it's powered directly from DCIN (VCC-5V) and
> > not switchable.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Those last two patches are fine with me, I'll merge them once the phy
> driver will be merged.

PHY driver has been merged. You can now pull these patches too, when
you like.

See here: https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/log/?h=next

Thank you,
	o.

> Maxime


