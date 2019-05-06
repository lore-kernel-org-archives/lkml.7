Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D513C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C692F206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k0jb0a3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfEFNgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:36:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48688 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:36:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506133647euoutp0235c75aac46a0e414607cc3effa00dda7~cG3-qeX1D1221512215euoutp02F
        for <linux-kernel@vger.kernel.org>; Mon,  6 May 2019 13:36:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506133647euoutp0235c75aac46a0e414607cc3effa00dda7~cG3-qeX1D1221512215euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557149807;
        bh=mpzfjPxjilDGHHTfSGCPPOE2d5TMe4FioI4bwbCKZKM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=k0jb0a3jdVNvB97ioEkUQyu2CUAewOOyuQE6gox++Os4uPaotPrJgw/+AC5tCRSi7
         MFYpPFeGGtSblbim93y8RJu1IL8ZIKfa8WGV9I77nsWIrb9/UdmMG9F+BbuG2jNJQJ
         qnCrxOWVdajf229bnzGSmgSZVOg8ojRFomL5eo3E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190506133646eucas1p1da9c632aad85f681acd4466a7eaf21ca~cG3__AKpo1913119131eucas1p1q;
        Mon,  6 May 2019 13:36:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CC.56.04325.E6830DC5; Mon,  6
        May 2019 14:36:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506133645eucas1p28ec8b11ad9d2109d92029b86b1c29425~cG3_J9sMq2088420884eucas1p2j;
        Mon,  6 May 2019 13:36:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190506133645eusmtrp1e94c412f27e99463b1b2e3ba16cc394e~cG3978Zl91095910959eusmtrp1P;
        Mon,  6 May 2019 13:36:45 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-ff-5cd0386e7615
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 60.60.04140.D6830DC5; Mon,  6
        May 2019 14:36:45 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506133645eusmtip1ddfc37e0a733b13cd9062236dd513ee0~cG39kQvWY0999109991eusmtip1V;
        Mon,  6 May 2019 13:36:45 +0000 (GMT)
Subject: Re: [PATCH 13/57] docs: fb: convert documentation to ReST format
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ff3ed615-ba13-37d7-7c5f-583161e91adc@samsung.com>
Date:   Mon, 6 May 2019 15:36:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <f282cbd57dcee9d598c13d8b1e4ea4cc1459b8ad.1555382110.git.mchehab+samsung@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7p5FhdiDN7uFLZ4cqCd0eLK1/ds
        FgvblrBYnOj7wGpxedccNov3nzqZLHacWsTswO6xeYWWx6ZVnWwe97uPM3ks7pvM6vF5k1wA
        axSXTUpqTmZZapG+XQJXxpM1P9gLVjNX/Hoxka2B8QlTFyMnh4SAicS0Z73MXYxcHEICKxgl
        nv47xwbhfGGU+HR0FSOE85lRYseWiewwLf0Ni9khEssZJfZ3XILqf8so8fzoMmaQKmEBT4n/
        R5+C2SICZhInzx0Fm8ss8JJRYvmpP6wgCTYBK4mJ7SA7ODl4BewkPm84ABZnEVCRuPl3I1AD
        B4eoQIRE/xl1iBJBiZMzn7CA2JwCiRKNHXvBypkF5CW2v50DdoSEwDJ2ieOfu1khTnWRuPG8
        nQXCFpZ4dXwL1AsyEqcn97BANKxjlPjb8QKqezvQdZP/sUFUWUscPn6RFeQKZgFNifW79CHC
        jhKN1x8xg4QlBPgkbrwVhDiCT2LStulQYV6JjjYhiGo1iQ3LNrDBrO3auZIZwvaQeLmzn2UC
        o+IsJK/NQvLOLIS9CxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmm9P/jn/dwbjv
        T9IhRgEORiUeXg+l8zFCrIllxZW5hxglOJiVRHgTn52LEeJNSaysSi3Kjy8qzUktPsQozcGi
        JM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cA4j/Ptw7o/b9NmpUv1pcafORsutzvxybe+O8sy
        Y5rnKb82CnioZMq0JeCi/9OpUyzWnpy6kHEZ2zsW/o91p7LWz5ibdfIe1+85Yiv548t1N9Wt
        F1uaNHO6r/a1ksyz1vMuvjabkty1IfNfTvsR68S6Rbf9cx/LTLjCxNPPWjST6dHejMq+DVNX
        KbEUZyQaajEXFScCAMySGdgyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7q5FhdiDO4/lbJ4cqCd0eLK1/ds
        FgvblrBYnOj7wGpxedccNov3nzqZLHacWsTswO6xeYWWx6ZVnWwe97uPM3ks7pvM6vF5k1wA
        a5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexpM1
        P9gLVjNX/Hoxka2B8QlTFyMnh4SAiUR/w2L2LkYuDiGBpYwS3zcvBEpwACVkJI6vL4OoEZb4
        c62LDaLmNaNEV+deRpCEsICnxP+jT5lBbBEBM4mT546ygdhCAi8YJXouiYI0MAu8ZJTY2LSe
        FSTBJmAlMbF9FVgzr4CdxOcNB8DiLAIqEjf/bgRrFhWIkLj1sIMFokZQ4uTMJ2A2p0CiRGPH
        XrB6ZgF1iT/zLjFD2PIS29/OYZ7AKDgLScssJGWzkJQtYGRexSiSWlqcm55bbKRXnJhbXJqX
        rpecn7uJERhD24793LKDsetd8CFGAQ5GJR5eD6XzMUKsiWXFlbmHGCU4mJVEeBOfnYsR4k1J
        rKxKLcqPLyrNSS0+xGgK9MREZinR5HxgfOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJ
        zU5NLUgtgulj4uCUamDcvGjDgivG0zSMf0Vul1jaEd+4PcD7+t7zZy86HLu3YdGS5rXskbEz
        bq7RbdHdZKC/ZKPiAYPExNzlQnNmVYmucnVxLE+LL/93xISr5LKPYtVB3xuvT0bV79Hy7V/P
        Vehk+0x3u8C8F6zO9TtdH3xPjJ2/MnfS5lvum5nzdYt29YpGW8TMsG1RYinOSDTUYi4qTgQA
        SqZNebcCAAA=
X-CMS-MailID: 20190506133645eucas1p28ec8b11ad9d2109d92029b86b1c29425
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190416025636epcas4p2b3bd395b2673bffb3cc0cbdd211aa841
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190416025636epcas4p2b3bd395b2673bffb3cc0cbdd211aa841
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <CGME20190416025636epcas4p2b3bd395b2673bffb3cc0cbdd211aa841@epcas4p2.samsung.com>
        <f282cbd57dcee9d598c13d8b1e4ea4cc1459b8ad.1555382110.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/16/2019 04:55 AM, Mauro Carvalho Chehab wrote:
> Convert all documents here from plain txt to ReST format, in
> order to allow parsing them with the documentation build
> system.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
