Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C608CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9526D20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Re3hZz0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDAMy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:54:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35723 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfDAMy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:54:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401125455euoutp011dcb4a78622e9c7e4d5369e5afa9a0b5~RWucZaK7I0822208222euoutp01c
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 12:54:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401125455euoutp011dcb4a78622e9c7e4d5369e5afa9a0b5~RWucZaK7I0822208222euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554123295;
        bh=iEongVj9yFOR4U+ZK1GEMPlhcu82DAAZ2RUBrK1irho=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Re3hZz0JDqMAt2TD8ZM5uJoMbxkBc7KzWaqSiy6ZR9qQm6IYZhdQbWZLjCseZ+3yF
         w1wyV+gg9OtScJGSOOYLj4a+ViNc78Mfe/Ppw8K6NqBDR7L+ZJ+ksSLAICD1GzLWeW
         JtqxvULh3QxTVMDFmb5Qja9UjN5hxRpnDvhg5m2Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401125454eucas1p2fed457f603ada165168000126f29c758~RWubeHGdd1974519745eucas1p2z;
        Mon,  1 Apr 2019 12:54:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D5.5A.04325.D1A02AC5; Mon,  1
        Apr 2019 13:54:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401125453eucas1p220e854bae54dc81b812f450cf82c2c2f~RWuanG-Fv2169821698eucas1p2x;
        Mon,  1 Apr 2019 12:54:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190401125452eusmtrp16a3a8163760118a9b0af661e4d86f021~RWuaZHMMy1063310633eusmtrp1C;
        Mon,  1 Apr 2019 12:54:52 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-f4-5ca20a1df1e4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.71.04146.C1A02AC5; Mon,  1
        Apr 2019 13:54:52 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401125452eusmtip2e70bf6a5f386f0317d05e1147253800f~RWuaBdyZ51677716777eusmtip23;
        Mon,  1 Apr 2019 12:54:52 +0000 (GMT)
Subject: Re: [PATCH] xen, fbfront: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xen-devel <xen-devel@lists.xenproject.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7bda7932-6af9-3422-c56d-983b565b3290@samsung.com>
Date:   Mon, 1 Apr 2019 14:54:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <ca45f983-9a42-6326-3c9a-5e239ddc4e46@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87qyXItiDO7u0bVY+/Eti8WVr+/Z
        LLbuUbU4051rcaLvA6vF5V1z2Cy+b5nM5MDuMbvhIovHuoOqHjtn3WX3uN99nMnj8IcrLB6f
        N8kFsEVx2aSk5mSWpRbp2yVwZWw7coi54BFTxeNXl9kaGCcwdTFycEgImEjcvGnSxcjFISSw
        glHi/+EpTBDOF0aJW9tmsUA4nxklTi6ZyN7FyAnWcfXPXTaIxHJGiQ2fd7NDOG8ZJSYe3M8K
        UiUs4CJx5Mp7FhBbRMBIYvaMblaQImaBh4wSHecnMoMk2ASsJCa2r2IEOYRXwE7i6d8kkDCL
        gIrEuVt/WEDCogIREv1n1EHCvAKCEidnPgEbySlgLzF591KwVcwC8hLb385hBhkvIbCKXaJr
        0hZmiEtdJBYc+ckEYQtLvDq+BeoDGYnTk3tYIBrWMUr87XgB1b2dUWL55H9sEFXWEoePX2QF
        uYJZQFNi/S59iLCjxOIJM6CBxydx460gxBF8EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpVQ
        p3lILFz9nm0Co+IsJK/NQvLOLIS9CxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgSm
        m9P/jn/dwbjvT9IhRgEORiUe3gqmhTFCrIllxZW5hxglOJiVRHjP9C+IEeJNSaysSi3Kjy8q
        zUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cCo5bDyWb1i86W7N/SDfmhH69Sm
        ccoeLjvxfkW65O7vDpMLdObcE78fUOhU5y38+k7xzM9H5+sX6dx9EfUg/crj3G2MNye0XJvP
        aHaVQ5Jp9YNTtz/rJH5+2a2vlp0+bf/TqXsfGje57r9fnDl/+uT3i44rfJsv8efVLs0S7tmu
        xsoid8MFT/02VGIpzkg01GIuKk4EANi5J1czAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7oyXItiDJo6DS3WfnzLYnHl63s2
        i617VC3OdOdanOj7wGpxedccNovvWyYzObB7zG64yOKx7qCqx85Zd9k97ncfZ/I4/OEKi8fn
        TXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6
        GduOHGIueMRU8fjVZbYGxglMXYycHBICJhJX/9xl62Lk4hASWMoocezaLdYuRg6ghIzE8fVl
        EDXCEn+udUHVvGaUWLHhKCtIQljAReLIlfcsILaIgJHE7BndYHEhgUVMEs09tiANzAIPGSUO
        7lvLDpJgE7CSmNi+ihFkAa+AncTTv0kgYRYBFYlzt/6AzREViJC49bADzOYVEJQ4OfMJmM0p
        YC8xefdSsPnMAuoSf+ZdYoaw5SW2v53DPIFRcBaSlllIymYhKVvAyLyKUSS1tDg3PbfYUK84
        Mbe4NC9dLzk/dxMjMI62Hfu5eQfjpY3BhxgFOBiVeHgrmBbGCLEmlhVX5h5ilOBgVhLhPdO/
        IEaINyWxsiq1KD++qDQntfgQoynQExOZpUST84ExnlcSb2hqaG5haWhubG5sZqEkznveoDJK
        SCA9sSQ1OzW1ILUIpo+Jg1OqgTHzoJFD6/aKoPkXDU4s0D+mpe2lJPjr3yKODNF7ZckTguv/
        rfuQW5z/L8kj+pKd2PUvCpPUtj2SPMmpabLc8cj8zQVz3rmpPKv+klrPKhnIIKQUXasxNfRs
        uYG8ya2/mexZ6/dUb3m4VkpinWV85GJVpaTcqd+4GFIn1a3LvuSf982rcubWt0osxRmJhlrM
        RcWJAGgiX8q5AgAA
X-CMS-MailID: 20190401125453eucas1p220e854bae54dc81b812f450cf82c2c2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190320200813epcas3p20887ed1e3e3f1542f67f0b664f777a8c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190320200813epcas3p20887ed1e3e3f1542f67f0b664f777a8c
References: <20190227205303.GA1231@embeddedor>
        <f8ff03de-9d7c-233a-cd86-37269667db0c@gmail.com>
        <CGME20190320200813epcas3p20887ed1e3e3f1542f67f0b664f777a8c@epcas3p2.samsung.com>
        <6675f2ed-6916-2be5-fb60-39c9436f53f7@embeddedor.com>
        <ca45f983-9a42-6326-3c9a-5e239ddc4e46@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/21/2019 12:03 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On 03/20/2019 09:08 PM, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping:
>>
>> Who can take this?
> 
> I'll take this for v5.2.

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
