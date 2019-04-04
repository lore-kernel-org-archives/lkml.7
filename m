Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E76DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6404A206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfDDN3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:29:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60349 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfDDN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:29:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B418780221; Thu,  4 Apr 2019 15:29:33 +0200 (CEST)
Date:   Thu, 4 Apr 2019 15:21:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 00/25] Add generic support for composing LED class
 device name
Message-ID: <20190404132157.GB6124@xo-6d-61-c0.localdomain>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have not yet gone through the series in great detail.

This will change the userland ABI, right? Now, I understand that old ABI is bad, but
will it break someone's code?

										Pavel

