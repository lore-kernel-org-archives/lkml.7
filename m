Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF41C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF7220879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OcrOtKYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfCRKIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:08:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:64603 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfCRKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:08:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190318100809epoutp042be2a13bbce0460769bf80a1c53976d7~NBa15p7IH0506205062epoutp04j;
        Mon, 18 Mar 2019 10:08:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190318100809epoutp042be2a13bbce0460769bf80a1c53976d7~NBa15p7IH0506205062epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552903689;
        bh=fiThL1Y11fyQdiY7/DpqTvb0WisTIffM0l2ZRE/FwCY=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=OcrOtKYl2nqDdx/RQAewkyY02wZnnHDnDaJ5CIQSZ/XlLu3XitqN1Qqqxthi7SLBi
         +7Jm58uXnEQ8hDFsBPauUo11+qrH+dfcCnD/Co+fgX+y/NaXeVDEOgooL2kA2xWOXo
         kzR6N6vWidSRMxmNo3O1Hvd1fkXIaHimMRKY2vec=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190318100808epcas1p39be17f1ff8c3cb9169066ca4493bba6c~NBa1fY-ZE0496704967epcas1p3F;
        Mon, 18 Mar 2019 10:08:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.EE.04143.80E6F8C5; Mon, 18 Mar 2019 19:08:08 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190318100808epcas1p4e571b1ed461506b1037bd277e29ec07e~NBa1L8GxY2314623146epcas1p4O;
        Mon, 18 Mar 2019 10:08:08 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-59-5c8f6e082d33
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 74.A7.03598.80E6F8C5; Mon, 18 Mar
        2019 19:08:08 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0POK000FI45H1280@mmp2.samsung.com>; Mon, 18 Mar 2019 19:08:08 +0900 (KST)
Subject: Re: linux-next: Fixes tag needs some work in the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <7d368c6e-3816-14fb-da32-2aeb9c076db6@samsung.com>
Date:   Mon, 18 Mar 2019 11:08:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-version: 1.0
In-reply-to: <20190317122851.2cf734bf@canb.auug.org.au>
Content-type: text/plain; charset="windows-1252"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCmri5HXn+MwbR7ahZTHz5hs/h2pYPJ
        4vKuOWwWBxe2MVps3XuV3YHVo/HGDTaPnbPusntsWtXJ5vF5k1wASxSXTUpqTmZZapG+XQJX
        xqP72QUr+Cpav59lbGD8xtXFyMkhIWAi0bBkPVMXIxeHkMAORolrT06zgySEBL4zSmz+JAZT
        9KP3PSNE0QZGibNrfzBDOPcZJR6eeAHWISzgKXHuwDe2LkYODhGBYolfjxVAwswCJRKfVu9m
        BbHZBAwleo/2MYLYvAJ2Eh/mL2MBsVkEVCU+TbsEZosKREi8f7qbBaJGUOLH5HtgNqeAucTs
        izOZIGYaSMyYchjKFpc4dv8mI4QtL7F5zVuw2yQEdrBJHHi/ngniAxeJ+T8PM4PcJiEgLXHp
        qC1ETTOjxI7n19ghnAmMEhPmTGaDaLCWOHz8IivEVD6Jd197WCGaeSU62oQgSjwk9r57yQIJ
        iC5Gie4Zx9gnMMrMQnL4LCTHzkJy7Cwkxy5gZFnFKJZaUJybnlpsWGCsV5yYW1yal66XnJ+7
        iRGcBLTMdzBuOOdziFGAg1GJh/fGtL4YIdbEsuLK3EOMEhzMSiK89p79MUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR51zs4xwgJpCeWpGanphakFsFkmTg4pRoY06fui71bschLxlrPqe/8zuvy
        jHe+sC7T4p94P2aHz5251c9+Lp3iea1Xa5v0K4/lDQqsgU4dYS4HU99Z52tn/Fkc67zjb+zq
        bTa/jwVdXSRwM87jjcDrrdd/vFrG92jO6qeVVtOmScz11as1erp8TpX1D7EFYdt65XZpKUh+
        fNx4q1GH1+3ATiWW4oxEQy3mouJEABnHaIj+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t9jQV2OvP4Yg0cLRC2mPnzCZvHtSgeT
        xeVdc9gsDi5sY7TYuvcquwOrR+ONG2weO2fdZffYtKqTzePzJrkAligum5TUnMyy1CJ9uwSu
        jEf3swtW8FW0fj/L2MD4jauLkZNDQsBE4kfve8YuRi4OIYF1jBKHV/ZDOQ8ZJSb/2c8KUiUs
        4Clx7sA3NhBbRKBY4sCCC+wgNrNAicS0GTtZIRp6GCW2nd8MlmATMJToPdrHCGLzCthJfJi/
        jAXEZhFQlfg07RKYLSoQIXH34gsWiBpBiR+T74HZnALmErMvzmTqYuQAWqAncf+iFsQucYlj
        928yQtjyEpvXvGWewCgwC0n3LISOWUg6ZiHpWMDIsopRMrWgODc9t9iowDAvtVyvODG3uDQv
        XS85P3cTIzDItx3W6tvBeH9J/CFGAQ5GJR7ehil9MUKsiWXFlbmHGCU4mJVEeO09+2OEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYHQw53rYeN7v++PS
        62LxZ/49rjbPNhGcqHMyrnjyEgON8/yny8tnP8hsuTnBTvQx917LX6bWR8Nevdvk27b9kO9R
        p7/1tqIrzplXbv637m/oQwGJvKdcsjHeEzVcw4SWtgZNvR+2V8Pm+Il3k5rrZn7km66zk03s
        5on2nAuHbvumfJ6+Ifz7vrdKLMUZiYZazEXFiQAUtG3mbgIAAA==
