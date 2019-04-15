Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA528206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfDOHd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:33:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfDOHd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:33:27 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFw6y-0001BF-In; Mon, 15 Apr 2019 09:33:04 +0200
Date:   Mon, 15 Apr 2019 09:33:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Baluta <daniel.baluta@gmail.com>
cc:     Fabio Estevam <festevam@gmail.com>,
        Andra Danciu <andradanciu1997@gmail.com>,
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
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
In-Reply-To: <CAEnQRZAP6EWXkwfuR+83trtYrpDaRjA6zp-k5sp33bo5jUEjPg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904150931170.4917@nanos.tec.linutronix.de>
References: <20190414191450.18377-1-andradanciu1997@gmail.com> <20190414191450.18377-2-andradanciu1997@gmail.com> <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com> <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
 <CAEnQRZAP6EWXkwfuR+83trtYrpDaRjA6zp-k5sp33bo5jUEjPg@mail.gmail.com>
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

On Mon, 15 Apr 2019, Daniel Baluta wrote:
> On Mon, Apr 15, 2019 at 10:26 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
> > On Mon, Apr 15, 2019 at 12:53 AM Fabio Estevam <festevam@gmail.com> wrote:
> > > On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> > > > -// SPDX-License-Identifier: GPL
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > >
> > > According to Documentation/process/license-rules.rst this should be:
> > >
> > > // SPDX-License-Identifier: GPL-2.0
> >
> 
> Actually, according to
> 
> https://spdx.org/licenses/GPL-2.0-only.html
> 
> GPL-2.0 is another name for GPL-2.0-only

See also: LICENSES/preferred/GPL-2.0

    Valid-License-Identifier: GPL-2.0
    Valid-License-Identifier: GPL-2.0-only

If the identifier would be invalid, scripts/spdxcheck.py would complain ...

Thanks,

	tglx

