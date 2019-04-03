Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27988C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1442075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDCPJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:09:05 -0400
Received: from muru.com ([72.249.23.125]:44114 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCPJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:09:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 81754803A;
        Wed,  3 Apr 2019 15:09:19 +0000 (UTC)
Date:   Wed, 3 Apr 2019 08:09:01 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     nsekhar@ti.com, s-anna@ti.com, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        "Kristo, Tero" <t-kristo@ti.com>
Subject: Re: [RFC PATCH 1/4] ARM: dts: dra7: Keep usb_otg_ss3 and usb_otg_ss4
 disabled
Message-ID: <20190403150901.GR49658@atomide.com>
References: <20190402133752.6912-1-rogerq@ti.com>
 <20190402133752.6912-2-rogerq@ti.com>
 <20190402162203.GL49658@atomide.com>
 <001699f0-a143-5174-692b-78f53098f8aa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001699f0-a143-5174-692b-78f53098f8aa@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190403 14:54]:
> Below patch is just to get initial feedback. Is the overall approach of splitting
> into DRA7 vs AM5 dtsi files OK?

Yes makes sense to me. And if the devices are on the interconnect but not
fully functional, we probably want to set the status = "disabled" only for
the child to idle the module on init. If the whole device is missing then
not adding it at all for certain SoC variants makes sense.

Regards,

Tony
