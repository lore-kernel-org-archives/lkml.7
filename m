Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4893120850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfB1VNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:13:36 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:40746 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfB1VNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:13:36 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6FC388034C;
        Thu, 28 Feb 2019 22:13:27 +0100 (CET)
Date:   Thu, 28 Feb 2019 22:13:25 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Claudiu.Beznea@microchip.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] add LCD support for SAM9X60
Message-ID: <20190228211325.GA30188@ravnborg.org>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <20190228182119.GA28318@ravnborg.org>
 <20190228205214.GD23094@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228205214.GD23094@piout.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=JFH84537j1yvcaEBNc4A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre.

> > > 
> > > These patches adds support for SAM9X60's LCD controller.
> > Can you elaborate a little more which chips that are relevant.
> > To be able to look into the right data-sheet, while reviewing.
> > Link to data-sheet would be nice too.
> > 
> 
> sam9x60 is the chip name (i.e. x is not a wildcard). I don't think the
> datasheet is finished/public yet.

Thanks. I will take a look at the patches but not knowing
the specifics of the implementation/IP will makes this less valueable.

	Sam
