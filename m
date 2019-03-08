Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCFDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B644620851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="H88o9g7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCHADv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:03:51 -0500
Received: from sonic304-25.consmr.mail.gq1.yahoo.com ([98.137.68.206]:33507
        "EHLO sonic304-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbfCHADt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1552003428; bh=pTk9jg8tKtz9gDaZTovaO7ioRq8KfVCHxt2a33PGA7c=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=H88o9g7tz8QudLljc5uTw2gV98GTPfMAtd0sdkxNcNmEL3Z19QYHgJyvzdjD/EfgpBNJt4HYr2JyboP8uD9uFZNF7tqYQWODDAhbmCponu+WDh7Ef4YLK2IFqIZtJEz2pfwwNd5mdcFWafTNI69eAhvD8FnCbFkSbvlUcBw35zY/YwXkE5m6Ze+GXoi/5ieLUgdFH7nL1SOJ7UXM6Vnd2/nvQuMkOJVvAfqDcuEoVQruEb3mdNtmSeP7g1pVzoKjEcygFz0G2uxPQiuP94YRDhgKSDNlvu+LP3OMd1eGBl+oSQUlzJBD8VFfRtppslW638pn1yjSWrP/ucv+pvYxsQ==
X-YMail-OSG: I4AaH5QVM1nWqecuv31MdxdDvJNEfc.SIhuP5PDL04m4NeffWj34WQ4tgUkX0pE
 B6ICbhxaSZ9j.SbAgaZzyGLa5u4xxThbYTUP0aWG7REzsYo7NyIMcstpDcLM.MQ_4Tp6uMZaAITq
 pUOZqsRxuVx11yFZ0zVCx_quFkRZzr54e54mzXQUF8RUcOFCx3CopfJ6ig8QUFx8ftvU8fFn5vmI
 xv0cN3I1KpQ1BSph7ilBre0ECsJhgd9bvfxaP6jVrEbkNbpAPnqQL.oeoGnjKpOVpvTtAQPX3d3m
 P4L4ZW0VLWB.YS6QSANSHQHL_wS5BP4tM24YLnCJKozgGbNU4WCxpmbocqZj.aqNxf7lBeyt2DoZ
 6ZgEhYV4e6XCoqQgwAY859ch17moaVlYmkPKWBiPjmOO5sK3I6vIEFugueH9CMozMC6x1tzn0MoI
 esdlmZxoIxZ5zaRSrEDjUMq7Z_IqbQYRwdTvfLna67yFh6td8gxfti9P_9h.aWHCj12Sv9OoDTM2
 HxuovR4kS_agBrWKYqHPtITG.DdyGS6swnTEeYZGJ2MzIyisp2N3YtOp9LB.oM4r1abPpljn76._
 RP5aAcB_w54w8lAD9uTsNryf3T3uNBFM.Qy3X1Oa2xWCyC4lfhzp73oRMNUJWGZiMV9t2h8qUGMl
 Ov9ksVeh16MnwMYqvJCL1oIKFrkyzNBK.tqaX4W._KIUswPqzMfALdHBFrEHmFP.Wr6UnbnAzd9F
 3HbDtjBWceXnNEYwZOE.iKrhISlF.MfVconhEckgbGA75QqfqoXzE1FkIF00Jb8ySsV10hNj9ZRq
 yGB4_lLgLp.3hpFc.pYua.KeSAFnGztS9ENtHeCasx02uXWL88gJY16ymImTLaUjI_Ac1vx5yt3k
 Sk31JOkbYe702IZ.v1NF9P2Sz_Yvt2qK_RFpWJFTfOHqB.yVCOGYrz7hLXQ4q_nkWdT88WxSf9FB
 .YEL2VHccVw5Z0TrAWu3aOxqLR..MOZjlHDF9ForwvipHzdF6fn2gOnvlq2_xpe3CCaKgePU3hVF
 I9.66Fys27JuhNmT462dUmFs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 8 Mar 2019 00:03:48 +0000
Received: from 36.24.171.113 (EHLO [192.168.199.149]) ([36.24.171.113])
          by smtp431.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d9329a980e37cd530ba7804660e51cc2;
          Fri, 08 Mar 2019 00:03:45 +0000 (UTC)
Subject: Re: [PATCH for-4.19] staging: erofs: fix mis-acted TAIL merging
 behavior
To:     Greg KH <greg@kroah.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Sasha Levin <sashal@kernel.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20190301212203.5FE0C2084F@mail.kernel.org>
 <20190307053404.29108-1-gaoxiang25@huawei.com>
 <20190307122539.GD21325@kroah.com>
 <5b7e1914-f8e5-da3d-4492-17d6afc00fb1@huawei.com>
 <20190307152147.GA24453@kroah.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <3110c661-ceae-2014-c5eb-50aa72e9b087@aol.com>
Date:   Fri, 8 Mar 2019 08:03:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307152147.GA24453@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/7 23:21, Greg KH wrote:
> On Thu, Mar 07, 2019 at 09:04:06PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2019/3/7 20:25, Greg KH wrote:
>>> On Thu, Mar 07, 2019 at 01:34:04PM +0800, Gao Xiang wrote:
>>>> commit a112152f6f3a2a88caa6f414d540bd49e406af60 upstream.
>>>>
>>>> EROFS has an optimized path called TAIL merging, which is designed
>>>> to merge multiple reads and the corresponding decompressions into
>>>> one if these requests read continuous pages almost at the same time.
>>>>
>>>> In general, it behaves as follows:
>>>>  ________________________________________________________________
>>>>   ... |  TAIL  .  HEAD  |  PAGE  |  PAGE  |  TAIL    . HEAD | ...
>>>>  _____|_combined page A_|________|________|_combined page B_|____
>>>>         1  ]  ->  [  2                          ]  ->  [ 3
>>>> If the above three reads are requested in the order 1-2-3, it will
>>>> generate a large work chain rather than 3 individual work chains
>>>> to reduce scheduling overhead and boost up sequential read.
>>>>
>>>> However, if Read 2 is processed slightly earlier than Read 1,
>>>> currently it still generates 2 individual work chains (chain 1, 2)
>>>> but it does in-place decompression for combined page A, moreover,
>>>> if chain 2 decompresses ahead of chain 1, it will be a race and
>>>> lead to corrupted decompressed page. This patch fixes it.
>>>>
>>>> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
>>>> Cc: <stable@vger.kernel.org> # 4.19+
>>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  drivers/staging/erofs/unzip_vle.c | 69 +++++++++++++++++++++++++--------------
>>>>  1 file changed, 44 insertions(+), 25 deletions(-)
>>>>
>>>
>>> thanks for the backport, now applied.
>>
>> Yes, it seems that Sasha's bot cannot cherry-pick it directly,
>> therefore I made this patch for 4.19 by hand...
>>
>> BTW, there is another patch called "staging: erofs: compressed_pages should not be accessed again after freed"
>> in the same condition... And I also send 4.19 and 4.20 version to stable mailing list,
>> could you also kindly check them out?
> 
> Yes, please give me a chance to catch up on stable pending patches to
> process:
> 
> 	$ mdfrm -c ~/mail/stable/
> 	585 messages in /home/gregkh/mail/stable/
> 
> You are in good company :)

Thanks for taking time.
I received more reports which shows some 5.1-rc patches are failed to be applied,
I will backport them later. :)

Thanks,
Gao Xiang

> 
> greg k-h
> 
