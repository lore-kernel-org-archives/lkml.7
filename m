Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC6C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995B22077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfLIRn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:43:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33346 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLIRn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:43:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 07E3915436C4C;
        Mon,  9 Dec 2019 09:43:57 -0800 (PST)
Date:   Mon, 09 Dec 2019 09:43:56 -0800 (PST)
Message-Id: <20191209.094356.813138131056263064.davem@davemloft.net>
To:     dmurphy@ti.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        bunk@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.strashko@ti.com, robh@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dp83867: Convert fifo-depth to common
 fifo-depth and make optional
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191206164516.2702-1-dmurphy@ti.com>
References: <20191206164516.2702-1-dmurphy@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Dec 2019 09:43:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


These patches don't apply cleanly to my networking trees.

Please also properly supply an appropriate "[PATCH 0/N]" header posting
and clearly indicate the target GIT tree as in "[PATCH net-next 0/N]"
as well as the patch series version "[PATCH v2 net-next 0/N]" when you
repsin this.

Thanks.
