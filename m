Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B87C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5B220700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfCZVET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:04:19 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35709 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbfCZVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:04:19 -0400
X-Originating-IP: 88.3.237.213
Received: from windsurf (213.red-88-3-237.dynamicip.rima-tde.net [88.3.237.213])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DBCA8FF809;
        Tue, 26 Mar 2019 21:04:13 +0000 (UTC)
Date:   Tue, 26 Mar 2019 22:04:03 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH v2 3/5] gpio: use new gpio_set_config() helper in more
 places
Message-ID: <20190326220403.63e0b533@windsurf>
In-Reply-To: <20190326200302.GA15712@roeck-us.net>
References: <20190207162859.26252-1-thomas.petazzoni@bootlin.com>
        <20190207162859.26252-4-thomas.petazzoni@bootlin.com>
        <20190316014352.GA6124@roeck-us.net>
        <20190316144519.07805478@windsurf>
        <20190326200302.GA15712@roeck-us.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On Tue, 26 Mar 2019 13:03:02 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > I'll have a look. In the mean time, I'm fine with the patch being
> > reverted.
> 
> The problem is still seen in the latest kernel as of last night, and
> I did not see any further activities. Should I send a revert request ?

Sorry for not replying. I have not had the chance to investigate this
further due to lack of time. Linus Walleij initially suggested to use
gpio_set_config() in more places, but that doesn't to work as expected.

A revert patch has already been sent:

  https://lore.kernel.org/lkml/20190326044954.18671-1-andrew@aj.id.au/

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
