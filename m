Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34151C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B062075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDCO5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:57:12 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38811 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfDCO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:57:12 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CC16E1C0002;
        Wed,  3 Apr 2019 14:57:09 +0000 (UTC)
Date:   Wed, 3 Apr 2019 16:57:09 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Message-ID: <20190403145709.GN22216@piout.net>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/04/2019 16:52:44+0200, Flavio Suligoi wrote:
> Some RTC devices have a battery-low automatic detection circuit.
> The battery-low event is usually reported with:
> 
> - a bit change in a RTC status register
> - a hw signaling (generally using an interrupt generation), changing
>   the hw level of a specific pin;
> 
> The new property "battery-low-hw-alarm" enable the RTC to generate the
> hw signaling in case of battery-low event.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
> index a97fc6a..f93a44d 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> @@ -31,6 +31,9 @@ below.
>                              expressed in femto Farad (fF).
>                              The default value shall be listed (if optional),
>                              and likewise all valid values.
> +- battery-low-hw-alarm :    Enable the "battery-low" output pin. This function

I would name that voltage-low-alarm as not all the secondary voltages
are batteries.

> +                            is available on the following devices:
> +                            - pcf2127 - pin used for alarm: INTn
>  
>  Trivial RTCs
>  ------------
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
