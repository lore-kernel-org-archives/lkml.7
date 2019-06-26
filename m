Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E3C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAB521738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561574221;
	bh=rPjrA5UKDItDDeBvMzrvupA/HE7q5dkO/2GejoVYEsU=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=0LVpC4NlmBuAj9GZsVsiTlRimqN7VR6zy7x5PXNW2IWuZpMDyFclN88JPGZLqrL8M
	 istyLsTx95BuTXcHDPf34L+fMgZeX5TI+0OdyJbl1xn7x6rf8/+neVpuNWqU2hHKTm
	 NMVVHqgmodgEeXPKW0kR3/hWefL8BeZKcb8MNZXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFZShA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZSg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:36:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA53A216FD;
        Wed, 26 Jun 2019 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561574218;
        bh=rPjrA5UKDItDDeBvMzrvupA/HE7q5dkO/2GejoVYEsU=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=pyiZmAQTWwmV9IucQm5qJLcRgqCJyBirwquRA9A0YFbOVE7WcEhB0PDd0LFoFh5Ux
         Q83RYbitSQbtdPIkzJtkHGO+01GyWUg6bJwAIrpsMyR9912CITIh7IHLBXagIsyHaJ
         FKm1pvMRlGh1yefdXwX/3Iz7HKwi3ncOw+5djHXA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1558433454-27971-5-git-send-email-claudiu.beznea@microchip.com>
References: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com> <1558433454-27971-5-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 4/4] clk: at91: sckc: add support for SAM9X60
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:36:58 -0700
Message-Id: <20190626183658.BA53A216FD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2019-05-21 03:11:33)
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add support for SAM9X60's slow clock.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

FYI, this patch is base64 encoded and causes my MUA to have lots of
pain. It would be nice if you could send plain text emails, otherwise it
takes me a few more seconds to extract the patch. Of course, it reminds
me that I need to fix my MUA so maybe this is OK!

