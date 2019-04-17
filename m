Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F9C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69427206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbfDQRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:21:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56718 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732746AbfDQRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:21:16 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D564D133E9778;
        Wed, 17 Apr 2019 10:21:12 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:21:12 -0700 (PDT)
Message-Id: <20190417.102112.382636552216165456.davem@davemloft.net>
To:     nhorman@tuxdriver.com
Cc:     arnd@arndb.de, ralf@linux-mips.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, socketcan@hartkopp.net,
        mkl@pengutronix.de, gerrit@erg.abdn.ac.uk, alex.aring@gmail.com,
        stefan@datenfreihafen.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, vyasevich@gmail.com,
        marcelo.leitner@gmail.com, andrew.hendry@gmail.com,
        edumazet@google.com, willemb@google.com, deepa.kernel@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-x25@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190417093523.GA15487@hmswarspite.think-freely.org>
References: <20190416203620.539628-1-arnd@arndb.de>
        <20190417093523.GA15487@hmswarspite.think-freely.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Apr 2019 10:21:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Horman <nhorman@tuxdriver.com>
Date: Wed, 17 Apr 2019 05:35:23 -0400

> Acked-by: Neil Horman <nhorman@tuxdriver.com>

Neil, please quote appropriately in the future.

I have to scroll through all of those pages of quoted patch just to
see this one line.

Thank you.
