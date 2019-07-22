Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E4FC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1AE21904
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 02:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563761055;
	bh=u4GMHX419j+/fLtW5nJhQiv+DYaZYYSo6Ud74Se+32w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NH/T48Nk47i22foH1xarTNKDuvDcSLG6D6vOMehCKs0F3JaK1fYFsY0JL2Daut3Ku
	 7IsL7h5PjsF9fJfghRX/qO8eFt3M2CQwHbxElsRQnVWGWK8Uz1vLOSyLD1G94LVj3k
	 ESpYdKUiGRMBkcC2QqOXTymsajCaRGhEKvRP1xQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfGVCEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 22:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfGVCEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:04:13 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D2321903;
        Mon, 22 Jul 2019 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563761052;
        bh=u4GMHX419j+/fLtW5nJhQiv+DYaZYYSo6Ud74Se+32w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z4eZt8wEZuLZ+mtO0Xva01Eg3MwbuxFhCt6ub0uXmg4C8u8iJAf8GLjXsippu5hrw
         YmNDMAbU8IQpsERrOC1lKDFqKbnCLjQwhjdUMgjdWqT65aZLeH2FmptVZNFhPt7B9a
         2KUM0geVCoZk8PCaG0aSXV1AzqaSd9MlsCWPV5Yc=
Date:   Mon, 22 Jul 2019 10:03:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com,
        Fabio Estevam <festevam@gmail.com>, aisheng.dong@nxp.com,
        l.stach@pengutronix.de, angus@akkea.ca, vabhav.sharma@nxp.com,
        pankaj.bansal@nxp.com, bhaskar.upadhaya@nxp.com, ping.bai@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Richard Hu <richard.hu@technexion.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: fsl: pico-pi: Add a device tree for the
 PICO-PI-IMX8M
Message-ID: <20190722020345.GR3738@dragon>
References: <20190625123407.15888-1-andradanciu1997@gmail.com>
 <20190718035523.GD11324@X250>
 <CAJNLGszB239AHpD+kRCPRWZaToTYHiq5YUHRjfRwTqknwHMdMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNLGszB239AHpD+kRCPRWZaToTYHiq5YUHRjfRwTqknwHMdMA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 02:12:10PM +0300, Andra Danciu wrote:
...
> > > +     pmic: pmic@4b {
> > > +             reg = <0x4b>;
> > > +             compatible = "rohm,bd71837";
> > > +             /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> > > +             pinctrl-0 = <&pinctrl_pmic>;
> > > +             gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;
> >
> > Where is the bindings for this property?
> Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

I do not see property 'gpio_intr' in there.

Shawn
