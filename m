Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B2CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AAD21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfJVKWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:22:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43617 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfJVKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:22:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMrJ8-0004tM-Gs; Tue, 22 Oct 2019 12:22:30 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iMrJ7-0008HH-Ew; Tue, 22 Oct 2019 12:22:29 +0200
Date:   Tue, 22 Oct 2019 12:22:29 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        broonie@kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Message-ID: <20191022102229.ma4tayqsxsl52eab@pengutronix.de>
References: <AM5PR1001MB0994316EA8AD903B2943CE2080820@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191002134521.zcree6w4loutjrud@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002134521.zcree6w4loutjrud@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:19:41 up 157 days, 16:37, 97 users,  load average: 0.01, 0.04,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Bartosz,

can you have a look on this discussion? I wanna prepare a new version
and this is still open.

Regards,
  Marco

On 19-10-02 15:45, Marco Felsch wrote:
> On 19-09-30 09:53, Adam Thomson wrote:
> > On 26 September 2019 15:39, Marco Felsch wrote:
> > 
> > > On 19-09-26 14:04, Adam Thomson wrote:
> > > > On 26 September 2019 12:44, Marco Felsch wrote:
> > > >
> > > > > On 19-09-26 10:17, Adam Thomson wrote:
> > > > > > On 26 September 2019 09:10, Marco Felsch wrote:
> > > > > >
> > > > > > > On 19-09-25 16:18, Adam Thomson wrote:
> > > > > > > > On 25 September 2019 16:52, Marco Felsch wrote:
> > > > > > > >
> > > > > > > > > Hi Adam,
> > > > > > > > >
> > > > > > > > > On 19-09-24 09:23, Adam Thomson wrote:
> > > > > > > > > > On 17 September 2019 13:43, Marco Felsch wrote:
> > > > > > > > > >
> > > > > > > > > > > Add the documentation which describe the voltage selection gpio
> > > > > > > support.
> > > > > > > > > > > This property can be applied to each subnode within the
> > > 'regulators'
> > > > > > > > > > > node so each regulator can be configured differently.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > > > > > > > ---
> > > > > > > > > > >  Documentation/devicetree/bindings/mfd/da9062.txt | 9
> > > +++++++++
> > > > > > > > > > >  1 file changed, 9 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > > > > > b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > > > > > index edca653a5777..9d9820d8177d 100644
> > > > > > > > > > > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > > > > > +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > > > > > > @@ -66,6 +66,15 @@ Sub-nodes:
> > > > > > > > > > >    details of individual regulator device can be found in:
> > > > > > > > > > >    Documentation/devicetree/bindings/regulator/regulator.txt
> > > > > > > > > > >
> > > > > > > > > > > +  Optional regulator device-specific properties:
> > > > > > > > > > > +  - dlg,vsel-sense-gpios : The GPIO reference which should be
> > > used
> > > > > by
> > > > > > > the
> > > > > > > > > > > +    regulator to switch the voltage between active/suspend
> > > voltage
> > > > > > > settings.
> > > > > > > > > If
> > > > > > > > > > > +    the signal is active the active-settings are applied else the
> > > suspend
> > > > > > > > > > > +    settings are applied. Attention: Sharing the same gpio for other
> > > > > > > purposes
> > > > > > > > > > > +    or across multiple regulators is possible but the gpio settings
> > > must
> > > > > be
> > > > > > > the
> > > > > > > > > > > +    same. Also the gpio phandle must refer to to the dlg,da9062-
> > > gpio
> > > > > > > device
> > > > > > > > > > > +    other gpios are not allowed and make no sense.
> > > > > > > > > > > +
> > > > > > > > > >
> > > > > > > > > > Should we not use the binding names that are defined in 'gpio-
> > > > > > > regulator.yaml'
> > > > > > > > > as
> > > > > > > > > > these seem to be generic and would probably serve the purpose
> > > here?
> > > > > > > > >
> > > > > > > > > Hm.. as the description says:
> > > > > > > > >
> > > > > > > > > 8<--------------------------------------------------
> > > > > > > > > gpios:
> > > > > > > > >    description: Array of one or more GPIO pins used to select the
> > > > > > > > >    regulator voltage/current listed in "states".
> > > > > > > > > 8<--------------------------------------------------
> > > > > > > > >
> > > > > > > > > But we don't have a "states" property and we can't select between
> > > > > > > > > voltage or current.
> > > > > > > >
> > > > > > > > Yes I think I was at cross purposes when I made this remark. The
> > > bindings
> > > > > there
> > > > > > > > describe the GPOs that are used to enable/disable and set
> > > voltage/current
> > > > > for
> > > > > > > > regulators and the supported voltage/current levels that can be
> > > configured
> > > > > in
> > > > > > > > this manner. What you're describing is the GPI for DA9061/2. If you look
> > > at
> > > > > > > > GPIO handling in existing regulator drivers I believe they all deal with
> > > > > external
> > > > > > > > GPOs that are configured to enable/disable and set voltage/current
> > > limits
> > > > > > > rather
> > > > > > > > than the GPI on the PMIC itself. That's why I'm thinking that the
> > > > > configurations
> > > > > > > > you're doing here should actually be in a pinctrl or GPIO driver.
> > > > > > >
> > > > > > > That's true, the common gpio bindings are from the view of the
> > > > > > > processor, e.g. which gpio must the processor drive to enable/switch the
> > > > > > > regualtor. So one reasone more to use a non-common binding.
> > > > > > >
> > > > > > > Please take a look on my other comment I made :) I don't use the
> > > > > > > gpio-alternative function. I use it as an input.
> > > > > >
> > > > > > I know in the datasheet this isn't marked as an alternate function specifically
> > > > > > but to me having regulator control by the chip's own GPI is an alternative
> > > > > > function for that GPIO pin, in the same way a specific pin can be used for
> > > > > > SYS_EN or Watchdog control. It's a dedicated purpose rather than being a
> > > > > normal
> > > > > > GPI.
> > > > >
> > > > > Nope, SYS_EN or Watchdog is a special/alternate function and not a
> > > > > normal input.
> > > >
> > > > Having spoken with our HW team there's essentially no real difference.
> > >
> > > So I don't have to configure the gpio to alternate to use it as SYS_EN?
> > 
> > Yes you do, but the effect is much the same as manually configuring the GPIO as
> > input, just that the IC does it for you. The regulator control features could
> > well have been done in a similar manner. Guess that was a design choice.
> > 
> > >
> > > > >
> > > > > > See the following as an example of what I'm suggesting:
> > > > > >
> > > > > >
> > > > >
> > > https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindin
> > > > > gs/pinctrl/pinctrl-palmas.txt
> > > > > >
> > > > > > You could then pass the pinctrl information to the regulator driver and use
> > > > > > that rather than having device specific bindings for this. That's at least my
> > > > > > current interpretation of this anyway.
> > > > >
> > > > > For me pinctrl decides which function should be assigned to a pin. So in
> > > > > our case this would be:
> > > > >   - alternate
> > > > >   - gpo
> > > > >   - gpi
> > > > >
> > > > > In our use-case it is a gpi..
> > > >
> > > > It's not being used as a normal GPI as such. It's being used to enable/disable
> > > > the regulator so I disagree.
> > >
> > > This one is used as voltage-selection. What is a "normal" GPI in your
> > > point of view?
> > 
> > With the voltage selection and enable/disable control the actual work of
> > handling the GPI state is all done internally in the IC. There is no control
> > required from SW other than setting of initial direction. For a normal GPI
> 
> Thats correct and setting the direction and active levels can be done
> perfectly by the gpio-interface.
> 
> > I would expect SW to be involved in the handling of that GPI state, for example
> > as part of a bit banging interface.
> > 
> > >
> > > > >
> > > > > An other reason why pinctrl seems not be the right solution is that the
> > > > > regulator must be configured to use this gpi. This decision can't be
> > > > > made globally because each regulator can be configured differently.. For
> > > > > me its just a local gpio.
> > > >
> > > > You'd pass pinctrl information, via DT, to the regulator driver so it can set
> > > > accordingly. At least that's my take here, unless I'm missing something. The
> > > > regulator driver would be the consumer and could set the regulator control
> > > > accordingly.
> > >
> > > IMHO this is what I have done. I use the gpi so the regulator is the
> > > consumer. Since the gpi can be used by several regulators for voltage
> > > selection or enable/disable action this gpi is marked as shared. If I
> > > got you right than you would do something like for regulatorX.
> > >
> > >   pinctrl-node {
> > >
> > >   	gpio2 {
> > > 		func = "vsel";
> > > 	}
> > >   }
> > >
> > > But the gpi(o)2 can also be used to enable/disable a regulatorY if I
> > > understood the datasheet correctly. I other words:
> > >
> > >
> > >
> > >          +--> Alternate function
> > >       /
> > >   ---+   +--> GPI ----> Edge detection ---> more processing
> > >    |       |                |
> > >    |       |                +-----> Regulator control
> > >    |       |                          |
> > >    \__  __/ \__________  _______
> > >       \/               \/
> > >    pinctrl            gpio
> > >
> > > This is how I understood the pinctrl use-case. I configure the pin as
> > > gpio and then the regulator driver consume a gpio.
> > 
> > How I see it is that you configure the function through pinctrl as
> > 'regulator_switch' or 'regulator_vsel' (or whatever name is deemed sensible to
> 
> The case is that it can be "muxed" for both at same time so there is no
> or instead it is a or/and. Depending on the design some regulators can
> be turned off and some should be switched upon that signal.
> 
> > cover the two types of functionality) and then the pinctrl driver code would do
> > the work of requesting and configuring the relevant GPIO as input so it's no
> > longer available for use as something else (basically what you do in the
> > regulator driver right now).
> 
> So by this I avoided the user-space to get this gpio and this seems fine
> to me. What a driver does with a gpio is up to the driver but the gpio
> shouldn't be reachable from the user-space.
> 
> > I believe you can have more than one consumer of a pinctrl pin so it could be
> > provided to both regulator X and Y to indicate that this is the chosen
> > functionality of that pin and so the regulator can then be marked as being
> > controlled by that pin. Using pinctrl also would mean you're using standard
> > bindings as well rather than something which is device specific.
> 
> That seems wrong to me because pinctrl should assign a dedicated function
> to that pin e.g. regulator_switch or regulator_vsel. But thats wrong as
> I pointed out above. On the other hand the gpio as the name says is
> general purpose and each regulator gives the meaning to it.
> 
> > > > At the end of the day I'm not the gatekeeper here so I think Mark's input is
> > > > necessary as he will likely have a view on how this should be done. I appreciate
> > > > the work you've done here but I want to be sure we have a generic solution
> > > > as this would also apply to DA9063 and possibly other devices too.
> > >
> > > Why should this only apply to da9062 devices? IMHO this property can be
> > > used by any other dlg pmic as well if it is supported. Comments and suggestions
> > > are welcome so no worries ;)
> > 
> > You're right. You can do the same for DA9063 and other devices potentially. I
> > would just like to make sure we take the right/agreed approach. Potentially
> > this could be used in non-Dialog products as well which have similar
> > functionality.
> 
> Yeah, but I think we should consider about that after an other device
> appears with that funcitonality.
> 
> > As I say, Mark is really the gatekeeper so his input is also key in this.
> 
> That's right, I added Mark to To.
> 
> Regards,
>   Marco
> 
> > 
> > >
> > > Regards,
> > >   Marco
> > >
> > > > Have added Mark to the 'To' in this e-mail thread so he might see it.
> > > > >
> > > > > Regards,
> > > > >   Marco
> > > > >
> > > > > > >
> > > > > > > Regards,
> > > > > > >   Marco
> > > > > > >
> > > > > > >
> > > > > > > > I'd be interested in hearing Mark's view on this though as he has far
> > > more
> > > > > > > > experience in this area than I do.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > >   Marco
> > > > > > > > >
> > > > > > > > > > >  - rtc : This node defines settings required for the Real-Time Clock
> > > > > > > associated
> > > > > > > > > > >    with the DA9062. There are currently no entries in this binding,
> > > > > however
> > > > > > > > > > >    compatible = "dlg,da9062-rtc" should be added if a node is
> > > created.
> > > > > > > > > > > --
> > > > > > > > > > > 2.20.1
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Pengutronix e.K.                           |                             |
> > > > > > > > > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > > > > > > > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-
> > > 0
> > > > > |
> > > > > > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> > > |
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Pengutronix e.K.                           |                             |
> > > > > > > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > > > > > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> > > |
> > > > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> > > > > >
> > > > >
> > > > > --
> > > > > Pengutronix e.K.                           |                             |
> > > > > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > > > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> > > >
> > >
> > > --
> > > Pengutronix e.K.                           |                             |
> > > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
