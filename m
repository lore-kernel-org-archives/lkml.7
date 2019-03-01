Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DB2204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfCAUky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:40:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57746 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCAUkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:40:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E84A714F76147;
        Fri,  1 Mar 2019 12:40:52 -0800 (PST)
Date:   Fri, 01 Mar 2019 12:40:50 -0800 (PST)
Message-Id: <20190301.124050.1008013447164978990.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     michal.vokac@ysoft.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: Do not configure VLAN ID 0
From:   David Miller <davem@davemloft.net>
In-Reply-To: <ab4f9ea2-f108-1538-3a98-dd03d3657a16@gmail.com>
References: <5cfd1cbc-1ba4-2274-841a-4285db72afa4@ysoft.com>
        <2f23dc48-a042-4fcf-cc5b-11d247061239@gmail.com>
        <ab4f9ea2-f108-1538-3a98-dd03d3657a16@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 01 Mar 2019 12:40:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 1 Mar 2019 09:54:07 -0800

> David, please discard this version, I will submit a version that
> properly emulates the prepare/commit phase such that no assumptions are
> broken, this will take care of both issues at once. Thanks!

Ok.
