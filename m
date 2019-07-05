Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A48C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C1D2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfGEKSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:18:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47432 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfGEKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:18:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CCFEE806B3; Fri,  5 Jul 2019 12:17:54 +0200 (CEST)
Date:   Fri, 5 Jul 2019 12:17:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com
Subject: Re: [PATCH 1/2] leds: tlc591xx: simplify driver by using the managed
 led API
Message-ID: <20190705101755.gd36zbjz2p4x3yp6@devuan>
References: <20190701152602.31716-1-jjhiblot@ti.com>
 <20190701152602.31716-2-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701152602.31716-2-jjhiblot@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-01 17:26:01, Jean-Jacques Hiblot wrote:
> Use the managed API of the LED class (devm_led_classdev_register()
> instead of led_classdev_register()).
> This allows us to remove the code used to track-and-destroy the LED devices
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>

ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
