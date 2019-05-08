Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC19C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA719216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfEHQne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:43:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48748 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfEHQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:43:34 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7D8B614013BD0;
        Wed,  8 May 2019 09:43:33 -0700 (PDT)
Date:   Wed, 08 May 2019 09:43:32 -0700 (PDT)
Message-Id: <20190508.094332.1843206062245441197.davem@davemloft.net>
To:     geert@linux-m68k.org
Cc:     pshelar@ovn.org, fw@strlen.de, fbl@redhat.com, pablo@netfilter.org,
        netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openvswitch: Replace removed NF_NAT_NEEDED with
 IS_ENABLED(CONFIG_NF_NAT)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190508065232.23400-1-geert@linux-m68k.org>
References: <20190508065232.23400-1-geert@linux-m68k.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 May 2019 09:43:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed,  8 May 2019 08:52:32 +0200

> Commit 4806e975729f99c7 ("netfilter: replace NF_NAT_NEEDED with
> IS_ENABLED(CONFIG_NF_NAT)") removed CONFIG_NF_NAT_NEEDED, but a new user
> popped up afterwards.
> 
> Fixes: fec9c271b8f1bde1 ("openvswitch: load and reference the NAT helper.")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thanks.
