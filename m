Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC5BC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772E120652
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404712AbfFKIOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:14:04 -0400
Received: from mail.gnudd.com ([77.43.112.34]:51749 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403996AbfFKIOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:14:04 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 04:14:03 EDT
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id x5B85XXK024993;
        Tue, 11 Jun 2019 10:05:33 +0200
Received: (from rubini@localhost)
        by mail.gnudd.com (8.14.4/8.14.4/Submit) id x5B85XS4024992;
        Tue, 11 Jun 2019 10:05:33 +0200
Date:   Tue, 11 Jun 2019 10:05:33 +0200
From:   Alessandro Rubini <rubini@gnudd.com>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, federico.vaga@cern.ch,
        riehecky@fnal.gov
Subject: Re: [PATCH] fmc: Delete the FMC subsystem
Message-ID: <20190611080533.GA24985@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <20190610141809.17542-1-linus.walleij@linaro.org>
References: <20190610141809.17542-1-linus.walleij@linaro.org> 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alessandro Rubini <rubini@gnudd.com>

