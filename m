Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC2C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0AE2072C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgAEWrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:47:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEWrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:47:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C020E155566CB;
        Sun,  5 Jan 2020 14:47:46 -0800 (PST)
Date:   Sun, 05 Jan 2020 14:47:46 -0800 (PST)
Message-Id: <20200105.144746.2055568145717937218.davem@davemloft.net>
To:     vikas.gupta@broadcom.com
Cc:     zajec5@gmail.com, sheetal.tigadoli@broadcom.com,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, sumit.garg@linaro.org,
        vasundhara-v.volam@broadcom.com, vikram.prakash@broadcom.com
Subject: Re: [PATCH INTERNAL v2] firmware: tee_bnxt: Fix multiple call to
 tee_client_close_context
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1578068404-26195-1-git-send-email-vikas.gupta@broadcom.com>
References: <1578068404-26195-1-git-send-email-vikas.gupta@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 Jan 2020 14:47:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


What does "INTERNAL" mean in these patch Subject lines?