X-CMS-MailID: 20190318100808epcas1p4e571b1ed461506b1037bd277e29ec07e
CMS-TYPE: 101P
X-CMS-RootMailID: 20190317012907epcas3p129240b3dcef7d974c2fea23c26a76f2a
References: <CGME20190317012907epcas3p129240b3dcef7d974c2fea23c26a76f2a@epcas3p1.samsung.com>
        <20190317122851.2cf734bf@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/19 02:28, Stephen Rothwell wrote:
> In commit
> 
>   2b13bee38849 ("ASoC: samsung: odroid: Fix clock configuration for 44100 sample rate")
> 
> Fixes tag
> 
>   Fixes: fbeec965b8d1c ("ASoC: samsung: odroid: Fix 32000 sample rate handling")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean:
> 
>   1d22c337dc8f ("ASoC: samsung: odroid: Fix 32000 sample rate handling"


Yes, I unfortunately used erroneously hash from this -stable commit:
 

commit fbeec965b8d1ca4005f2b63f70fd6ed54a147027
Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date:   Wed Mar 14 17:41:13 2018 +0100

    ASoC: samsung: odroid: Fix 32000 sample rate handling
    
    [ Upstream commit 1d22c337dc8f3a25638f7262e7bcb5729a34d140 ]
    
    In case of sample rates lower than 44100 currently there is too low MCLK
    frequency set for the CODEC. Playback fails with following errors:
    
    $ speaker-test -c2 -t sine -f 1500 -l2 -r 32000
    
    Sine wave rate is 1500.0000Hz
    Rate set to 32000Hz (requested 32000Hz)
    Buffer size range from 128 to 131072
    Period size range from 64 to 65536
    Using max buffer size 131072
    Periods = 4
    Unable to set hw params for playback: Invalid argument
    Setting of hwparams failed: Invalid argument
    
    [  497.883700] max98090 1-0010: Invalid master clock frequency
    
    To fix this the I2S root clock's frequency is increased, depending
    on sampling rate.
    
    Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
    Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>
    Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


-- 
Thanks,
Sylwester
