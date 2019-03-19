Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C70C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA418213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCSNGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:06:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54121 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCSNGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:06:39 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6ERv-000712-Hq; Tue, 19 Mar 2019 14:06:35 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6ERt-0007fB-SK; Tue, 19 Mar 2019 14:06:33 +0100
Date:   Tue, 19 Mar 2019 14:06:33 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190319130633.2kiwwxqhyttizf3h@pengutronix.de>
References: <1552977898-5590-1-git-send-email-Anson.Huang@nxp.com>
 <1552977898-5590-3-git-send-email-Anson.Huang@nxp.com>
 <20190319080400.shcsnsyyjcwijsg3@pengutronix.de>
 <DB3PR0402MB3916E87140DE4A4242E879E9F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190319101641.45sztmodp4pgz5uu@pengutronix.de>
 <DB3PR0402MB39167AAC67468C6D89AA81A3F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB39167AAC67468C6D89AA81A3F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 19, 2019 at 11:49:32AM +0000, Anson Huang wrote:
> > On Tue, Mar 19, 2019 at 09:08:26AM +0000, Anson Huang wrote:
> > > > On Tue, Mar 19, 2019 at 06:50:12AM +0000, Anson Huang wrote:
> > > > > +	}
> > > > > +
> > > > > +	/* if no valid prescale found, use MAX instead */
> > > > > +	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, prescale)))
> > > > > +		prescale = PWM_IMX_TPM_SC_PS >> __bf_shf(PWM_IMX_TPM_SC_PS);
> > > >
> > > > 		prescale = FIELD_PREP(PWM_IMX_TPM_SC_PS, PWM_IMX_TPM_SC_PS)
> > > >
> > > > What is the consequence if the calculated prescale isn't valid? I
> > > > assume this yields a greatly different period? If yes, this should result in
> > > > an error.
> > >
> > > Yes, that is what I intend to do, if a request period is too large and
> > > the prescale Can NOT meet the requirement, I force it to the largest
> > > value that hardware can Provide, I am NOT sure if it is the correct
> > > solution, if no, I can make it return error If round period returns an invalid
> > > result.
> > 
> > I'd say for sure it is not correct to configure for a period of 3 s if
> > 20 s are requested. Where to draw the line exactly I don't know either.
> > 
> > In my opinion we need a general guideline like:
> > 
> > 	If the requested period + duty_cycle combo isn't supported use
> > 	the biggest available period that is not bigger than requested,
> > 	scale duty cycle accordingly and pick the biggest available duty
> > 	cycle that is not bigger than the scaled value.
> > 	If the requested period is shorter than possible, return
> > 	-ERANGE.
> > 
> > I think the above is sensible, but that's something that IMHO must first be
> > declared to be "official" as it doesn't make sense if a single driver implements
> > this and the other still do their own stuff.
> 
> As for now, do you agree if I make TPM driver ONLY support those period/duty
> Setting that HW can support, for other request, just return -ERANGE to make it
> Simple until there is a general guideline available?

I would be surprised if that would result in something that is actually
usable. But feel free to try.

> > Additionally I would consider it beneficial to have something like:
> > 
> > 	int pwm_round_state(pwm, &state)
> > 
> > that modifies state according to the above rules without affecting the
> > hardware. With the respective driver callback the framework could then
> > implement stuff like: "If the resulting configuration deviates too much from
> > the requested state, return an error to the consumer." with having the
> > definition of "too much" in a single place. It would also allow a consumer
> > who cares much about the resulting waveform to determine the effects
> > without testing.
> > 
> > The framework could then add additional checks like:
> > 
> > 	int pwm_apply_state(pwm, state)
> > 	{
> > 		struct pwm_state rounded_state;
> > 
> > 		if IS_ENABLED(CONFIG_PWM_EXTRA_CHECKS):
> > 			rounded_state = pwm->ops->round_state(state);
> > 
> > 	if !was_rounded_according_to_the_rules(round_state):
> > 				warn(...)
> > 
> > 		pwm->ops->apply(pwm, state)
> > 
> > 		if IS_ENABLED(CONFIG_PWM_EXTRA_CHECKS):
> > 			actual_state = pwm->ops->get_state(state);
> > 			if actual_state != round_state:
> > 				warn(...)
> > 
> 
> As for now, do you agree if I add the "round state" function to make sure every time
> the newly requested state applied, the HW outputs the expected result? I can merge
> the "config" and "enable" function into 1 function and make sure of that.

Yeah, that sounds right. Splitting into enable and config is a thing
from the past and makes it hard to provide the needed atomicity.

> > > > > +	/*
> > > > > +	 * polarity settings will enabled/disable output status
> > > > > +	 * immediately, so here ONLY save the config and write
> > > > > +	 * it into register when channel is enabled/disabled.
> > > > > +	 */
> > > > > +	chan->config = val;
> > > >
> > > > This function's behaviour is strange. It configures the hardware
> > > > with the right the duty_cycle but not the polarity. I cannot imagine that
> > > > this not buggy.
> > >
> > > I think that is hardware limitation here, I used the polarity setting
> > > to enable/disable the channel, if we set the polarity here directly,
> > > the output status may NOT reflect the real state, if eventually the
> > > status is disabled, setting the polarity directly into register will
> > > make the output active, that is NOT expected, right? And that is why I put
> > > comments here.
> > 
> > The frameworks expectation is that .apply results in the hardware switches
> > to the new configuration directly after completing a previously configured
> > period. So if you change the period, get preempted and then change the
> > polarity three periods later that is a bug. If it's impossible to fix this in
> > software please do as good as possible (whatever that means) and add this
> > problem to the list of limitations at the top of the driver.
> 
> I think after merging the "config" and "enable" function into ONE function, the
> output result should can be expected and no "polarity setting late" issue, talking
> about the preempt between the period setting and polarity settings, should we
> use the spin_lock_irqsave() instead of mutex() for .apply?

No, I think mutexes are fine.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
