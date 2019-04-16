Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADFAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F98520821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u9hNX+S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfDPJHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:07:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13785 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfDPJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:07:49 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190416090746epoutp0251c0d7eb4d9ce1b1c7e46ba9031b5a46~V6TaA7jHK1724817248epoutp02F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:07:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190416090746epoutp0251c0d7eb4d9ce1b1c7e46ba9031b5a46~V6TaA7jHK1724817248epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555405666;
        bh=UcelvCdIITTZO4u5G1znVtgrNrl50MMARxbln6+D55E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u9hNX+S/FM5e8k3H9vhEma89RSyvEswe9RYFt0cJaxktYmXY0yPLIWsEUSnvP2iIm
         s9qtTgA5gB6YqrLbn5EYIGSc8PFGbqVqyZbRyMFxRTlvlS32y0fFFJumR3gb4rUORU
         7S1lozTDjX0Y8eW/NdafzgRadmpr+5kUQEHS+RgY=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190416090742epcas1p1bf0e4e50480bde4f2ca07c36e43a9f18~V6TWEmiit0687106871epcas1p1k;
        Tue, 16 Apr 2019 09:07:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.2A.04143.E5B95BC5; Tue, 16 Apr 2019 18:07:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190416090741epcas1p3ee8ee173f9da7d60bdb3be01e6cb0f94~V6TVq_PPY2535825358epcas1p3A;
        Tue, 16 Apr 2019 09:07:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416090741epsmtrp2707760a9eed8c3369f9e12408b6058df~V6TVp93rj1516415164epsmtrp2F;
        Tue, 16 Apr 2019 09:07:41 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-d2-5cb59b5e4be5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.94.03662.D5B95BC5; Tue, 16 Apr 2019 18:07:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190416090741epsmtip2609e7d1bd0ffbdd6812b8de31b24fefb~V6TVeeS-G2827328273epsmtip2F;
        Tue, 16 Apr 2019 09:07:41 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] dt-bindings: devfreq: add compatible for mt8183
 cci devfreq
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <28f2c90a-9588-3afa-193d-2572c9cc9bf5@samsung.com>
Date:   Tue, 16 Apr 2019 18:08:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553841972-19737-4-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmrm7c7K0xBq/fCVpsX/+C1WL+kXOs
        Ft/u/GayONv0ht1i0+NrrBaXd81hs7jcfJHR4nPvEUaLpdcvMlk0tRhb3G5cwWZx5vQlVovW
        vUfYLabfFbLY+NXDgd9jzbw1jB47Z91l99i0qpPN4861PWwem5fUe7Sc3M/iseVqO4tH35ZV
        jB6fN8kFcEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYAna+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0
        MDAyBSpMyM7YfegRW8EZ7oo7j2YxNjAe4+xi5OSQEDCReNA2g72LkYtDSGAHo8S/nZ/YIJxP
        jBLPGl4xQzjfGCU29n5jgWn5eKOXFSKxl1Hi1NdvUM57Rom2P42sIFXCApES7TcXgM0SEbjM
        JHFl+3k2kASzwC1Gidf7wWw2AS2J/S9ugNn8AooSV388ZgSxeQXsJH79mAA0iIODRUBVYu9S
        X5CwqECExP1jG1ghSgQlTs58AnYRp4CvxPYvk6DGi0vcejKfCcKWl2jeOhvsBQmBY+wSqyb8
        ZYJ4wUVi+8q3rBC2sMSr41vYIWwpic/v9rJB2NUSK08eYYNo7mCU2LL/AlSDscT+pZOZQI5j
        FtCUWL9LH2IZn8S7rz1gN0sI8Ep0tAlBVCtLXH5wF2qtpMTi9k6o8R4Ssz+1MU9gVJyF5J1Z
        SF6YheSFWQjLFjCyrGIUSy0ozk1PLTYsMEaO7k2M4LStZb6DccM5n0OMAhyMSjy8CX1bYoRY
        E8uKK3MPMUpwMCuJ8DqmAIV4UxIrq1KL8uOLSnNSiw8xmgIDeyKzlGhyPjCn5JXEG5oaGRsb
        W5gYmpkaGiqJ8653cI4REkhPLEnNTk0tSC2C6WPi4JRqYAy4qjz5wuY1hyJXuLRyOIcb+J6b
        vffXfPu8fcEW7+68fTJZwZax7LjFBvEraX5K/5S5C2L73t15sN4j9CuL0MYzPku8Vi1YEPHy
        +vJ0Yds9DL89Z7ukbdg3xy/EpkXFP5hBXz/irq758um/1Xflseoe+/2H9+GB+QufP9fQnbW1
        /7iqfYjjdx0lluKMREMt5qLiRAARTFUy8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7bCSvG7s7K0xBpMem1lsX/+C1WL+kXOs
        Ft/u/GayONv0ht1i0+NrrBaXd81hs7jcfJHR4nPvEUaLpdcvMlk0tRhb3G5cwWZx5vQlVovW
        vUfYLabfFbLY+NXDgd9jzbw1jB47Z91l99i0qpPN4861PWwem5fUe7Sc3M/iseVqO4tH35ZV
        jB6fN8kFcEZx2aSk5mSWpRbp2yVwZew+9Iit4Ax3xZ1HsxgbGI9xdjFyckgImEh8vNHL2sXI
        xSEksJtRYt+nPmaIhKTEtItHgWwOIFtY4vDhYoiat4wSm24dYgSpERaIlGi/uYANJCEicJ1J
        4tXdoywgDrPALaCq5iPsEC2PGSWO9RxjB2lhE9CS2P/iBhuIzS+gKHH1x2OwUbwCdhK/fkxg
        BVnHIqAqsXepL0hYVCBC4sz7FSwQJYISJ2c+AbM5BXwltn+ZBDaGWUBd4s+8S8wQtrjErSfz
        mSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66X
        nJ+7iREcwVpaOxhPnIg/xCjAwajEw5vQtyVGiDWxrLgy9xCjBAezkgivYwpQiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA2Mle6cWd8MF12sRixR7J5dZ
        rrD3C13pUFysvWPOjR+bHSUqktJ0nX8xCTQonuk0WDnh9TrR4/Oex3+ddC3s17ozDL2rLgkJ
        HVtoVLqwYs/Gmq7dPNvW2Ux37M65UmJYU8Y20clVJiBfZYP9R8f6bRWXrqzcJLNut/Y5fdWG
        BInqGsF1f3v2BSmxFGckGmoxFxUnAgBeTOiV3AIAAA==
