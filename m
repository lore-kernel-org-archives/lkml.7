Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C3C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC072086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfFEJuE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:50:04 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52247 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfFEJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:50:03 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 765DB1BF216;
        Wed,  5 Jun 2019 09:50:00 +0000 (UTC)
Date:   Wed, 5 Jun 2019 11:49:59 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Sean Young <sean@mess.org>
Subject: Re: [PATCH v4 03/13] media: rc: sunxi: Add A31 compatible
Message-ID: <20190605094959.6i477kd3vq77ds7w@flea>
References: <20190604162959.29199-1-peron.clem@gmail.com>
 <20190604162959.29199-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190604162959.29199-4-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 06:29:49PM +0200, Clément Péron wrote:
> Allwiner A31 has a different memory mapping so add the compatible
> we will need it later.
>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Sean Young <sean@mess.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
