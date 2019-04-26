Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE849C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824B12067D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfDZM7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:59:16 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:53876 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:59:16 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7207325AD60;
        Fri, 26 Apr 2019 22:59:13 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 4161F9403ED; Fri, 26 Apr 2019 14:59:11 +0200 (CEST)
Date:   Fri, 26 Apr 2019 14:59:11 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbnet: ipheth: Simplify device detection
Message-ID: <20190426125905.whklj6ns4xsrm3l2@verge.net.au>
References: <1556128704-10831-1-git-send-email-linux@roeck-us.net>
 <20190426112703.lrceujboxox6no3y@verge.net.au>
 <339d6eb5-0534-a455-735f-2abf28d5f509@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339d6eb5-0534-a455-735f-2abf28d5f509@roeck-us.net>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 05:13:17AM -0700, Guenter Roeck wrote:
> On 4/26/19 4:27 AM, Simon Horman wrote:
> > On Wed, Apr 24, 2019 at 10:58:24AM -0700, Guenter Roeck wrote:
> > > All Apple products use the same protocol for tethering over USB.
> > > To simplify the code and make it future proof, use
> > > USB_VENDOR_AND_INTERFACE_INFO() instead of
> > > USB_DEVICE_AND_INTERFACE_INFO() to automatically detect and support
> > > all existing and future Apple products using the same interface.
> > 
> > What if future Apple products behave differently?
> > 
> 
> Sure, Apple may decide to use the same device/class/subclass/protocol
> identifier for a different protocol. That is unlikely but possible.
> 
> If the associated risk is considered higher than the benefit of supporting
> new devices announcing the same protocol with a different product id,
> please feel free to ignore (or nack) this patch.

My experience with hardware vendors would lead me to err on the side of
caution. But my experience does not extend to Apple and the benefit you
describe may well be worth the risk in this case.

...
