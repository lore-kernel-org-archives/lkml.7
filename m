Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D8EC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6444206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfDYOy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:54:26 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.78]:15034 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfDYOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:54:25 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 8F58AA139F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:54:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id JflYhKead2qH7JflYhevU1; Thu, 25 Apr 2019 09:54:24 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.223] (port=57752 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hJflY-002jNo-4y; Thu, 25 Apr 2019 09:54:24 -0500
Subject: Re: [PATCH net-next] amd-xgbe: Mark expected switch fall-throughs
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20190424160823.GA20314@embeddedor>
 <bfb7c017-e7df-5fa3-d946-32ee3b94fa53@amd.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <1cd135d4-df0f-ee31-d85f-5f47c8037f2d@embeddedor.com>
Date:   Thu, 25 Apr 2019 09:54:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bfb7c017-e7df-5fa3-d946-32ee3b94fa53@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.223
X-Source-L: No
X-Exim-ID: 1hJflY-002jNo-4y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.127.223]:57752
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/19 8:12 AM, Lendacky, Thomas wrote:
[..]
>>   ^~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> Notice that, in this particular case, the code comments are modified
>> in accordance with what GCC is expecting to find.
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> index 0cc911f928b1..3dd0cecddba8 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> @@ -1612,7 +1612,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
>>  	/* PTP v2, UDP, any kind of event packet */
>>  	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
>> -	/* PTP v1, UDP, any kind of event packet */
>> +		/* Fall through - to PTP v1, UDP, any kind of event packet */
> 
> If the compiler doesn't have a problem with adding just an indented
> "Fall through" comment and leaving the original comment in place, I would
> prefer that. It seems clearer to me.
> 

This is the other alternative:

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 0cc911f928b1..f913bf404baa 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1613,6 +1613,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
        case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
        /* PTP v1, UDP, any kind of event packet */
+               /* Fall through */
        case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
@@ -1624,6 +1625,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
        case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
        /* PTP v1, UDP, Sync packet */
+               /* Fall through */
        case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
@@ -1635,6 +1637,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
        case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
        /* PTP v1, UDP, Delay_req packet */
+               /* Fall through */
        case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
                XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);


The thing is that the fall-through comments have to be placed at the
very bottom of each case.

Which do you prefer?

Thanks
--
Gustavo

> Thanks,
> Tom
> 
>>  	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
>> @@ -1623,7 +1623,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
>>  	/* PTP v2, UDP, Sync packet */
>>  	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
>> -	/* PTP v1, UDP, Sync packet */
>> +		/* Fall through - to PTP v1, UDP, Sync packet */
>>  	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
>> @@ -1634,7 +1634,7 @@ static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
>>  	/* PTP v2, UDP, Delay_req packet */
>>  	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
>> -	/* PTP v1, UDP, Delay_req packet */
>> +		/* Fall through - to PTP v1, UDP, Delay_req packet */
>>  	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
>>  		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
>>
