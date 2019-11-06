Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB0C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA312178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfKFCcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 21:32:20 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42330 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfKFCcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 21:32:20 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4FBDB1510CC26;
        Tue,  5 Nov 2019 18:32:19 -0800 (PST)
Date:   Tue, 05 Nov 2019 18:32:18 -0800 (PST)
Message-Id: <20191105.183218.1289105160253580168.davem@davemloft.net>
To:     bianpan2016@163.com
Cc:     allison@lohutok.net, gregkh@linuxfoundation.org,
        tglx@linutronix.de, rfontana@redhat.com,
        kstewart@linuxfoundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFC: fdp: fix incorrect free object
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1572942847-35209-1-git-send-email-bianpan2016@163.com>
References: <1572942847-35209-1-git-send-email-bianpan2016@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Nov 2019 18:32:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>
Date: Tue,  5 Nov 2019 16:34:07 +0800

> The address of fw_vsc_cfg is on stack. Releasing it with devm_kfree() is
> incorrect, which may result in a system crash or other security impacts.
> The expected object to free is *fw_vsc_cfg.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Applied and queued up for -stable, thanks.
