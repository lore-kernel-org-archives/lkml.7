Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFEC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361FF20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bf+XAIy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfFZKSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:18:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38226 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZKSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:18:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190626101814euoutp02d184fe0de817e897bc9fcdf4a7777942~ruENEN8OF1844718447euoutp02C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:18:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190626101814euoutp02d184fe0de817e897bc9fcdf4a7777942~ruENEN8OF1844718447euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561544294;
        bh=mACOH5YjrD8HO6K17o9dm9Cq5IPYkmCjlQwi/Y9hIgc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bf+XAIy6eKibNbho2avxZpuplGGPYjTkk2cbU2gKQW1PjjdhtRTew1YltOpG7nKe/
         1nTa26GNTpKVPmOeMGyBpsm10AkiObQqbIcI7i5MzBIxGB3TjlzYjfON+Q+lYHRLXC
         8tGS/muDaT1LrvyTQ2Da26WRKv9rdcLfJkIe/agk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190626101814eucas1p194c4cea1e4840626363990352d8aad0b~ruEMUydD11535515355eucas1p17;
        Wed, 26 Jun 2019 10:18:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 00.59.04377.566431D5; Wed, 26
        Jun 2019 11:18:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190626101813eucas1p250a269267f9adf4366d90bdb3924fa31~ruELlLPG52320623206eucas1p2i;
        Wed, 26 Jun 2019 10:18:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190626101813eusmtrp173e559ec318145c7c1a289ae7b5d1d13~ruELXGmQ52416324163eusmtrp1A;
        Wed, 26 Jun 2019 10:18:13 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-77-5d13466591ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.A3.04140.466431D5; Wed, 26
        Jun 2019 11:18:13 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190626101812eusmtip225081abb5508b2a23afae10fc7da8bdc~ruEK7uFx90924609246eusmtip2V;
        Wed, 26 Jun 2019 10:18:12 +0000 (GMT)
Subject: Re: [PATCH] MAINTAINERS: Update Maintainers and Reviewers of DRM
 Bridge Drivers
To:     Neil Armstrong <narmstrong@baylibre.com>,
        laurent.pinchart@ideasonboard.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <79d1611d-c6a0-f524-f8f2-1ad6a8952abe@samsung.com>
Date:   Wed, 26 Jun 2019 12:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624090851.17859-1-narmstrong@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87qpbsKxBld6DS3+b5vIbHHl63s2
        i6vfXzJbnHxzlcWic+ISdovLu+awWRzqi3Zg93h/o5XdY++3BSwesztmsnqcmHCJyeN+93Em
        jwO9k1k8Pm+SC2CP4rJJSc3JLEst0rdL4Mo4tSW24BRnxcGlE1kbGH+ydzFyckgImEjsbdzC
        3MXIxSEksIJRYt3sb+wQzhdGiWsrN7JAOJ8ZJba3nmaGabk2bRIjRGI5o8TZs6+ZIJy3jBLr
        324FqxIWiJI4segAC4gtIpAk0XTrBNhcZoGFjBKrD+1jAkmwCWhK/N18kw3E5hWwk3iyfALY
        VSwCqhIHd+0As0UFIiS+7NzECFEjKHFy5hOwoZwCthLNV4+CzWEWkJdo3jqbGcIWl7j1ZD7Y
        RRICu9gllq7dBHW3i8TH3gZWCFtY4tXxLdAgkJE4PbmHBcKul7i/ooUZormDUWLrhp1QzdYS
        h49fBGrmANqgKbF+lz6IKSHgKHHogRCEySdx460gxAl8EpO2TWeGCPNKdLQJQcxQlLh/divU
        PHGJpRe+sk1gVJqF5LFZSJ6ZheSZWQhrFzCyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/d
        xAhMSqf/Hf+yg3HXn6RDjAIcjEo8vA3yQrFCrIllxZW5hxglOJiVRHiXJgrECvGmJFZWpRbl
        xxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamDsyVadseKksatK67EdL5wP
        TZw+vXmrfpKRu5asf91C5j87FX/5F0//U3JmPbNM5+foufy7u6seRd8MbCz7clhN/aU2d4je
        Aa1vE9/vMQsOe6Dt7/P+tV25yVVxv/yMOktH64cvdu3hu+zb+fVm6yTmknMhj7skZ1W6W5e1
        63q8sfHnKZPNeaLEUpyRaKjFXFScCADNMUpBRgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7qpbsKxBhtTLP5vm8hsceXrezaL
        q99fMlucfHOVxaJz4hJ2i8u75rBZHOqLdmD3eH+jld1j77cFLB6zO2ayepyYcInJ4373cSaP
        A72TWTw+b5ILYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcks
        Sy3St0vQyzi1JbbgFGfFwaUTWRsYf7J3MXJySAiYSFybNomxi5GLQ0hgKaPE4nkToRLiErvn
        v2WGsIUl/lzrYoMoes0oMflFF1iRsECUxIlFB1hAbBGBJImm03+ZQYqYBRYySvz418cO0TGB
        UWLTvcVgo9gENCX+br7JBmLzCthJPFk+AWwSi4CqxMFdO8BsUYEIidm7GlggagQlTs58AmZz
        CthKNF89ygRiMwuoS/yZd4kZwpaXaN46G8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsY
        RVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC43DbsZ9bdjB2vQs+xCjAwajEw9sgLxQrxJpYVlyZ
        e4hRgoNZSYR3aaJArBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NEXkm8oamhuYWlobmx
        ubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxgAf25Q9dZ1CMSUHVmmLTWybe/z2Qk2F
        Q5nHt4lt3vjS9+JVOce1+sYlxjsepv+8lMY/b82ERet9LLe65RlN106p2H01NbdUJ/2wgDlT
        fW5O1L3FLU67BPxvhC2Y4z1HUfXSVV6DKl+lTZoVQd+26m+etCJjqZ78Bp2nbSt1Ftx0uaWv
        f9DgiBJLcUaioRZzUXEiALabIOnZAgAA
X-CMS-MailID: 20190626101813eucas1p250a269267f9adf4366d90bdb3924fa31
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190624090900epcas3p4d67a86c35a028a2afd4eef7720872a4b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190624090900epcas3p4d67a86c35a028a2afd4eef7720872a4b
References: <CGME20190624090900epcas3p4d67a86c35a028a2afd4eef7720872a4b@epcas3p4.samsung.com>
        <20190624090851.17859-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2019 11:08, Neil Armstrong wrote:
> Add myself as co-maintainer of DRM Bridge Drivers then add Jonas Karlman
> and Jernej Škrabec as Reviewers of DRM Bridge Drivers.
>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Jernej Škrabec <jernej.skrabec@siol.net>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>


Queued to drm-misc-next.

Good luck with reviewing/maintaining.

--
Regards
Andrzej


> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2abf6d28db64..dd8dacc61e79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5253,7 +5253,10 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  DRM DRIVERS FOR BRIDGE CHIPS
>  M:	Andrzej Hajda <a.hajda@samsung.com>
> +M:	Neil Armstrong <narmstrong@baylibre.com>
>  R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +R:	Jernej Skrabec <jernej.skrabec@siol.net>
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/bridge/


