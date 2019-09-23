Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA87C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E0020820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfIWIvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:51:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38306 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbfIWIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:51:13 -0400
Received: from localhost (unknown [185.13.106.231])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6A303154461DA;
        Mon, 23 Sep 2019 01:51:11 -0700 (PDT)
Date:   Mon, 23 Sep 2019 10:51:07 +0200 (CEST)
Message-Id: <20190923.105107.1607030014690831006.davem@davemloft.net>
To:     marcelo.cerri@canonical.com
Cc:     shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: replace AF_MAX with INT_MAX in socket.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190916150337.18049-1-marcelo.cerri@canonical.com>
References: <20190916150337.18049-1-marcelo.cerri@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Sep 2019 01:51:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Date: Mon, 16 Sep 2019 12:03:37 -0300

> Use INT_MAX instead of AF_MAX, since libc might have a smaller value
> of AF_MAX than the kernel, what causes the test to fail.
> 
> Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>

Definitely need to fix this differently.
