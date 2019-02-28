Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D055C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A712084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbfB1SV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:21:26 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:37202 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfB1SVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:21:25 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1D39A80420;
        Thu, 28 Feb 2019 19:21:20 +0100 (CET)
Date:   Thu, 28 Feb 2019 19:21:19 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu.Beznea@microchip.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] add LCD support for SAM9X60
Message-ID: <20190228182119.GA28318@ravnborg.org>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8 a=Fe56jAomiwCZgAULtVMA:9
        a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu

On Wed, Feb 27, 2019 at 04:24:11PM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Hi,
> 
> These patches adds support for SAM9X60's LCD controller.
Can you elaborate a little more which chips that are relevant.
To be able to look into the right data-sheet, while reviewing.
Link to data-sheet would be nice too.

Thanks in advance,
	Sam
