Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40573C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306F20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfDOHYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:24:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44644 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:24:12 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFvxs-0000tB-4l; Mon, 15 Apr 2019 09:23:40 +0200
Date:   Mon, 15 Apr 2019 09:23:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
cc:     Andra Danciu <andradanciu1997@gmail.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
In-Reply-To: <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904150923280.4917@nanos.tec.linutronix.de>
References: <20190414191450.18377-1-andradanciu1997@gmail.com> <20190414191450.18377-2-andradanciu1997@gmail.com> <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019, Fabio Estevam wrote:

> On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> >
> > As the file had no other license notice/reference, it falls under the
> > project license and therefore the proper SPDX id is: GPL-2.0-only
> >
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > ---
> >  sound/soc/fsl/mpc5200_dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> > index 4396442c2fdd..ccf9301889fe 100644
> > --- a/sound/soc/fsl/mpc5200_dma.c
> > +++ b/sound/soc/fsl/mpc5200_dma.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL
> > +// SPDX-License-Identifier: GPL-2.0-only
> 
> According to Documentation/process/license-rules.rst this should be:
> 
> // SPDX-License-Identifier: GPL-2.0

Both are valid.

