Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5864FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979B720820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404679AbfJQGmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:42:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40973 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392487AbfJQGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:42:19 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1iKzUG-0004o0-Ih; Thu, 17 Oct 2019 08:42:16 +0200
Subject: Re: [PATCH v1 2/4] dt-bindings: net: dsa: qca,ar9331 switch
 documentation
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Chris Snook <chris.snook@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Jay Cliburn <jcliburn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20191014061549.3669-1-o.rempel@pengutronix.de>
 <20191014061549.3669-3-o.rempel@pengutronix.de>
 <20191016202356.GM17013@lunn.ch>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <3944e911-8eaf-1c57-14de-0998b3245225@pengutronix.de>
Date:   Thu, 17 Oct 2019 08:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016202356.GM17013@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.10.19 22:23, Andrew Lunn wrote:
> On Mon, Oct 14, 2019 at 08:15:47AM +0200, Oleksij Rempel wrote:
>> Atheros AR9331 has built-in 5 port switch. The switch can be configured
>> to use all 5 or 4 ports. One of built-in PHYs can be used by first built-in
>> ethernet controller or to be used directly by the switch over second ethernet
>> controller.
> 
> Hi Oleksij
> 
> How exactly is this phy sharing controlled? I did not see anything in
> the driver. Is there a mux we need to set?

Currently it is not controlled at all, eth0 should be disabled and switch port5 enabled 
(or other way around) in devicetree. If both are enabled, it will be some how brocken.  I 
don't know how to properly implement it.
I assume, it should not be controlled by devicetree configuration and user should be able 
to do it dynamically from user space.

Ideas, suggestions?

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
