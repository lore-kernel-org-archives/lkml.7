Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83737C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE7321907
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M0Ta3ELW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408970AbfITM2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:28:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33856 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406209AbfITM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:28:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190920122758euoutp01d502ac4885fcafc4216ebdc04b188f24~GJUBDo5QV0339903399euoutp01M
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 12:27:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190920122758euoutp01d502ac4885fcafc4216ebdc04b188f24~GJUBDo5QV0339903399euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568982478;
        bh=CRv8cWql1pD5QaeOj5tudGOhxXGTGFylyrv7c6clQ/M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=M0Ta3ELWazk5JcfZSA0dN40C5000KO6ehApq3yc3YI2xQaPUxOo+z0KtP3Uf+PCTI
         JudGfeXd3KFNR8Ob2rYQp5Hbykot9XgfglzTu3xqKJpbxw2gZ+N2PI3sObJ8AwwV2z
         +wuMZVqmX6G22jqAQBi048jE9MB3EzCePN+E+738=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190920122757eucas1p21ee05ab4e9f207f550fbc43b5be5e94f~GJUAH2Xzt2181421814eucas1p2O;
        Fri, 20 Sep 2019 12:27:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 48.F7.04469.CC5C48D5; Fri, 20
        Sep 2019 13:27:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190920122756eucas1p2613b07383330c6082e4bc2c787bab52e~GJT-S38pM2181421814eucas1p2N;
        Fri, 20 Sep 2019 12:27:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190920122755eusmtrp25ebacc731815671520d4df8ea761d851~GJT-BnA2Z2056820568eusmtrp2R;
        Fri, 20 Sep 2019 12:27:55 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-63-5d84c5cc2d94
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 37.46.04166.BC5C48D5; Fri, 20
        Sep 2019 13:27:55 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190920122755eusmtip2a35b10d4433b5de438ed2413664e94de~GJT_iatwD2316023160eusmtip2-;
        Fri, 20 Sep 2019 12:27:55 +0000 (GMT)
Subject: Re: [PATCH v3] dt-bindings: sound: Convert Samsung I2S controller
 to dt-schema
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <a7289122-9114-240e-8e84-9d7c1000472c@samsung.com>
Date:   Fri, 20 Sep 2019 14:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920113540.30687-1-m.szyprowski@samsung.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7pnjrbEGtxcpm9xa905VosrFw8x
        WUx9+ITNYv4RIPf8+Q3sFt+udDBZXN41h81ixvl9TBYPmtexWaw9cpfdYun1i0wWrXuPsDvw
        eGz43MTmsWbeGkaPnbPusntsWtXJ5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZS7q/sxUs
        FKh43rqJtYFxOU8XIyeHhICJxOKPR9i6GLk4hARWMErc2L2fBcL5wiix9tdrJgjnM6PEp+NN
        zDAtuzpeM0MkljNKbN60kxXCecsosenZLbAqYYFIicb+ZjYQW0QgVmLmtAZ2kCJmgbtMEtN2
        LANLsAkYSvQe7WMEsXkF7CROfznNCmKzCKhKLJnXyw5iiwpESHx6cJgVokZQ4uTMJywgNidQ
        /bmJP8DizALiEk1fVkLZ8hLb384BO09C4BG7RPf792wQd7tI7L67hxHCFpZ4dXwLO4QtI/F/
        53wmiIZmRome3bfZIZwJjBL3jy+A6rCWOHz8ItAKDqAVmhLrd+lDhB0l+tu7WEDCEgJ8Ejfe
        CkIcwScxadt0Zogwr0RHmxBEtYrE71XTmSBsKYnuJ/9ZJjAqzULy2iwk78xC8s4shL0LGFlW
        MYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCax0/+Of9rB+PVS0iFGAQ5GJR5ehfLmWCHW
        xLLiytxDjBIczEoivHNMm2KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0t
        SC2CyTJxcEo1MDLev6yy6P2J12syee8xXzPgLH73bcERtuNHVysHrFy5QXfRSs5lU7Yzz/m5
        KXL2hv/vKpJu/3hvaMj0zfh9QZFYhoC1pdz9Ged1xDbUTVQN4jsmd59RPNOTK6p5IW+Wl/Cd
        0u+tn/vd6v9FK7h4neddv18mtS32mUvlEVG/EP3/up2TuHXaXJRYijMSDbWYi4oTAQO/6lte
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7qnj7bEGlw9Z2Fxa905VosrFw8x
        WUx9+ITNYv4RIPf8+Q3sFt+udDBZXN41h81ixvl9TBYPmtexWaw9cpfdYun1i0wWrXuPsDvw
        eGz43MTmsWbeGkaPnbPusntsWtXJ5tG3ZRWjx+dNcgFsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZS7q/sxUsFKh43rqJtYFxOU8XIyeHhICJ
        xK6O18xdjBwcQgJLGSXWSIOYEgJSEvNblCAqhCX+XOti62LkAqp4zShxZt1mdpCEsECkxIYf
        HWC2iECsxIvds1lAipgF7jJJfOqfwAzRcYNR4uO6RmaQKjYBQ4neo32MIDavgJ3E6S+nWUFs
        FgFViSXzesEmiQpESBzeMQuqRlDi5MwnLCA2J1D9uYk/wOqZBdQl/sy7xAxhi0s0fVkJFZeX
        2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjddux
        n5t3MF7aGHyIUYCDUYmHV6G8OVaINbGsuDL3EKMEB7OSCO8c06ZYId6UxMqq1KL8+KLSnNTi
        Q4ymQM9NZJYSTc4HppK8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TByc
        Ug2MHWv56j7yRC25cvj99v+Nyi511mvY/ko9vsly6fAkF3bDCfOVtumHzviZflVWuHvF9m9/
        lNomh33eLTDvzrXSO66i8yeFyU3qV7kwgdFpY9nC5d9mtfFtclxZ3bKRz+RH1n6/BzOWmueo
        Z5zMFr1oXNNgcWfJlrKFiz3v/1z8cNKcqk8frGuP6yqxFGckGmoxFxUnAgC7Odqk7QIAAA==
