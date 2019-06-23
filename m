Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC25BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF874204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfFXCmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:42:40 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:39704 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfFXCmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:42:40 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 5857818019A00;
        Sun, 23 Jun 2019 21:57:06 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2A69A18029123;
        Sun, 23 Jun 2019 21:57:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean01_37b054319919
X-Filterd-Recvd-Size: 1554
Received: from XPS-9350 (unknown [172.58.30.132])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Jun 2019 21:57:03 +0000 (UTC)
Message-ID: <c88cfce8a80eb69c932fd249f2ef0224e60b127a.camel@perches.com>
Subject: Re: [PATCH] bluetooth: Cleanup formatting and coding style
From:   Joe Perches <joe@perches.com>
To:     Fabian Schindlatz <fabian.schindlatz@fau.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas =?ISO-8859-1?Q?R=F6thenbacher?= 
        <thomas.roethenbacher@fau.de>, linux-kernel@i4.cs.fau.de
Date:   Sun, 23 Jun 2019 14:56:33 -0700
In-Reply-To: <20190623211548.1966-1-fabian.schindlatz@fau.de>
References: <20190623211548.1966-1-fabian.schindlatz@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-23 at 23:15 +0200, Fabian Schindlatz wrote:
> Fix some warnings and one error reported by checkpatch.pl:
[]
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
[]
> @@ -351,7 +356,8 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  		skb_queue_tail(&ll->tx_wait_q, skb);
>  		break;
>  	default:
> -		BT_ERR("illegal hcill state: %ld (losing packet)", ll->hcill_state);
> +		BT_ERR("illegal hcill state: %ld (losing packet)",

trivia:

Might use invalid instead of illegal as no crime was committed.


