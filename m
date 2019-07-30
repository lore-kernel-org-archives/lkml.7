Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD4C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD4E206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfG3NNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:13:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37669 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbfG3NNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:13:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1hsRvP-0000zD-03; Tue, 30 Jul 2019 15:12:19 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hsRvF-0002oJ-SH; Tue, 30 Jul 2019 15:12:09 +0200
Date:   Tue, 30 Jul 2019 15:12:09 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Patrick Glaser <pglaser@tesla.com>,
        Rob Duncan <rduncan@tesla.com>, Nate Case <ncase@tesla.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802 amplifier
Message-ID: <20190730131209.rdv2kdlrpfeouh66@pengutronix.de>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
 <20190730122748.GF54126@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730122748.GF54126@ediswmail.ad.cirrus.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:06:48 up 73 days, 19:24, 49 users,  load average: 0.10, 0.03,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

sorry for jumping in..

On 19-07-30 13:27, Charles Keepax wrote:
> On Tue, Jul 30, 2019 at 01:09:35PM +0100, Thomas Preston wrote:
> > Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> > Cc: Patrick Glaser <pglaser@tesla.com>
> > Cc: Rob Duncan <rduncan@tesla.com>
> > Cc: Nate Case <ncase@tesla.com>
> > ---
> >  .../devicetree/bindings/sound/tda7802.txt     | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
> > new file mode 100644
> > index 000000000000..f80aaf4f1ba0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
> > @@ -0,0 +1,26 @@
> > +ST TDA7802 audio processor
> > +
> > +This device supports I2C only.
> > +
> > +Required properties:
> > +
> > +- compatible : "st,tda7802"
> > +- reg : the I2C address of the device
> > +- enable-supply : a regulator spec for the PLLen pin

Shouldn't that be a pin called 'pllen-gpios'? IMHO I would not use a
regulator for that.

Regards,
  Marco

> > +
> > +Optional properties:
> > +
> > +- st,gain-ch13 : gain for channels 1 and 3 (range: 1-4)
> > +- st,gain-ch24 : gain for channels 2 and 3 (range: 1-4)
> 
> I wouldn't have expected the gains to be available as a device
> tree setting.
> 
> > +- st,diagnostic-mode-ch13 : diagnotic mode for channels 1 and 3
> > +                            values: "Speaker" (default), "Booster"
> > +- st,diagnostic-mode-ch24 : diagnotic mode for channels 2 and 4
> > +                            values: "Speaker" (default), "Booster"
> > +
> > +Example:
> > +
> > +amp: tda7802@6c {
> > +	compatible = "st,tda7802";
> > +	reg = <0x6c>;
> > +	enable-supply = <&amp_enable_reg>;
> > +};
> > -- 
> > 2.21.0
> > 
> 
> Thanks,
> Charles
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
