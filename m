Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6061AC31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 03:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3915D21473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 03:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfFODUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 23:20:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58080 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfFODUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 23:20:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 999D7140518E3;
        Fri, 14 Jun 2019 20:20:20 -0700 (PDT)
Date:   Fri, 14 Jun 2019 20:20:20 -0700 (PDT)
Message-Id: <20190614.202020.2299196626940226476.davem@davemloft.net>
To:     vivien.didelot@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v2 0/4] net: dsa: use switchdev attr and obj
 handlers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190614174922.2590-1-vivien.didelot@gmail.com>
References: <20190614174922.2590-1-vivien.didelot@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Jun 2019 20:20:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivien Didelot <vivien.didelot@gmail.com>
Date: Fri, 14 Jun 2019 13:49:18 -0400

> This series reduces boilerplate in the handling of switchdev attribute and
> object operations by using the switchdev_handle_* helpers, which check the
> targeted devices and recurse into their lower devices.
> 
> This also brings back the ability to inspect operations targeting the bridge
> device itself (where .orig_dev and .dev were originally the bridge device),
> even though that is of no use yet and skipped by this series.
> 
> Changes in v2: Only VLAN and (non-host) MDB objects not directly targeting
> the slave device are unsupported at the moment, so only skip these cases.

Series applied.
