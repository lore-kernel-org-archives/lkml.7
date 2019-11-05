Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58FFC49EAA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77B320717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfKEJXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:23:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:36178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbfKEJXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:23:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7D8EB2CE;
        Tue,  5 Nov 2019 09:23:40 +0000 (UTC)
Date:   Tue, 5 Nov 2019 10:23:37 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Woojung Huh <woojung.huh@microchip.com>,
        Marc Zyngier <maz@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: usb: lan78xx: Disable interrupts before calling
 generic_handle_irq()
Message-ID: <20191105092337.rkjeohkdkmiiswzy@beryllium.lan>
References: <20191025080413.22665-1-dwagner@suse.de>
 <20191104085703.diajpzpxo6dchuhs@beryllium.lan>
 <793b1cfa-dc45-c01c-ef0f-72db6df3ecd1@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793b1cfa-dc45-c01c-ef0f-72db6df3ecd1@gmx.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> did you never saw a warning about under voltage from the Raspberry Pi
> hwmon driver?

Guess why I feel so stupid? I just ignored it... /me goes back to
shaming in the corner.
