Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0706C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43A1218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfCUKzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:55:20 -0400
Received: from skyboo.net ([94.40.87.198]:34918 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCUKzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:55:20 -0400
Received: from [10.1.0.1] (helo=nemesis.skyboo.net)
        by skyboo.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1h6vLs-0005Ze-MM; Thu, 21 Mar 2019 11:55:18 +0100
Date:   Thu, 21 Mar 2019 11:55:11 +0100
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>
Message-Id: <20190321115511.29f8f6f25a2b9b96c2dd77aa@skyboo.net>
In-Reply-To: <DF2ABF87-116D-4287-8A18-89C2C59124AF@gmail.com>
References: <20190318092737.8170-1-manio@skyboo.net>
        <20190318092737.8170-2-manio@skyboo.net>
        <DF2ABF87-116D-4287-8A18-89C2C59124AF@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.1.0.1
X-SA-Exim-Rcpt-To: jeff.dagenais@gmail.com, linux-kernel@vger.kernel.org, zbr@ioremap.net, greg@kroah.com
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: Re: [PATCH 1/2] w1: ds2408: add a missing reset when retrying in
 output_write()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 10:21:32 -0400
Jean-Francois Dagenais <jeff.dagenais@gmail.com> wrote:

> May I suggest a cleaned up version my original klunky code with your fix in it
> (Note: this is untested, it compiles on arm64, that's all):
Thank you Jean!
I just tested your version - and it is working as expected :)

> I can do a proper patch submission if you guys provide positive response on this
> early RFC. Or better yet, you can take it and own it yourself as your v2
> Mariusz. ;)
No, it's your code, please just submit v2 as yours (I've already sent simplified
version of the patch 1/2 as you suggested).

Just drop the following and all will be fine :)
Reported-by: Mariusz Bialonczyk <manio@skyboo.net>

Thanks!
regards,
-- 
Mariusz Białończyk | xmpp/e-mail: manio@skyboo.net
https://skyboo.net | https://github.com/manio
