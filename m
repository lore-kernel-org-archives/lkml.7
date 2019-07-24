Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CF9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17A2229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfGXIcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:32:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34593 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:32:53 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hqChZ-0001Cp-C2; Wed, 24 Jul 2019 10:32:45 +0200
Message-ID: <1563957164.2311.28.camel@pengutronix.de>
Subject: Re: [Sound-open-firmware] [PATCH v2 1/5] ASoC: SOF: imx: Add i.MX8
 HW support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
Date:   Wed, 24 Jul 2019 10:32:44 +0200
In-Reply-To: <CAEnQRZCuB2QKzz-08K0z+x+p0qCpqR_wDc=q2GChvJiw4E9hBA@mail.gmail.com>
References: <20190723084104.12639-1-daniel.baluta@nxp.com>
         <20190723084104.12639-2-daniel.baluta@nxp.com>
         <a5d44d96-4d50-ee46-a6bf-3ce108b1994a@linux.intel.com>
         <CAEnQRZCuB2QKzz-08K0z+x+p0qCpqR_wDc=q2GChvJiw4E9hBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am Mittwoch, den 24.07.2019, 09:54 +0300 schrieb Daniel Baluta:
> On Tue, Jul 23, 2019 at 6:18 PM Pierre-Louis Bossart
[...]
> 
> > Also are all the resources device-managed, I don't see a remove()?
> 
> Good catch for pm stuff. We mostly didn't care about remove because
> drivers are always Y in our distribution.

Linux drivers need to be hotplug aware, even if they are not built as a
module. You can test things by manually unbinding the driver from the
device via sysfs.

Regards,
Lucas