X-CMS-MailID: 20190416090741epcas1p3ee8ee173f9da7d60bdb3be01e6cb0f94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190329064630epcas5p216f8d9263dc6fea26bb71165b5673111
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190329064630epcas5p216f8d9263dc6fea26bb71165b5673111@epcas5p2.samsung.com>
        <1553841972-19737-4-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I already reviewed this patch on v1[1].
[1] https://lkml.org/lkml/2019/2/11/2228

But, the second version patch doesn't include the anything
about review. Please check it[1].

On 19. 3. 29. 오후 3:46, Andrew-sh.Cheng wrote:
> This adds dt-binding documentation of cci devfreq
> for Mediatek MT8183 SoC platform.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  .../bindings/devfreq/mt8183-cci-devfreq.txt           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> new file mode 100644
> index 0000000..e2b61cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> @@ -0,0 +1,19 @@
> +* Mediatek CCI frequency device
> +
> +Required properties:
> +- compatible: should contain "mediatek,mt8183-cci" for cci devfreq
> +
> +- clocks: for cci devfreq
> +
> +- clock-names: for cci devfreq driver to reference
> +
> +- operating-points-v2: for cci devfreq opp table
> +
> +Example:
> +	cci: cci {
> +		compatible = "mediatek,cci";
> +		clocks = <&apmixedsys CLK_APMIXED_CCIPLL>;
> +		clock-names = "cci_clock";
> +		operating-points-v2 = <&cci_opp>;
> +	};
> +
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
