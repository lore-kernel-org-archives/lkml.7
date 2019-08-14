Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099A1C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2A4206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfHNNaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:30:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56759 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfHNNaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:30:52 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxtMU-00068E-KA; Wed, 14 Aug 2019 15:30:46 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxtMR-0005bv-RB; Wed, 14 Aug 2019 15:30:43 +0200
Date:   Wed, 14 Aug 2019 15:30:43 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190814133043.peh63lwngujjuo5d@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
 <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
 <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
 <CAMz4ku+3txx5kO-u_+_pxFwoovnX81WFF-moNBasUUgEpvQb+Q@mail.gmail.com>
 <20190814105535.svslc57qp3wx5lub@pengutronix.de>
 <CAMz4ku+H1++pzZ9pAw2N6Z342j3NMBwfRj9VZTdsihtZYzuFOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4ku+H1++pzZ9pAw2N6Z342j3NMBwfRj9VZTdsihtZYzuFOw@mail.gmail.com>
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

On Wed, Aug 14, 2019 at 08:23:37PM +0800, Baolin Wang wrote:
> On Wed, 14 Aug 2019 at 18:55, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Aug 14, 2019 at 06:01:50PM +0800, Baolin Wang wrote:
> > > On Wed, 14 Aug 2019 at 17:23, Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Wed, Aug 14, 2019 at 04:42:28PM +0800, Baolin Wang wrote:
> > > > > On Tue, 13 Aug 2019 at 23:16, Uwe Kleine-König
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
> > > > > > [...]
> > > > > Not really, our hardware's method is, when you changed a new
> > > > > configuration (MOD or duty is changed) , the hardware will wait for a
> > > > > while to complete current period, then change to the new period.
> > > >
> > > > Can you describe that in more detail? This doesn't explain why MOD must be
> > > > configured before DUTY. Is there another reason for that?
> > >
> > > Sorry, I did not explain this explicitly. When we change a new PWM
> > > configuration, the PWM controller will make sure the current period is
> > > completed before changing to a new period. Once setting the MOD
> > > register (since we always set MOD firstly), that will tell the
> > > hardware that a new period need to change.
> >
> > So if the current period just ended after you reconfigured MOD but
> > before you wrote to DUTY we'll see a bogus period, right? I assume the
> > same holds true for writing the prescale value?
> 
> I confirmed again, I am sorry I missed something before. Yes, like you
> said before, writing DUTY triggers the hardware to actually apply the
> values written to MOD and DUTY to the output. So write DUTY last. I
> will update the comments and change the PWM configure like:
> 
> sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
> sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);

So PRESCALE is independent and it can still happen that writing PRESCALE
affects the output before MOD and DUTY do?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
