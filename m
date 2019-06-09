Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30F8C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9513E2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 14:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfFIOei convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 10:34:38 -0400
Received: from hilbert2.alphasky.net ([178.63.16.112]:55879 "EHLO
        hilbert2.alphasky.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfFIOeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 10:34:37 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 10:34:37 EDT
Received: from localhost (localhost [127.0.0.1])
        by hilbert.alphasky.net (Postfix) with ESMTP id AB36BE011C7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2019 16:28:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hilbert.alphasky.net
Received: from hilbert2.alphasky.net ([127.0.0.1])
        by localhost (hilbert.alphasky.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DfGMcWPVf8nv for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jun 2019 16:28:10 +0200 (CEST)
Received: from tau.familiekling.de (tau.familiekling.de [10.99.0.1])
        by delta.familiekling.de (Postfix) with ESMTPS id 0C51312A10FB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2019 16:28:10 +0200 (CEST)
Received: from tau.familiekling.de (10.99.0.1) by tau.familiekling.de
 (10.99.0.1) with Microsoft SMTP Server (TLS) id 15.0.847.32; Sun, 9 Jun 2019
 16:28:03 +0200
Received: from tau.familiekling.de ([fe80::5c8e:2c3e:e113:32f7]) by
 tau.familiekling.de ([fe80::5c8e:2c3e:e113:32f7%12]) with mapi id
 15.00.0847.040; Sun, 9 Jun 2019 16:28:03 +0200
From:   Christoph Kling <christoph@kling.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL net-next, resend] isdn: deprecate non-mISDN drivers
Thread-Topic: Re: [GIT PULL net-next, resend] isdn: deprecate non-mISDN
 drivers
Thread-Index: AdUezS0NeVLicA74QvuShSLnam5txw==
Date:   Sun, 9 Jun 2019 14:28:03 +0000
Message-ID: <7076fa0e275247bf9caabfb630204a2e@tau.familiekling.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.0.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

I'm a long time ISDN user and I cannot fully agree to the assessment of current ISDN usage. It is of course true that ISDN is no longer a main protocol for telephone connections and therefore the number of users has dropped. But still there are people with public ISDN telephone links, e.g. in Germany. Not everything has been converted into voice over ip. 

More importantly however, there are still many *private* ISDN networks. The simple reason is that beyond the public networks, there are still a lot of people who have ISDN telephone installations in their buildings. 

Those installations date from the time when many public telephone connections used ISDN. Those private ISDN telephone installations have a *very* long lifetime (> 20 years), as many people, especially individuals shy at the cost and effort to get a new internal telephone installation. A reliable indicator for that is that one of the most widespread wifi router products in Germany and beyond, AVM Fritz!Box still supports ISDN even in its most recent version (7590). 

Speaking for myself, I still use the capi based b1pci driver for active AVM cards in several installations.

Please do not base your assessment of ISDN usage on the size and number of public ISDN networks and please do not remove capi and isdn4linux support from the kernel.

Thank you for commitment to the kernel development!

Kind regards,
Christoph Kling 
