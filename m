Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F82C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DF820675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="irPtc4N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCFFIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 00:08:14 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35412 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCFFIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 00:08:14 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190306050809epoutp0447dc6045b4215b07400960fb32b6060f~JRlfNz7Iw0443004430epoutp04i
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 05:08:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190306050809epoutp0447dc6045b4215b07400960fb32b6060f~JRlfNz7Iw0443004430epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551848889;
        bh=IPS2Tk8BC8XcAYpYlK9XMOsA45NDB+trqHJFFvkD5mc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=irPtc4N1p929GWNyHJ5gJ88A2z33uAOu+yi5aS5Mhmfu3hFN49Q73JTAQLhU7y63B
         KndhgN2PiWnk2y3MGVW3olenJHKPpDTDR12kEtYX5ICgwpHoL3L1WJI4CjtP2aeID8
         f+1pgLIltn0voAgwnfdCNeX/a3LXUd21gCeYyisU=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190306050806epcas1p13a8a917a83523edede94ce669573586e~JRlcJq5YQ2834528345epcas1p1k;
        Wed,  6 Mar 2019 05:08:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.E6.04288.0B55F7C5; Wed,  6 Mar 2019 14:08:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190306050759epcas1p1f79758ce587634ac58d62ec47d7578ba~JRlWA1yeW1473214732epcas1p1u;
        Wed,  6 Mar 2019 05:07:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190306050759epsmtrp267d431c8f59b364527269edb9a92139a~JRlWAA-9J1050110501epsmtrp2B;
        Wed,  6 Mar 2019 05:07:59 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-c3-5c7f55b02b77
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.F1.03971.FA55F7C5; Wed,  6 Mar 2019 14:07:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190306050759epsmtip260fcb32d8803e3ce6fad67a107e89d94~JRlVtz-Vt0905509055epsmtip2i;
        Wed,  6 Mar 2019 05:07:59 +0000 (GMT)
