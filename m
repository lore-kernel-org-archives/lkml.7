Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0021DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C325720835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCDChc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:37:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfCDChc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:37:32 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 135D16D3EB8914E326E8;
        Mon,  4 Mar 2019 10:37:30 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 10:37:23 +0800
CC:     <liuyu712@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, Yao Chen <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        songxiaowei <songxiaowei@hisilicon.com>,
        xu yiping <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Pengcheng Li <lpc.li@hisilicon.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v3 07/12] phy: Add usb phy support for hi3660 Soc of
 Hisilicon
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190302090505.65542-1-chenyu56@huawei.com>
 <20190302090505.65542-8-chenyu56@huawei.com>
 <CAHp75VeZWQ42eaGqwUJ6r=XebKRk=nJM9c+OFaKoOT+jXxkDHw@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <d17d12d1-0f72-9820-5f1d-bc29578e7a68@huawei.com>
Date:   Mon, 4 Mar 2019 10:37:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VeZWQ42eaGqwUJ6r=XebKRk=nJM9c+OFaKoOT+jXxkDHw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2019/3/2 23:56, Andy Shevchenko wrote:
> On Sat, Mar 2, 2019 at 11:06 AM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> This driver handles usb phy power on and shutdown for hi3660 Soc of
>> Hisilicon.
> 
> Few comments below. After fixing them, FWIW
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
>> +#define HI3660_USB_DEFAULT_PHY_PARAM           0x1c466e3
> 
> A bit of description would be nice to have what this value means.
> 
OK.
>> +       /* delay for exit from IDDQ mode */
>> +       usleep_range(100, 100);
> 
> 100,100 ? I think you need to give a room to scheduler, at least 20%
> margin would be good to have.
> 
>> +       /* delay for vbus valid */
>> +       usleep_range(100, 100);
> 
> Ditto.
> 
> 
OK.

Thanks
Yu Chen

