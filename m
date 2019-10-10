Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3B3C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1C421835
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfJJSZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:25:45 -0400
Received: from dispatchb-us1.ppe-hosted.com ([148.163.129.53]:43390 "EHLO
        dispatchb-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfJJSZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:25:44 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 14:25:43 EDT
Received: from dispatchb-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatchb-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9BEFD49B07
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:17:04 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 80F9E48007A;
        Thu, 10 Oct 2019 18:16:59 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Oct
 2019 11:16:54 -0700
Subject: Re: [PATCH net-next 2/2] net: core: increase the default size of
 GRO_NORMAL skb lists to flush
To:     Alexander Lobakin <alobakin@dlink.ru>,
        "David S. Miller" <davem@davemloft.net>
CC:     Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>,
        "Ido Schimmel" <idosch@mellanox.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Petr Machata <petrm@mellanox.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191010144226.4115-1-alobakin@dlink.ru>
 <20191010144226.4115-3-alobakin@dlink.ru>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <c2450dc3-8ee0-f7cd-4f8a-61a061989eb7@solarflare.com>
Date:   Thu, 10 Oct 2019 19:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191010144226.4115-3-alobakin@dlink.ru>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24966.005
X-TM-AS-Result: No-8.992500-4.000000-10
X-TMASE-MatchedRID: 9d2LtCNB3NLbE+eFyyIBkfZvT2zYoYOwC/ExpXrHizwZFDQxUvPcmBvt
        T5Aez5bygGDwjrZraFXjuBuuqzqGcEt1FMotbBEQ8pHTorDcPMrqobkz1A0A7TiuMlzVheGwgyW
        NJp//h3XdTAmCcpzVLkDVDr5/unyvzD8138PYfo6InASnzB5VfKlHaQwZyzDtGUs9b7xvtJqw0F
        FGdeCd9srqJH3Kw4BAnGG1j6OVoIhOhKWBO+Cmgxwu4QM/6Cpy4cLBHAw1BRYIFWSswluXgvea4
        uH4Y9hvDwMB0lawjhYAthf4DwDQ7fd9a88CNZMQYjzB3tJbO8tfx1AX9LMZGZm3TxN83Lo4cybj
        UgE5SsJd4QVrhn+V0zwGoNMkGAxEpbsaAAEB5vI/ApMPW/xhXkyQ5fRSh2651l38M6aWfEhljNm
        CIkXOCq3tSJ6nOy02WjS2cKZCreJwYKSOfcZadiQ4UCgoD20C64sVlliWKx+/WXZS/HqJ2lZ0V5
        tYhzdWxEHRux+uk8jQ9TRN0mhS1/76p52Ka1tPa86s112mGSnac2IfPCSzDIxu0g2For1O3Qd/G
        zjDQc+oi8wxUkcbN+ML+Y6yjZX/nU2BuN2s/6b3PSEAW4dhg4VyAlz5A0zC7xsmi8libwVi6nHR
        eNJA8sM4VWYqoYnhs+fe0WifpQo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.992500-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24966.005
X-MDID: 1570731420-TinRgbzGYmMa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2019 15:42, Alexander Lobakin wrote:
> Commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL
> skbs") have introduced a sysctl variable gro_normal_batch for defining
> a limit for listified Rx of GRO_NORMAL skbs. The initial value of 8 is
> purely arbitrary and has been chosen, I believe, as a minimal safe
> default.
8 was chosen by performance tests on my setup with v1 of that patch;
 see https://www.spinics.net/lists/netdev/msg585001.html .
Sorry for not including that info in the final version of the patch.
While I didn't re-do tests on varying gro_normal_batch on the final
 version, I think changing it needs more evidence than just "we tested
 it; it's better".  In particular, increasing the batch size should be
 accompanied by demonstration that latency isn't increased in e.g. a
 multi-stream ping-pong test.

> However, several tests show that it's rather suboptimal and doesn't
> allow to take a full advantage of listified processing. The best and
> the most balanced results have been achieved with a batches of 16 skbs
> per flush.
> So double the default value to give a yet another boost for Rx path.

> It remains configurable via sysctl anyway, so may be fine-tuned for
> each hardware.
I see this as a reason to leave the default as it is; the combination
 of your tests and mine have established that the optimal size does
 vary (I found 16 to be 2% slower than 8 with my setup), so any
 tweaking of the default is likely only worthwhile if we have data
 over lots of different hardware combinations.

> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index a33f56b439ce..4f60444bb766 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4189,7 +4189,7 @@ int dev_weight_tx_bias __read_mostly = 1;  /* bias for output_queue quota */
>  int dev_rx_weight __read_mostly = 64;
>  int dev_tx_weight __read_mostly = 64;
>  /* Maximum number of GRO_NORMAL skbs to batch up for list-RX */
> -int gro_normal_batch __read_mostly = 8;
> +int gro_normal_batch __read_mostly = 16;
>  
>  /* Called with irq disabled */
>  static inline void ____napi_schedule(struct softnet_data *sd,

