Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EBDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209B520896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uK8lQv1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfCYEsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:48:47 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41686 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfCYEsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:48:46 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190325044843epoutp0106152500b403ae1b9b95b306e2c2e130~PGk8yb2AF0550205502epoutp01Q
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 04:48:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190325044843epoutp0106152500b403ae1b9b95b306e2c2e130~PGk8yb2AF0550205502epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553489323;
        bh=cs4w+DzadlYVLPU5Ul6D8sQJyqA/gZ+1QKwn6xv4NpU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uK8lQv1eKtovp0xwUqjhyy7wjCwmQpx/RPxVGeNcuJs1diI/PC+O7W+A1Nh4KGMN+
         cCYJ4xUONCk+kjFxNoSSJMNloD5C/9xFAQX9O9a0zTF1d3pK8O6tKazIH2gCy2aPcN
         vfI7MzVirWiUEp89xyYMw/DhexK72uplLxwOBgSo=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190325044840epcas1p27ca6d9d30aa25c97cc61106a772d9f87~PGk5zTitR0071400714epcas1p2J;
        Mon, 25 Mar 2019 04:48:40 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-a4-5c985da8a068
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.31.04257.8AD589C5; Mon, 25 Mar 2019 13:48:40 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 1/5] devfreq: rockchip-dfi: Move GRF definitions to a
 common place.
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
CC:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@collabora.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190321231440.19031-2-gael.portay@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190325044840epcms1p20afe8dc66d0357e6a97939e1b2bb6e76@epcms1p2>
Date:   Mon, 25 Mar 2019 13:48:40 +0900
X-CMS-MailID: 20190325044840epcms1p20afe8dc66d0357e6a97939e1b2bb6e76
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmru6K2BkxBg9mali8uvuL0WLTx/es
        Fi8PaVpc//Kc1eLV5j1sFvOPnGO1OLvsIJvFmtuHGC2W7HrDZvH/0WtWix8bTjFbfJ28nMni
        bNMbdotNj6+xWlzeNYfN4nPvEUaLTw/+M1ssvX6RyaJ17xF2B2GPNfPWMHrMbrjI4rHj7hJG
        j02rOtk8Ni+p9/g7az+LR9+WVYwe26/NY/Zovjud1WPtow0sHp83yQVwR2XbZKQmpqQWKaTm
        JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gC9p6RQlphTChQKSCwuVtK3
        synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzmi//Yy14DdnxZ/1
        E9kbGDdxdDFyckgImEisbTvF1sXIxSEksINR4ljnPyCHg4NXQFDi7w5hkBphgRiJJUt/sIDY
        QgJKEg039zFDxPUlOh5sYwSx2QR0JbZuuMsCMkdEYDabxJ5jx9hAEswCyRJPNs1mg1jGKzGj
        /SkLhC0tsX35VrBmTgF7ibmrvzNBxEUlbq5+yw5jvz82nxHCFpFovXeWGcIWlHjwczcjzJwZ
        U/5DzayWuDZ9MTvIERICLYwSvaunQBXpS5yZexLqMV+J2VPiQMIsAqoSZ5d8gLrNRWJK0w9m
        iJvlJba/ncMMUs4soCmxfpc+zPkNG3+zo7OZBfgk3n3tYYWJ75j3BOoVNYlDu5dA1ctInJ6+
        EOp8D4mFi7axT2BUnIUI6VlIFs9CWLyAkXkVo1hqQXFuemqxYYEJcuRuYgSndC2LHYx7zvkc
        YhTgYFTi4XXYMz1GiDWxrLgy9xCjBAezkgjvE9EZMUK8KYmVValF+fFFpTmpxYcYTYH+n8gs
        JZqcD8w3eSXxhqZGxsbGFiaGZqaGhkrivOsdnGOEBNITS1KzU1MLUotg+pg4OKUaGEWKozRt
        mzqN959y+skdEe1TvIz92qrdr8Izje8npBwo8XO61tZpOF1RKFrw0dxpz6e97XTn8Jz02EHE
        usyoUKlq6wqTzAbBy0VS0xiVHd+1bPhY4rVYP/Bug3zAuWlsPneWnZGvPteueEZvu5jFhl+S
        X3wrChLnKn2fV2v8RrBj1tagZ0fklViKMxINtZiLihMBiJzY3f8DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190321231444epcas2p364deab07c3436f4ac78c63cb2d103a0b
References: <20190321231440.19031-2-gael.portay@collabora.com>
        <20190321231440.19031-1-gael.portay@collabora.com>
        <CGME20190321231444epcas2p364deab07c3436f4ac78c63cb2d103a0b@epcms1p2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
>Some rk3399 GRF (Generic Register Files) definitions can be used for
>different drivers. Move these definitions to a common include so we
>don't need to duplicate these definitions.
>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>Signed-off-by: Gael PORTAY <gael.portay@collabora.com>
>---
>
>Changes in v3:
>- [PATCH v2 1/5] Add Signed-off-by: Gael PORTAY <gael.portay@collabora.com>.
>
>Changes in v2:
>- [PATCH 1/8] Really add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>.
>
>Changes in v1:
>- [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>- [RFC 1/10] s/Generic/General/ (Robin Murphy)
>- [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
>- [RFC 7/10] Removed from the series. I did not found a use case where this matters.
>
> drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
> include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
> 2 files changed, 28 insertions(+), 16 deletions(-)
> create mode 100644 include/soc/rockchip/rk3399_grf.h
>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


