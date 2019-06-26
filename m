Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A0C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F29E2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UBaIRenG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfFZG0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:26:21 -0400
Received: from first.geanix.com ([116.203.34.67]:59366 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfFZG0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:26:20 -0400
Received: from [192.168.100.94] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 1FEB8A8C;
        Wed, 26 Jun 2019 06:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1561530346; bh=NDzWY1mn8lR9WsNTeOSRA7DhTJGZznkTv0X6E2FIZ0k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UBaIRenG4Cel4QngwSQ1B2hHFpou0eDA/c+J/ub1C3MTrt/jHs2A4lrSvuLxqhL0x
         2AyWZxz0UBtrh+aqOSqIrin9+IQgBbjf8eZaIWe6WYmg/30Kcu5vexu6gDtM30iGMS
         /ds5jksQ2rY2PDsDsOjT1aiXltgUkS45rKrHNYHNYBseg7Jo7ADD8GuMdztswItfvL
         jtUQXFUq3MEPnZNgWNqJ6Tbk2/k7C8sY4rH1IjROks7Y54ZMsOgLxHdPi6baVHBaD7
         mf4lS7wo/IRFKl+xoDgS77gbarFvId89gC9EisZvaYGvelNFQnzyc4h/HopvsXxWiu
         Qrx41MMrxhEjQ==
Subject: Re: [PATCH] can: mcp251x: add error check when wq alloc failed
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weitao Hou <houweitaoo@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190625125048.28849-1-houweitaoo@gmail.com>
 <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <6a678bc9-648e-e566-9781-2b42a678ed86@geanix.com>
Date:   Wed, 26 Jun 2019 08:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/06/2019 16.03, Willem de Bruijn wrote:
> On Tue, Jun 25, 2019 at 8:51 AM Weitao Hou <houweitaoo@gmail.com> wrote:
>>
>> add error check when workqueue alloc failed, and remove
>> redundant code to make it clear
>>
>> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> 
> Acked-by: Willem de Bruijn <willemb@google.com>
> 
Tested-by: Sean Nyekjaer <sean@geanix.com>
