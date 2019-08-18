Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF91C3A59F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 13:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA9D2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566134236;
	bh=EHAg19dhuoUw2RPhHf/01UOmpOQq9u8V/sPWJh9P9hk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=F0jTG27/cbKqCEu2/ZpoJGsSe+hYCQkr6W/HCZh9l/moj1sF0fcYP7ppavprdZ8pA
	 hf8o8Nm7RiCSdl7dEegCfAImv3zWA23uBD2+BxYNxoqiF9dI+ltI3jdmKSQWPumLVG
	 0EAxLb8B37JCVBMqC6+3fW8oRSR10M1pWNV5tjvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfHRNRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 09:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRNRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 09:17:12 -0400
Received: from [192.168.0.101] (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6765C20673;
        Sun, 18 Aug 2019 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566134232;
        bh=EHAg19dhuoUw2RPhHf/01UOmpOQq9u8V/sPWJh9P9hk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p2XTujf78t56CPTrbS/mPW6FtvPSuulqBnBLybpc47xapTQsH7RHTZNEh5x9Hs3WY
         bdhzAJdyXH/ZTbYGePHEJR7izYevxiOfdnS/3HAjoG8JqTIh4E6c5Z3CCcXUPcBjjZ
         fpILNq8whh9b+0a+7i80xIqSt1pqAEnYExspt+8s=
Subject: Re: [PATCH] staging: erofs: refuse to mount images with malformed
 volume name
To:     Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
References: <20190818102824.22330-1-hsiangkao@aol.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <d8bca74f-62db-29c2-1165-48b491ad4118@kernel.org>
Date:   Sun, 18 Aug 2019 21:17:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190818102824.22330-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-8-18 18:28, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> As Richard reminder [1], A valid volume name should be
> ended in NIL terminator within the length of volume_name.
> 
> Since this field currently isn't really used, let's fix
> it to avoid potential bugs in the future.
> 
> [1] https://lore.kernel.org/r/1133002215.69049.1566119033047.JavaMail.zimbra@nod.at/
> 
> Reported-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
