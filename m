Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C18AC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03216214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfG1NU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:20:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58888 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1NU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:20:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 02D3F80234; Sun, 28 Jul 2019 15:20:40 +0200 (CEST)
Date:   Sun, 28 Jul 2019 15:20:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Add support for WD MyCloud EX2 Ultra (+ versatile
 UART-based restart/poweroff drivers)
Message-ID: <20190728132047.GA8718@xo-6d-61-c0.localdomain>
References: <cover.1563822216.git.evgenyz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1563822216.git.evgenyz@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-22 21:53:00, Evgeny Kolesnikov wrote:
> This patchset consists of the DTS, which describes the WD MyCloud EX2 Ultra device,
> 'poweroff' and 'resert' drivers for power-managing MCUs connected to a board via UART
> (these drivers are more versatile than qnap-poweroff and could be used as a substitude),
> and DT bindings for these drivers.
> 
> The difference between uart-poweroff and qnap-poweroff is small, but important:
> uart-poweroff is able to send to an MCU a command of arbitrary length, and the command
> itself is defined in a DTS file for a specific device/board, thus making this driver
> applicable to wider range of devices.
> 
>  drivers/power/reset/uart-poweroff.c           | 155 +++++++++
>  drivers/power/reset/uart-restart.c            | 204 ++++++++++++

These twon really need to be combined somehow.

Plus... does it have mini-16550 driver in it? Should it use serdev instead?
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
