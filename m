Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB3C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31702206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfFTO2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:28:43 -0400
Received: from mail.gnudd.com ([77.43.112.34]:54313 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfFTO2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:28:43 -0400
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id x5KESZCh014367;
        Thu, 20 Jun 2019 16:28:35 +0200
Received: (from rubini@localhost)
        by mail.gnudd.com (8.14.4/8.14.4/Submit) id x5KESYEF014366;
        Thu, 20 Jun 2019 16:28:34 +0200
Date:   Thu, 20 Jun 2019 16:28:34 +0200
From:   Alessandro Rubini <rubini@gnudd.com>
To:     dingxiang@cmss.chinamobile.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FMC: fix 'passing zero to PTR_ERR()' warning
Message-ID: <20190620142834.GA14359@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <1561025421-19655-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1561025421-19655-1-git-send-email-dingxiang@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

drivers/fmc is going to be removed from the official kernel (removal
is queued by Linus Walleij, with approval by fmc authors).
So this patch should be dropped.

thanks
/alessandro
