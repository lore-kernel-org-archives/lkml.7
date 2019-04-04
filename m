Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58883C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD6A2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDDAET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:04:19 -0400
Received: from muru.com ([72.249.23.125]:44224 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDAET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:04:19 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 73E48803A;
        Thu,  4 Apr 2019 00:04:33 +0000 (UTC)
Date:   Wed, 3 Apr 2019 17:04:15 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
Message-ID: <20190404000415.GW49658@atomide.com>
References: <20190321142838.22985-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321142838.22985-1-dmurphy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dan Murphy <dmurphy@ti.com> [190321 14:29]:
> Add the lm3532 device tree documentation.
> Remove lm3532 device tree reference from the ti_lmu devicetree
> documentation.
> 
> With the addition of the dedicated lm3532 documentation the device
> can be removed from the ti_lmu.txt.
> 
> The reason for this is that the lm3532 dt documentation now defines
> the ability to control LED output strings against different control
> banks or groups multiple strings to be controlled by a single control
> bank.
> 
> Another addition was for ALS lighting control and configuration.  The
> LM3532 has a feature that can take in the ALS reading from 2 separate
> ALS devices and adjust the brightness on the strings that are configured
> to support this feature.
> 
> Finally the device specific properties were moved to the parent node as these
> properties are not control bank configurable.  These include the runtime ramp
> and the ALS configuration.

Acked-by: Tony Lindgren <tony@atomide.com>