Subject: Re: [PATCH v3 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
To:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <66c747db-0edf-456e-ac32-68b1dc6b8297@samsung.com>
Date:   Wed, 6 Mar 2019 14:07:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <81e492cc-80d5-c0f0-a6e2-522002913f5b@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmru6G0PoYg9ubOS16m6YzWbw5DiQO
        rlvKanF51xw2i9uNK9gcWD12zrrL7jHvZKDH+31X2Tz6tqxi9Pi8SS6ANSrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdot5JCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+P10mMsBRe4K5pP
        7GBtYFzA2cXIySEhYCIx5/4v9i5GLg4hgR2MEm8mXWeDcD4xSsxftQfK+cYoMb13MytMy5Jn
        q1kgEnsZJVa+WskK4bxnlPi4YD0zSJWwQJrE/lctbCC2iEC2xOI/pxlBbGaBJInT+y+DxdkE
        tCT2v7gBZvMLKEpc/fEYrIZXwE5iwtILLCA2i4CKRN/6n2AzRQUiJN4/3c0CUSMocXLmEzCb
        E6j+9MYdbBDzxSVuPZnPBGHLSzRvnc0McpyEwG02iZaGpywQL7hIrOq/ywxhC0u8Or6FHcKW
        kvj8bi8bhF0tsfLkETaI5g5GiS37L0D9byyxf+lkoA0cQBs0Jdbv0odYxifx7msPK0hYQoBX
        oqNNCKJaWeLyg7tMELakxOL2TqjxHhK37t1jnsCoOAvJO7OQvDALyQuzEJYtYGRZxSiWWlCc
        m55abFhgghzdmxjBCVPLYgfjnnM+hxgFOBiVeHgntNbFCLEmlhVX5h5ilOBgVhLhDXaojxHi
        TUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ+cBknlcSb2hqZGxsbGFiaGZqaKgkzrvewTlGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgZGpcLGRIl/Ig+41/zkWTI+7u6ei9LBZybvEHYJ9Ihpr9rDyHnm7
        Uftn1Lba4AZOsSmfeYoNJrr+vNfGvX6leLjg0dfHUiSdLK/Ex4dM/q4waZu3ZKG12Xwty5TL
        H5e+u+O/cDPPq5533VKVVXwfQh+z3U9wOsqvdV3yh2PziTcvtb543G+R2qLEUpyRaKjFXFSc
        CAD4+CP9rgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXnd9aH2Mwcm/kha9TdOZLN4cBxIH
        1y1ltbi8aw6bxe3GFWwOrB47Z91l95h3MtDj/b6rbB59W1YxenzeJBfAGsVlk5Kak1mWWqRv
        l8CV8XrpMZaCC9wVzSd2sDYwLuDsYuTkkBAwkVjybDVLFyMXh5DAbkaJvds2sUEkJCWmXTzK
        3MXIAWQLSxw+XAxR85ZRYt3t+YwgNcICaRL7X7WA1YsIZEssbr0LZjMLJEk8alrEBtGwl1Hi
        5qo7TCAJNgEtif0vboAV8QsoSlz98RhsEK+AncSEpRdYQGwWARWJvvU/mUFsUYEIibsXX7BA
        1AhKnJz5BMzmBKo/vXEH1DJ1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC
        0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw5Ghp7mC8vCT+EKMAB6MSD++E
        1roYIdbEsuLK3EOMEhzMSiK8wQ71MUK8KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8s
        Sc1OTS1ILYLJMnFwSjUw6ly2aJV9qs0WvOdJtJ/pixPd+3qfKFn/N/rDsM06diLb4yciX4Ij
        voeefX6fU9fP1suyRneaF8smZp9vC/94iEXYvwt6JGmnmlsivG1jmlqA2lfey12/TuQyOV6f
        bvwkyezV5MaV7EF9VZk/t6/k1pwqsE7GhT/a9PS2zgXLGpm6Sx+YSy9QYinOSDTUYi4qTgQA
        XsJMYJgCAAA=
X-CMS-MailID: 20190306050759epcas1p1f79758ce587634ac58d62ec47d7578ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190305192211epcas2p3f14be06074f7ccd310d1976fcd7fd12b
References: <20190303201613.19884-1-jekhor@gmail.com>
        <CGME20190305192211epcas2p3f14be06074f7ccd310d1976fcd7fd12b@epcas2p3.samsung.com>
        <81e492cc-80d5-c0f0-a6e2-522002913f5b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 3. 6. 오전 4:22, Hans de Goede wrote:
> Hi,
> 
> On 03-03-19 21:16, Yauhen Kharuzhy wrote:
>> At implementation of charging support for Lenovo Yoga Book (Intel Cherry
>> Trail based with Whiskey Cove PMIC), two pitfalls were found:
>>
>> - for detection of charger type by PMIC, bit 6 in the CHGRCTRL1 register
>>    should be set in 0 (and set to 1 for Host mode). Pick up its definition
>>    and logic from from Intel code drop[1];
>>
>> - "#CHARGE ENABLE" signal of external charger (bq25892) in Yoga Book is
>>    connected to one of PMIC outputs controlled by CHGDISCTRL register.
>>    Enable charging at driver initialization. Pick up this from Lenovo's code
>>    drop[2,3].
>>
>>
>> v3 changes:
>> - Don't restore of initial state of CHGDISCTRL and CHGRCTRL0 at exit but
>>    switch them into HW-controlled mode (as discussed in mailing list);
>> - Use regmap_update_bits() instead of regmap_readi()/regmap_write() in
>>    the cht_wc_extcon_set_otgmode();
>> - Coding style and constant names changed as Andy and Hans recommended.
> 
> Series looks good to me now, and I've also tested that it does not
> cause any charging or 5v boost related regressions on a GPD pocket
> laptop, so for the series:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
