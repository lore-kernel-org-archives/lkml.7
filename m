Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863AC28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1EE20862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390581AbfFJNxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:53:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33135 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390306AbfFJNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:53:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E71D080245; Mon, 10 Jun 2019 15:52:57 +0200 (CEST)
Date:   Mon, 10 Jun 2019 15:52:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Shawn Guo <shawnguo@kernel.org>, angus.ainslie@puri.sm,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/3] Add support for the Purism Librem5 devkit
Message-ID: <20190610135258.GA7976@xo-6d-61-c0.localdomain>
References: <20190528125747.1047-1-angus@akkea.ca>
 <20190605090315.GJ29853@dragon>
 <db174b0173d0bcdb9ab5ff4e2e1cc4bc@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db174b0173d0bcdb9ab5ff4e2e1cc4bc@www.akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-06-05 06:48:05, Angus Ainslie wrote:
> On 2019-06-05 03:03, Shawn Guo wrote:
> >On Tue, May 28, 2019 at 05:57:44AM -0700, Angus Ainslie (Purism) wrote:
> >>The Librem5 devkit is based on the imx8mq from NXP. This is a default
> >>devicetree to boot the board to a command prompt.
> >>
> >>Changes since v14:
> >>
> >>Add regulator-always-on for the SNVS regulators.
> >>Added pgc nodes.
> >>Fixed charger pre-current.
> >
> >Since Pavel was reviewing your patches, you should copy him on the new
> >version.  Has this version addressed all his review comments?
> >
> 
> Sorry I had meant to include him in the CC.
> 
> I believe so but don't want to speak for him so we should see if he
> has anymore.

I did not check the code, sorry.

I still believe your shutdown voltage is too low; try that. Battery will go down from 3V
to 2.8V in seconds, so you don't really gain anything by using lower threshold, and you
may not even have enough time to shutdown the system if you set it too low.

Normally something like 3.0V, 3.2V is reasonable shutdown voltage.

Best regards,
										Pavel
