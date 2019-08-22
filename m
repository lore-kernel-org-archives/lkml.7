Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D8CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49736233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394421AbfHVXXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:23:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50602 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfHVXXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:23:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DF6051539DF80;
        Thu, 22 Aug 2019 16:23:39 -0700 (PDT)
Date:   Thu, 22 Aug 2019 16:23:39 -0700 (PDT)
Message-Id: <20190822.162339.831735149510227752.davem@davemloft.net>
To:     Markus.Elfring@web.de
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        intel-wired-lan@lists.osuosl.org,
        bcm-kernel-feedback-list@broadcom.com,
        UNGLinuxDriver@microchip.com, alexandre.torgue@st.com,
        alexios.zavras@intel.com, allison@lohutok.net,
        bryan.whitehead@microchip.com, claudiu.manoil@nxp.com,
        opendmb@gmail.com, dougmill@linux.ibm.com, f.fainelli@gmail.com,
        peppe.cavallaro@st.com, gregkh@linuxfoundation.org,
        jeffrey.t.kirsher@intel.com, opensource@jilayne.com,
        jonathan.lemon@gmail.com, joabreu@synopsys.com,
        kstewart@linuxfoundation.org, mcgrof@kernel.org,
        mcoquelin.stm32@gmail.com, michael.heimpold@i2se.com,
        nico@fluxnic.net, ynezz@true.cz, shannon.nelson@oracle.com,
        stefan.wahren@i2se.com, swinslow@gmail.com, tglx@linutronix.de,
        weiyongjun1@huawei.com, wsa+renesas@sang-engineering.com,
        yang.wei9@zte.com.cn, yuehaibing@huawei.com, zhongjiang@huawei.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ethernet: Delete unnecessary checks before the macro
 call =?iso-2022-jp?B?GyRCIUgbKEJkZXZfa2ZyZWVfc2tiGyRCIUkbKEI=?=
From:   David Miller <davem@davemloft.net>
In-Reply-To: <af1ae1cf-4a01-5e3a-edc2-058668487137@web.de>
References: <af1ae1cf-4a01-5e3a-edc2-058668487137@web.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 16:23:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 22 Aug 2019 20:30:15 +0200

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 22 Aug 2019 20:02:56 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied.
