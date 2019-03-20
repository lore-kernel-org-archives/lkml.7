Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A27C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ADD2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfCTHHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:07:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:38839 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfCTHHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:07:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 00:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="scan'208";a="143525931"
Received: from sneftin-mobl1.ger.corp.intel.com (HELO [10.185.23.11]) ([10.185.23.11])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2019 00:07:09 -0700
Subject: Re: [Intel-wired-lan] [PATCH net-next] igc: Make
 igc_write_rss_indir_tbl static
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        jeffrey.t.kirsher@intel.com
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190319145507.22388-1-yuehaibing@huawei.com>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <92371ea1-e9d7-e0b1-1c7a-a374f3c68681@intel.com>
Date:   Wed, 20 Mar 2019 09:07:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319145507.22388-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2019 16:55, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/net/ethernet/intel/igc/igc_ethtool.c:646:6:
>   warning: symbol 'igc_write_rss_indir_tbl' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index eff37a6..5442394 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -643,7 +643,7 @@ static int igc_set_coalesce(struct net_device *netdev,
>   	return 0;
>   }
>   
> -void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
> +static void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
>   	u32 reg = IGC_RETA(0);
> 
The 'igc_write_rss_indir_tbl' method is declared in igc.h and used in 
igc_main.c
Please, refer to latest Jeff next-queue, there is latest patches used 
these methods.
