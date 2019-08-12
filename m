Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA01DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAAF20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfHLJqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:46:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47963 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfHLJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:46:13 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx6u0-0001xp-3O; Mon, 12 Aug 2019 11:46:08 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx6tz-00089g-1q; Mon, 12 Aug 2019 11:46:07 +0200
Date:   Mon, 12 Aug 2019 11:46:07 +0200
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
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190812094607.yg7efmvefewxicke@pengutronix.de>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de>
 <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
 <20190809144124.3as3rtctlywxkudr@pengutronix.de>
 <CAMz4ku+o6dCyxhR3-5yM+zr2nBpTQG5A8Pbnxpo7yRciwPbv3Q@mail.gmail.com>
 <20190812083556.dvprpwv6mjy3cjae@pengutronix.de>
 <CAMz4kuJA81ZP6Kc63dPV1jEn1ah=jow6tQBfO=UDCcTzSf3y-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuJA81ZP6Kc63dPV1jEn1ah=jow6tQBfO=UDCcTzSf3y-A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Baolin,

On Mon, Aug 12, 2019 at 05:11:56PM +0800, Baolin Wang wrote:
> On Mon, 12 Aug 2019 at 16:36, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Aug 12, 2019 at 03:29:07PM +0800, Baolin Wang wrote:
> > > The clock framework supplies 'assigned-clocks' and
> > > 'assigned-clock-parents' properties to set parent, but for our case we
> > > still want to set a default clock rate if failed to set parent when
> > > met some abnormal things.
> >
> > Without understanding the complete problem I'd say this is out of the
> > area the driver should care about.
> 
> Fair enough, I will try to use 'assigned-clocks' and
> 'assigned-clock-parents' to simplify the code.

There is also assigned-clock-rates if you need that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
