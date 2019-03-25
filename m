Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2262087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r6q8R9t2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfCYEzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:55:53 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45211 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfCYEzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:55:53 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190325045549epoutp013898518bbbef6ac6473484b554512568~PGrJZ20Fw1009110091epoutp01c
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 04:55:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190325045549epoutp013898518bbbef6ac6473484b554512568~PGrJZ20Fw1009110091epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553489749;
        bh=ZnogbQL+Vqpgqc677v3+eqqpLdSdJQ1889pWjuSTYkc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=r6q8R9t2cKcoGVPdGvhNO0tsjH73sc0t3RM5gt9u4ucye7VspP7o9No2j0aLZ065n
         /OwMg35SshGDX8pPTs7mhlHKi0oRGaSPguhisTCojGrH+bhLGs//6gj86n4oSl4k2v
         Xc0rnISXer8/Wy2V09lUQzuHWgoizVffA7Sx8hB0=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190325045546epcas1p4ed7455d1a849bba43463e49a1f7b24ba~PGrF61P_q0429904299epcas1p49;
        Mon, 25 Mar 2019 04:55:46 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-fb-5c985f4e876d
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.23.04257.E4F589C5; Mon, 25 Mar 2019 13:55:42 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 2/5] dt-bindings: devfreq: rk3399_dmc: Add
 rockchip,pmu phandle.
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190321231440.19031-3-gael.portay@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190325045542epcms1p585d5cec9453adef9b4531ff2a2bf5be6@epcms1p5>
Date:   Mon, 25 Mar 2019 13:55:42 +0900
X-CMS-MailID: 20190325045542epcms1p585d5cec9453adef9b4531ff2a2bf5be6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJsWRmVeSWpSXmKPExsWy7bCmnq5f/IwYg287FC1e3f3FaLHp43tW
        i5eHNC2uf3nOavFq8x42i/lHzrFanF12kM1ize1DjBZLdr1hs/j/6DWrxY8Np5gtvk5ezmRx
        tukNu8Wmx9dYLS7vmsNm8bn3CKPFpwf/mS2WXr/IZNG69wi7xf89O9gdRDzWzFvD6DG74SKL
        x467Sxg9Nq3qZPPYvKTe4++s/SwefVtWMXpsvzaP2aP57nRWj7WPNrB4fN4kF8AdlW2TkZqY
        klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA/SjkkJZYk4pUCgg
        sbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE749f+i0wF
        d9kqFn7YydLAeIW1i5GTQ0LAROLu771ANheHkMAORokVJ5cDORwcvAKCEn93CIPUCAtESnw/
        dJkRxBYSUJJouLmPGSKuL9HxYBtYnE1AV2LrhrssIHNEBGazSew5dowNxGEWaGKUOLevnxFi
        G6/EjPanLBC2tMT25VvB4pwC9hKHvh1ng4iLStxc/ZYdxn5/bD5Ur4hE672zzBC2oMSDn7sZ
        YebMmPIfama1xLXpi9lBFksItDBK9K6eAlWkL3Fm7kmwBbwCvhJTdzwDG8QioCrxaudCqMUu
        En+ndYDFmQXkJba/ncMMCglmAU2J9bv0Ye5v2PibHZ3NLMAn8e5rDytMfMe8J0wQtprEod1L
        oOplJE5PXwh1v4fEknkNjBMYFWchwnoWksWzEBYvYGRexSiWWlCcm55abFhgghy9mxjBCV7L
        YgfjnnM+hxgFOBiVeHgd9kyPEWJNLCuuzD3EKMHBrCTC+0R0RowQb0piZVVqUX58UWlOavEh
        RlOg/ycyS4km5wOzT15JvKGpkbGxsYWJoZmpoaGSOO96B+cYIYH0xJLU7NTUgtQimD4mDk6p
        BsZFXp9t3PN1J9y4ZvzgkN+cWyzPy6oMLH/P2uT3mPGKU7TspJn/rJW3vArNKAi82vvIvyAr
        PSck7f7R3uRNfOktu9ZpRNuE7Zlhuyf5V8kTjd+VTXorZ7MJCR+8a2A080ux7ZIP75u1pn7K
        mh0Yc5Hpt6ewJufhmK7H53nW+/L8M4zQ6DeOlVZiKc5INNRiLipOBABkm6g+BgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190321231447epcas2p4de5947e1eced053fee285ccd75d1d669
References: <20190321231440.19031-3-gael.portay@collabora.com>
        <20190321231440.19031-1-gael.portay@collabora.com>
        <CGME20190321231447epcas2p4de5947e1eced053fee285ccd75d1d669@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
>The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
>general register files to know the DRAM type, so add a phandle to the
>syscon that manages these registers.
>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>Acked-by: Rob Herring <robh@kernel.org>
>Signed-off-by: Gael PORTAY <gael.portay@collabora.com>
>---
>
>Changes in v3:
>- [PATCH v2 2/5] Add Signed-off-by: Gael PORTAY <gael.portay@collabora.com>.
>
>Changes in v2: None
>
>Changes in v1:
>- [RFC 2/10] Add reviewed and acked tags from Chanwoo Choi and Rob Herring
>
> Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
> 1 file changed, 2 insertions(+)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

