Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9899C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967802166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfFSO0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:26:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34940 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFSO0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:26:21 -0400
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CC535152366DD;
        Wed, 19 Jun 2019 07:26:20 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:26:19 -0400 (EDT)
Message-Id: <20190619.102619.618962498575895795.davem@davemloft.net>
To:     rasmus.villemoes@prevas.dk
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        Rasmus.Villemoes@prevas.se, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: fix shift of FID bits in
 mv88e6250_g1_vtu_loadpurge()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190619100224.11848-1-rasmus.villemoes@prevas.dk>
References: <20190619100224.11848-1-rasmus.villemoes@prevas.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Jun 2019 07:26:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Wed, 19 Jun 2019 10:02:38 +0000

> The comment is correct, but the code ends up moving the bits four
> places too far, into the VTUOp field.
> 
> Fixes: bec8e5725281 (net: dsa: mv88e6xxx: implement vtu_getnext and vtu_loadpurge for mv88e6250)
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Also applied, thank you.
