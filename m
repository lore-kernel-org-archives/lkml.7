Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055FFCA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C4021835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfJ2BZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:25:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728754AbfJ2BZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:25:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3800B9EF4580E136FF24;
        Tue, 29 Oct 2019 09:25:17 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 09:25:15 +0800
Message-ID: <5DB794FB.4010203@huawei.com>
Date:   Tue, 29 Oct 2019 09:25:15 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8723bs: remove an redundant null check before
 kfree()
References: <1571211506-19005-1-git-send-email-zhongjiang@huawei.com> <20191025024216.GB331827@kroah.com> <5DB711AE.1040904@huawei.com> <20191028162434.GB321492@kroah.com>
In-Reply-To: <20191028162434.GB321492@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/29 0:24, Greg KH wrote:
> On Tue, Oct 29, 2019 at 12:05:02AM +0800, zhong jiang wrote:
>> On 2019/10/25 10:42, Greg KH wrote:
>>> On Wed, Oct 16, 2019 at 03:38:26PM +0800, zhong jiang wrote:
>>>> kfree() has taken null pointer into account. hence it is safe to remove
>>>> the unnecessary check.
>>>>
>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>>> ---
>>>>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
>>>> index 7011c2a..4597f4f 100644
>>>> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
>>>> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
>>>> @@ -2210,8 +2210,7 @@ void rtw_free_hwxmits(struct adapter *padapter)
>>>>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
>>>>  
>>>>  	hwxmits = pxmitpriv->hwxmits;
>>>> -	if (hwxmits)
>>>> -		kfree(hwxmits);
>>>> +	kfree(hwxmits);
>>>>  }
>>>>  
>>>>  void rtw_init_hwxmits(struct hw_xmit *phwxmit, sint entry)
>>>> -- 
>>>> 1.7.12.4
>>>>
>>> Patch does not apply to my tree :(
>>>
>>> .
>>>
>> Greg,  Could you apply the patch to your  tree ?
> It did not apply, so what do you want me to do with it?
>
> confused,
Could you  receive the patch ? :-)

Thanks,
zhong jiang
> greg k-h
>
> .
>


