Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5025FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E02206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgAGVrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:47:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38504 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgAGVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:47:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EA2F115A16BA1;
        Tue,  7 Jan 2020 13:47:11 -0800 (PST)
Date:   Tue, 07 Jan 2020 13:47:11 -0800 (PST)
Message-Id: <20200107.134711.1860200595614980441.davem@davemloft.net>
To:     dan.carpenter@oracle.com
Cc:     claudiu.manoil@nxp.com, po.liu@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] enetc: Fix an off by one in
 enetc_setup_tc_txtime()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200107131143.jqytedvewberqp5c@kili.mountain>
References: <20200107131143.jqytedvewberqp5c@kili.mountain>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Jan 2020 13:47:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 7 Jan 2020 16:11:43 +0300

> The priv->tx_ring[] has 16 elements but only priv->num_tx_rings are
> set up, the rest are NULL.  This ">" comparison should be ">=" to avoid
> a potential crash.
> 
> Fixes: 0d08c9ec7d6e ("enetc: add support time specific departure base on the qos etf")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.
