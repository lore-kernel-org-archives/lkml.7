Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA43C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3921900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553220953;
	bh=eadqRmD4wngUMD6qTa3bB14njgwxymC1DGCiMVdB70Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U83TJX6mpK92b24I5osJT6A2mQt8Rf+67l2x6WTXOXarKYVhAD6AJcUaslz8Ffqup
	 Sjjc+sizypmUnIAX1D9qw3TiLqkHLWpgZinUeJqlTr/l8UZ13RPb0oPElXVS0SLd3g
	 KNNX9Y+GZGSbsIw/eGUREFDct8E6J2ULgE0DOMQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCVCPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfCVCPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:15:51 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0ACD213F2;
        Fri, 22 Mar 2019 02:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553220951;
        bh=eadqRmD4wngUMD6qTa3bB14njgwxymC1DGCiMVdB70Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ty+ADwk/JNoKNAAKqJDEMIKX0CT4Y8mwdtYc2vYtlwIl/Xuza04kZI2F8E5RgfRYk
         6G3M+JjeYQFwHFv3vg6dCPy892KXlIVWVI4KWzYyo15IwWgEQidgdXK8hE2XPf0YOj
         9CtoZi7ayAC9MWAzRysZjyq3GOYGtxSm6NWozM5o=
Date:   Fri, 22 Mar 2019 10:15:22 +0800
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
Message-ID: <20190322021521.GY12513@dragon>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
 <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
 <20190322011155.GO12513@dragon>
 <CAOMZO5CBjG_xZWjZof_VOKaLLOCxFz3g7Gz1uTVzD=D5GeQb4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CBjG_xZWjZof_VOKaLLOCxFz3g7Gz1uTVzD=D5GeQb4g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:00:18PM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Thu, Mar 21, 2019 at 10:12 PM Shawn Guo <shawnguo@kernel.org> wrote:
> 
> > > So yes, we currently have lots of broken dtb's in mainline and I am
> > > wondering what is the proper fix here.
> >
> > So can we have a single patch fixing all broken i.MX DTBs?
> 
> Unfortunately, just by looking at the dts files we do not know if a
> board uses an AR803x PHY or not, so I am afraid we can not do an
> automatic conversion.

At least for those we already know?

Shawn
