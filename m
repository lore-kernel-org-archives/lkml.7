Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCEC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8766206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgAGVm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:42:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38476 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgAGVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:42:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C97B15A17458;
        Tue,  7 Jan 2020 13:42:24 -0800 (PST)
Date:   Tue, 07 Jan 2020 13:42:24 -0800 (PST)
Message-Id: <20200107.134224.1676825160556917131.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
        Joao.Pinto@synopsys.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, bot@kernelci.org, sriram.dash@samsung.com
Subject: Re: [PATCH net] net: stmmac: Fixed link does not need MDIO Bus
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5d4a30a5-7af5-7147-11a9-bb5ca3564baa@gmail.com>
References: <5764e60da6d3af7e76c30f63b07f1a12b4787918.1578400471.git.Jose.Abreu@synopsys.com>
        <5d4a30a5-7af5-7147-11a9-bb5ca3564baa@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Jan 2020 13:42:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 7 Jan 2020 11:05:07 -0800

> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail> # Lamobo R1 (fixed-link +
> MDIO sub node for roboswitch).

Florian please be careful not to let individual tags split into
multiple lines, I had to hand edit the second part of the Tested-by:
tag into the commit message.
