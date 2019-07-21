Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54010C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29291206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfGUTEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 15:04:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49479 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfGUTEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 15:04:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3B47880385; Sun, 21 Jul 2019 21:04:35 +0200 (CEST)
Date:   Sun, 21 Jul 2019 21:03:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, jpawar@cadence.com,
        kurahul@cadence.com, aniljoy@cadence.com
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Message-ID: <20190721190335.GA19831@xo-6d-61-c0.localdomain>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563733939-21214-1-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> 
> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.

I see you are using debugfs to select between DRD, peripheral-onlyh and XHCI... 

Is that good idea?

This is at least 3rd driver needing that capability, and debugfs does not
sound like a good match.

									Pavel
