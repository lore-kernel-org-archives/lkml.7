Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ADBC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD1720830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfCYN4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:56:02 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49031 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCYN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:56:02 -0400
X-Originating-IP: 109.213.38.144
Received: from localhost (alyon-652-1-47-144.w109-213.abo.wanadoo.fr [109.213.38.144])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D839940003;
        Mon, 25 Mar 2019 13:55:59 +0000 (UTC)
Date:   Mon, 25 Mar 2019 14:55:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: rtc: Correct location of rtctest.c
Message-ID: <20190325135558.GL30105@piout.net>
References: <20190325103322.2578-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325103322.2578-1-joel@jms.id.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 21:03:22+1030, Joel Stanley wrote:
> The useful little rtctest program moved location a while back.
> 
> Fixes: a12ab9e125f1 ("selftests: move RTC tests to rtc subfolder")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/rtc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
