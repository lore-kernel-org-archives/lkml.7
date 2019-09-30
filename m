Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D9FC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D96215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbfI3VUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:20:55 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:33895 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfI3VUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:20:54 -0400
Received: from webmail.gandi.net (webmail21.sd4.0x35.net [10.200.201.21])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay12.mail.gandi.net (Postfix) with ESMTPA id 6FEF2200005;
        Mon, 30 Sep 2019 21:20:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Oct 2019 00:20:50 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, wsa@the-dreams.de, qii.wang@mediatek.com,
        drinkcat@chromium.org, hsinyi@chromium.org, tglx@linutronix.de,
        linux-i2c-owner@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i2c-mt65xx: fix NULL ptr dereference
In-Reply-To: <20190930152846.5062-1-fparent@baylibre.com>
References: <20190930152846.5062-1-fparent@baylibre.com>
Message-ID: <aa0487c21e1f9f04402f209358b18c75@kernel.wtf>
X-Sender: cengiz@kernel.wtf
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-30 18:28, Fabien Parent wrote:
> Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for 
> mt8183")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Cengiz Can <cengiz@kernel.wtf>
