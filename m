Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB3D20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCDB1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:27:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbfCDB1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:27:24 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 60058E539DEC465AAAC1;
        Mon,  4 Mar 2019 09:27:22 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 09:27:14 +0800
CC:     <liuyu712@hisilicon.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "Zhuangluan Su" <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>,
        Li Pengcheng <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, YiPing Xu <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        Zang Leigang <zangleigang@hisilicon.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 10/12] hikey960: Support usb functionality of Hikey960
To:     John Stultz <john.stultz@linaro.org>
References: <20190302090505.65542-1-chenyu56@huawei.com>
 <20190302090505.65542-11-chenyu56@huawei.com>
 <CALAqxLVSiWB-HRJWd-aBWNZ-u3JpK4WVR84DSEKRNV1Kzom8pg@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <7069e483-8dbb-d0ed-dfe6-50e427574b9c@huawei.com>
Date:   Mon, 4 Mar 2019 09:27:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CALAqxLVSiWB-HRJWd-aBWNZ-u3JpK4WVR84DSEKRNV1Kzom8pg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/4 4:17, John Stultz wrote:
> On Sat, Mar 2, 2019 at 4:05 AM Yu Chen <chenyu56@huawei.com> wrote:
>> +static int hisi_hikey_usb_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *root = dev->of_node;
> 
> Minor nit: root is unused and generates build warnings.
> 
OK. Thanks!

> thanks
> -john
> 
> .
> 

Thanks
Yu Chen

