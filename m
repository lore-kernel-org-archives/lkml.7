Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C8C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749362084D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfGVM5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:57:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43641 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbfGVM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:57:08 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hpXs2-0005L4-03; Mon, 22 Jul 2019 14:56:50 +0200
Message-ID: <1563800209.2311.10.camel@pengutronix.de>
Subject: Re: [PATCH 06/10] ASoC: dt-bindings: Document dl_mask property
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@nxp.com>, broonie@kernel.org
Cc:     festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de,
        viorel.suman@nxp.com
Date:   Mon, 22 Jul 2019 14:56:49 +0200
In-Reply-To: <20190722124833.28757-7-daniel.baluta@nxp.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
         <20190722124833.28757-7-daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 22.07.2019, 15:48 +0300 schrieb Daniel Baluta:
> SAI supports up to 8 data lines. This property let the user
> configure how many data lines should be used per transfer
> direction (Tx/Rx).
> 
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2e726b983845..59f4d965a5fb 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -49,6 +49,11 @@ Optional properties:
>  
> >    - big-endian		: Boolean property, required if all the SAI
> >  			  registers are big-endian rather than little-endian.
> > +  - fsl,dl_mask		: list of two integers (bitmask, first for RX, second
> > +			  for TX) representing enabled datalines. Bit 0
> > +			  represents first data line, bit 1 represents second
> > +			  data line and so on. Data line is enabled if
> > +			  corresponding bit is set to 1.

No underscores in property names, please. Also this should document the
default value used by the driver when the property is absent.

Regards,
Lucas
