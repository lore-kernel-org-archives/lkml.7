Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC950C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3D120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCDG6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:58:11 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:30822 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725981AbfCDG6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:58:11 -0500
X-UUID: 873b889c21174a91b57c226523e36ca3-20190304
X-UUID: 873b889c21174a91b57c226523e36ca3-20190304
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1125917710; Mon, 04 Mar 2019 14:58:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 4 Mar
 2019 14:58:05 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 4 Mar 2019 14:58:04 +0800
Message-ID: <1551682684.2210.67.camel@mhfsdcap03>
Subject: Re: [PATCH v3 10/12] hikey960: Support usb functionality of Hikey960
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Yu Chen <chenyu56@huawei.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        "Yao Chen" <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, songxiaowei <songxiaowei@hisilicon.com>,
        xu yiping <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Mon, 4 Mar 2019 14:58:04 +0800
In-Reply-To: <CAHp75Vdkp40e5-Bv+LnLBxgPkTDJ0FA1ooq+C4-do=4k5prTiQ@mail.gmail.com>
References: <20190302090505.65542-1-chenyu56@huawei.com>
         <20190302090505.65542-11-chenyu56@huawei.com>
         <1551664069.2210.64.camel@mhfsdcap03>
         <CAHp75Vdkp40e5-Bv+LnLBxgPkTDJ0FA1ooq+C4-do=4k5prTiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Mon, 2019-03-04 at 08:50 +0200, Andy Shevchenko wrote:
> On Mon, Mar 4, 2019 at 3:47 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > On Sat, 2019-03-02 at 17:05 +0800, Yu Chen wrote:
> 
> > > +     hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
> > > +     if (!hisi_hikey_usb->role_sw)
> > > +             return -EPROBE_DEFER;
> > Here return EPROBE_DEFFER means the related device_connection is
> > registered after this probe is called, right?
> > if not, use IS_ERR_OR_NULL then return PTR_ERR is enough
> 
> How enough? If return value is NULL it would be transformered to 0,
> which is success return code from the ->probe() which means we will
> have ->probed() and not functional device.
> 
You are right:)

> Am I missing something?
> 