X-CMS-MailID: 20190920122756eucas1p2613b07383330c6082e4bc2c787bab52e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190920115200eucas1p2253a3eb13373061ef8aa39131c98a319
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190920115200eucas1p2253a3eb13373061ef8aa39131c98a319
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
        <CGME20190920115200eucas1p2253a3eb13373061ef8aa39131c98a319@eucas1p2.samsung.com>
        <20190920113540.30687-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/19 13:35, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung I2S controller to newer dt-schema format.

>  .../devicetree/bindings/sound/samsung-i2s.txt |  84 -----------
>  .../bindings/sound/samsung-i2s.yaml           | 135 ++++++++++++++++++
>  2 files changed, 135 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.yaml

> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> new file mode 100644
> index 000000000000..20ae5da7f798
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml

> +  clocks:
> +    minItems: 1
> +    maxItems: 3

> +    description: |
> +      There are following clocks available at the I2S device nodes:
> +      CLK_I2S_CDCLK:
> +      the CDCLK (CODECLKO) gate clock.
> +
> +      CLK_I2S_RCLK_PSR:
> +      RCLK prescaler divider clock corresponding to the IISPSR register.
> +
> +      CLK_I2S_RCLK_SRC:
> +      RCLKSRC mux clock corresponding to RCLKSRC bit in IISMOD register.

Sorry for the confusion, this description refers to the supplier clocks
but the clocks property refers to the consumer clocks. The I2C controller
is both clock consumer and provider. I'm not sure where this description
should be moved to, "#clock-cells" property might be better but is likely
not the right place either. 

> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: iis
> +      - items:
> +          - const: iis
> +          - const: i2s_opclk0
> +      - items:
> +          - const: iis
> +          - const: i2s_opclk0
> +          - const: i2s_opclk1
> +    description: |
> +      "iis" is the i2s bus clock.
> +      For i2s1 and i2s2 - "iis", "i2s_opclk0"
> +      For i2s0 - "iis", "i2s_opclk0", "i2s_opclk1"
> +
> +  "#clock-cells":
> +    const: 1

--
Thanks,
Sylwester

