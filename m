Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ACAC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A592E20859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfDVPQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:16:58 -0400
Received: from mout1.freenet.de ([195.4.92.91]:47266 "EHLO mout1.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfDVPQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:16:58 -0400
X-Greylist: delayed 1972 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2019 11:16:56 EDT
Received: from [195.4.92.164] (helo=mjail1.freenet.de)
        by mout1.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.90_1 #2)
        id 1hIaAs-0004YC-F3; Mon, 22 Apr 2019 16:44:02 +0200
Received: from [::1] (port=57776 helo=mjail1.freenet.de)
        by mjail1.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.90_1 #2)
        id 1hIaAs-00008P-EJ; Mon, 22 Apr 2019 16:44:02 +0200
Received: from sub5.freenet.de ([195.4.92.124]:50614)
        by mjail1.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.90_1 #2)
        id 1hIa8u-0007Vf-S0; Mon, 22 Apr 2019 16:42:00 +0200
Received: from p2e5b8614.dip0.t-ipconnect.de ([46.91.134.20]:35588 helo=mail.maya.org)
        by sub5.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.90_1 #2)
        id 1hIa8u-0007mu-LW; Mon, 22 Apr 2019 16:42:00 +0200
Received: internal info suppressed
From:   Andreas Hartmann <andihartmann@01019freenet.de>
To:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
References: <20190121134913.924726465@linuxfoundation.org>
 <20190121134914.421023706@linuxfoundation.org>
Openpgp: preference=signencrypt
Autocrypt: addr=andihartmann@01019freenet.de; keydata=
 mQGiBDz/vtQRBAC+OSpes1p57fA8ENLYy3Nl/CpEvtRoDdhy7DPyc1+adE57vpK52naRfaZB
 f0RSMvIZwJYggMio+emiN5Du7kL9y2IEjmHBvp/1x68dEwswHP9X4hJmHmyOJL3IB2WsvEdh
 QF97913bWX34MYCeuOoSJ1OWvBLGfNs0zv70HOTfJwCgricyy8N1itEryLwoeu5HWz0SmDED
 /2IiuDhPZ332i0Ylp40RQb2Wb0xBvpscVeRZDItsYYbJ/Sgmso1sn93sFFWmmrvGUyg3MNCt
 +u+7P8Wg3VXte8cHbNwdzNtXHTfYyTcgZXC4xJN2akZt4pdR531mXyP2kFxmKtAEmW6bNpvV
 oNnkgZVWvoT4BHLloLzA62JUEgFJA/9dHilAVS3Ezv5ECB02Lt2vNNzMvPlyNbxBhWnrb6VC
 mFMCRg9bOK2io1zYb8C4gEpJ33wl8hEBxOWfCOEEKesAUCjViosNvxqGNtGWjk5p1O2QBWE2
 D6u5+itACQRqhmmgNl+dK6Of2yGG9GxOYWozIELEfL9ZB4xQ7A2tDFR0ZrRHQW5kcmVhcyBI
 YXJ0bWFubiAod2VpbCBkZXIgUmVjaG5lciBuZXUgaGVpc3N0KSA8YW5kcmVhc0BkdWFsYy5t
 YXlhLm9yZz6IYAQTEQIAIAUCTMsY3gIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJEBhU
 mcTgYeNVT1QAoJ4cJ2jl6Jgmi+PmWCXPk4m8lgAGAKCjkxgK/PjE3+cNsLa/xEpReqYwRrkB
 DQQ8/77WEAQAqBBex8oxPC1srpaSFbq8NCM/Gy7SKucKsQPqG/De46WQESbmnMElVft2xCBC
 rOJ7E02k10h/twe0yQnNdXMJDMDM0w0EEyX9ljekIr3SFbXpU2S4wUl3C6CW2hizUgOyLsg0
 chpfGMB9+wiVycyjZahafoc14wuuDj5BqWEOCccAAwcD/14lh1PTPKx4hs7ITtFZh5TI6+5f
 xAWIBBUeQL+GEt+CKwyNc/hWp8YTPJ3SAedmDrEMX+2yPO95KeIfg6bnnIVvI/aTR/vJFsWK
 GKMx+KaKx+IEwuhCpNIMUASpJWRvVlo3lMIvqAMJIBj79uKq/X9fppblcJst29QVO6aWf3Gh
 iEYEGBECAAYFAjz/vtYACgkQGFSZxOBh41VBAgCfZRiPCQ+jNvdT5iR2fEblqTtBrF0An0nb
 M8B1Lpkm44214BbtIQKneVrYiEYEGBECAAYFAjz/vtcACgkQGFSZxOBh41UjjgCgoua1QYf+
 FcHpxrRgoioO3D7ddkUAnAkRf8FH9i94x8f6LfS4npozycQc
Subject: Re: [PATCH 4.19 13/99] netfilter: nf_conncount: fix argument order to
 find_next_bit
Message-ID: <f55ad830-dd61-8ce2-7fa0-d33fb93c0b9c@01019freenet.de>
Date:   Mon, 22 Apr 2019 16:41:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190121134914.421023706@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originated-At: 46.91.134.20!35588
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Since 4.19.17, I'm facing problems during streaming of videos I've never seen before. This means:

- video from internet stutters although enough data flow can be seen in bmon.
- gpu is locked:
  radeon 0000:0a:00.0: ring 0 stalled for more than 14084msec
  radeon 0000:0a:00.0: GPU lockup (current fence id 0x0000000000053ed7 last fence id 0x0000000000053f0f on ring 0)
- The connection of videos streamed locally by the machine for a TV suddenly breaks (upnp - serviio as server).

After very long time of testing, I detected, that removing the complete patch series for 4.19.17 regarding netfilter: nf_conncount makes the problem disappear.

Please remove / fix this patchset!


Thanks
Andreas Hartmann


On 21.01.19 at 14:48 Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Florian Westphal <fw@strlen.de>
> 
> commit a007232066f6839d6f256bab21e825d968f1a163 upstream.
> 
> Size and 'next bit' were swapped, this bug could cause worker to
> reschedule itself even if system was idle.
> 
> Fixes: 5c789e131cbb9 ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
> Reviewed-by: Shawn Bohrer <sbohrer@cloudflare.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  net/netfilter/nf_conncount.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/net/netfilter/nf_conncount.c
> +++ b/net/netfilter/nf_conncount.c
> @@ -488,7 +488,7 @@ next:
>  	clear_bit(tree, data->pending_trees);
>  
>  	next_tree = (tree + 1) % CONNCOUNT_SLOTS;
> -	next_tree = find_next_bit(data->pending_trees, next_tree, CONNCOUNT_SLOTS);
> +	next_tree = find_next_bit(data->pending_trees, CONNCOUNT_SLOTS, next_tree);
>  
>  	if (next_tree < CONNCOUNT_SLOTS) {
>  		data->gc_tree = next_tree;
> 
> 
> 



