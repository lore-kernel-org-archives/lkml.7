Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C67AC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245282173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="a44Ogx8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403787AbfGROCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:02:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34345 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390571AbfGROCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:02:48 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so51668632iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N24J+jmdN0lKgcrjm3AxPIDQpb2nNWH2GoBgCJq2grY=;
        b=a44Ogx8yhBjHD7qABQSqkr5enznNXtYgqI1iXd2mCVVKPh1tpLJni/TI0ZojQtJYz5
         +EfkjSyqcJCg8lrRYizJs6mn+x1tS5LM9/E7mSXhvm7vC9I94o9IfQ0+ZstKc7zZ5Bii
         l834vuoPlUIFmBpyYeMOiMiX8CR5daXKWDJBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N24J+jmdN0lKgcrjm3AxPIDQpb2nNWH2GoBgCJq2grY=;
        b=PcbF+lOdcjDDBaC7fOpMKvPVjjnJKvVYYTG8abwyitJhTDksYLA7wgFWCTvNKly35u
         rFxe4Oz1CaS+MIRkY3HBZKiFlijpuTinatbG1U1ty67+Wk1DODgF3rn9wOCSxtz9KOme
         EKF386fZz5zpfUN/WroilVsVhfO2VZ6DkDR6S5aHODRJzNjFtkbxby93M8yRor/8jfiZ
         XU1JlkQ2WmpLJaON1wvoT8BmZxel/GNaFOKXT94R2jlb8QKaICvoMI2QDOtlvkM5BdDC
         /nZG/sCDsdwjA8D6r56nR0utEhm8NdeF165SiHNIFMLZk9d6fuBTib4x0ezw8CAcZIfH
         t3JQ==
X-Gm-Message-State: APjAAAVzAYmcmX2RgeadNFUYYqpKSMXmo5G47p1N9F5RZsVOldBjk3Pb
        bVjOA5j+lXFELUZQEOkkjDqUhzqLG2w=
X-Google-Smtp-Source: APXvYqzbPH7wSI0MnT9Mx4FrGE2zoAB/gDPIi+LM9imGGFG3EsRABb3Yx2dGWfJKo2lwgTwmADNM7Q==
X-Received: by 2002:a5e:d618:: with SMTP id w24mr7995031iom.73.1563458567767;
        Thu, 18 Jul 2019 07:02:47 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:54f6:cf0:7185:650f? ([2601:282:800:fd80:54f6:cf0:7185:650f])
        by smtp.googlemail.com with ESMTPSA id i4sm39896096iog.31.2019.07.18.07.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 07:02:46 -0700 (PDT)
Subject: Re: [PATCH] Signed-off-by: Peter Kosyh <p.kosyh@gmail.com>
To:     Peter Kosyh <p.kosyh@gmail.com>
Cc:     davem@davemloft.net, Shrijeet Mukherjee <shrijeet@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190718094114.13718-1-p.kosyh@gmail.com>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <213bada2-fe81-3c14-1506-11abf0f3ca22@cumulusnetworks.com>
Date:   Thu, 18 Jul 2019 08:02:45 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190718094114.13718-1-p.kosyh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

your subject line needs a proper Subject - a one-line summary of the
change starting with 'vrf:'. See examples from 'git log drivers/net/vrf.c'


On 7/18/19 3:41 AM, Peter Kosyh wrote:
> vrf_process_v4_outbound() and vrf_process_v6_outbound() do routing
> using ip/ipv6 addresses, but don't make sure the header is available in
> skb->data[] (skb_headlen() is less then header size).
> 
> The situation may occures while forwarding from MPLS layer to vrf, for
> example.

so the use case is a label pop with the nexthop as the VRF device?

> 
> So, this patch adds pskb_may_pull() calls in is_ip_tx_frame(), just before
> call to vrf_process_... functions.
> 
> Signed-off-by: Peter Kosyh <p.kosyh@gmail.com>
> ---
>  drivers/net/vrf.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 54edf8956a25..d552f29a58d1 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -292,13 +292,16 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
>  {
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IP):
> +		if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct iphdr))
> +			break;

that check goes in vrf_process_v4_outbound.

>  		return vrf_process_v4_outbound(skb, dev);
>  	case htons(ETH_P_IPV6):
> +		if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct ipv6hdr))
> +			break;

that check goes in vrf_process_v6_outbound

leave this higher level sorter untouched.

>  		return vrf_process_v6_outbound(skb, dev);
> -	default:
> -		vrf_tx_error(dev, skb);
> -		return NET_XMIT_DROP;
>  	}
> +	vrf_tx_error(dev, skb);
> +	return NET_XMIT_DROP;
>  }
>  
>  static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
> 

