Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EDC21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfLSCGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:06:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSCGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 21:06:37 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 438F537EFDE5E5790483;
        Thu, 19 Dec 2019 10:06:35 +0800 (CST)
Received: from [127.0.0.1] (10.67.103.228) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 10:06:20 +0800
Subject: Re: [PATCH v3] net: hisilicon: Fix a BUG trigered by wrong
 bytes_compl
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
References: <1576635093-60466-1-git-send-email-xiaojiangfeng@huawei.com>
 <20191218093750.2c9f1aa1@cakuba.netronome.com>
CC:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <zhangfei.gao@linaro.org>,
        <arnd@arndb.de>, <dingtianhong@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leeyou.li@huawei.com>, <nixiaoming@huawei.com>
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <3e7db503-993d-fbc9-d4cf-e05a39d5cb7a@huawei.com>
Date:   Thu, 19 Dec 2019 10:06:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191218093750.2c9f1aa1@cakuba.netronome.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/19 1:37, Jakub Kicinski wrote:
> On Wed, 18 Dec 2019 10:11:33 +0800, Jiangfeng Xiao wrote:
>> Fixes: a41ea46a9 ("net: hisilicon: new hip04 ethernet driver")
> 
> Thanks for providing the fixes tag, for quoting commits please always
> use 12 characters of the hash.
> 
Thanks for your guidance. I will fix this in v4.

