Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F28C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6522E206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfDECbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:31:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728699AbfDECbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:31:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E90C10C18CE56E358BD;
        Fri,  5 Apr 2019 10:31:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 10:31:18 +0800
Subject: Re: [PATCH] staging: rtl8192u: ieee80211: add space around '==' and
 before '('
To:     Caio Salvador Rohwedder <caiosalvador96@gmail.com>,
        <gregkh@linuxfoundation.org>
References: <20190405015646.20672-1-caiosalvador96@gmail.com>
CC:     <johnfwhitmore@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <lkcamp@lists.libreplanetbr.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <e595121b-81f1-8242-eb91-a9258b96831d@huawei.com>
Date:   Fri, 5 Apr 2019 10:31:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190405015646.20672-1-caiosalvador96@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/5 9:56, Caio Salvador Rohwedder wrote:
> Fix checkpatch coding style errors on rtl819x_TSProc.c
> - space required before the open parenthesis '('
> - spaces required around that '=='
> 
> Signed-off-by: Caio Salvador Rohwedder <caiosalvador96@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
> index c76715ffa08b..0af1a87a5545 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
> @@ -373,7 +373,7 @@ bool GetTs(
>  			if(!list_empty(pUnusedList)) {
>  				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, list);
>  				list_del_init(&(*ppTS)->list);
> -				if(TxRxSelect==TX_DIR) {
> +				if (TxRxSelect == TX_DIR) {
>  					struct tx_ts_record *tmp = container_of(*ppTS, struct tx_ts_record, ts_common_info);

This line seems over 80 characters, may also be fixed.

In fact, this file has so many code style issues, see

./scripts/checkpatch.pl --no-tree -f drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c

>  					ResetTxTsEntry(tmp);
>  				} else {
> 

