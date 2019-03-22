Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A99B21902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553217144;
	bh=+Jps0iEd3bdCFbP9oFYuue95U49Jlt+DMHVEaw2TlCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zqLrh7JxXaAJZ6qxyuJhbQAzm7p37tLjmJzMmJEPZqaAw9kYVXVBkXj2ExLgJAcHm
	 xNkizPhwGAWZ6am5/nLGsxvUz7QKf6Z48PFRgVodUcjDKCwqZ/hJajgnwKBG8GqicD
	 GU9YotYtL15fXtjdsaLA20tVcXZLOEO0tiuLoxUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCVBMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfCVBMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:12:22 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 933BA21900;
        Fri, 22 Mar 2019 01:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553217142;
        bh=+Jps0iEd3bdCFbP9oFYuue95U49Jlt+DMHVEaw2TlCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBsFQTJu/wnNMrm7gmUve8eHPjdouvOxjWGUbMg7pcvCLese8wLvaHnC1jN1QkOAC
         VGJaRMwWdzfMRbTQ0H1e4A7rJM2E+3/HCUY1m/TzoiwNcZyWQ/V+hulimf1Rl426Dq
         MEdQsfrrDgZmE/8AOC8tL/dVdWq4DLyAYtb8RLGk=
Date:   Fri, 22 Mar 2019 09:11:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Message-ID: <20190322011155.GO12513@dragon>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
 <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 08:17:01AM -0300, Fabio Estevam wrote:
> Hi Abel,
> 
> On Thu, Mar 21, 2019 at 5:42 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> 
> > > It seems we have other boards that need to be fixed and we can not
> > > have an old dtb with functional Ethernet with a new kernel.
> > >
> > > Does anyone know if this issue is AR8031 specific?
> >
> > I can confirm the same fix is works on imx6sx too.
> 
> imx6sx-sabresd also uses an AR8031 Ethernet PHY.
> 
> I also tested that changing the phy-mode to "rgmii-id" fixes Ethernet
> on pico-imx7d with AR8035.
> 
> So yes, we currently have lots of broken dtb's in mainline and I am
> wondering what is the proper fix here.

So can we have a single patch fixing all broken i.MX DTBs?

Shawn
