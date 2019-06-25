Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC5CC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCBC213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561503900;
	bh=+CGuu9k+uPdFdb6RRHWgE8kNKhCrYuk5mghMuKCGlZ4=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=xmtizczGGWxbPYIt+Qe08hndmpVckB/ST0vUfeJxUcVKfeK/yYwFjIBjs0jUqkzGs
	 9+Y2EEzx5a66HEYzK/zrsz/qweWfmmGOAeoQ70S7vZCITVuRylo1C47GrFcj3tKA9+
	 zPu48nNdv8Cs8zSFDbnyN7CGIIitqPOQBuNDXDQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFYXE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYXE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:04:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B48E62086D;
        Tue, 25 Jun 2019 23:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561503897;
        bh=+CGuu9k+uPdFdb6RRHWgE8kNKhCrYuk5mghMuKCGlZ4=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=u7X3FHT767mlnYuFXB1qdSOmnAVBasE0imtx33jpynu7jgJYKTuKDiKEi5ChA/oY2
         noWZpS2QBrFT9m6fffQGOwJFRxnOe9K/lUsari/72M+/VWdr2sFXNail/oM6fvKoaI
         kSxFY0Q1Weeko3qE5TR1URZ5XpAdTW2KADNeUtzY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190612182500.4097-4-nsaenzjulienne@suse.de>
References: <20190612182500.4097-1-nsaenzjulienne@suse.de> <20190612182500.4097-4-nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 3/7] firmware: raspberrypi: register clk device
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 16:04:56 -0700
Message-Id: <20190625230457.B48E62086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-12 11:24:55)
> Since clk-raspberrypi is tied to the VC4 firmware instead of particular
> hardware it's registration should be performed by the firmware driver.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

