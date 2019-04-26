Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B083C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27112206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfDZJrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:47:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfDZJrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:47:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B588315C5260A7BA587D;
        Fri, 26 Apr 2019 17:47:09 +0800 (CST)
Received: from [127.0.0.1] (10.65.91.35) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Apr 2019
 17:47:01 +0800
Subject: Re: [PATCH topic-hns-5.1 0/3] {topost} net: hns3: add support for mac
 autoneg and FEC enconding control
From:   "shenjian (K)" <shenjian15@huawei.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1556271763-24142-1-git-send-email-shenjian15@huawei.com>
Message-ID: <a646e3f8-5883-9445-eeb5-045416f3d6a2@huawei.com>
Date:   Fri, 26 Apr 2019 17:47:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1556271763-24142-1-git-send-email-shenjian15@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.65.91.35]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, please ignore this patchset.

ÔÚ 2019/4/26 17:42, Jian Shen Ð´µÀ:
> This patchset introduce multiple media type, autoneg, FEC encoding control
> for fibre port.
> 
> Jian Shen (3):
>   {topost} net: hns3: add support for multiple media type
>   {topost} net: hns3: add autoneg and change speed support for fibre
>     port
>   {topost} net: hns3: add support for FEC encoding control
> 
>  drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  37 +++-
>  drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 101 ++++++++-
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  30 ++-
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 233 +++++++++++++++++----
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  11 +-
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   7 +-
>  .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  14 +-
>  .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
>  8 files changed, 364 insertions(+), 70 deletions(-)
> 

