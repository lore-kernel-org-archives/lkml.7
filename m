Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2472CC04AB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007D3206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfFGA3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 20:29:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfFGA3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:29:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2BC7CB80D7F8379151E0;
        Fri,  7 Jun 2019 08:29:17 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Jun 2019
 08:29:08 +0800
Subject: Re: [PATCH net-next 01/12] net: hns3: log detail error info of ROCEE
 ECC and AXI errors
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <tanxiaofei@huawei.com>
References: <1559809267-53805-1-git-send-email-tanhuazhong@huawei.com>
 <1559809267-53805-2-git-send-email-tanhuazhong@huawei.com>
 <20190606.103621.340824426867229259.davem@davemloft.net>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <705efc0c-eada-98d0-d6a8-b92eca0f09f9@huawei.com>
Date:   Fri, 7 Jun 2019 08:29:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190606.103621.340824426867229259.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/7 1:36, David Miller wrote:
> From: Huazhong Tan <tanhuazhong@huawei.com>
> Date: Thu, 6 Jun 2019 16:20:56 +0800
> 
>> +static int hclge_log_rocee_axi_error(struct hclge_dev *hdev)
>> +{
>   ...
>> +	ret = hclge_cmd_send(&hdev->hw, &desc[0], 3);
>> +	if (ret) {
>> +		dev_err(dev, "failed(%d) to query ROCEE AXI error sts\n", ret);
>> +		return ret;
>> +	}
>   ...
>> +		ret = hclge_log_rocee_axi_error(hdev);
>> +		if (ret) {
>> +			dev_err(dev, "failed(%d) to process axi error\n", ret);
> 
> You log the error twice which is unnecessary.
> 

ok, thanks.

> .
> 

