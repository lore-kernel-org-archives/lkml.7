Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE667C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986832081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEBOsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:48:40 -0400
Received: from muru.com ([72.249.23.125]:47986 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBOsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:48:40 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 08967809B;
        Thu,  2 May 2019 14:48:56 +0000 (UTC)
Date:   Thu, 2 May 2019 07:48:36 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, bcousson@baylibre.com
Subject: Re: [PATCH] ARM: dts: dra76x: Update MMC2_HS200_MANUAL1 iodelay
 values
Message-ID: <20190502144836.GQ8007@atomide.com>
References: <20190430060856.18445-1-faiz_abbas@ti.com>
 <20190430155415.GI8007@atomide.com>
 <9e32440f-cdab-eb79-2abb-9b0596701743@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e32440f-cdab-eb79-2abb-9b0596701743@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190502 06:28]:
> Hi Tony,
> 
> On 30/04/19 9:24 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Faiz Abbas <faiz_abbas@ti.com> [190429 23:09]:
> >> Update the MMC2_HS200_MANUAL1 iodelay values to match with the latest
> >> dra76x data manual[1].
> >>
> >> Also this particular pinctrl-array is using spaces instead of tabs for
> >> spacing between the values and the comments. Fix this as well.
> > 
> > Is this needed as a fix or can this wait?
> > 
> 
> This is a fix. The new iodelay values will have better marginality and
> should prevent issues in corner cases.

OK thanks tagging this one with cc stable as well.

Regards,

Tony
