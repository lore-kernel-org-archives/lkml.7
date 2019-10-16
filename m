Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B004ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AA22067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbfJPBD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:03:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42652 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfJPBD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:03:58 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CD32A1265001C;
        Tue, 15 Oct 2019 18:03:56 -0700 (PDT)
Date:   Tue, 15 Oct 2019 18:03:56 -0700 (PDT)
Message-Id: <20191015.180356.268577945716013325.davem@davemloft.net>
To:     Mark-MC.Lee@mediatek.com
Cc:     sean.wang@mediatek.com, john@phrozen.org,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com, andrew@lunn.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, opensource@vdorst.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        jakub.kicinski@netronome.com
Subject: Re: [PATCH net,v3 0/2] Update MT7629 to support PHYLINK API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191014071518.11923-1-Mark-MC.Lee@mediatek.com>
References: <20191014071518.11923-1-Mark-MC.Lee@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Oct 2019 18:03:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: MarkLee <Mark-MC.Lee@mediatek.com>
Date: Mon, 14 Oct 2019 15:15:16 +0800

> This patch set has two goals :
> 	1. Fix mt7629 GMII mode issue after apply mediatek
> 	   PHYLINK support patch.
> 	2. Update mt7629 dts to reflect the latest dt-binding
> 	   with PHYLINK support.

Series applied, thank you.
