Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8963523406
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbfHWC20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51994 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390502AbfHWC2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DF187153AC223;
        Thu, 22 Aug 2019 19:28:24 -0700 (PDT)
Date:   Thu, 22 Aug 2019 19:28:24 -0700 (PDT)
Message-Id: <20190822.192824.2273357204230762835.davem@davemloft.net>
To:     benwei@fb.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next] net/ncsi: update response packet length for
 GCPS/GNS/GNPTS commands
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CH2PR15MB3686567EBCBE71B41C5F079AA3AA0@CH2PR15MB3686.namprd15.prod.outlook.com>
References: <CH2PR15MB3686567EBCBE71B41C5F079AA3AA0@CH2PR15MB3686.namprd15.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 19:28:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Wei <benwei@fb.com>
Date: Wed, 21 Aug 2019 22:08:49 +0000

> Update response packet length for the following commands per NC-SI spec
> - Get Controller Packet Statistics
> - Get NC-SI Statistics
> - Get NC-SI Pass-through Statistics command
> 
> Signed-off-by: Ben Wei <benwei@fb.com>

Applied, thanks Ben.
